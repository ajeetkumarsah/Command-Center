const express = require('express')
const router = express.Router();

const filter = require('../../appData/filterData')
const supplyChainFilter = require('../../appData/supplyChainFilterData')

// ======================== Home Page ========================//
router.get('/appData/divisionFilter', filter.getDivisionFilterData);
router.get('/appData/siteFilter', filter.getSiteFilterData);
router.get('/appData/branchFilter', filter.getBranchFilterData);
router.get('/appData/clusterFilter', filter.getClusterFilterData);
router.get('/appData/channelFilter', filter.getChannelFilterData);
router.post('/appData/channelFilter/category', filter.getChannelFilterDataByCategory);
router.get('/appData/categoryFilter', filter.getCategoryFilterData);
router.post('/appData/categoryFilter/channel', filter.getCategoryFilterDataByChannel);
router.post('/appData/brandFilter/channel', filter.getBrandFilterDataByChannel);
router.post('/appData/brandFormFilter/channel', filter.getBrandFormFilterDataByChannel);
router.post('/appData/subBrandFormFilter/channel', filter.getSBFGroupFilterDataByChannel);
router.get('/appData/brandFilter', filter.getBrandFilterData);
router.get('/appData/brandFormFilter', filter.getBrandFormFilterData);
router.get('/appData/subBrandGroupFilter', filter.getSubBrandFormGroupFilterData);

// Supply Chain Filters
router.post('/appData/supply/sbfFilter', supplyChainFilter.getSBFGroupFilterData);
router.post('/appData/supply/sourceCityFilter', supplyChainFilter.getSourceCityFilterData);
router.post('/appData/supply/categoryFilter', supplyChainFilter.getCategoryFilterData);
router.post('/appData/supply/vehicleTypeFilter', supplyChainFilter.getVehicleTypeFilterData);
router.get('/appData/supply/movementFilter', supplyChainFilter.getMovementFilterData);
router.post('/appData/supply/destinationFilter', supplyChainFilter.getDestinationCityFilterData);

module.exports = router;
