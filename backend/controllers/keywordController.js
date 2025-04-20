const { db } = require("../config")

// GET /keywords - Ambil semua keywords
exports.getAllKeywords = async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM keywords ORDER BY createdAt DESC")
    res.json({ keywords: rows })
  } catch (err) {
    console.error("Gagal ambil keywords:", err)
    res.status(500).json({ error: "Gagal ambil data keywords" })
  }
}

// POST /keywords - Tambah keyword baru
exports.createKeyword = async (req, res) => {
  const { keyword } = req.body
  if (!keyword) return res.status(400).json({ error: "Keyword tidak boleh kosong" })

  try {
    const [result] = await db.query("INSERT INTO keywords (keyword) VALUES (?)", [keyword])
    res.status(201).json({ message: "Keyword berhasil ditambahkan", id: result.insertId })
  } catch (err) {
    console.error("Gagal tambah keyword:", err)
    res.status(500).json({ error: "Gagal tambah keyword" })
  }
}

// PUT /keywords/:id - Update keyword
exports.updateKeyword = async (req, res) => {
  const { id } = req.params
  const { keyword } = req.body

  try {
    const [result] = await db.query("UPDATE keywords SET keyword = ? WHERE id = ?", [keyword, id])
    if (result.affectedRows === 0) return res.status(404).json({ error: "Keyword tidak ditemukan" })

    res.json({ message: "Keyword berhasil diupdate" })
  } catch (err) {
    console.error("Gagal update keyword:", err)
    res.status(500).json({ error: "Gagal update keyword" })
  }
}

// DELETE /keywords/:id - Hapus keyword
exports.deleteKeyword = async (req, res) => {
  const { id } = req.params

  try {
    const [result] = await db.query("DELETE FROM keywords WHERE id = ?", [id])
    if (result.affectedRows === 0) return res.status(404).json({ error: "Keyword tidak ditemukan" })

    res.json({ message: "Keyword berhasil dihapus" })
  } catch (err) {
    console.error("Gagal hapus keyword:", err)
    res.status(500).json({ error: "Gagal hapus keyword" })
  }
}
