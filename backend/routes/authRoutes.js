const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const authMiddleware = require('../../middlewares/authMiddleware'); 

router.post('/register', authController.register);
router.post('/login', authController.login);
router.post('/logout', authMiddleware , authController.logout);
router.post('/forgot-password', authController.forgotPassword);
router.post('/reset-password', authController.resetPassword);

module.exports = router;