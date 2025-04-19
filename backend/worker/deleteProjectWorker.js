const { redis, db } = require("../config")
const moment = require("moment")
const fs = require("fs")
const path = require("path")
const logPath = path.join(__dirname, "../logs/deleteProjectWorker.log")

function logToFile(message) {
  const timestamp = new Date().toISOString()
  const finalMessage = `[${timestamp}] ${message}\n`
  fs.appendFile(logPath, finalMessage, err => {
    if (err) console.error("Gagal menulis ke file log:", err)
  })
}

async function deleteExpiredProjects() {
  const keys = await redis.keys("delete_project:*")

  for (const key of keys) {
    const value = await redis.get(key)
    if (!value) continue

    const { project_name, userId } = JSON.parse(value)

    try {
      const [projectRows] = await db.query(
        `SELECT id, id_keyword, deletedAt FROM projects WHERE project_name = ? AND id_user = ? AND is_active = 0`,
        [project_name, userId]
      )

      if (!projectRows.length) {
        await redis.del(key)
        continue
      }

      const project = projectRows[0]
      const deletedAt = moment.utc(project.deletedAt)
      const now = moment.utc()
      const diffDays = now.diff(deletedAt, "days")

      if (diffDays === 6) {
        const deleteTime = deletedAt.clone().add(7, "days").local().format("dddd, D MMMM YYYY [pukul] HH:mm")
        const reminderMessage = `Reminder: Project '${project_name}' akan dihapus besok (${deleteTime}). Segera restore jika ingin menyelamatkan.`

        await redis.setex(
          `reminder:${project_name}:${userId}`,
          86400, // 1 hari
          JSON.stringify({
            project_name,
            userId,
            message: reminderMessage,
            delete_at: deleteTime
          })
        )

        logToFile(`Reminder: Project '${project_name}' akan dihapus besok (${deleteTime})`)

      } else if (diffDays >= 7) {
        const projectId = project.id
        const keywordId = project.id_keyword

        await db.query(`DELETE FROM reports WHERE id_project = ?`, [projectId])
        await db.query(`DELETE FROM projects WHERE id = ?`, [projectId])

        const [keywordCheck] = await db.query(
          `SELECT COUNT(*) AS count FROM projects WHERE id_keyword = ?`,
          [keywordId]
        )

        if (keywordCheck[0].count === 0) {
          const [mentions] = await db.query(`SELECT id FROM media_mentions WHERE id_keyword = ?`, [keywordId])
          const mentionIds = mentions.map(m => m.id)

          if (mentionIds.length > 0) {
            await db.query(`DELETE FROM sentiment_analysis WHERE id_mentions IN (?)`, [mentionIds])
          }

          await db.query(`DELETE FROM media_mentions WHERE id_keyword = ?`, [keywordId])
          await db.query(`DELETE FROM keywords WHERE id = ?`, [keywordId])

          logToFile(`Keyword ID ${keywordId} dihapus karena tidak dipakai project lain.`)
        }

        const deleted = await redis.del(key)
        if (!deleted) logToFile(`Redis key '${key}' gagal dihapus.`)

        logToFile(`Project '${project_name}' milik user ${userId} dihapus permanen setelah 7 hari.`)

      } else {
        logToFile(`Project '${project_name}' masih dalam masa tunggu (${diffDays} hari).`)
      }

    } catch (err) {
      logToFile(`Gagal hapus project permanen: ${err.message}`)
    }
  }
}

deleteExpiredProjects()
  .then(() => {
    logToFile("Worker selesai dijalankan.")
  })
  .catch(err => {
    logToFile(`Worker gagal dijalankan: ${err.message}`)
  })