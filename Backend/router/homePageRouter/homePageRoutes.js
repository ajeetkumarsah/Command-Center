const express = require('express')
const router = express.Router();

const homePage = require('../../appData/appData')

// ======================== Home Page ========================//
router.get('/appData', homePage.getHomePageData);
router.get('/appData/coverage', homePage.getCoverageData);
router.get('/appData/dgpCompliance', homePage.getDgpComplianceData);
router.get('/appData/mtdRetailing', homePage.getMtdRetailingData);
router.get('/appData/focusBrand/Channel', homePage.getFocusBrandDataByChannel);
router.get('/appData/focusBrand/Category', homePage.getFocusBrandDataByCategory);
router.get('/appData/focusBrand/Brand', homePage.getFocusBrandDataByBrand);
router.get('/appData/focusBrand/BrandForm', homePage.getFocusBrandDataByBrandForm);
router.get('/appData/focusBrand/SubBrandForm', homePage.getFocusBrandDataBySubBrandForm);
router.get('/appData/CBPData', homePage.getCoverageBillingProductiveData);
router.get('/appData/CBPByChannelData', homePage.getCoverageBillingProductiveByChannelData);
router.get('/appData/coverageTrends', homePage.getCoverageTrendsData);
router.get('/tableData', homePage.getTableData);

module.exports = router;
