const rateLimit = require('express-rate-limit');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { db } = require('../config');

// Membuat rate limiter untuk login dan register
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 menit
    max: 20, // maksimal 5 permintaan per IP dalam waktu 15 menit
    message: 'Too many requests, please try again later.'
});

// Apply limiter middleware hanya untuk rute login dan register
exports.register = [limiter, async (req, res) => {
    const { username, name, email, password } = req.body;

    if (!username || !name || !email || !password ) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const [result] = await db.query(
            'INSERT INTO users (username, name, email, password) VALUES (?, ?, ?, ?)',
            [username, name, email, hashedPassword]
        );

        res.status(201).json({ message: 'User registered', id: result.insertId });
    } catch (err) {
        console.error('Error:', err);  // Menampilkan error di konsol
        res.status(500).json({ error: 'Something went wrong' });
    }
}];

// Login (Sign In) dengan rate limiting
exports.login = [limiter, async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required' });
    }

    try {
        const [results] = await db.query('SELECT * FROM users WHERE username = ?', [username]); // Ganti 'user' jadi 'users'

        if (results.length === 0) {
            return res.status(401).json({ message: 'User not found' });
        }

        const user = results[0];
        const match = await bcrypt.compare(password, user.password);
        if (!match) {
            return res.status(401).json({ message: 'Invalid password' });
        }

        const token = jwt.sign(
            { id: user.id, username: user.username, role: user.role },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );

        res.status(200).json({ message: 'Login successful', token });
    } catch (err) {
        console.error('Error:', err);  // Menampilkan error di konsol
        res.status(500).json({ error: 'Something went wrong' });
    }
}];