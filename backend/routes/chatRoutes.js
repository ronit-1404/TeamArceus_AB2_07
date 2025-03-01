const express = require("express");
const { sendMessage } = require("../controllers/chatController.js");
const { authMiddleware } = require("../middlewares/authMiddleware.js");

const router = express.Router();

router.post("/send", authMiddleware, sendMessage);

module.exports = router;
