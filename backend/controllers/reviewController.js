const Review = require("../models/Review.js");

exports.submitReview = async (req, res) => {
    try {
        const { donorId, recipientId, rating, feedback } = req.body;
        const review = new Review({ donorId, recipientId, rating, feedback });
        await review.save();
        res.status(201).json({ message: "Review submitted!", review });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
