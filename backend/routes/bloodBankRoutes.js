const express = require("express");
const {getBloodStock} = require("../controllers/bloodBankController.js");

const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.get('/allbloodbanks',getBloodStock);

module.exports = router;
