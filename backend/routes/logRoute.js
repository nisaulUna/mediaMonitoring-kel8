const express = require('express')
const router = express.Router()
const logController = require('../controllers/logController')

// NoSQL: Ambil email logs & export logs
router.get('/email-logs', logController.getEmailLogs)
router.get('/export-logs', logController.getExportLogs)
router.get('/test', (req, res) => {
    res.json({ message: 'Log route working' });
  });
module.exports = router
