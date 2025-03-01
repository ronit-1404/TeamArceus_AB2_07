exports.formatDate = (date) => {
    return new Date(date).toISOString().split("T")[0];
};

exports.generateRandomCode = (length = 6) => {
    return Math.random().toString(36).substring(2, 2 + length).toUpperCase();
};
