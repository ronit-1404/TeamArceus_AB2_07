const mongoose = require("mongoose");

const sosAlertSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    emergencyType: { type: String, required: true },
    location: { type: String, required: true },
    status: { type: String, enum: ["Active", "Resolved"], default: "Active" },

    responders: [{
        responderId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
        status: { type: String, enum: ["Accepted", "Declined"], default: "Accepted" }
    }]
}, { timestamps: true });

module.exports = mongoose.model("SOSAlert", sosAlertSchema);
