const express = require("express")
const {register,login} = require("../controllers/userController.js")
const {authMiddleware} = require("../middlewares/authMiddleware.js")
const {createRequest} = require("../controllers/bloodRequestController.js")
const router = express.Router();

router.post("/register",register);
router.post("/login",login)
router.post("/request-blood",createRequest)

module.exports = router;