import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/data/repository/home_repo.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/filters_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/summary_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/gp_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/coverage_trends_model.dart';


class HomeController extends GetxController {
  //
  final HomeRepo homeRepo;
  //constructor :)
  HomeController({required this.homeRepo});

//

  final ScrollController sScrollController = ScrollController();
  final ScrollController mScrollController = ScrollController();
  //
  bool _isLoading = false,
      _isSummaryExpanded = false,
      _isExpandedCategory = false,
      _isExpandedTrends = false,
      _isExpandedChannel = false,
      _showRetailing = true,
      _showCoverage = true,
      _showGoldenPoints = true,
      _showFocusBrand = true,
      _isFilterLoading = false,
      _isSummaryLoading = false,
      _isCategoryLoading = false,
      _isChannelLoading = false,
      _isRetailingTrendsLoading = false,
      _isCoverageTrendsLoading = false,
      _isGPTrendsLoading = false,
      _isFBTrendsLoading = false,
      _channelSales = true,
      _isSummaryPageLoading = false;
  bool get isLoading => _isLoading;
  bool get isSummaryExpanded => _isSummaryExpanded;
  bool get isExpandedCategory => _isExpandedCategory;
  bool get isExpandedTrends => _isExpandedTrends;
  bool get isExpandedChannel => _isExpandedChannel;
  bool get showRetailing => _showRetailing;
  bool get showCoverage => _showCoverage;
  bool get showGoldenPoints => _showGoldenPoints;
  bool get showFocusBrand => _showFocusBrand;
  bool get isFilterLoading => _isFilterLoading;
  bool get isSummaryLoading => _isSummaryLoading;
  bool get isCategoryLoading => _isCategoryLoading;
  bool get isChannelLoading => _isChannelLoading;
  bool get isRetailingTrendsLoading => _isRetailingTrendsLoading;
  bool get channelSales => _channelSales;
  bool get isSummaryPageLoading => _isSummaryPageLoading;
  bool get isCoverageTrendsLoading => _isCoverageTrendsLoading;
  bool get isGPTrendsLoading => _isGPTrendsLoading;
  bool get isFBTrendsLoading => _isFBTrendsLoading;

  //int
  int _selectedNav = 0;
  int get selectedNav => _selectedNav;

  //
  String _selectedCoverageTrendsFilter = 'Billing %';
  String get selectedCoverageTrendsFilter => _selectedCoverageTrendsFilter;
  String _selectedTrends = 'Channel';
  String get selectedTrends => _selectedTrends;
  String _selectedChannel = 'Channel';
  String get selectedChannel => _selectedChannel;
  String _selectedTrendsChannel = 'Channel';
  String get selectedTrendsChannel => _selectedTrendsChannel;
  String _selectedTrendsChannelValue = '';
  String get selectedTrendsChannelValue => _selectedTrendsChannelValue;
  String _selectedCategory = 'Category';
  String get selectedCategory => _selectedCategory;
  String _selectedTrendsCategory = 'Category';
  String get selectedTrendsCategory => _selectedTrendsCategory;
  String _selectedTrendsCategoryValue = '';
  String get selectedTrendsCategoryValue => _selectedTrendsCategoryValue;
  // String _selectedBrand = 'Brand';
  // String get selectedBrand => _selectedBrand;
  String _selectedGeo = 'All India';
  String get selectedGeo => _selectedGeo;
  String _selectedMultiGeo = 'All India';
  String get selectedMultiGeo => _selectedMultiGeo;
  String _selectedGeoValue = 'All India';
  String get selectedGeoValue => _selectedGeoValue;

  String? _selectedMonth = 'Dec';
  String? get selectedMonth => _selectedMonth;
  String? _selectedYear = '2023';
  String? get selectedYear => _selectedYear;
  String? _selectedTempMonth = 'Dec';
  String? get selectedTempMonth => _selectedTempMonth;
  String? _selectedTempYear = '2023';
  String? get selectedTempYear => _selectedTempYear;
  String _selectedTempGeo = 'All India';
  String get selectedTempGeo => _selectedTempGeo;
  String _selectedTempGeoValue = 'All India';
  String get selectedTempGeoValue => _selectedTempGeoValue;
  String _selectedTrendsGeo = 'All India';
  String get selectedTrendsGeo => _selectedTrendsGeo;
  String _selectedTrendsGeoValue = '';
  String get selectedTrendsGeoValue => _selectedTrendsGeoValue;

  //
  List<String> selectedMultiFilters = [], branchFilter = [], subBrandForm = [];
  List<String> categoryFilters = [],
      categoryTrendsFilters = [],
      selectedCategoryFilters = [],
      selectedSubBrandFilters = [],
      // subBrandsFilters = [],
      channelFilter = [],
      channelTrendsFilter = [],
      selectedChannelFilter = [],
      selectedMultiDivisions = [],
      selectedMultiClusters = [],
      selectedMultiSites = [],
      selectedMultiBranches = [];
  List<String> activeMetrics = [
        'Retailing',
        'Coverage',
        'Golden Points',
        'Focus Brand'
      ],
      moreMetrics = ['Shipment', 'Inventory'];
  //Models
  FiltersModel? _filtersModel;
  FiltersModel? get filtersModel => _filtersModel;
  void onChannelSalesChange(bool value) {
    _channelSales = value;
    update();
  }

  void onChangeCoverageTrends(String value) {
    _selectedCoverageTrendsFilter = value;
    update();
  }

  void onSavePersonalizedData(
      {required List<String> active, required List<String> more}) {
    savePersonalizedActiveMetrics(json.encode(active));
    savePersonalizedMoreMetrics(json.encode(more));
    update();
  }

