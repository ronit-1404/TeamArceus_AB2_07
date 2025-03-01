const fs = require("fs");
const path = require("path");

const logFilePath = path.join(__dirname, "../logs/app.log");

exports.log = (message) => {
    const timestamp = new Date().toISOString();
    const logMessage = `[${timestamp}] ${message}\n`;
    fs.appendFileSync(logFilePath, logMessage);
    console.log(logMessage);
};
