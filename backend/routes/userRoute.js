const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require("../../middlewares/authMiddleware")

router.get('/', userController.getUsers);
router.get('/detail', auth,userController.getUserById);
router.put('/update', auth, userController.updateUser);
router.delete('/delete', auth, userController.deleteUser);
router.get('/logs', auth, userController.getLoginLogs);

module.exports = router;
