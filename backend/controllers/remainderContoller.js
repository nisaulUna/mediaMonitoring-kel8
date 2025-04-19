const { db, redis } = require("../config")

// Rimaindes delete project
exports.getProjectDeleteReminders = async (req, res) => {
  const userId = req.user.id
  try {
    const keys = await redis.keys(`reminder:*:${userId}`)
    const results = await Promise.all(
      keys.map(async key => {
        const val = await redis.get(key)
        return JSON.parse(val)
      })
    )
    res.json({ reminders: results })
  } catch (err) {
    console.error("Gagal ambil reminder:", err)
    res.status(500).json({ error: "Gagal ambil reminder project" })
  }
}
