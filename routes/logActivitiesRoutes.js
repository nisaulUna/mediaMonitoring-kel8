const express = require('express');
const router = express.Router();
const db = require('../db');

// CREATE Log Activities
router.post('/', (req, res) => {
  const { id_user, action_type, action_details } = req.body;
  if (!id_user || !action_type || !action_details) {
    return res.status(400).json({ message: 'All fields are required' });
  }
  
  db.query(
    'INSERT INTO log_activities (id_user, action_type, action_details, createdAt) VALUES (?, ?, ?, NOW())',
    [id_user, action_type, action_details],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ message: 'Log activity created', id: result.insertId });
    }
  );
});

// READ Log Activities
router.get('/', (req, res) => {
  db.query('SELECT * FROM log_activities', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json(results);
  });
});

// UPDATE Log Activities
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const { action_type, action_details } = req.body;

  if (!action_type || !action_details) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  db.query(
    'UPDATE log_activities SET action_type = ?, action_details = ? WHERE id = ?',
    [action_type, action_details, id],
    (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(200).json({ message: 'Log activity updated' });
    }
  );
});

// DELETE Log Activities
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  db.query('DELETE FROM log_activities WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json({ message: 'Log activity deleted' });
  });
});

module.exports = router;