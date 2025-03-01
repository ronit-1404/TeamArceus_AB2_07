const { findNearestDonor } = require("../ai/donorMatching.js");
const { predictUrgency } = require("../ai/urgencyPredictionAI.js");
const { chatWithAI } = require("../ai/chatAssistantAI.js");

exports.handleBloodRequest = async (bloodType, location) => {
    const nearestDonor = await findNearestDonor(bloodType, location);
    return nearestDonor ? nearestDonor : "No donors available nearby.";
};

exports.assessUrgency = (condition) => predictUrgency(condition);

exports.chatAssistant = async (message) => await chatWithAI(message);
