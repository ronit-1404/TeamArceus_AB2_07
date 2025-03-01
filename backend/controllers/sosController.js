const SOSAlert = require("../models/SOSAlert.js");

exports.triggerSOS = async (req, res) => {
    try {
        const { userId, emergencyType, location } = req.body;
        const sos = new SOSAlert({ userId, emergencyType, location });
        await sos.save();
        res.status(201).json({ message: "SOS Alert triggered!", sos });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
