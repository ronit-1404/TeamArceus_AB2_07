const Chat = require("../models/Chat.js");

exports.sendMessage = async (req, res) => {
    try {
        const { senderId, receiverId, message } = req.body;
        const chat = new Chat({ senderId, receiverId, message });
        await chat.save();
        res.status(201).json(chat);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
