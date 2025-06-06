// STEP 1: Buat file baru logController.js di folder controllers

const { redis } = require('../config');

// Simpan log email
exports.logEmail = async (userId, email, subject) => {
  const log = {
    userId,
    email,
    subject,
    timestamp: new Date().toISOString()
  }

  await redis.lpush("email_logs", JSON.stringify(log))
  await redis.ltrim("email_logs", 0, 99)
}

// Simpan log export
exports.logExport = async (userId, projectName, format) => {
  const log = {
    userId,
    projectName,
    format,
    timestamp: new Date().toISOString()
  }

  await redis.lpush("export_logs", JSON.stringify(log))
  await redis.ltrim("export_logs", 0, 49)
}

// Simpan activity log
exports.logActivity = async (userId, action, target) => {
  const log = {
    log_id: `log_${Date.now()}`, // Bisa pakai UUID juga
    user_id: userId,
    action,
    target,
    timestamp: new Date().toISOString()
  }

  await redis.lpush("activity_logs", JSON.stringify(log))
  await redis.ltrim("activity_logs", 0, 99) // Simpan max 100 log
}

// Ambil log email terbaru
exports.getEmailLogs = async (req, res) => {
  try {
    const logs = await redis.lrange("email_logs", 0, 9)
    const parsed = logs.map(l => JSON.parse(l))
    res.json({ logs: parsed })
  } catch (err) {
    res.status(500).json({ error: 'Gagal ambil email logs' })
  }
}

// Ambil log export terbaru
exports.getExportLogs = async (req, res) => {
  try {
    const logs = await redis.lrange("export_logs", 0, 9)
    const parsed = logs.map(l => JSON.parse(l))
    res.json({ logs: parsed })
  } catch (err) {
    res.status(500).json({ error: 'Gagal ambil export logs' })
  }
}

// Ambil activity logs
exports.getActivityLogs = async (req, res) => {
  try {
    const logs = await redis.lrange("activity_logs", 0, 9)
    const parsed = logs.map(l => JSON.parse(l))
    res.json({ logs: parsed })
  } catch (err) {
    res.status(500).json({ error: 'Gagal ambil activity logs' })
  }
}