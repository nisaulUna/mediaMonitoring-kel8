const { db } = require('../config');
const Sentiment = require("sentiment")
const sentiment = new Sentiment()
const franc = require('franc')


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
  
      res.json({ message: "Analisis sentimen selesai diproses." })
    } catch (err) {
      console.error(err)
      res.status(500).json({ message: "Gagal menganalisis sentimen", error: err.message })
    }
  }

  // Mengambil jumlah sentimen positif
  exports.getPositiveSentimentSummary = async (req, res) => {
    try {
      const [rows] = await db.query(`
        SELECT COUNT(*) AS count
        FROM sentiment_analysis
        WHERE sentiment_category = 'positive'
      `)
  
      const count = rows[0].count
      res.json({ positive: count })
    } catch (err) {
      console.error(err)
      res.status(500).json({ message: "Gagal mengambil jumlah sentimen positif", error: err.message })
    }
  }
  
  // Mengambil Jumlah Sentimen Negatif
  exports.getNegativeSentimentSummary = async (req, res) => {
    try {
      const [rows] = await db.query(`
        SELECT COUNT(*) AS count
        FROM sentiment_analysis
        WHERE sentiment_category = 'negative'
      `)
  
      const count = rows[0].count
      res.json({ negative: count })
    } catch (err) {
      console.error(err)
      res.status(500).json({ message: "Gagal mengambil jumlah sentimen negatif", error: err.message })
    }
  }

  // Mengambil Jumlah sentimen netral
  exports.getNeutralSentimentSummary = async (req, res) => {
    try {
      const [rows] = await db.query(`
        SELECT COUNT(*) AS count
        FROM sentiment_analysis
        WHERE sentiment_category = 'neutral'
      `)
  
      const count = rows[0].count
      res.json({ neutral: count })
    } catch (err) {
      console.error(err)
      res.status(500).json({ message: "Gagal mengambil jumlah sentimen netral", error: err.message })
    }
  }
  