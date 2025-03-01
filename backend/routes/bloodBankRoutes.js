const express = require("express");
const {getBloodStock} = require("../controllers/bloodBankController.js");

const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.get('/allbloodbanks',authMiddleware,getBloodStock);

module.exports = router;
