const Donation = require("../models/Donation.js")

exports.recordDonation = async (req,res) => {
    try {
        const {donorId, recipientId,bloodType,location} = req.body;
        const donation = new Donation({
            donorId,
            recipientId,
            bloodType,
            location
        });
        await donation.save();
        res.status(201).json({ message: "Donation recorded successfully!", donation })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

exports.getDonations = async (req,res) => {
    try {
        const donations = await Donation.find().populate("donorId recipientId");
        res.status(200).json(donations);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}