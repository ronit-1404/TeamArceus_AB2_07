const Notification = require("../models/Notification.js");

exports.getNotifications = async (req, res) => {
    try {
        const { userId } = req.query;
        if (!userId) {
            return res.status(400).json({ error: "User ID is required" });
        }

        const notifications = await Notification.find({ userId }).sort({ createdAt: -1 });

        res.status(200).json({ success: true, notifications });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
