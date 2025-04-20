const express = require('express')
const router = express.Router()
const logController = require('../controllers/logController')

// NoSQL: Ambil email logs & export logs
router.get('/email-logs', logController.getEmailLogs)
router.get('/export-logs', logController.getExportLogs)
router.get('/activity-logs', logController.getActivityLogs)
router.get('/test', (req, res) => {
    res.json({ message: 'Log route working' });
  });
  router.post('/activity-logs', async (req, res) => {
    const { userId, action, target } = req.body;
  
    try {
      await logController.logActivity(userId, action, target);
      res.json({ message: 'Log aktivitas berhasil disimpan' });
    } catch (err) {
      res.status(500).json({ error: 'Gagal simpan log aktivitas' });
    }
  });
// Simpan log email (POST)
router.post('/email-logs', async (req, res) => {
    const { userId, email, subject } = req.body;
  
    try {
      await logController.logEmail(userId, email, subject);
      res.json({ message: 'Log email berhasil disimpan' });
    } catch (err) {
      res.status(500).json({ error: 'Gagal simpan log email' });
    }
  });
  
  // Simpan log export (POST)
  router.post('/export-logs', async (req, res) => {
    const { userId, projectName, format } = req.body;
  
    try {
      await logController.logExport(userId, projectName, format);
      res.json({ message: 'Log export berhasil disimpan' });
    } catch (err) {
      res.status(500).json({ error: 'Gagal simpan log export' });
    }
  });
    
module.exports = router
