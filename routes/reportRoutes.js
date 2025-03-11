const express = require('express');
const router = express.Router();
const db = require('../db');

//POST Reports
router.post('/', (req, res) => {
    const { project_id, created_by, report_type, report_parameters, report_data, expiresAt } = req.body;
  
    if (!project_id || !created_by || !report_type || !report_parameters || !report_data || !expiresAt || isNaN(Date.parse(expiresAt))) {
      return res.status(400).json({ message: 'All fields except generatedAt are required' });
    }
  
    // Cek apakah project_id ada di tabel project
    db.query('SELECT id FROM project WHERE id = ?', [project_id], (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
  
      if (results.length === 0) {
        return res.status(400).json({ message: 'Invalid project_id. Project does not exist.' });
      }
  
      const expiresAtFormatted = new Date(expiresAt).toISOString().slice(0, 19).replace('T', ' ');

      db.query(
        'INSERT INTO reports (project_id, created_by, report_type, report_parameters, report_data, generatedAt, expiresAt) VALUES (?, ?, ?, ?, ?, NOW(), ?)',
        [project_id, created_by, report_type, report_parameters, report_data, expiresAtFormatted],
        (err, result) => {
          if (err) return res.status(500).json({ error: err.message });
          res.status(201).json({ message: 'Report created', id: result.insertId });
        }
      );
    });
});
 

// GET Reports
router.get('/', (req, res) => {
  db.query('SELECT * FROM reports', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json(results);
  });
});

// UPDATE Report (Tidak mengupdate project_id)
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const { created_by, report_type, report_parameters, report_data, expiresAt } = req.body;

  if (!created_by || !report_type || !report_parameters || !report_data || !expiresAt || isNaN(Date.parse(expiresAt))) {
    return res.status(400).json({ message: 'All fields are required' });
  }

  const expiresAtFormatted = new Date(expiresAt).toISOString().slice(0, 19).replace('T', ' ');

  db.query(
    'UPDATE reports SET created_by = ?, report_type = ?, report_parameters = ?, report_data = ?, expiresAt = ? WHERE id = ?',
    [created_by, report_type, report_parameters, report_data, expiresAtFormatted, id],
    (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(200).json({ message: 'Report updated' });
    }
  );
});

// DELETE Report
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  db.query('DELETE FROM reports WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(200).json({ message: 'Report deleted' });
  });
});

module.exports = router;
