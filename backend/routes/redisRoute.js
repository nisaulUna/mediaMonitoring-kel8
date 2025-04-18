const express = require("express")
const router = express.Router()
const redisController = require("../controllers/redisController")
const auth = require("../../middlewares/authMiddleware")

router.post("/create", auth, redisController.createProject)
router.delete("/delete", auth, redisController.softDeleteProject)
router.delete("/restore", auth, redisController.restoreProject)

module.exports = router
