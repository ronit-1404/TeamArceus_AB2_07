const mongoose = require("mongoose");

const bloodRequestSchema = new mongoose.Schema({
    recipientId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    bloodType: { type: String, required: true },
    urgency: { type: String, enum: ["Low", "Medium", "High"], required: true },
    hospital: { type: String, required: true },
    status: { type: String, enum: ["Pending", "Fulfilled", "Cancelled"], default: "Pending" },

    donors: [{
        donorId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
        status: { type: String, enum: ["Accepted", "Declined"], default: "Accepted" }
    }]
}, { timestamps: true 
})

module.exports = mongoose.model("BloodRequest", bloodRequestSchema);