const { db, redis } = require("../config")

// Membuat project
exports.createProject = async (req, res) => {
  let { project, keyword } = req.body
  const userId = req.user.id

  // Ubah keyword ke huruf kecil
  keyword = keyword.toLowerCase()

  if (!project || !keyword || !userId) {
    return res.status(400).json({ error: "Nama project dan keyword wajib diisi!" })
  }

  try {
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


// // Menampilkan Detal Project
exports.getProjectDetail = async (req, res) => {
  const { project_name } = req.query
  const userId = req.user.id

  try {
    if (project_name) {
      // Ambil 1 project berdasarkan nama
      const [rows] = await db.query(`
        SELECT p.*, k.keyword
        FROM projects p
        JOIN keywords k ON p.id_keyword = k.id
        WHERE p.project_name = ? AND p.id_user = ? AND p.is_active = 1
      `, [project_name, userId])

      if (!rows.length) {
        return res.status(404).json({ error: "Project tidak ditemukan" })
      }

      return res.json({ project: rows[0] })
    } else {
      const [projects] = await db.query(`
        SELECT p.*, k.keyword
        FROM projects p
        JOIN keywords k ON p.id_keyword = k.id
        WHERE p.id_user = ? AND p.is_active = 1
        ORDER BY p.createdAt DESC
      `, [userId])

      return res.json({ projects })
    }
  } catch (err) {
    console.error("Gagal ambil project:", err)
    res.status(500).json({ error: "Gagal ambil data project" })
  }
}

// Menampilkan Project detail besrta filter
exports.getMentions = async (req, res) => {
  const { project_name, source, year, month, day, language, sentiment } = req.query
  const userId = req.user.id

  if (!project_name) return res.status(400).json({ error: "project_name harus diisi" })

  try {
    let query = `
      SELECT 
        mm.published_date AS date,
        ms.source_name,
        mm.content,
        mm.url,
        mm.author,
        mm.profile_image,
        sa.sentiment_score,
        sa.sentiment_category,
        sa.language
      FROM projects p
      JOIN keywords k ON p.id_keyword = k.id
      JOIN media_mentions mm ON mm.id_keyword = k.id
      JOIN media_sources ms ON mm.id_mediaSource = ms.id
      LEFT JOIN sentiment_analysis sa ON sa.id_mentions = mm.id
      WHERE p.project_name = ? AND p.id_user = ? AND p.is_active = 1
    `
    const params = [project_name, userId]

    if (source) {
      const sources = Array.isArray(source) ? source : [source]
      query += ` AND ms.source_name IN (${sources.map(() => '?').join(',')})`
      params.push(...sources)
    }

    if (year || month || day) {
      query += ` AND ms.source_name != 'google'`
      if (year) { query += ` AND YEAR(mm.published_date) = ?`; params.push(year) }
      if (month) { query += ` AND MONTH(mm.published_date) = ?`; params.push(month) }
      if (day) { query += ` AND DAY(mm.published_date) = ?`; params.push(day) }
    }

    if (language) {
      query += ` AND sa.language = ?`
      params.push(language)

      if (language === 'id' || language === 'en') {
        if (sentiment) {
          query += ` AND sa.sentiment_category = ?`
          params.push(sentiment)
        }
      } else {
        query += ` AND sa.sentiment_category IS NULL`
      }
    }

    query += ` ORDER BY mm.published_date DESC`

    const [rows] = await db.query(query, params)
    res.json({ data: rows })

  } catch (err) {
    console.error("Gagal ambil media mentions:", err)
    res.status(500).json({ error: "Terjadi kesalahan" })
  }
}


// Jumlah Mention per Platform
exports.getPlatformSummary = async (req, res) => {
  const { project_name } = req.query
  const userId = req.user.id

  if (!project_name) return res.status(400).json({ error: "project_name harus diisi" })

  try {
    const [rows] = await db.query(`
      SELECT ms.source_name, COUNT(*) AS total_mentions
      FROM projects p
      JOIN keywords k ON p.id_keyword = k.id
      JOIN media_mentions mm ON mm.id_keyword = k.id
      JOIN media_sources ms ON mm.id_mediaSource = ms.id
      WHERE p.project_name = ? AND p.id_user = ? AND p.is_active = 1
      GROUP BY ms.source_name
    `, [project_name, userId])

    res.json({ data: rows })
  } catch (err) {
    console.error("Gagal ambil platform summary:", err)
    res.status(500).json({ error: "Terjadi kesalahan" })
  }
}


// Jumlah Mention per Bahasa
exports.getLanguageSummary = async (req, res) => {
  const { project_name } = req.query
  const userId = req.user.id

  if (!project_name) return res.status(400).json({ error: "project_name harus diisi" })

  try {
    const [rows] = await db.query(`
      SELECT sa.language, COUNT(*) AS total_mentions
      FROM projects p
      JOIN keywords k ON p.id_keyword = k.id
      JOIN media_mentions mm ON mm.id_keyword = k.id
      JOIN sentiment_analysis sa ON sa.id_mentions = mm.id
      WHERE p.project_name = ? AND p.id_user = ? AND p.is_active = 1
      GROUP BY sa.language
    `, [project_name, userId])

    res.json({ data: rows })
  } catch (err) {
    console.error("Gagal ambil language summary:", err)
    res.status(500).json({ error: "Terjadi kesalahan" })
  }
}

// Jumlah Mention per Sentimen
exports.getSentimentSummary = async (req, res) => {
  const { project_name } = req.query
  const userId = req.user.id

  if (!project_name) return res.status(400).json({ error: "project_name harus diisi" })

  try {
    const [rows] = await db.query(`
      SELECT sa.sentiment_category, COUNT(*) AS total
      FROM projects p
      JOIN keywords k ON p.id_keyword = k.id
      JOIN media_mentions mm ON mm.id_keyword = k.id
      JOIN sentiment_analysis sa ON sa.id_mentions = mm.id
      WHERE p.project_name = ? AND p.id_user = ? AND p.is_active = 1
        AND sa.language IN ('id', 'en')
        AND sa.sentiment_category IS NOT NULL
      GROUP BY sa.sentiment_category
    `, [project_name, userId])

    res.json({ data: rows })
  } catch (err) {
    console.error("Gagal ambil sentiment summary:", err)
    res.status(500).json({ error: "Terjadi kesalahan" })
  }
}

// Hapus project
exports.deleteProject = async (req, res) => {
  const { project_name } = req.query
  const userId = req.user.id

  if (!project_name) {
    return res.status(400).json({ error: "project_name harus diisi" })
  }

  try {
    const [check] = await db.query(
      `SELECT id FROM projects WHERE project_name = ? AND id_user = ? AND is_active = 1`,
      [project_name, userId]
    )

    if (!check.length) {
      return res.status(404).json({ error: "Project tidak ditemukan atau sudah dihapus" })
    }

    await db.query(
      `UPDATE projects SET is_active = 0 WHERE project_name = ? AND id_user = ?`,
      [project_name, userId]
    )

    res.json({ message: `Project '${project_name}' berhasil dihapus.` })
  } catch (err) {
    console.error("Gagal hapus project:", err)
    res.status(500).json({ error: "Terjadi kesalahan saat menghapus project" })
  }
}
