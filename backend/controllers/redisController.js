const { db, redis } = require("../config")
const moment = require('moment')

// Membuat project
exports.createProject = async (req, res) => {
  let { project, keyword } = req.body
  const userId = req.user.id

  keyword = keyword.toLowerCase()

  if (!project || !keyword || !userId) {
    return res.status(400).json({ error: "Nama project dan keyword wajib diisi!" })
  }

  const today = moment().format('YYYY-MM-DD')
  const throttleKey = `create_project:${userId}:${today}`

  try {
    // Throttling
    const currentCount = await redis.incr(throttleKey)

    if (currentCount === 1) {
      await redis.expire(throttleKey, 86400) // TTL 1 hari = 86400 detik
    }

    if (currentCount > 3) {
      return res.status(429).json({ error: "Maksimal 3 project per hari per user" })
    }

    const [projectRows] = await db.query(
      "SELECT id FROM projects WHERE project_name = ? AND is_active = 1", [project]
    )
    if (projectRows.length) {
      return res.status(400).json({ error: "Nama project sudah dipakai" })
    }

    const [keywordRows] = await db.query(
      "SELECT id FROM keywords WHERE keyword = ? AND is_active = 1", [keyword]
    )

    let keywordId = keywordRows.length
      ? keywordRows[0].id
      : (await (async () => {
          await redis.sadd("keywordSet", keyword)
          const [insert] = await db.query(
            "INSERT INTO keywords (keyword, is_active, createdAt) VALUES (?, 1, NOW())", [keyword]
          )
          return insert.insertId
        })())

    await db.query(
      "INSERT INTO projects (id_user, id_keyword, project_name, is_active, createdAt) VALUES (?, ?, ?, 1, NOW())",
      [userId, keywordId, project]
    )

    res.json({ message: `Project "${project}" dengan keyword "${keyword}" berhasil dibuat.` })

  } catch (err) {
    console.error(err)
    res.status(500).json({ message: "Gagal memproses keyword", error: err.message })
  }
}

// Hapus Project
exports.softDeleteProject = async (req, res) => {
    const { project_name } = req.query
    const userId = req.user.id
  
    if (!project_name) return res.status(400).json({ error: "project_name harus diisi" })
  
    try {
      const [check] = await db.query(
        `SELECT id FROM projects WHERE project_name = ? AND id_user = ? AND is_active = 1`,
        [project_name, userId]
      )
  
      if (!check.length) {
        return res.status(404).json({ error: "Project tidak ditemukan atau sudah dihapus" })
      }
  
      await db.query(
        `UPDATE projects SET is_active = 0, deletedAt = NOW() WHERE project_name = ? AND id_user = ?`,
        [project_name, userId]
      )
  
      // Masukkan ke Redis dengan TTL 5 hari (432000 detik)
      await redis.setex(`delete_queue:${project_name}:${userId}`, 432000, JSON.stringify({ project_name, userId }))
  
      res.json({ message: `Project '${project_name}' berhasil dinonaktifkan dan masuk antrian penghapusan.` })
    } catch (err) {
      console.error("Gagal hapus project:", err)
      res.status(500).json({ error: "Terjadi kesalahan saat menghapus project" })
    }
  }
  
  // Restore Project
  exports.restoreProject = async (req, res) => {
    const { project_name } = req.query
    const userId = req.user.id
  
    try {
      const [check] = await db.query(
        `SELECT id FROM projects WHERE project_name = ? AND id_user = ? AND is_active = 0`,
        [project_name, userId]
      )
  
      if (!check.length) return res.status(404).json({ error: "Project tidak ditemukan dalam kondisi nonaktif" })
  
      await db.query(
        `UPDATE projects SET is_active = 1, deletedAt = NULL WHERE project_name = ? AND id_user = ?`,
        [project_name, userId]
      )
  
      // Hapus dari Redis jika sempat masuk
      const redisKeyPattern = `delete_queue:${project_name}:${userId}`
      await redis.del(redisKeyPattern)
  
      res.json({ message: `Project '${project_name}' berhasil di-restore.` })
    } catch (err) {
      console.error("Restore error:", err)
      res.status(500).json({ error: "Gagal mengaktifkan kembali project" })
    }
  }
  
  // recent-deleted
  exports.getRecentlyDeletedProjects = async (req, res) => {
  try {
    const keys = await redis.keys("delete_queue:*")
    const data = await Promise.all(keys.map(async (key) => {
      const value = await redis.get(key)
      return JSON.parse(value)
    }))
    res.json({ recently_deleted: data })
  } catch (err) {
    res.status(500).json({ error: "Gagal mengambil data dari Redis" })
  }
}

// Top Searchead
exports.getTodayHotSearches = async (req, res) => {
  const today = new Date().toISOString().slice(0, 10)
  try {
    const data = await redis.zrevrange(`daily_search:${today}`, 0, 4, "WITHSCORES")
    res.json({ top_searches: data })
  } catch (err) {
    res.status(500).json({ error: "Gagal ambil pencarian terpopuler" })
  }
}

// Ringkasan Real Time
exports.getRedisDashboard = async (req, res) => {
  try {
    const keywordTotal = await redis.scard("keywordSet")
    const deleteKeys = await redis.keys("delete_queue:*")
    res.json({
      total_keywords: keywordTotal,
      total_deleted_projects_waiting: deleteKeys.length
    })
  } catch (err) {
    res.status(500).json({ error: "Gagal ambil data dashboard" })
  }
}

// Mengambil 10 Aktivitas terakhir dari User
exports.getUserActivity = async (req, res) => {
  const userId = req.params.userId
  try {
    const activities = await redis.lrange(`user_activity:${userId}`, 0, 9)
    res.json({ activities })
  } catch (err) {
    res.status(500).json({ error: "Gagal mengambil aktivitas user" })
  }
}

// Menampilkan statistik umum
exports.getCacheStats = async (req, res) => {
  try {
    const totalKeywords = await redis.scard("keywordSet")
    const deletedProjects = (await redis.keys("delete_queue:*")).length
    const alertKeywords = await redis.scard("alert_keywords")

    res.json({
      totalKeywords,
      deletedProjects,
      alertKeywords
    })
  } catch (err) {
    res.status(500).json({ error: "Gagal mengambil statistik cache" })
  }
}
