const rateLimit = require('express-rate-limit');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { db } = require('../config');

// Rate limiter
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 menit
    max: 20, // maksimal 20 permintaan per IP
    message: 'Too many requests, please try again later.'
});

// Konstanta action type
const ACTION_TYPES = {
    LOGIN: 'login',
    LOGOUT: 'logout',
    REGISTER: 'register',
    UPDATE_PROFILE: 'update_profile',
    DELETE_ACCOUNT: 'delete_account',
    FAILED_LOGIN: 'failed_login'
};

// Helper log activity
async function logActivity(userId, actionType, req, extraData = {}) {
    try {
        const actionDetails = JSON.stringify({
            ip: req.ip,
            userAgent: req.headers['user-agent'],
            ...extraData
        });

        await db.query(
            'INSERT INTO log_activities (id_user, action_type, action_details) VALUES (?, ?, ?)',
            [userId, actionType, actionDetails]
        );
    } catch (err) {
        console.error('Failed to log activity:', err);
    }
}

// Register
exports.register = [limiter, async (req, res) => {
    const { username, name, email, password } = req.body;

    if (!username || !name || !email || !password) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const [result] = await db.query(
            'INSERT INTO users (username, name, email, password) VALUES (?, ?, ?, ?)',
            [username, name, email, hashedPassword]
        );

        // Log activity
        await logActivity(result.insertId, ACTION_TYPES.REGISTER, req, { username, email });

        res.status(201).json({ message: 'User registered', id: result.insertId });
    } catch (err) {
        console.error('Error:', err);
        res.status(500).json({ error: 'Something went wrong' });
    }
}];

// Login
exports.login = [limiter, async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required' });
    }

    try {
        const [results] = await db.query('SELECT * FROM users WHERE username = ?', [username]);

        if (results.length === 0) {
            return res.status(401).json({ message: 'User not found' });
        }

        const user = results[0];
        const match = await bcrypt.compare(password, user.password);
        if (!match) {
            // Log failed login
            await logActivity(user.id, ACTION_TYPES.FAILED_LOGIN, req, { reason: 'Invalid password' });
            return res.status(401).json({ message: 'Invalid password' });
        }

        const token = jwt.sign(
            { id: user.id, username: user.username, role: user.role },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );

        // Log successful login
        await logActivity(user.id, ACTION_TYPES.LOGIN, req, { username });

        res.status(200).json({ message: 'Login successful', token });
    } catch (err) {
        console.error('Error:', err);
        res.status(500).json({ error: 'Something went wrong' });
    }
}];
