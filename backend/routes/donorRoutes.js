const express = require("express")
const { registerDonor, updateAvailability, requestBlood,getAllDonors } = require("../controllers/donorController");
const {authMiddleware} = require("../middlewares/authMiddleware");

const router = express.Router();

router.post("/register", registerDonor);
router.put("/update-availability/:id", updateAvailability);
router.get("/nearby", requestBlood);
router.get("/alldonors",getAllDonors);
module.exports = router;