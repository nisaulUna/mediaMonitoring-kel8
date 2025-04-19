const express = require("express")
const router = express.Router()
const projectController = require("../controllers/projectController")
const auth = require("../../middlewares/authMiddleware")

router.get("/", auth, projectController.getProjectDeleteReminders)

module.exports = router
