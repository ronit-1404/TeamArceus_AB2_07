const BloodBank = require("../models/BloodBank.js");

exports.getBloodStock = async (req, res) => {
    try {
        const stock = await BloodBank.find();
        res.status(200).json(stock);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
