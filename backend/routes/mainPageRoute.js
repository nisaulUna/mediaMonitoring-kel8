const express = require("express")
const router = express.Router()
const mainController = require("../controllers/mainPageController")

// Route untuk buat project
router.post("/search/cache", mainController.createProject)

// Route untuk analisis sentimen
router.post("/search/sentiment", mainController.analyzeSentiment)

module.exports = router