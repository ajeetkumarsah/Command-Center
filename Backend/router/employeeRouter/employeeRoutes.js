const express = require('express')
const router = express.Router();

const empAuth = require('../../employee/employeeAuthentication');
const homePage = require('../../appData/appData');
const homePage2 = require('../../appData/APIM_Test');
const filtersData = require('../../appData/publicAPI');
const retailing = require('../../appData/deepDive/retailing/retailingDeepDive');

// router.post('/appData/employeeAuthentication', empAuth.login);
router.post('/appData/employeeAuthentication', empAuth.login);
router.get('/appData', homePage.getHomePageData);
router.get('/appData/coverage', homePage2.getData);
router.get('/appData/focusBrand', homePage2.getData);
router.get('/appData/mtdRetailing', homePage2.getData);
router.get('/appData/dgpCompliance', homePage2.getData);
router.post('/appData/mtdRetailingTable', retailing.getData);
router.get('/appData/focusBrandTable', homePage2.getData);
router.get('/appData/dgpComplianceTable', homePage2.getData);
router.get('/appData/coverageTable', homePage2.getData);
router.get('/appData/productivity', homePage2.getData);
router.get('/appData/inventory', homePage2.getData);
router.get('/appData/storeList', homePage2.getData);
router.get('/appData/channellist', homePage2.getData);
router.get('/appData/branchlist', filtersData.getFilterData);
router.get('/appData/srn', homePage2.getData);
router.get('/appData/cfr', homePage2.getData);
router.get('/appData/largemedchannel', homePage2.getData);
router.get('/appData/smallnewchannel', homePage2.getData);
router.get('/appData/mrchannel', homePage2.getData);
router.get('/appData/mrindependentChannel', homePage2.getData);
router.get('/appData/dcomchannel', homePage2.getData);
router.get('/appData/gpachieved', homePage2.getData);
router.get('/appData/gpabs', homePage2.getData);
router.get('/appData/gpp3miya', homePage2.getData);
router.get('/appData/gpp1miya', homePage2.getData);
router.get('/appData/pxmbilling', homePage2.getData);
router.get('/appData/ccr', homePage2.getData);
router.get('/appData/targetsm1', homePage2.getData);
router.get('/appData/targetsquarterly', homePage2.getData);
router.get('/appData/grp', homePage2.getData);
router.get('/appData/sov', homePage2.getData);
router.get('/appData/tvspend', homePage2.getData);
router.get('/appData/tvreach', homePage2.getData);

module.exports = router;
