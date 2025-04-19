const { redis, db } = require("../config")

async function deleteExpiredProjects() {
  const keys = await redis.keys("delete_queue:*")

  for (const key of keys) {
    const value = await redis.get(key)
    if (!value) continue

    const { project_name, userId } = JSON.parse(value)

    try {
      await db.query(`DELETE FROM projects WHERE project_name = ? AND id_user = ?`, [project_name, userId])
      await redis.del(key)
      console.log(`Project '${project_name}' milik user ${userId} dihapus permanen.`)
    } catch (err) {
      console.error("Gagal hapus project permanen:", err)
    }
  }
}

// Jalankan setiap 6 jam sekali
setInterval(deleteExpiredProjects, 6 * 60 * 60 * 1000)
