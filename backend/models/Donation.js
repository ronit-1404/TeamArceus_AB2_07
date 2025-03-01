const mongoose = require("mongoose");

const donationSchema = new mongoose.Schema({
    donorId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    recipientId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    bloodType: { type: String, required: true },
    date: { type: Date, default: Date.now },
    location: { type: String, required: true },
    status: { type: String, enum: ["Completed", "Pending", "Cancelled"], default: "Pending" }
}, { timestamps: true });

module.exports = mongoose.model("Donation", donationSchema);
