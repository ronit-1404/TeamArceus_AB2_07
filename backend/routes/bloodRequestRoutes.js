const express =require("express")

const {getRequests,deleteRequests} = require("../controllers/bloodRequestController.js")

const {authMiddleware} = require("../middlewares/authMiddleware.js")

const router = express.Router();

router.get('/',authMiddleware,getRequests)
router.delete('/:id',authMiddleware,deleteRequests);

module.exports = router;