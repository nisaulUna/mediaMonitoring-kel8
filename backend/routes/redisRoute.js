const express = require("express")
const router = express.Router()
const redisController = require("../controllers/redisController")
const auth = require("../../middlewares/authMiddleware")

router.post("/create", auth, redisController.createProject)
router.delete("/delete", auth, redisController.softDeleteProject)
router.delete("/restore", auth, redisController.restoreProject)
router.get('/recent-deleted', auth, redisController.getRecentlyDeletedProjects)
router.get('/top-searches', auth, redisController.getTodayHotSearches)
router.get('/dashboard-summary', auth, redisController.getRedisDashboard)
router.get('/user-activity/:userId', auth, redisController.getUserActivity)
router.get('/cache-stats', auth, redisController.getCacheStats)

module.exports = router
