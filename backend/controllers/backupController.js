const fs = require("fs")
const path = require("path")

const backupDir = path.join(__dirname, "../backup")

// Daftar semua file backup
exports.getBackupList = async (req, res) => {
  try {
    const files = fs.readdirSync(backupDir)
    const jsonFiles = files.filter(file => file.endsWith(".json"))
    res.json({ backups: jsonFiles })
  } catch (err) {
    console.error("Gagal membaca folder backup:", err)
    res.status(500).json({ error: "Gagal membaca backup." })
  }
}

// Isi file backup tertentu
exports.getBackupFile = async (req, res) => {
  const fileName = req.params.name
  const filePath = path.join(backupDir, fileName)

  if (!fileName.endsWith(".json")) {
    return res.status(400).json({ error: "File tidak valid" })
  }

  try {
    const content = fs.readFileSync(filePath, "utf-8")
    const parsed = JSON.parse(content)
    res.json(parsed)
  } catch (err) {
    console.error("Gagal baca file:", err)
    res.status(500).json({ error: "Gagal membaca file backup." })
  }
}

// Hapus file backup tertentu
exports.deleteBackupFile = async (req, res) => {
  const fileName = req.params.name
  const filePath = path.join(backupDir, fileName)

  if (!fileName.endsWith(".json")) {
    return res.status(400).json({ error: "File tidak valid" })
  }

  try {
    fs.unlinkSync(filePath)
    res.json({ message: `File '${fileName}' berhasil dihapus.` })
  } catch (err) {
    console.error("Gagal hapus file backup:", err)
    res.status(500).json({ error: "Gagal menghapus file backup." })
  }
}

// Update file backup
exports.updateBackupFile = async (req, res) => {
  const fileName = req.params.name
  const filePath = path.join(backupDir, fileName)
  const newData = req.body

  if (!fileName.endsWith(".json")) {
    return res.status(400).json({ error: "File tidak valid" })
  }

  try {
    fs.writeFileSync(filePath, JSON.stringify(newData, null, 2), "utf-8")
    res.json({ message: `File '${fileName}' berhasil diperbarui.` })
  } catch (err) {
    console.error("Gagal update file backup:", err)
    res.status(500).json({ error: "Gagal memperbarui file backup." })
  }
}
