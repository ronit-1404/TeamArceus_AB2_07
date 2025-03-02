const express =require("express")

const {getRequests,deleteRequests} = require("../controllers/bloodRequestController.js")


const router = express.Router();

router.get('/servicerequest',getRequests)
router.delete('/:id',deleteRequests);

module.exports = router;