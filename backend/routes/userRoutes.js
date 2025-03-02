const express = require("express")
const {register,login,getallusers} = require("../controllers/userController.js")

const router = express.Router();

router.post("/register",register);
router.post("/login",login)
router.get("/getallusers",getallusers)

module.exports = router;