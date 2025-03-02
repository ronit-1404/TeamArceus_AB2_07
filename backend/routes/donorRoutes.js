const express = require("express")
const { registerDonor, updateAvailability, requestBlood,getAllDonors } = require("../controllers/donorController");
const {authMiddleware} = require("../middlewares/authMiddleware");

const router = express.Router();

router.post("/register", authMiddleware, registerDonor);
router.put("/update-availability/:id", authMiddleware, updateAvailability);
router.get("/nearby", authMiddleware, requestBlood);
router.get("/alldonors",getAllDonors);
module.exports = router;