  void getPersonalizedData() {
    String activeJson = getPersonalizedActiveMetrics();
    String moreJson = getPersonalizedMoreMetrics();
    debugPrint('==>Active Data:$activeJson  ==>More Data:$moreJson');
    if (activeJson.trim().isNotEmpty) {
      activeMetrics = List<String>.from(json.decode(activeJson));
    }
    if (moreJson.trim().isNotEmpty) {
      moreMetrics = List<String>.from(json.decode(moreJson));
    }
    update();
  }

  //
  void onChangeCategory(String value) {
    _selectedCategory = value;
    selectedCategoryFilters.clear();
    if (filtersModel != null) {
      if (value.toLowerCase().startsWith('category')) {
        categoryFilters = filtersModel?.category ?? [];
      } else if (value.toLowerCase().startsWith('brand form')) {
        categoryFilters = filtersModel?.brandForm ?? [];
      } else if (value.trim().toLowerCase().startsWith('brand')) {
        categoryFilters = filtersModel?.brand ?? [];
      } else if (value.trim().toLowerCase().startsWith('sub-brand')) {
        // categoryFilters = filtersModel?.subBrandForm ?? [];
      }
    } else {
      debugPrint('====>Filter model is Null');
    }

    update();
  }

  void onChangeTrendsCategory(String value) {
    debugPrint('====>Trends onclick ${value}');
    _selectedTrendsCategory = value;
    _selectedTrendsCategoryValue = '';
    if (filtersModel != null) {
      if (value.toLowerCase().startsWith('category')) {
        categoryTrendsFilters = filtersModel?.category ?? [];
      } else if (value.toLowerCase().startsWith('brand form')) {
        categoryTrendsFilters = filtersModel?.brandForm ?? [];
      } else if (value.trim().toLowerCase().startsWith('brand')) {
        categoryTrendsFilters = filtersModel?.brand ?? [];
      } else if (value.trim().toLowerCase().startsWith('sub-brand')) {
        categoryTrendsFilters = [];
      }
    } else {
      debugPrint('====>Filter model is Null');
    }

    update();
  }

  void onChangeChannel(String value) {
    _selectedChannel = value;
    selectedChannelFilter.clear();
    if (filtersModel != null) {
      if (value.toLowerCase().startsWith('channel')) {
        channelFilter = filtersModel?.channel ?? [];
      }
    } else {
      getAllFilters().then((v) {
        if (value.toLowerCase().startsWith('channel')) {
          channelFilter = filtersModel?.channel ?? [];
        }
      });
    }

    update();
  }

  void onChangeCategoryValue(String value) {
    if (selectedCategoryFilters.contains(value)) {
      selectedCategoryFilters.remove(value);
    } else {
      selectedCategoryFilters.add(value);
    }
    update();
  }

  void onChangeCategoryTrendsValue(String value) {
    debugPrint('====>Trends value$value');
    _selectedTrendsCategoryValue = value;
    _selectedTrendsChannelValue = '';
    _selectedTrendsGeoValue = '';
    update();
  }

  void onChangeFiltersAll({type = 'branch'}) {
    if (type == 'branch') {
      if (listEquals(selectedMultiFilters, branchFilter)) {
        selectedMultiFilters.clear();
      } else {
        selectedMultiFilters.clear();
        selectedMultiFilters.addAll(branchFilter);
      }
    } else if (type == 'category') {
      if (listEquals(selectedCategoryFilters, categoryFilters)) {
        selectedCategoryFilters.clear();
      } else {
        selectedCategoryFilters.clear();
        selectedCategoryFilters.addAll(categoryFilters);
      }
    }

    update();
  }

  void onChangeChannelValue(String value) {
    if (selectedChannelFilter.contains(value)) {
      selectedChannelFilter.remove(value);
    } else {
      selectedChannelFilter.add(value);
    }
    update();
  }

  void onChangeTrendsChannelValue(String value) {
    _selectedTrendsChannelValue = value;
    _selectedTrendsCategoryValue = '';
    _selectedTrendsGeoValue = '';
    update();
  }

  void onChangeChannelAllSelect() {
    if (listEquals(selectedChannelFilter, channelFilter)) {
      debugPrint('===>Select All Clear');
      selectedChannelFilter.clear();
    } else {
      debugPrint('===>Select All ADD');
      selectedChannelFilter.addAll(channelFilter);
    }
    update();
  }

