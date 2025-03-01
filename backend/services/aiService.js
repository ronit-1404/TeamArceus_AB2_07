const { findNearestDonor } = require("../ai/donorMatching.js");
const { predictUrgency } = require("../ai/urgencyPredictionAI.js")

exports.handleBloodRequest = async (bloodType, location) => {
    const nearestDonor = await findNearestDonor(bloodType, location);
    return nearestDonor ? nearestDonor : "No donors available nearby.";
};

exports.assessUrgency = (condition) => predictUrgency(condition);


