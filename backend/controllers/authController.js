const rateLimit = require('express-rate-limit');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const { db } = require('../config');
const { logActivity, ACTION_TYPES } = require('../activityLogger');
const { sendResetEmail } = require('../mailer');

// Rate limiter
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 menit
    max: 20, // maksimal 20 permintaan per IP
    message: 'Too many requests, please try again later.'
});

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

// Logout
exports.logout = async (req, res) => {
    try {
      console.log('DEBUG req.user:', req.user);
  
      const userId = req.user?.id;
      const username = req.user?.username;
  
      if (!userId || !username) {
        return res.status(400).json({ message: 'Invalid or missing user data in token.' });
      }
  
      if (req.cookies?.refreshToken) {
        res.clearCookie('refreshToken');
      }
  
      // Log logout activity
      const ipAddress = req.ip || req.connection.remoteAddress;
      await logActivity(userId, ACTION_TYPES.LOGOUT, req, {
        username,
        ip: ipAddress,
      });
  
      return res.status(200).json({
        message: 'Logout successful',
        details: 'Your session and token have been invalidated. Please log in again.',
      });
  
    } catch (err) {
      console.error('Error during logout:', err);
      return res.status(500).json({
        message: 'Something went wrong during logout.',
        error: err.message,
      });
    }
  };

  // Forget Password

exports.forgotPassword = async (req, res) => {
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ message: 'Email is required' });
    }

    try {
        // Cari user berdasarkan email
        const [results] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
        if (results.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        const user = results[0];

        // Buat token dan expired time
        const token = crypto.randomBytes(32).toString('hex');
        const expires = new Date(Date.now() + 60 * 60 * 1000); // 1 jam

        // Simpan token ke DB
        await db.query(
            'UPDATE users SET reset_token = ?, reset_token_expires = ? WHERE id = ?',
            [token, expires, user.id]
        );

        const resetLink = `http://localhost:3000/reset-password?token=${token}`;

        // Ambil akun email pengirim dari DB
        const [emailSettingsResult] = await db.query('SELECT * FROM email_settings WHERE purpose = "RESET_PASSWORD"');
        if (emailSettingsResult.length === 0) {
            return res.status(500).json({ message: 'Email settings not found' });
        }

        const { email: senderEmail, password: senderPass } = emailSettingsResult[0];

        // Kirim email reset
        await sendResetEmail(senderEmail, senderPass, user.email, resetLink);

        // Log aktivitas
        await logActivity(user.id, ACTION_TYPES.FORGOT_PASSWORD, req, { resetLink });

        res.json({ message: 'Password reset link has been sent to your email.' });

    } catch (err) {
        console.error('Forgot password error:', err);  // Log error lebih detail
        res.status(500).json({ message: 'Something went wrong', error: err.message });  // Kirim pesan error ke response
    }
};

// Reset Password
exports.resetPassword = async (req, res) => {
    const { token, newPassword } = req.body;

    if (!token || !newPassword) {
        return res.status(400).json({ message: 'Token and new password are required' });
    }

    try {
        // Cari user berdasarkan token yang diberikan
        const [results] = await db.query('SELECT * FROM users WHERE reset_token = ?', [token]);

        if (results.length === 0) {
            return res.status(400).json({ message: 'Invalid or expired token' });
        }

        const user = results[0];

        // Verifikasi apakah token sudah kedaluwarsa
        const tokenExpires = new Date(user.reset_token_expires);
        if (new Date() > tokenExpires) {
            return res.status(400).json({ message: 'Token has expired' });
        }

        // Hash password baru
        const hashedPassword = await bcrypt.hash(newPassword, 10);

        // Update password dan hapus token
        await db.query('UPDATE users SET password = ?, reset_token = NULL, reset_token_expires = NULL WHERE id = ?', 
            [hashedPassword, user.id]);

        // Kirimkan response sukses
        res.json({ message: 'Password has been reset successfully' });

    } catch (err) {
        console.error('Error resetting password:', err);
        res.status(500).json({ message: 'Something went wrong' });
    }
};