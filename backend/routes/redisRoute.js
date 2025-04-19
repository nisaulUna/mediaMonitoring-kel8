const express = require("express")
const router = express.Router()
const redisController = require("../controllers/redisController")
const auth = require("../../middlewares/authMiddleware")

router.post("/create", auth, redisController.createProject)
router.delete("/delete", auth, redisController.softDeleteProject)
router.delete("/restore", auth, redisController.restoreProject)
router.get('/recent-deleted', redisController.getRecentlyDeletedProjects)
router.get('/top-searches', redisController.getTodayHotSearches)
router.get('/dashboard-summary', redisController.getRedisDashboard)
router.get('/user-activity/:userId', auth, redisController.getUserActivity)
router.get('/cache-stats', redisController.getCacheStats)

module.exports = router
