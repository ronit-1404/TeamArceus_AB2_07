const twilio = require("twilio");

const client = new twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN);

exports.sendSMS = async (phone, message) => {
    try {
        await client.messages.create({
            body: message,
            from: process.env.TWILIO_PHONE_NUMBER,
            to: phone
        });
        return { success: true, message: "SMS sent successfully" };
    } catch (error) {
        return { success: false, error: error.message };
    }
};
