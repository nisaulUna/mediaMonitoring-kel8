const fs = require("fs")
const path = require("path")
const moment = require("moment")
const { redis, db } = require("../config")

const logPath = path.join(__dirname, "../logs/backupWorker.log")
const backupDir = path.join(__dirname, "../backup")

function logToFile(message) {
  const timestamp = new Date().toISOString()
  const finalMessage = `[${timestamp}] ${message}\n`
  fs.appendFile(logPath, finalMessage, err => {
    if (err) console.error("Gagal menulis ke file log:", err)
  })
}

function ensureBackupDir() {
  if (!fs.existsSync(backupDir)) {
    fs.mkdirSync(backupDir)
  }
}

async function fetchAndBackup(tableName) {
  try {
    const [rows] = await db.query(`SELECT * FROM ${tableName}`)
    return rows
  } catch (err) {
    logToFile(`Gagal fetch data dari tabel ${tableName}: ${err.message}`)
    return []
  }
}

async function runOfflineBackup() {
  ensureBackupDir()

  const dateStr = moment().format("YYYY-MM-DD_HH-mm-ss")
  const backupFile = path.join(backupDir, `backup-${dateStr}.json`)

  try {
    const projects = await fetchAndBackup("projects")
    const keywords = await fetchAndBackup("keywords")
    const mentions = await fetchAndBackup("media_mentions")
    const sentiments = await fetchAndBackup("sentiment_analysis")
    const reports = await fetchAndBackup("reports")

    const allData = {
      timestamp: dateStr,
      projects,
      keywords,
      mentions,
      sentiments,
      reports
    }

    fs.writeFileSync(backupFile, JSON.stringify(allData, null, 2))
    logToFile(`Backup sukses disimpan di ${backupFile}`)
  } catch (err) {
    logToFile(`Gagal membuat backup: ${err.message}`)
  }
}

runOfflineBackup()
  .then(() => logToFile("Worker backup selesai dijalankan."))
  .catch(err => logToFile(`Error utama di worker: ${err.message}`))
