const mongoose = require("mongoose");

const reviewSchema = new mongoose.Schema({
    donorId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    recipientId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    rating: { type: Number, min: 1, max: 5, required: true },
    feedback: { type: String, required: true }
}, { timestamps: true });

module.exports = mongoose.model("Review", reviewSchema);
