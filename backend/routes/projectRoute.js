const express = require("express")
const router = express.Router()
const projectController = require("../controllers/projectController")
const auth = require("../../middlewares/authMiddleware")

router.post("/create", auth, projectController.createProject)
router.get("/mentions", auth, projectController.getMentions)
router.get("/summary/platform", auth, projectController.getPlatformSummary)
router.get("/summary/language", auth, projectController.getLanguageSummary)
router.get("/summary/sentiment", auth, projectController.getSentimentSummary)
router.delete("/delete", auth, projectController.deleteProject)

module.exports = router
