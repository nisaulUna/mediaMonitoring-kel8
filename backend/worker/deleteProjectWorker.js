const { redis, db } = require("../config")
const moment = require("moment")

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
        console.log(`Reminder: Project '${project_name}' akan dihapus besok (${deleteTime}). Segera restore jika ingin menyelamatkan.`)
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

          console.log(`🧹 Keyword ID ${keywordId} dihapus karena tidak dipakai project lain.`)
        }

        await redis.del(key)
        console.log(`Project '${project_name}' milik user ${userId} dihapus permanen setelah 7 hari.`)
      } else {
        console.log(`Project '${project_name}' masih dalam masa tunggu (${diffDays} hari).`)
      }

    } catch (err) {
      console.error("Gagal hapus project permanen:", err)
    }
  }
}

deleteExpiredProjects()
  .then(() => {
    console.log("Worker dijalankan manual.")
  })
  .catch(err => {
    console.error("Error saat menjalankan worker:", err)
  })
