const { db, redis } = require("../config")
const Sentiment = require("sentiment")
const sentiment = new Sentiment()
const franc = require('franc')

exports.createProject = async (req, res) => {
  const { project, keyword } = req.body
  const userId = 1 //pake session

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

const indoLexicon = {
  bagus: 2, baik: 2, mantap: 3, luar_biasa: 3, senang: 2, puas: 2,
  kecewa: -3, buruk: -2, jelek: -2, sampah: -4, benci: -3, menyebalkan: -3, tidak_suka: -2,
  aku: 0, saya: 0, gua: 0, kita: 0, kami: 0, kamu: 0, kalian: 0, dia: 0, mereka: 0, 
  dan: 0, atau: 0, karena: 0, jadi: 0, tapi: 0, lalu: 0, padahal: 0, sehingga: 0, setelah: 0,
  lagi: 0, udah: 0, sudah: 0, belum: 0, akan: 0, pernah: 0, sedang: 0,banget: 0, berapa : 0, baru : 0, menjadi : 0
}

exports.analyzeSentiment = async (req, res) => {
  try {
    const [mentions] = await db.query("SELECT id, content FROM media_mentions")

    for (const mention of mentions) {
      const contentRaw = mention.content || ''
      const contentLower = contentRaw.toLowerCase()

      const content = contentLower
        .split(/\s+/)
        .filter(word => /^[a-zA-Z]+$/.test(word)) // hanya ambil kata yang hanya huruf
        .join(" ")

      const result = sentiment.analyze(content, { extras: indoLexicon })
      const score = result.score

      
      const contentWords = content.split(/\s+/)
      const indoHits = Object.keys(indoLexicon).filter(word => contentWords.includes(word)).length
      const francLang = franc(content)

      if (francLang === 'eng') {
        language = 'en'
      } else if (indoHits > 0 || francLang === 'ind') {
        language = 'id'
      } else {
        language = 'other'
      }

      // Klasifikasi sentimen
      let category = null
      let sentimentScore = null

      if (language !== 'other') {
        sentimentScore = score
        if (score > 0) category = "positive"
        else if (score < 0) category = "negative"
        else category = "neutral"
      }

      // Simpan atau update hasil analisis ke database
      const [exists] = await db.query("SELECT id FROM sentiment_analysis WHERE id_mentions = ?", [mention.id])
      if (exists.length > 0) {
        await db.query(
          `UPDATE sentiment_analysis 
           SET sentiment_score = ?, sentiment_category = ?, language = ?, analyzedAt = NOW()
           WHERE id_mentions = ?`,
          [sentimentScore, category, language, mention.id]
        )
      } else {
        await db.query(
          `INSERT INTO sentiment_analysis 
           (id_mentions, sentiment_score, sentiment_category, language, analyzedAt)
           VALUES (?, ?, ?, ?, NOW())`,
          [mention.id, sentimentScore, category, language]
        )
      }
    }

    res.json({ message: "Analisis sentimen selesai diproses. Kalimat yang mengandung simbol atau emoji diabaikan." })
  } catch (err) {
    console.error(err)
    res.status(500).json({ message: "Gagal menganalisis sentimen", error: err.message })
  }
}
