const admin = require("firebase-admin");

exports.sendNotification = async (token, title, message) => {
    try {
        const payload = { notification: { title, body: message } };
        await admin.messaging().sendToDevice(token, payload);
        return { success: true, message: "Notification sent successfully" };
    } catch (error) {
        return { success: false, error: error.message };
    }
};
