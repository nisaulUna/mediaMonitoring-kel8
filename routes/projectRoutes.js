const express = require('express');
const router = express.Router();
const db = require('../db');

// POST Project
router.post('/', (req, res) => {
  const { id_user, project_name, description, is_active } = req.body;
  
  if (!id_user || !project_name || !description || is_active === undefined) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  db.query(
    'INSERT INTO project (id_user, project_name, description, is_active, createdAt, updatedAt) VALUES (?, ?, ?, ?, NOW(), NOW())',
    [id_user, project_name, description, is_active],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ message: 'Project created', id: result.insertId });
    }
  );
});

// GET Project
router.get('/', (req, res) => {
  db.query('SELECT * FROM project', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json(results);
  });
});

// UPDATE Project
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const { id_user, project_name, description, is_active } = req.body;

  if (!id_user || !project_name || !description || is_active === undefined) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  db.query(
    'UPDATE project SET id_user = ?, project_name = ?, description = ?, is_active = ?, updatedAt = NOW() WHERE id = ?',
    [id_user, project_name, description, is_active, id],
    (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(200).json({ message: 'Project updated' });
    }
  );
});

// DELETE Project
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  db.query('DELETE FROM project WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json({ message: 'Project deleted' });
  });
});

module.exports = router;
