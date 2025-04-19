const express = require("express")
const router = express.Router()
const remainderContoller = require("../controllers/remainderContoller")
const auth = require("../../middlewares/authMiddleware")

router.get("/", auth, remainderContoller.getProjectDeleteReminders)

module.exports = router
