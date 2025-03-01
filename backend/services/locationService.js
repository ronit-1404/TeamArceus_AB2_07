const User = require("../models/User.js");

exports.updateLocation = async (userId, location) => {
    try {
        await User.findByIdAndUpdate(userId, { location });
        return { success: true, message: "Location updated successfully" };
    } catch (error) {
        return { success: false, error: error.message };
    }
};
