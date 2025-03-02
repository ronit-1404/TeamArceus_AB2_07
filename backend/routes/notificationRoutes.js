const express = require("express")
const {getNotifications} = require("../controllers/notificationController.js")

const router = express.Router();

router.get('/notification',getNotifications);

module.exports = router;