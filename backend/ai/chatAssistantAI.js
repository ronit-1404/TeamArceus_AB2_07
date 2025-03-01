const OpenAI = require("openai");

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

exports.chatWithAI = async (message) => {
    try {
        const response = await openai.completions.create({
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: message }],
        });
        return response.choices[0].message.content;
    } catch (error) {
        console.error("Chat AI error:", error);
        return "I'm sorry, I couldn't process your request.";
    }
};
