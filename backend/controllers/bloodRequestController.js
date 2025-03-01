const BloodRequest = require("../models/BloodRequest.js")
const { handleBloodRequest } = require("../services/aiService.js");

exports.createRequest = async (req, res) => {
    try {
        const { recipientId, bloodType, urgency, hospital, location } = req.body;
        const request = new BloodRequest({ recipientId, bloodType, urgency, hospital });

        await request.save();
        
        
        const nearestDonor = await handleBloodRequest(bloodType, location);

        res.status(201).json({
            message: "Blood request created successfully!",
            request,
            nearestDonor
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
exports.getRequests = async (req,res) => {
    try {
        const requests = await BloodRequest.findById("recipientId")
        res.status(200).json(requests);
    } catch (error) {
        res.status(500).json({ error: error.message });      
    }
}