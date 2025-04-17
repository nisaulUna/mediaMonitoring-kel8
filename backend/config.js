require('dotenv').config()
const Redis = require('ioredis')
const mysql = require("mysql2/promise")

// MySQL
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
})

db.getConnection()
  .then(conn => {
    console.log('Connected to db')
    conn.release()
  })
  .catch(err => {
    console.error('DB Error:', err)
  })

// Redis
const redis = new Redis({
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT,
  db: process.env.REDIS_DB,
})

redis.on('connect', () => {
  console.log('Connected to redis')
})

redis.on('error', (err) => {
  console.log('Redis Error:', err)
})

module.exports = {
  redis,
  db
}