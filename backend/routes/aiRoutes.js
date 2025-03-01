const express = require("express");
const { handleBloodRequest, assessUrgency, chatAssistant } = require("../services/aiService.js");

const router = express.Router();

router.post("/find-donor", async (req, res) => {
    const { bloodType, location } = req.body;
    const donor = await handleBloodRequest(bloodType, location);
    res.json({ donor });
});

router.post("/predict-urgency", (req, res) => {
    const { condition } = req.body;
    const urgencyLevel = assessUrgency(condition);
    res.json({ urgencyLevel });
});

router.post("/chat", async (req, res) => {
    const { message } = req.body;
    const response = await chatAssistant(message);
    res.json({ response });
});

module.exports = router;
