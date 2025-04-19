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
  const userId = req.user.id
  try {
    const [results] = await db.query('SELECT id, username, name, email FROM users WHERE id = ?', [userId]);
    if (results.length === 0) return res.status(404).json({ message: 'User not found' });
    res.status(200).json(results[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Update user
exports.updateUser = async (req, res) => {
  const userId = req.user.id
  const { username, name, email, password } = req.body;

  if (!username || !email || !password || !name) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.query(
      'UPDATE users SET username = ?, name = ?, email = ?, password = ? WHERE id = ?',
      [username, name, email, hashedPassword, userId]
    );
    res.status(200).json({ message: 'User updated' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Delete user
exports.deleteUser = async (req, res) => {
  const userId = req.user.id
  try {

    const [projects] = await db.query(
      'SELECT project_name FROM projects WHERE id_user = ? AND is_active = 1',
      [userId]
    )

    await db.query(
      'UPDATE projects SET is_active = 0, deletedAt = NOW() WHERE id_user = ?',
      [userId]
    )

    for (const project of projects) {
      const project_name = project.project_name
      await redis.set(
        `delete_project:${project_name}:${userId}`,
        JSON.stringify({ project_name, userId: userId })
      )
    }

    await db.query('DELETE FROM users WHERE id = ?', [userId]);
    res.status(200).json({ message: 'User deleted' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
