const express = require("express")
const router = express.Router()
const projectController = require("../controllers/projectController")
const auth = require("../../middlewares/authMiddleware")

router.get("/mentions", auth, projectController.getMentions)
router.get("/summary/platform", auth, projectController.getPlatformSummary)
router.get("/summary/language", auth, projectController.getLanguageSummary)
router.get("/summary/sentiment", auth, projectController.getSentimentSummary)

module.exports = router
