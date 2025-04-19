const { db } = require('../config');
const bcrypt = require('bcrypt');

// Get all users
exports.getUsers = async (req, res) => {
  try {
    const [results] = await db.query('SELECT id, username, name, email FROM users');
    res.status(200).json(results);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get user by ID
exports.getUserById = async (req, res) => {
  const { id } = req.params;
  try {
    const [results] = await db.query('SELECT id, username, name, email FROM users WHERE id = ?', [id]);
    if (results.length === 0) return res.status(404).json({ message: 'User not found' });
    res.status(200).json(results[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Create new user
exports.createUser = async (req, res) => {
  const { username, name, email, password } = req.body;
  if (!username || !email || !password || !name) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const [result] = await db.query(
      'INSERT INTO users (username, name, email, password) VALUES (?, ?, ?, ?)',
      [username, name, email, hashedPassword]
    );
    res.status(201).json({ message: 'User created', id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Update user
exports.updateUser = async (req, res) => {
  const { id } = req.params;
  const { username, name, email, password } = req.body;

  if (!username || !email || !password || !name) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.query(
      'UPDATE users SET username = ?, name = ?, email = ?, password = ? WHERE id = ?',
      [username, name, email, hashedPassword, id]
    );
    res.status(200).json({ message: 'User updated' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Delete user
exports.deleteUser = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('DELETE FROM users WHERE id = ?', [id]);
    res.status(200).json({ message: 'User deleted' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
