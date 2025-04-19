const express = require("express")
const router = express.Router()
const backupController = require("../controllers/backupController")
const auth = require("../../middlewares/authMiddleware")

router.get("/", auth, backupController.getBackupList)
router.get("/:name", auth, backupController.getBackupFile)
router.delete("/:name", auth, backupController.deleteBackupFile)
router.put("/:name", auth, backupController.updateBackupFile)

module.exports = router
