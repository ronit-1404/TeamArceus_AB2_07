const express = require("express")
const {getNotifications} = require("../controllers/notificationController.js")
const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.get('/notification',getNotifications);

module.exports = router;