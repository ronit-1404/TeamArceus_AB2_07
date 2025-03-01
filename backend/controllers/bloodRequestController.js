const BloodRequest = require("../models/BloodRequest.js")

exports.createRequest= async (req,res) => {
    try {
        const {recipientId,bloodType,urgency,hospital} = req.body;
        const request = new BloodRequest({
            recipientId,
            bloodType,
            urgency,
            hospital
        })
        await request.save();
        res.status(201).json({ message: "Blood request created successfully!", request })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

exports.getRequests = async (req,res) => {
    try {
        const requests = await BloodRequest.findById("recipientId")
        res.status(200).json(requests);
    } catch (error) {
        res.status(500).json({ error: error.message });      
    }
}