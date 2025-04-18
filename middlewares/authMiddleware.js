const jwt = require('jsonwebtoken')

const authMiddleware = (req, res, next) => {
  const authHeader = req.headers.authorization

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Token tidak ditemukan atau format salah' })
  }

  const token = authHeader.split(' ')[1]
  console.log('Received token:', token)

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET)
    console.log('Decoded token:', decoded)
    req.user = decoded
    next()
  } catch (err) {
    console.error('Token error:', err.message)
    return res.status(403).json({ message: 'Token tidak valid atau kadaluarsa' })
  }
}

module.exports = authMiddleware