  void onTrendsFilterSelect(String value) {
    _selectedTrends = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // getAllFilters();
    getPersonalizedData();
    getInitValues(getOnlyShared: true);
    getInitData();
    getMonthFilters();
    filters = ['All India'];
    multiFilters = ['All India'];
    geoFilters = [
      {
        "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
        _selectedGeo.startsWith('All India')
            ? "allIndia"
            : _selectedGeo.startsWith('Site')
                ? "site"
                : _selectedGeo.toLowerCase(): selectedGeoValue,
        "category": [],
      }
    ];
    getRetailingData();
    getRetailingData(type: 'category', name: 'category');
    getRetailingData(type: 'channel', name: 'geo');
    getRetailingData(type: 'geo', name: 'trends');
    //gp
    getGPData();
    getGPData(type: 'category', name: 'category');
    getGPData(type: 'channel', name: 'geo');
    getGPData(type: 'geo', name: 'trends');
    //fb
    getFocusBrandData();
    getFocusBrandData(type: 'category', name: 'category');
    getFocusBrandData(type: 'channel', name: 'geo');
    getFocusBrandData(type: 'geo', name: 'trends');
    //Coverage
    getCoverageData();
    getCoverageData(type: 'channel', name: 'geo');
    getCoverageData(type: 'trends', name: 'trends');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getInitValues({bool getOnlyShared = false}) {
    // getPersonalizedData();
    if (getMonth().trim().isNotEmpty) {
      _selectedMonth = getMonth();
      _selectedTempMonth = getMonth();
    }
    if (getYear().trim().isNotEmpty) {
      _selectedYear = getYear();
      _selectedTempYear = getYear();
    }
    if (getGeo().trim().isNotEmpty) {
      _selectedTempGeo = getGeo();
      debugPrint('===>Selected Geo : $selectedGeo');
      _selectedGeo = getGeo();
      _selectedTrendsGeo = getGeo();
      onGeoChange(_selectedGeo);
    }
    if (getGeoValue().trim().isNotEmpty) {
      _selectedTempGeoValue = getGeoValue();
      _selectedGeoValue = getGeoValue();
      _selectedTrendsGeoValue = getGeoValue();
    }
    if (!getOnlyShared) {
      getSummaryData();
      getAllFilters().then((value) {
        categoryFilters = filtersModel?.category ?? [];
        categoryTrendsFilters = filtersModel?.category ?? [];
        channelFilter = filtersModel?.channel ?? [];
        channelTrendsFilter = filtersModel?.channel ?? [];
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  void onChangeMonthFilter(String value) {
    debugPrint('====>Selected Month $value');
    if (selectedTempMonth != null &&
        value.trim().toLowerCase() == selectedTempMonth!.trim().toLowerCase()) {
      _selectedTempMonth = null;
    } else {
      _selectedTempMonth = value;
    }
    update();
  }

  void onChangeYearFilter(String value) {
    _selectedTempYear = value;
    getMonthFilters(year: value);
    update();
  }

  void onChangeGeo(String geo, String geoValue) {
    _selectedGeo = geo;
    _selectedGeoValue = geoValue;
    saveGeo(geo);
    saveGeoValue(geoValue);
    update();
  }

  void onChangeDate(
      {bool isLoadRetailing = false, String tabType = 'Retailing'}) {
    _selectedYear = _selectedTempYear;
    _selectedMonth = _selectedTempMonth;

    setYear(_selectedTempYear ?? '');
    setMonth(_selectedTempMonth ?? '');
    getSummaryData();
    if (isLoadRetailing) {
      if (SummaryTypes.retailing.type == tabType) {
        //retailing screen data

        getRetailingData();
        getRetailingData(type: 'category', name: 'category');
        getRetailingData(type: 'channel', name: 'geo');
        getRetailingData(type: 'geo', name: 'trends');
      } else if (SummaryTypes.coverage.type == tabType) {
        //Coverage screen data
        getCoverageData();
        // getCoverageData(type: 'category', name: 'category');
        getCoverageData(type: 'channel', name: 'geo');
        getCoverageData(type: 'geo', name: 'trends');
      } else if (SummaryTypes.gp.type == tabType) {
        //retailing screen data
        getGPData();
        getGPData(type: 'category', name: 'category');
        getGPData(type: 'channel', name: 'geo');
        getGPData(type: 'geo', name: 'trends');
      } else if (SummaryTypes.fb.type == tabType) {
        //retailing screen data
        getFocusBrandData();
        getFocusBrandData(type: 'category', name: 'category');
        getFocusBrandData(type: 'channel', name: 'geo');
        getFocusBrandData(type: 'geo', name: 'trends');
      } else if (tabType == "All") {
        reloadAllDeepDive();
      }
    }
    update();
  }

  void onGeoChange(String value, {bool isMultiSelect = false}) {
    if (isMultiSelect) {
      //multiFilters
      _selectedMultiGeo = value;
      selectedMultiFilters.clear();
      if (filtersModel != null) {
        if (value.startsWith('All India')) {
          multiFilters = ['All India'];
        } else if (value.startsWith('Division')) {
          multiFilters = filtersModel!.division;
        } else if (value.startsWith('Cluster')) {
          multiFilters = filtersModel!.cluster;
        } else if (value.startsWith('Site')) {
          multiFilters = filtersModel!.site;
        } else if (value.startsWith('Branch')) {
          multiFilters = [];
          // multiFilters = filtersModel!.branch;
        }
      } else {
        getAllFilters().then((v) {
          if (value.startsWith('All India')) {
            // getFilters(filter: 'allIndia');

            multiFilters = ['All India'];
          } else if (value.startsWith('Division')) {
            multiFilters = filtersModel?.division ?? [];
          } else if (value.startsWith('Cluster')) {
            multiFilters = filtersModel?.cluster ?? [];
          } else if (value.startsWith('Site')) {
            multiFilters = filtersModel?.site ?? [];
          } else if (value.startsWith('Branch')) {
            multiFilters = [];
            // multiFilters = filtersModel?.branch ?? [];
          }
        });
      }
    } else {
      _selectedTempGeo = value;
      _selectedTempGeoValue = '';
      if (filtersModel != null) {
        if (value.startsWith('All India')) {
          filters = ['All India'];
        } else if (value.startsWith('Division')) {
          filters = filtersModel!.division;
        } else if (value.startsWith('Cluster')) {
          filters = filtersModel!.cluster;
        } else if (value.startsWith('Site')) {
          filters = filtersModel!.site;
        } else if (value.startsWith('Branch')) {
          filters = [];
        }
      } else {
        getAllFilters().then((v) {
          _selectedTempGeoValue = '';
          if (value.startsWith('All India')) {
            // getFilters(filter: 'allIndia');

            filters = ['All India'];
          } else if (value.startsWith('Division')) {
            filters = filtersModel?.division ?? [];
          } else if (value.startsWith('Cluster')) {
            filters = filtersModel?.cluster ?? [];
          } else if (value.startsWith('Site')) {
            filters = filtersModel?.site ?? [];
          } else if (value.startsWith('Branch')) {
            filters = [];
            // filters = filtersModel?.branch ?? [];
          }
        });
      }
    }
    update();
  }

  void onTrendsGeoChange(String value) {
    _selectedTrendsGeo = value;
    _selectedTrendsGeoValue = '';
    if (filtersModel != null) {
      if (value.startsWith('All India')) {
        trendsFilter = ['All India'];
      } else if (value.startsWith('Division')) {
        trendsFilter = filtersModel!.division;
      } else if (value.startsWith('Cluster')) {
        trendsFilter = filtersModel!.cluster;
      } else if (value.startsWith('Site')) {
        trendsFilter = filtersModel!.site;
      } else if (value.startsWith('Branch')) {
        trendsFilter = [];
      }
    } else {
      getAllFilters().then((v) {
        _selectedTrendsGeoValue = '';
        if (value.startsWith('All India')) {
          trendsFilter = ['All India'];
        } else if (value.startsWith('Division')) {
          trendsFilter = filtersModel?.division ?? [];
        } else if (value.startsWith('Cluster')) {
          trendsFilter = filtersModel?.cluster ?? [];
        } else if (value.startsWith('Site')) {
          trendsFilter = filtersModel?.site ?? [];
        } else if (value.startsWith('Branch')) {
          trendsFilter = [];
        }
      });
    }

    update();
  }

  void onApplyFilter(
      {bool isLoadRetailing = false, String tabType = 'Retailing'}) {
    debugPrint(
        '===>selected Filter $selectedTempGeo  -- $selectedTempGeoValue');
    _selectedGeo = _selectedTempGeo;
    _selectedGeoValue = _selectedTempGeoValue;
    saveGeo(_selectedTempGeo);
    saveGeoValue(_selectedTempGeoValue);
    getSummaryData();
    if (isLoadRetailing) {
      if (SummaryTypes.retailing.type == tabType) {
        //retailing screen data
        getRetailingData();
        getRetailingData(type: 'category', name: 'category');
        getRetailingData(type: 'channel', name: 'geo');
        getRetailingData(type: 'geo', name: 'trends');
      } else if (SummaryTypes.coverage.type == tabType) {
        //Coverage screen data

        getCoverageData();
        // getCoverageData(type: 'category', name: 'category');
        getCoverageData(type: 'channel', name: 'geo');
        getCoverageData(
            type: tabType == SummaryTypes.coverage.type ? 'trends' : 'geo',
            name: 'trends');
      } else if (SummaryTypes.gp.type == tabType) {
        //golden points screen data

        getGPData();
        getGPData(type: 'category', name: 'category');
        getGPData(type: 'channel', name: 'geo');
        getGPData(type: 'geo', name: 'trends');
      } else if (SummaryTypes.fb.type == tabType) {
        //focus brand screen data

        getFocusBrandData();
        getFocusBrandData(type: 'category', name: 'category');
        getFocusBrandData(type: 'channel', name: 'geo');
        getFocusBrandData(type: 'geo', name: 'trends');
      } else if (tabType == 'All') {
        debugPrint('====>Reloading all deep dive');
        //reload all deep dive
        reloadAllDeepDive();
      }
    }
    update();
  }

  void reloadAllDeepDive() {
    //retailing screen data
    getRetailingData();
    getRetailingData(type: 'category', name: 'category');
    getRetailingData(type: 'channel', name: 'geo');
    getRetailingData(type: 'geo', name: 'trends');
    //Coverage screen data
    getCoverageData();
    getCoverageData(type: 'channel', name: 'geo');
    getCoverageData(type: 'trends', name: 'trends');
    //golden points screen data
    getGPData();
    getGPData(type: 'category', name: 'category');
    getGPData(type: 'channel', name: 'geo');
    getGPData(type: 'geo', name: 'trends');
    //focus brand screen data
    getFocusBrandData();
    getFocusBrandData(type: 'category', name: 'category');
    getFocusBrandData(type: 'channel', name: 'geo');
    getFocusBrandData(type: 'geo', name: 'trends');
    update();
  }

  void onApplyMultiFilter(String name, String type,
      {String tabType = 'Retailing'}) {
    if (SummaryTypes.retailing.type == tabType) {
      //retailing screen data
      getRetailingData(type: type, name: name);
    } else if (SummaryTypes.coverage.type == tabType) {
      //Coverage screen data
      getCoverageData(type: type, name: name);
    } else if (SummaryTypes.gp.type == tabType) {
      //retailing screen data
      getGPData(type: type, name: name);
    } else if (SummaryTypes.fb.type == tabType) {
      //retailing screen data
      getFocusBrandData(type: type, name: name);
    }
    update();
  }

  void onChangeFilters(String value) {
    _selectedTempGeoValue = value;
    update();
  }

  void onChangeTrendsFilters(String value) {
    _selectedTrendsGeoValue = value;
    _selectedTrendsCategoryValue = '';
    _selectedTrendsChannelValue = '';

    update();
  }

  void onChangeMultiFilters(String value) {
    //
    if (_selectedMultiGeo.toLowerCase() == 'Division'.toLowerCase()) {
      debugPrint('===>Adding Division $value');
      if (selectedMultiDivisions.contains(value)) {
        debugPrint('===>Contains Division $value');
        selectedMultiDivisions.remove(value);
      } else {
        debugPrint('===>Not Contains Division $value');
        selectedMultiDivisions.add(value);
      }
      update();
    } else if (_selectedMultiGeo.toLowerCase() == 'Cluster'.toLowerCase()) {
      debugPrint('===>Adding Cluster');
      if (selectedMultiClusters.contains(value)) {
        selectedMultiClusters.remove(value);
      } else {
        selectedMultiClusters.add(value);
      }
    } else if (_selectedMultiGeo.toLowerCase() == 'Site'.toLowerCase()) {
      debugPrint('===>Adding Site');
      if (selectedMultiSites.contains(value)) {
        selectedMultiSites.remove(value);
      } else {
        selectedMultiSites.add(value);
      }
    } else if (_selectedMultiGeo.toLowerCase() == 'Branch'.toLowerCase()) {
      debugPrint('===>Adding Branch');
      if (selectedMultiBranches.contains(value)) {
        selectedMultiBranches.remove(value);
      } else {
        selectedMultiBranches.add(value);
      }
    } else {
      debugPrint('===>Adding else');
      if (selectedMultiFilters.contains(value)) {
        selectedMultiFilters.remove(value);
      } else {
        selectedMultiFilters.add(value);
      }
    }
    update();
  }

  void getInitData() async {
    _showRetailing = await homeRepo.getRetailing();
    _showCoverage = await homeRepo.getCoverage();
    _showGoldenPoints = await homeRepo.getGoldenPoints();
    _showFocusBrand = homeRepo.getFocusBrand();
    update();
  }

  String getAccessToken() {
    return homeRepo.getAccessToken();
  }

  String getUserName() {
    return homeRepo.getUserName();
  }

  String getYear() {
    return homeRepo.getYear();
  }

  String getMonth() {
    return homeRepo.getMonth();
  }

  String getPersonalizedActiveMetrics() {
    return homeRepo.getPersonalizedActiveMetrics();
  }

  String getPersonalizedMoreMetrics() {
    return homeRepo.getPersonalizedMoreMetrics();
  }

  String getGeo() {
    return homeRepo.getGeo();
  }

  String getGeoValue() {
    return homeRepo.getGeoValue();
  }

  Future<bool> setSeen(bool seen) async {
    return await homeRepo.saveUserSeen(seen);
  }

  Future<bool> setYear(String year) async {
    return await homeRepo.saveYear(year);
  }

  Future<bool> savePersonalizedActiveMetrics(String active) async {
    return await homeRepo.savePersonalizedActiveMetrics(active);
  }

  Future<bool> savePersonalizedMoreMetrics(String more) async {
    return await homeRepo.savePersonalizedMoreMetrics(more);
  }

  Future<bool> setMonth(String month) async {
    return await homeRepo.saveMonth(month);
  }

  Future<bool> saveGeo(String geo) async {
    return await homeRepo.saveGeo(geo);
  }

  Future<bool> saveGeoValue(String geoValue) async {
    return await homeRepo.saveGeoValue(geoValue);
  }

  Future<bool> savePurpose(String purpose) async {
    return await homeRepo.savePurpose(purpose);
  }

  void onChangeBottomNav(int value) {
    _selectedNav = value;
    update();
  }

  void onExpandSummary(bool value) {
    _isSummaryExpanded = value;
    update();
  }

  void onExpandCategory(bool value) {
    _isExpandedCategory = value;
    update();
  }

  void onExpandChannel(bool value) {
    _isExpandedChannel = value;
    update();
  }

  void onExpandTrends(bool value) {
    _isExpandedTrends = value;
    update();
  }

  void onChangeRetailingView(bool value) {
    homeRepo.setRetailing(value);
    _showRetailing = value;
    update();
  }

  void onChangeCoverageView(bool value) {
    homeRepo.setCoverage(value);
    _showCoverage = value;
    update();
  }

  void onChangeGoldenPointsView(bool value) {
    homeRepo.setGoldenPoints(value);
    _showGoldenPoints = value;
    update();
  }

  void onChangeFocusBrandView(bool value) {
    homeRepo.setFocusBrand(value);
    _showFocusBrand = value;
    update();
  }

  List<SummaryModel> summaryData = [];
  List<List<String>> retailingList = [],
      coverageList = [],
      gpList = [],
      fbList = [],
      categoryCoverageList = [],
      categoryGPList = [],
      categoryFBList = [];
  List<List<String>> categoryList = [];
  List<List<String>> channelList = [],
      channelCoverageList = [],
      channelGPList = [],
      channelFBList = [];
  List<String> filters = [], multiFilters = [], trendsFilter = [];
  List<String> monthFilters = [];
  List<TrendsModel> trendsList = [];
  List<CoverageTrendsModel> trendsCoverageList = [];
  List<GPTrendsModel> trendsGPList = [];
  List<FBTrendsModel> trendsFBList = [];
  List<Map<String, dynamic>> geoFilters = [];

  // Future<void> addRetailingGeo(Map<String, dynamic> value) async {
  //   if (geoFilters.contains(value)) {
  //   } else {
  //     geoFilters.add(value);
  //   }
  //   // getRetailingData(allFilter: geoFilters);
  //   update();
  // }

  Future<ResponseModel> getSummaryData() async {
    debugPrint('===>Calling summary data');
    _isSummaryPageLoading = true;

    update();

    Response response = await homeRepo.getSummaryData({
      "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
      _selectedGeo.startsWith('All India')
          ? "allIndia"
          : _selectedGeo.startsWith('Site')
              ? "site"
              : _selectedGeo.toLowerCase(): _selectedGeo.startsWith('All India')
          ? ["allIndia"]
          : [_selectedGeoValue],
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      summaryData = summaryModelFromJson(response.bodyString.toString());
      responseModel = ResponseModel(true, 'Success');
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isSummaryPageLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getMonthFilters({String year = '2023'}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    Response response = await homeRepo.getFilters({"year": year});
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null) {
          monthFilters = List<String>.from(data!.map((x) => x));
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      Logger().e(response.body);
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getRetailingData(
      {String type = 'geo',
      String name = 'geo',
      List<Map<String, dynamic>>? allFilter}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        _isRetailingTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        _isSummaryLoading = true;
      } else if (type.startsWith('category')) {
        _isCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        _isChannelLoading = true;
      } else {
        _isLoading = true;
      }

      update();
    });
    Response response = await homeRepo.getRetailingData({
      "name": name,
      "type": type,
      "query": name.toLowerCase().startsWith('trend')
          ? [
              {
                "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                if (selectedTrendsGeoValue.isNotEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (_selectedTrendsGeoValue.isEmpty)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (selectedTrendsCategoryValue.isNotEmpty)
                  selectedTrendsCategory.toLowerCase():
                      selectedTrendsCategoryValue,
                if (selectedChannelFilter.isNotEmpty)
                  selectedChannel.toLowerCase(): selectedChannelFilter,
              },
            ]
          : type.startsWith('channel')
              ? allFilter ??
                  [
                    {
                      "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedChannelFilter.isNotEmpty)
                        selectedChannel.toLowerCase(): selectedChannelFilter,
                      if (selectedChannelFilter.isEmpty) "channel": [],
                    }
                  ]
              : name.startsWith('geo')
                  ? allFilter ??
                      [
                        {
                          "date":
                              "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                        },
                        ...selectedMultiDivisions
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiClusters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "cluster": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiSites
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiBranches
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                  "category": [],
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date":
                            "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedCategoryFilters.isNotEmpty)
                          selectedCategory.toLowerCase().contains('sub-brand')
                                  ? 'subBrandForm'
                                  : selectedCategory.toLowerCase():
                              selectedCategoryFilters,
                        // if (selectedCategoryFilters.isNotEmpty)
                        //   selectedCategory.toLowerCase():
                        //       selectedCategoryFilters,
                        if (selectedCategoryFilters.isEmpty) "category": [],
                      },
                    ]
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          Logger().v('===>Trends Data:${json.encode(response.body)}');
          trendsList = response.body["data"] == null
              ? []
              : List<TrendsModel>.from(
                  response.body["data"]!.map((x) => TrendsModel.fromJson(x)));
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            debugPrint('===>Geo Data:${json.encode(response.body)}');
            retailingList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            Logger().i('===>Category Data:${json.encode(response.body)}');
            categoryList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            Logger().v('===>Category Data:${json.encode(response.body)}');
            debugPrint(
                '===>Retailing Channel Data:${json.encode(response.body)}');
            channelList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            Logger().v('===>Trends Data:${json.encode(response.body)}');

            trendsList = response.body["data"] == null
                ? []
                : List<TrendsModel>.from(
                    response.body["data"]!.map((x) => TrendsModel.fromJson(x)));
          }
        }
//trendsList
        responseModel = ResponseModel(true, response.body["message"]);
      } else if (response.statusCode == 401) {
        responseModel = ResponseModel(false, response.statusText ?? "");
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
      } else {
        Logger().e(response.body);
        // showCustomSnackBar(response.body["me  ssage"] ?? '');
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      showCustomSnackBar('${response.body}');
      Logger().e(response.body);
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      _isRetailingTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      _isSummaryLoading = false;
    } else if (type.startsWith('category')) {
      _isCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      _isChannelLoading = false;
    } else {
      _isLoading = false;
    }

    update();
    return responseModel;
  }

  Future<ResponseModel> getAllFilters({String filter = '2023'}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    Response response = await homeRepo.getFilters({"filter": filter});
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          _filtersModel = FiltersModel.fromJson(data[0]);
          // List<String>.from(data[0]!.map((x) => x));
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getCategorySearch(String type,
      {String query = ''}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    Response response = await homeRepo.getFilters({
      "search": {"name": query, "type": type}
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          if (type.toLowerCase() == 'branch') {
            branchFilter = List<String>.from(data!.map((x) => x));
          } else if (type.toLowerCase() == 'subBrandForm'.toLowerCase() ||
              type.toLowerCase() == 'subBrandGroup'.toLowerCase()) {
            subBrandForm = List<String>.from(data!.map((x) => x));
          }
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  //coverage
  Future<ResponseModel> getCoverageData(
      {String type = 'geo',
      String name = 'geo',
      List<Map<String, dynamic>>? allFilter}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        _isCoverageTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        _isSummaryLoading = true;
      } else if (type.startsWith('category')) {
        _isCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        _isChannelLoading = true;
      } else {
        _isLoading = true;
      }

      update();
    });
    Response response = await homeRepo.getCoverageData({
      "name": name,
      "type": type,
      "query": name.toLowerCase().startsWith('trend')
          ? [
              {
                "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                if (_selectedTrendsGeoValue.trim().isNotEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (_selectedTrendsGeoValue.trim().isEmpty)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (selectedChannelFilter.isNotEmpty)
                  selectedChannel.toLowerCase(): selectedChannelFilter,
              },
            ]
          : type.startsWith('channel')
              ? allFilter ??
                  [
                    {
                      "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedChannelFilter.isNotEmpty)
                        selectedChannel.toLowerCase(): selectedChannelFilter,
                      if (selectedChannelFilter.isEmpty) "channel": [],
                    }
                  ]
              : name.startsWith('geo')
                  ? allFilter ??
                      [
                        {
                          "date":
                              "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                        },
                        ...selectedMultiDivisions
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedMultiClusters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "cluster": e,
                                })
                            .toList(),
                        ...selectedMultiSites
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedMultiBranches
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date":
                            "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedCategoryFilters.isNotEmpty)
                          selectedCategory.toLowerCase().contains('sub-brand')
                                  ? 'subBrandForm'
                                  : selectedCategory.toLowerCase():
                              selectedCategoryFilters,
                        if (selectedCategoryFilters.isEmpty) "category": [],
                      },
                    ]
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          Logger().v('===>Coverage Trends Data:${json.encode(response.body)}');

          trendsCoverageList = response.body["data"] == null
              ? []
              : List<CoverageTrendsModel>.from(response.body["data"]!
                  .map((x) => CoverageTrendsModel.fromJson(x)));
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            debugPrint('===>Geo Data:${json.encode(response.body)}');
            coverageList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            Logger().i('===>Category Data:${json.encode(response.body)}');
            categoryCoverageList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            Logger().v('===>Category Data:${json.encode(response.body)}');
            debugPrint(
                '===>Coverage Channel Data:${json.encode(response.body)}');
            channelCoverageList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            Logger().v('===>Trends Data:${json.encode(response.body)}');

            trendsCoverageList = response.body["data"] == null
                ? []
                : List<CoverageTrendsModel>.from(response.body["data"]!
                    .map((x) => CoverageTrendsModel.fromJson(x)));
          }
        }
//trendsList
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        Logger().e(response.body);
        // showCustomSnackBar(response.body["me  ssage"] ?? '');
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      Logger().e(response.body);
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      _isCoverageTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      _isSummaryLoading = false;
    } else if (type.startsWith('category')) {
      _isCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      _isChannelLoading = false;
    } else {
      _isLoading = false;
    }

    update();
    return responseModel;
  }

//Golden Points
  Future<ResponseModel> getGPData(
      {String type = 'geo',
      String name = 'geo',
      List<Map<String, dynamic>>? allFilter}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        _isGPTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        _isSummaryLoading = true;
      } else if (type.startsWith('category')) {
        _isCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        _isChannelLoading = true;
      } else {
        _isLoading = true;
      }

      update();
    });
    Response response = await homeRepo.getGPData(
      {
        "name": name,
        "type": type,
        "query": name.toLowerCase().startsWith('trend')
            ? [
                {
                  "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                  if (selectedTrendsGeoValue.isNotEmpty)
                    _selectedTrendsGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedTrendsGeo.toLowerCase():
                        _selectedTrendsGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedTrendsGeoValue,
                  if (selectedTrendsGeoValue.isEmpty)
                    _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeo.toLowerCase():
                        _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeoValue,
                  if (selectedTrendsCategoryValue.isNotEmpty)
                    selectedTrendsCategory.toLowerCase().contains('sub-brand')
                            ? 'subBrandGroup'
                            : selectedTrendsCategory.toLowerCase():
                        selectedTrendsCategoryValue,
                  if (selectedChannelFilter.isNotEmpty)
                    selectedChannel.toLowerCase(): selectedChannelFilter,
                },
              ]
            : type.startsWith('channel')
                ? allFilter ??
                    [
                      {
                        "date":
                            "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? ["allIndia"]
                                : [_selectedGeoValue],
                        if (selectedChannelFilter.isNotEmpty)
                          selectedChannel.toLowerCase(): selectedChannelFilter,
                        if (selectedChannelFilter.isEmpty) "channel": [],
                      }
                    ]
                : name.startsWith('geo')
                    ? allFilter ??
                        [
                          {
                            "date":
                                "${selectedMonth!.substring(0, 3)}-$selectedYear",
                            _selectedGeo.startsWith('All India')
                                    ? "allIndia"
                                    : _selectedGeo.toLowerCase():
                                _selectedGeo.startsWith('All India')
                                    ? "allIndia"
                                    : _selectedGeoValue,
                          },
                          ...selectedMultiDivisions
                              .map((e) => {
                                    "date":
                                        "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "division": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedMultiClusters
                              .map((e) => {
                                    "date":
                                        "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "cluster": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedMultiSites
                              .map((e) => {
                                    "date":
                                        "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "site": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedMultiBranches
                              .map((e) => {
                                    "date":
                                        "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "branch": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedMultiFilters
                              .map((e) => {
                                    "date":
                                        "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "allIndia": e,
                                    "category": [],
                                  })
                              .toList(),
                        ]
                    : [
                        {
                          "date":
                              "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                          if (selectedCategoryFilters.isNotEmpty)
                            selectedCategory.toLowerCase().contains('sub-brand')
                                    ? 'subBrandGroup'
                                    : selectedCategory.toLowerCase():
                                selectedCategoryFilters,
                          if (selectedCategoryFilters.isEmpty) 'category': []
                        },
                      ]
      },
    );
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          Logger().v('===>Trends Data:${json.encode(response.body)}');

          trendsGPList = response.body["data"] == null
              ? []
              : List<GPTrendsModel>.from(
                  response.body["data"]!.map((x) => GPTrendsModel.fromJson(x)));
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            debugPrint('===>Geo Data:${json.encode(response.body)}');
            gpList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            Logger().i('===>Category Data:${json.encode(response.body)}');
            categoryGPList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            Logger().v('===>Category Data:${json.encode(response.body)}');
            debugPrint('===>GP Channel Data:${json.encode(response.body)}');
            channelGPList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            Logger().v('===>Trends Data:${json.encode(response.body)}');

            trendsGPList = response.body["data"] == null
                ? []
                : List<GPTrendsModel>.from(response.body["data"]!
                    .map((x) => GPTrendsModel.fromJson(x)));
          }
        }
//trendsList
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        Logger().e("===>Name:$name --Type:$type  :${response.body}");
        // showCustomSnackBar(response.body["me  ssage"] ?? '');
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      Logger().e("===>Name:$name --Type:$type  :${response.body}");
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      _isGPTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      _isSummaryLoading = false;
    } else if (type.startsWith('category')) {
      _isCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      _isChannelLoading = false;
    } else {
      _isLoading = false;
    }

    update();
    return responseModel;
  }

//Focus Brand
  Future<ResponseModel> getFocusBrandData(
      {String type = 'geo',
      String name = 'geo',
      List<Map<String, dynamic>>? allFilter}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        _isFBTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        _isSummaryLoading = true;
      } else if (type.startsWith('category')) {
        _isCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        _isChannelLoading = true;
      } else {
        _isLoading = true;
      }

      update();
    });
    debugPrint('=====>FocusBrand Type:$type Name: $name');
    Response response = await homeRepo.getFocusBrandData({
      "name": name,
      "type": type,
      "query": name.toLowerCase().startsWith('trend')
          ? [
              {
                "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                if (selectedTrendsGeoValue.isNotEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (selectedTrendsGeoValue.isEmpty)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (selectedTrendsCategoryValue.isNotEmpty)
                  selectedTrendsCategory.toLowerCase():
                      selectedTrendsCategoryValue,
                if (selectedChannelFilter.isNotEmpty)
                  selectedChannel.toLowerCase(): selectedChannelFilter,
              },
            ]
          : type.startsWith('channel')
              ? allFilter ??
                  [
                    {
                      "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? ["allIndia"]
                              : [_selectedGeoValue],
                      if (selectedChannelFilter.isNotEmpty)
                        selectedChannel.toLowerCase(): selectedChannelFilter,
                      if (selectedChannelFilter.isEmpty) "channel": [],
                    }
                  ]
              : name.startsWith('geo')
                  ? allFilter ??
                      [
                        {
                          "date":
                              "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                        },
                        ...selectedMultiDivisions
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiClusters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "cluster": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiSites
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiBranches
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                  "category": [],
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                  "category": [],
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date":
                            "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? ["allIndia"]
                                : _selectedGeoValue,
                        if (selectedCategoryFilters.isNotEmpty)
                          selectedCategory.toLowerCase().contains('sub-brand')
                                  ? 'subBrandForm'
                                  : selectedCategory.toLowerCase():
                              selectedCategoryFilters,
                        if (selectedCategoryFilters.isEmpty) 'category': []
                      },
                    ]
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          Logger().v('===>Trends Data:${json.encode(response.body)}');

          trendsFBList = response.body["data"] == null
              ? []
              : List<FBTrendsModel>.from(
                  response.body["data"]!.map((x) => FBTrendsModel.fromJson(x)));
          Logger()
              .v('===>Trends Data Length:${trendsFBList.first.data?.length}');
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            debugPrint('===>Geo Data:${json.encode(response.body)}');
            fbList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            Logger().i('===>Category Data:${json.encode(response.body)}');
            categoryFBList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            Logger().v('===>Channel Data:${json.encode(response.body)}');
            debugPrint('===>FB Channel Data:${json.encode(response.body)}');
            channelFBList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            Logger().v('===>Trends Data:${json.encode(response.body)}');

            trendsFBList = response.body["data"] == null
                ? []
                : List<FBTrendsModel>.from(response.body["data"]!
                    .map((x) => FBTrendsModel.fromJson(x)));
          }
        }
//trendsList
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        Logger().e('==>Focus Brand $type $name ${{
          "name": name,
          "type": type,
          "query": name.toLowerCase().startsWith('trend')
              ? [
                  {
                    "date": "${selectedMonth!.substring(0, 3)}-$selectedYear",
                    if (selectedTrendsGeoValue.isNotEmpty)
                      _selectedTrendsGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedTrendsGeo.toLowerCase():
                          _selectedTrendsGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedTrendsGeoValue,
                    if (selectedTrendsGeoValue.isEmpty)
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                    if (selectedTrendsCategoryValue.isNotEmpty)
                      selectedTrendsCategory.toLowerCase():
                          selectedTrendsCategoryValue,
                    if (selectedChannelFilter.isNotEmpty)
                      selectedChannel.toLowerCase(): selectedChannelFilter,
                  },
                ]
              : type.startsWith('channel')
                  ? allFilter ??
                      [
                        {
                          "date":
                              "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? ["allIndia"]
                                  : [_selectedGeoValue],
                          if (selectedChannelFilter.isNotEmpty)
                            selectedChannel.toLowerCase():
                                selectedChannelFilter,
                          if (selectedChannelFilter.isEmpty) "channel": [],
                        }
                      ]
                  : name.startsWith('geo')
                      ? allFilter ??
                          [
                            {
                              "date":
                                  "${selectedMonth!.substring(0, 3)}-$selectedYear",
                              _selectedGeo.startsWith('All India')
                                      ? "allIndia"
                                      : _selectedGeo.toLowerCase():
                                  _selectedGeo.startsWith('All India')
                                      ? "allIndia"
                                      : _selectedGeoValue,
                            },
                            ...selectedMultiDivisions
                                .map((e) => {
                                      "date":
                                          "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                      "division": e,
                                      "category": [],
                                    })
                                .toList(),
                            ...selectedMultiClusters
                                .map((e) => {
                                      "date":
                                          "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                      "cluster": e,
                                      "category": [],
                                    })
                                .toList(),
                            ...selectedMultiSites
                                .map((e) => {
                                      "date":
                                          "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                      "site": e,
                                      "category": [],
                                    })
                                .toList(),
                            ...selectedMultiBranches
                                .map((e) => {
                                      "date":
                                          "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                      "branch": e,
                                      "category": [],
                                    })
                                .toList(),
                            ...selectedMultiFilters
                                .map((e) => {
                                      "date":
                                          "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                      "allIndia": e,
                                      "category": [],
                                    })
                                .toList(),
                          ]
                      : [
                          {
                            "date":
                                "${selectedMonth!.substring(0, 3)}-$selectedYear",
                            _selectedGeo.startsWith('All India')
                                    ? "allIndia"
                                    : _selectedGeo.toLowerCase():
                                _selectedGeo.startsWith('All India')
                                    ? ["allIndia"]
                                    : _selectedGeoValue,
                            if (selectedCategoryFilters.isNotEmpty)
                              selectedCategory
                                          .toLowerCase()
                                          .contains('sub-brand')
                                      ? 'subBrandForm'
                                      : selectedCategory.toLowerCase():
                                  selectedCategoryFilters,
                            if (selectedCategoryFilters.isEmpty) 'category': []
                          },
                        ]
        }} ${response.body}');
        // showCustomSnackBar(response.body["me  ssage"] ?? '');
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      Logger().e('==>Focus Brand $type $name ${response.body}');
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      _isFBTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      _isSummaryLoading = false;
    } else if (type.startsWith('category')) {
      _isCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      _isChannelLoading = false;
    } else {
      _isLoading = false;
    }

    update();
    return responseModel;
  }
}
