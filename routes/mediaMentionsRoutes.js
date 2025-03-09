const express = require('express');
const router = express.Router();
const db = require('../db');

// Get all media mentions (Tanpa Promise)
router.get('/', (req, res) => {
    db.query('SELECT * FROM media_mentions', (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// Get one media mention by ID
router.get('/:id', (req, res) => {
    db.query('SELECT * FROM media_mentions WHERE id = ?', [req.params.id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: 'Media mention not found' });
        }
        res.json(results[0]);
    });
});

// Create new media mention
router.post('/', (req, res) => {
    const { media_source_id, mention_text, mention_date } = req.body;
    db.query(
        'INSERT INTO media_mentions (media_source_id, mention_text, mention_date) VALUES (?, ?, ?)', 
        [media_source_id, mention_text, mention_date],
        (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            res.json({ id: result.insertId, media_source_id, mention_text, mention_date });
        }
    );
});

// Update media mention
router.put('/:id', (req, res) => {
    const { media_source_id, mention_text, mention_date } = req.body;
    db.query(
        'UPDATE media_mentions SET media_source_id = ?, mention_text = ?, mention_date = ? WHERE id = ?', 
        [media_source_id, mention_text, mention_date, req.params.id],
        (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            if (result.affectedRows === 0) {
                return res.status(404).json({ message: 'Media mention not found' });
            }
            res.json({ message: 'Media mention updated' });
        }
    );
});

// Delete media mention
router.delete('/:id', (req, res) => {
    db.query('DELETE FROM media_mentions WHERE id = ?', [req.params.id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Media mention not found' });
        }
        res.json({ message: 'Media mention deleted' });
    });
});

module.exports = router;
