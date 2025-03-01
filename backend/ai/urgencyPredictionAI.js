exports.predictUrgency = (condition) => {
    const severityLevels = {
        "critical": 5,
        "serious": 4,
        "moderate": 3,
        "mild": 2,
        "normal": 1
    };
    return severityLevels[condition.toLowerCase()] || 1;
};
