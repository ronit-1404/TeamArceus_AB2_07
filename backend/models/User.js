const mongoose = require("mongoose")
const bcrypt = require("bcryptjs");


const userSchema = new mongoose.Schema({
    name: {type: String, required: true},
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    phone: { type: String, required: true, unique: true },
    bloodType: { type: String, required: true },
    address: { type: String },
    isDonor: { type: Boolean, default: false },
    isActive: { type: Boolean, default: true },
    donationHistory: [{
        donationId: { type: mongoose.Schema.Types.ObjectId, ref: "Donation" },
        date: { type: Date, default: Date.now },
        location: { type: String }
    }],
    sosAlerts: [{ type: mongoose.Schema.Types.ObjectId, ref: "SOSAlert" }],
    notifications: [{ type: mongoose.Schema.Types.ObjectId, ref: "Notification" }]
})

userSchema.pre("save", async function (next) {
    if (!this.isModified("password")) return next();
    try {
        this.password = await bcrypt.hash(this.password, 10);
        next();
    } catch (err) {
        next(err);
    }
});

module.exports = mongoose.model("User", userSchema);