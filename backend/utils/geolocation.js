const haversine = require("haversine");

exports.getDistance = (location1, location2) => {
    return haversine(location1, location2, { unit: "km" });
};
