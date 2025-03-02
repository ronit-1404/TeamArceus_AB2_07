const express =require("express")

const {getRequests,deleteRequests} = require("../controllers/bloodRequestController.js")

const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.get('/',getRequests)
router.delete('/:id',deleteRequests);

module.exports = router;