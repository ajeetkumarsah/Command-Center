const express = require('express')
const router = express.Router();


const transportation = require('../../webData/supplyChain/transpotationData/transportationData');
const lineGraph = require('../../webData/supplyChain/transpotationData/lineGraphData');

// router.post('/appData/employeeAuthentication', empAuth.login);
router.post('/webData/transportation', transportation.getTransportationPageData);
router.post('/webData/lineGraph', lineGraph.getLineGraphData);

module.exports = router;
