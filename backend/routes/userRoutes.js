const express = require("express")
const {register,login} = require("../controllers/userController.js")
const authMiddleware = require("../middlewares/authMiddleware.js")
const {createRequest} = require("../controllers/bloodRequestController.js")
const router = express.Router();

router.post("/register",authMiddleware,register);
router.post("/login",authMiddleware,login)
router.post("/request-blood",authMiddleware,createRequest)
module.exports = router;