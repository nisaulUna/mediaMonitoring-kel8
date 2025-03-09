const express = require('express');
const router = express.Router();
const db = require('../db');

// Get all sentiment analysis records
router.get('/', (req, res) => {
    db.query('SELECT * FROM sentiment_analysis', (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// Get one sentiment analysis record by ID
router.get('/:id', (req, res) => {
    db.query('SELECT * FROM sentiment_analysis WHERE id = ?', [req.params.id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ message: 'Sentiment analysis record not found' });
        }
        res.json(results[0]);
    });
});

// Create new sentiment analysis record
router.post('/', (req, res) => {
    const { media_mention_id, sentiment, confidence_score } = req.body;
    db.query(
        'INSERT INTO sentiment_analysis (media_mention_id, sentiment, confidence_score) VALUES (?, ?, ?)', 
        [media_mention_id, sentiment, confidence_score],
        (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            res.json({ id: result.insertId, media_mention_id, sentiment, confidence_score });
        }
    );
});

// Update sentiment analysis record
router.put('/:id', (req, res) => {
    const { media_mention_id, sentiment, confidence_score } = req.body;
    db.query(
        'UPDATE sentiment_analysis SET media_mention_id = ?, sentiment = ?, confidence_score = ? WHERE id = ?', 
        [media_mention_id, sentiment, confidence_score, req.params.id],
        (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            if (result.affectedRows === 0) {
                return res.status(404).json({ message: 'Sentiment analysis record not found' });
            }
            res.json({ message: 'Sentiment analysis record updated' });
        }
    );
});

// Delete sentiment analysis record
router.delete('/:id', (req, res) => {
    db.query('DELETE FROM sentiment_analysis WHERE id = ?', [req.params.id], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Sentiment analysis record not found' });
        }
        res.json({ message: 'Sentiment analysis record deleted' });
    });
});

module.exports = router;
