const express = require('express');
const router = express.Router();
const db = require('../db');

router.post('/', (req, res) => {
    const { project_id, keyword, is_active} = req.body;
 
    if (!project_id || !keyword || is_active === undefined) {
      return res.status(400).json({ message: 'All fields are required' });
    }
  
    // Cek apakah project_id ada di tabel project
    db.query('SELECT id FROM project WHERE id = ?', [project_id], (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
  
      if (results.length === 0) {
        return res.status(400).json({ message: 'Invalid project_id. Project does not exist.' });
      }
  
      db.query(
        'INSERT INTO keywords (project_id, keyword, is_active, createdAt) VALUES (?, ?, ?, NOW())',
        [project_id, keyword, is_active],
        (err, result) => {
          if (err) return res.status(500).json({ error: err.message });
          res.status(201).json({ message: 'Keyword created', id: result.insertId });
        }
      );
    });
  });  

// GET Keywords
router.get('/', (req, res) => {
  db.query('SELECT * FROM keywords', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json(results);
  });
});

// UPDATE Keyword (Tidak mengupdate project_id)
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const { keyword, is_active} = req.body;

  if (!keyword || is_active === undefined) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  db.query(
    'UPDATE keywords SET keyword = ?, is_active = ?, createdAt = NOW() WHERE id = ?',
    [keyword, is_active, id],
    (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(200).json({ message: 'Keyword updated' });
    }
  );
});

// DELETE Keyword
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  db.query('DELETE FROM keywords WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json({ message: 'Keyword deleted' });
  });
});

module.exports = router;
