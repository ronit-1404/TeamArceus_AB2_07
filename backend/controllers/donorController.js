const User = require("../models/User.js");
const { findNearestDonor } = require("../ai/donorMatching.js");
const { sendNotification } = require("../services/notificationService.js");

exports.registerDonor = async (req, res) => {
    try {
        const { userId, lastDonationDate } = req.body;

        const user = await User.findById(userId);
        if (!user) return res.status(404).json({ message: "User not found" });

        user.isDonor = true;
        if (lastDonationDate) {
            user.donationHistory.push({ date: lastDonationDate });
        }
        await user.save();

        res.status(201).json({ message: "User registered as donor successfully", user });
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
};

exports.updateAvailability = async (req, res) => {
    try {
        const { userId } = req.params;
        const { isAvailable } = req.body;

        const user = await User.findById(userId);
        if (!user) return res.status(404).json({ message: "User not found" });

        if (!user.isDonor) {
            return res.status(400).json({ message: "User is not a registered donor" });
        }

        user.isActive = isAvailable;
        await user.save();

        res.json({ message: "Availability updated", user });
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
};

exports.requestBlood = async (req, res) => {
    try {
        const { bloodType, userLocation } = req.body;

        if (!bloodType || !userLocation) {
            return res.status(400).json({ message: "Missing required fields" });
        }

        const nearestDonor = await findNearestDonor(bloodType, userLocation);

        if (!nearestDonor) {
            return res.status(404).json({ message: "No available donors nearby" });
        }

        if (nearestDonor.notificationToken) {
            await sendNotification(
                nearestDonor.notificationToken,
                "Urgent Blood Request",
                `A nearby patient urgently needs your blood type (${bloodType}).`
            );
        }

        res.json({ message: "Nearest donor found and notified", donor: nearestDonor });
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
};

exports.getAllDonors = async (req, res) => {
    try {
        const donors = await User.find({ isDonor: true }); // Fetch only donors
        res.status(200).json(donors);
    } catch (error) {
        res.status(500).json({ message: "Server error", error: error.message });
    }
};