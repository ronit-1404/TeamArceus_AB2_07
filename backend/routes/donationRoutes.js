const express = require("express")
const {recordDonation,getDonations} = require("../controllers/donationcController.js")

const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.post("/user-donation",authMiddleware,recordDonation);
router.post("/all-donations",authMiddleware,getDonations);

module.exports = router;