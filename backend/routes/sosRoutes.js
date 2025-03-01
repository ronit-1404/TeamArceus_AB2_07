const express  = require("express")
const {triggerSOS} = require("../controllers/sosController.js")

const router = express.Router();

//we are not adding middleware for sos routes 
router.post("/createsos",triggerSOS);

module.exports = router;