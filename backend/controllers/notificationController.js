const Notification = require("../models/Notification.js");

exports.getNotifications = async (req, res) => {
    try {
        const { userId } = req.query;
        const notifications = await Notification.find({ userId });
        res.status(200).json(notifications);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
