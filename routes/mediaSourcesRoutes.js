const express = require('express');
const router = express.Router();
const db = require('../db');

// Get all media sources
router.get('/', (req, res) => {
    db.query('SELECT * FROM media_sources', (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// Get one media source by ID
router.get('/:id', (req, res) => {
    db.query('SELECT * FROM media_sources WHERE id = ?', [req.params.id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: 'Media source not found' });
        }
        res.json(results[0]);
    });
});

// Create new media source
router.post('/', (req, res) => {
    const { name, url } = req.body;
    db.query('INSERT INTO media_sources (name, url) VALUES (?, ?)', [name, url], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json({ id: result.insertId, name, url });
    });
});

// Update media source
router.put('/:id', (req, res) => {
    const { name, url } = req.body;
    db.query('UPDATE media_sources SET name = ?, url = ? WHERE id = ?', [name, url, req.params.id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Media source not found' });
        }
        res.json({ message: 'Media source updated' });
    });
});

// Delete media source
router.delete('/:id', (req, res) => {
    db.query('DELETE FROM media_sources WHERE id = ?', [req.params.id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Media source not found' });
        }
        res.json({ message: 'Media source deleted' });
    });
});

module.exports = router;
