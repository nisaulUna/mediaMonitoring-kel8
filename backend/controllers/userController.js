const { db } = require('../config');
const bcrypt = require('bcrypt');
const { logActivity, ACTION_TYPES } = require('../activityLogger');

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
  const userId = req.user.id;
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
// Log aktivitas update user

    const ipAddress = req.ip || req.connection.remoteAddress;
    await logActivity(userId, ACTION_TYPES.UPDATE_PROFIL, req, {
      username,
      email,
      ip: ipAddress,
      message: 'User profile updated'
    });

    res.status(200).json({ message: 'User updated' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Delete user
exports.deleteUser = async (req, res) => {
  const userId = req.user.id;
  const username = req.user.username; 

  try {
    // Ambil proyek aktif milik user
    const [projects] = await db.query(
      'SELECT project_name FROM projects WHERE id_user = ? AND is_active = 1',
      [userId]
    );

    // Nonaktifkan proyek
    await db.query(
      'UPDATE projects SET is_active = 0 WHERE id_user = ?',
      [userId]
    );

    // Simpan info ke Redis
    for (const project of projects) {
      const project_name = project.project_name;
      await redis.set(
        `delete_project:${project_name}:${userId}`,
        JSON.stringify({ project_name, userId })
      );
    }

    // Hapus user dari database
    await db.query('DELETE FROM log_activities WHERE id_user = ?', [userId]);
    await db.query('DELETE FROM users WHERE id = ?', [userId]);

    res.status(200).json({ message: 'User deleted' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

//mengambil semua aktivitas login user
exports.getLoginLogs = async (req, res) => {
  try {
    const userId = req.user?.id;
    console.log('DEBUG userId:', userId); // Tambahin ini untuk cek user

    if (!userId) {
      return res.status(401).json({ message: 'Unauthorized' });
    }

    const [results] = await db.query(
      'SELECT COUNT(*) AS loginCount FROM log_activities WHERE id_user = ? AND action_type = ?',
      [userId, ACTION_TYPES.LOGIN]
    );

    console.log('DEBUG login count query result:', results); // Debug hasil query

    res.json({ loginCount: results[0].loginCount });
  } catch (err) {
    console.error('❌ Error fetching login count:', err);
    res.status(500).json({ message: 'Failed to fetch login count', error: err.message });
  }
};

