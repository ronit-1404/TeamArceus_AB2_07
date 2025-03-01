const User = require("../models/User.js");
const { getDistance } = require("../utils/geolocation.js");

exports.findNearestDonor = async (bloodType, userLocation) => {
    try {
        const donors = await User.find({ isDonor: true, isActive: true, bloodType });
        const sortedDonors = donors.sort((a, b) => 
            getDistance(userLocation, a.location) - getDistance(userLocation, b.location)
        );
        return sortedDonors[0] || null;
    } catch (error) {
        console.error("Error finding nearest donor:", error);
        return null;
    }
};
