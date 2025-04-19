const express = require('express');
const router = express.Router();
const reportController = require('../controllers/reportController');
const auth = require("../../middlewares/authMiddleware")

router.get('/', auth, reportController.getReports); 
router.post('/create', reportController.createReport);
router.put('/update', auth, reportController.updateReport);
router.delete('/delete', auth, reportController.deleteReport);

module.exports = router;
