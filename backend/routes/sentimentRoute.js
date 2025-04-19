const express = require("express")
const router = express.Router()
const sentimentController = require("../controllers/sentimentController")

router.post("/", sentimentController.analyzeSentiment)
router.get("/positive-sentiment-summary", sentimentController.getPositiveSentimentSummary)
router.get("/negative-sentiment-summary", sentimentController.getNegativeSentimentSummary)
router.get("/neutral-sentiment-summary", sentimentController.getNeutralSentimentSummary)

module.exports = router