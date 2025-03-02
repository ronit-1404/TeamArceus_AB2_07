const express =require("express")
const {getRequests,deleteRequests} = require("../controllers/bloodRequestController.js")
const {createRequest} = require("../controllers/bloodRequestController.js")

const router = express.Router();

router.get('/servicerequest',getRequests)
router.delete('/:id',deleteRequests);
router.post("/request-blood",createRequest)

module.exports = router;