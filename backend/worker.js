require("dotenv").config()
const axios = require("axios")
const { db, redis } = require("./config")
const franc = require('franc')

async function runWorker() {

    const keywords = await redis.smembers("keywordSet")
    if (!keywords.length) return

    for (const keyword of keywords){
        try {
            // Ambil id keyword
            const [rows] = await db.query("SELECT id FROM keywords WHERE keyword = ?", [keyword])
            const keywordId = rows[0].id

            try {
                // TWITTER
                const response = await axios.get("https://api.twitter.com/2/tweets/search/recent", {
                    params: {
                    query: keyword,
                    max_results: 10,
                    "tweet.fields": "created_at,author_id,lang,public_metrics",
                    "user.fields": "username,profile_image_url",
                    "expansions": "author_id"
                    },
                    headers: {
                    Authorization: `Bearer ${process.env.TWITTER_BEARER_TOKEN}`
                    }
                })
            
                const tweets = response.data.data || []
                const users = response.data.includes?.users || []
            
                for (const tweet of tweets) {

                    const user = users.find(u => u.id === tweet.author_id)
                
                    const tweetUrl = `https://twitter.com/i/web/status/${tweet.id}`
                    const [exists] = await db.query("SELECT id FROM media_mentions WHERE url = ?", [tweetUrl])
                    if (exists.length > 0) {
                        console.log(`Tweet sudah ada: ${tweetUrl}`)
                        continue
                    }

                    await db.query(`
                        INSERT INTO media_mentions (
                        id_keyword, id_mediaSource, content, url,
                        published_date, author, profile_image
                        )
                        VALUES (?, ?, ?, ?, ?, ?, ?)`,
                        [
                            keywordId,
                            1, // mediaSource Twitter
                            tweet.text,
                            tweetUrl,
                            tweet.created_at,
                            user?.username || 'unknown',
                            user?.profile_image_url || null
                        ]
                    )
                }
                console.log(`Berhasil proses ${tweets.length} tweet untuk keyword "${keyword}"`)
            }catch (err) {
                console.error("Twitter error:", err.message)
            }
            
            try {
                // YOUTUBE
                const searchRes = await axios.get("https://www.googleapis.com/youtube/v3/search", {
                    params: {
                    q: keyword,
                    part: "snippet",
                    maxResults: 1, // ambil 1 video aja
                    type: "video",
                    key: process.env.YOUTUBE_API_KEY
                    }
                })

                const video = searchRes.data.items?.[0]
                if (video) {
                    const videoId = video.id.videoId
            
                    const commentRes = await axios.get("https://www.googleapis.com/youtube/v3/commentThreads", {
                    params: {
                        part: "snippet",
                        videoId: videoId,
                        maxResults: 10,
                        key: process.env.YOUTUBE_API_KEY
                    }
                    })

                    const comments = commentRes.data.items || []

                    for (const item of comments) {
                        const comment = item.snippet.topLevelComment.snippet

                        const videoTitle = video.snippet.title
                        const content = `${videoTitle}: ${comment.textDisplay}`

                        const commentUrl = `https://www.youtube.com/watch?v=${videoId}`
                        const [exists] = await db.query("SELECT id FROM media_mentions WHERE url = ? AND content = ?", [
                            commentUrl,
                            content
                        ])
                        if (exists.length > 0) {
                            console.log(`Komentar YouTube sudah ada: ${comment.textDisplay}`)
                            continue
                        }

                        await db.query(`
                            INSERT INTO media_mentions (
                                id_keyword, id_mediaSource, content, url,
                                published_date, author, profile_image
                            ) 
                                VALUES (?, ?, ?, ?, ?, ?, ?)`,
                                [
                                    keywordId,
                                    2, // mediaSource YouTube
                                    content,
                                    commentUrl,
                                    comment.publishedAt,
                                    comment.authorDisplayName,
                                    comment.authorProfileImageUrl
                                ]
                        )
                    }
                    console.log(`Berhasil proses ${comments.length} comment pada youtube untuk keyword "${keyword}"`)
                }
            }catch (err) {
                console.error("YouTube error:", err.message)
            }

            try {
                // SERPER.DEV
                const serperRes = await axios.post("https://google.serper.dev/news", {
                    q: keyword
                }, {
                    headers: {
                    "X-API-KEY": process.env.SERPER_API_KEY,
                    "Content-Type": "application/json"
                    }
                })

                const articles = (serperRes.data.news || []).slice(0, 10)

                for (const article of articles) {
                
                    const [exists] = await db.query("SELECT id FROM media_mentions WHERE url = ?", [article.link])
                    if (exists.length > 0) {
                        console.log(`Artikel sudah ada: ${article.link}`)
                        continue
                    }
                
                    await db.query(`
                        INSERT INTO media_mentions (
                            id_keyword, id_mediaSource, content, url,
                            published_date, author, profile_image
                        ) VALUES (?, ?, ?, ?, ?, ?, ?)`, 
                         [
                            keywordId,
                            3,
                            article.snippet || article.title,
                            article.link,
                            article.date,
                            article.source || 'unknown',
                            null
                        ]
                    )
                }                
                console.log(`Berhasil serper ${articles.length} artikel (Kompas & Medium) "${keyword}"`)   
            }catch (err) {
                console.error("Serper error:", err.message)
            }
        } catch (err) {
        console.error("Worker error:", err.message)
        }
    }
}

setInterval(async () => {
    await runWorker()
  
    try {
      await axios.post("http://localhost:3000/search/sentiment")
      console.log(" Sentimen untuk seluruh mentions telah dianalisis.")
    } catch (err) {
      console.error(" Gagal hit sentimen API:", err.message)
    }
  }, 30000) // per hari (setengah menit)