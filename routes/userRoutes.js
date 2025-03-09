const express = require('express');
const router = express.Router();
const db = require('../db');

//POST user
router.post('/', (req, res) => {
  const { username, name, email, password, role } = req.body;
  if (!username || !email || !password || !role) {
    return res.status(400).json({ message: 'All fields are required' });
  }
  db.query('INSERT INTO user (username, name, email, password, role) VALUES (?, ?, ?, ?, ?)', 
  [username, name, email, password, role], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(201).json({ message: 'User created', id: result.insertId });
  });
});

router.get('/', (req, res) => {
  db.query('SELECT * FROM user', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json(results);
  });
});

// UPDATE User
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const { username, name, email, password, role } = req.body;

  if (!username || !email || !password || !role) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  db.query(
    'UPDATE user SET username = ?, name = ?, email = ?, password = ?, role = ? WHERE id = ?',
    [username, name, email, password, role, id],
    (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(200).json({ message: 'User updated' });
    }
  );
});

// DELETE User
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  db.query('DELETE FROM user WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json({ message: 'User deleted' });
  });
});

module.exports = router;
