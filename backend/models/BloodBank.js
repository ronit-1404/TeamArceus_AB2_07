const mongoose = require("mongoose");

const bloodBankSchema = new mongoose.Schema({
    name: { type: String, required: true },
    location: { type: String, required: true },
    contactNumber: { type: String, required: true },

    bloodStock: [{
        bloodType: { type: String, required: true },
        unitsAvailable: { type: Number, required: true }
    }]
}, { timestamps: true });

module.exports = mongoose.model("BloodBank", bloodBankSchema);
