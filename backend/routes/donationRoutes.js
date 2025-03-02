const express = require("express")
const {recordDonation,getDonations} = require("../controllers/donationcController.js")

const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.post("/user-donation",recordDonation);
router.post("/all-donations",getDonations);

module.exports = router;