const express = require('express')
const router = express.Router();

const webSummaryDefaultPage = require('../../webData/webSummaryPage/webSummaryDefaultPage')
const webSummaryDefaultMonthPage = require('../../webData/webSummaryPage/webSummaryDefaultMonthData')
const webRetailingPage = require('../../webData/webSummaryPage/webRetailingPage')
const webFBPage = require('../../webData/webSummaryPage/webFBPage')
const webGPPage = require('../../webData/webSummaryPage/webGPPage')
const webCCPage = require('../../webData/webSummaryPage/webCCPage')
const webCBPPage = require('../../webData/webSummaryPage/webCBPPage')
const webProductivityPage = require('../../webData/webSummaryPage/webProductivityPage')

const webDeepDiveCoveragePage = require('../../webData/webDeepDivePage/coverage/coverageDeepDive')
const webDeepDiveProductivityPage = require('../../webData/webDeepDivePage/coverage/productivityMonthyData')
// const webDeepDiveProductivityPage2 = require('../../webData/webDeepDivePage/coverage/productivityTemp')
const webDeepDiveBillingPage = require('../../webData/webDeepDivePage/coverage/billingMonthlyData')
const webDeepDiveCCPage = require('../../webData/webDeepDivePage/coverage/ccMonthlyData')

// const webDeepDiveGPPage = require('../../webData/webDeepDivePage/goldenPoint/gpMonthlyData')
const webDeepDiveFBPage = require('../../webData/webDeepDivePage/focousBrand/fbDeepDive')
const webDeepDiveMonthlyFBPage = require('../../webData/webDeepDivePage/focousBrand/fbMonthlyData')
const webDeepDiveFB2Page = require('../../webData/webDeepDivePage/focousBrand/focousBrandDeepDive')
const webDeepDiveFBCategoryPage = require('../../webData/webDeepDivePage/focousBrand/focousBrandDeepDiveByCategory')
const webDeepDiveFBMonthlyAbsPage = require('../../webData/webDeepDivePage/focousBrand/fbAbsMonthlyData')

const webDeepDiveGPPage = require('../../webData/webDeepDivePage/goldenPoint/gpDeepDiveData')
const webMonthlyGPPage = require('../../webData/webDeepDivePage/goldenPoint/gpMonthlyData2')
const webAbsMonthlyGPPage = require('../../webData/webDeepDivePage/goldenPoint/gpAbsMonthlyData')

const webMonthlyRetailingPage = require('../../webData/webDeepDivePage/retailing/retailingDayLevelData')
const webMonthlyRetailingByGeoPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthLevelData')
const webMonthlyDivisionRetailingByGeoPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthDivisionLevelData')
const webMonthlyDivisionSiteRetailingByGeoPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthSiteLevelData')
const webMonthlyDivisionBranchRetailingByGeoPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthBranchLevelData')
const webMonthlyDivisionChannelRetailingByGeoPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthChannelLevelData')
const webMonthlyDivisionSubChannelRetailingByGeoPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthSubChannelLevelData')
const webMonthlyRetailingByCategoryPage = require('../../webData/webDeepDivePage/retailing/retailingMonthLevelDataByCategory')
const webMonthlyRetailingByChannelPage = require('../../webData/webDeepDivePage/retailing/retailingMonthLevelData')
const webMonthlyRetailingByCategory2Page = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthCategoryLevelData')
const webMonthlyRetailingByBrandPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthBrandLevelData')
const webMonthlyRetailingByBrandFormPage = require('../../webData/webDeepDivePage/retailing/retailingGeoMonthBrandFormLevelData')
const cacheData = require('../../webData/webSummaryPage/cacheDataTest')

// ======================== Summary Page ========================//
// router.get('/webSummary/allData', webSummaryDefaultPage.getSummaryPageData);
router.post('/webSummary/allDefaultData', webSummaryDefaultMonthPage.getSummaryPageData);
router.get('/webSummary/retailingData', webRetailingPage.getSummaryPageData);
router.get('/webSummary/FBData', webFBPage.getSummaryPageData);
router.get('/webSummary/GPData', webGPPage.getSummaryPageData);
router.get('/webSummary/CCData', webCCPage.getSummaryPageData);
router.get('/webSummary/CBPData', webCBPPage.getSummaryPageData);
router.get('/webSummary/productivityData', webProductivityPage.getSummaryPageData);

// ======================== Coverage Page ========================//
router.get('/webDeepDive/coverage', webDeepDiveCoveragePage.getDeepDivePageData);
router.get('/webDeepDive/coverage/branch', webDeepDiveCoveragePage.getDeepDivePageDataByBranch);
router.post('/webDeepDive/coverage/productivity', webDeepDiveProductivityPage.getDeepDivePageData);
// router.post('/webDeepDive/coverage/productivity2', webDeepDiveProductivityPage2.getDeepDivePageData);
router.post('/webDeepDive/coverage/billing', webDeepDiveBillingPage.getDeepDivePageData);
router.post('/webDeepDive/coverage/cc', webDeepDiveCCPage.getDeepDivePageData);
router.post('/webDeepDive/coverage/subChannel', webDeepDiveCoveragePage.getDeepDivePageDataBySubChannel2);

// ======================== Golden Page ========================//
router.post('/webDeepDive/goldenPoint/gp', webDeepDiveGPPage.getDeepDivePageData);
router.post('/webDeepDive/goldenPoint/monthly', webMonthlyGPPage.getDeepDivePageData);
router.post('/webDeepDive/goldenPoint/abs/monthly', webAbsMonthlyGPPage.getDeepDivePageData);

// ======================== Focus Brand Page ========================//
router.post('/webDeepDive/fb/monthlyData', webDeepDiveMonthlyFBPage.getDeepDivePageData);
router.post('/webDeepDive/fb/sbf', webDeepDiveFB2Page.getDeepDivePageData);
router.post('/webDeepDive/fb/bf', webDeepDiveFBCategoryPage.getDeepDivePageData);
router.post('/webDeepDive/fb/abs/monthlyData', webDeepDiveFBMonthlyAbsPage.getDeepDivePageData);

// ======================== Retailing Page ========================//
router.post('/webDeepDive/rt/monthlyData', webMonthlyRetailingPage.getDeepDivePageData);
router.post('/webDeepDive/rt/monthlyData/byChannel', webMonthlyRetailingByChannelPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData', webMonthlyRetailingByGeoPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/division', webMonthlyDivisionRetailingByGeoPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/site', webMonthlyDivisionSiteRetailingByGeoPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/branch', webMonthlyDivisionBranchRetailingByGeoPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/channel', webMonthlyDivisionChannelRetailingByGeoPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/category', webMonthlyRetailingByCategory2Page.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/brand', webMonthlyRetailingByBrandPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/brandForm', webMonthlyRetailingByBrandFormPage.getDeepDivePageData);
router.post('/webDeepDive/rt/geo/monthlyData/subChannel', webMonthlyDivisionSubChannelRetailingByGeoPage.getDeepDivePageData);

router.post('/webDeepDive/rt/monthlyData/byCategory', webMonthlyRetailingByCategoryPage.getDeepDivePageData);

// ======================== Test Page ========================//
router.post('/webDeepDive/test/post', webDeepDiveFBPage.getPostTest);
router.get('/webDeepDive/test/get', webDeepDiveFBPage.getGetTest);
// router.post('/webDeepDive/test/getCacheData', cacheData.getSummaryPageData);

module.exports = router;
