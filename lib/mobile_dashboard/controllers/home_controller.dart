import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/utils/date_converter.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/utils/global.dart' as globals;
import 'package:command_centre/mobile_dashboard/data/repository/home_repo.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/filters_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/summary_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/gp_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/retailing_geo_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/coverage_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/retailing_trends_model.dart';

class HomeController extends GetxController {
  //
  final HomeRepo homeRepo;
  //constructor :)
  HomeController({required this.homeRepo});

//

  final ScrollController mScrollController = ScrollController();

  //
  final storage = new FlutterSecureStorage();
  //
  bool _isLoading = false,
      _isSummaryExpanded = true,
      _isExpandedCategory = false,
      _isExpandedTrends = false,
      _isExpandedChannel = false,
      _showRetailing = true,
      _showCoverage = true,
      _showGoldenPoints = true,
      _showFocusBrand = true,
      _isFilterLoading = false,
      _isMonthLoading = false,
      _isSummaryLoading = false,
      _isFirebaseVarLoading = false,
      _isRetailingGeoLoading = false,
      _isCoverageGeoLoading = false,
      _isGPGeoLoading = false,
      _isFBGeoLoading = false,
      _isRetailingCategoryLoading = false,
      _isCoverageCategoryLoading = false,
      _isGPCategoryLoading = false,
      _isFBCategoryLoading = false,
      // _isChannelLoading = false,
      _isRetailingChannelLoading = false,
      _isCoverageChannelLoading = false,
      _isGPChannelLoading = false,
      _isFBChannelLoading = false,
      _isRetailingTrendsLoading = false,
      _isCoverageTrendsLoading = false,
      _isGPTrendsLoading = false,
      _isFBTrendsLoading = false,
      _channelSales = true,
      _isSummaryDirect = false,
      _isDirectIndirectLoading = false,
      _isSummaryPageLoading = false,
      _isRetailingDeepDiveInd = true;
  bool get isFirebaseVarLoading => _isFirebaseVarLoading;
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
  bool get isRetailingGeoLoading => _isRetailingGeoLoading;
  bool get isCoverageGeoLoading => _isCoverageGeoLoading;
  bool get isGPGeoLoading => _isGPGeoLoading;
  bool get isFBGeoLoading => _isFBGeoLoading;
  bool get isRetailingCategoryLoading => _isRetailingCategoryLoading;
  bool get isCoverageCategoryLoading => _isCoverageCategoryLoading;
  bool get isGPCategoryLoading => _isGPCategoryLoading;
  bool get isFBCategoryLoading => _isFBCategoryLoading;
  bool get isMonthLoading => _isMonthLoading;
  bool get isRetailingChannelLoading => _isRetailingChannelLoading;
  bool get isCoverageChannelLoading => _isCoverageChannelLoading;
  bool get isGPChannelLoading => _isGPChannelLoading;
  bool get isFBChannelLoading => _isFBChannelLoading;
  bool get isRetailingTrendsLoading => _isRetailingTrendsLoading;
  bool get channelSales => _channelSales;
  bool get isSummaryPageLoading => _isSummaryPageLoading;
  bool get isCoverageTrendsLoading => _isCoverageTrendsLoading;
  bool get isGPTrendsLoading => _isGPTrendsLoading;
  bool get isFBTrendsLoading => _isFBTrendsLoading;
  bool get isSummaryDirect => _isSummaryDirect;
  bool get isDirectIndirectLoading => _isDirectIndirectLoading;
  bool get isRetailingDeepDiveInd => _isRetailingDeepDiveInd;

  //int
  int _selectedNav = 0;
  int get selectedNav => _selectedNav;

  //

  String _retailingTrendsValue = '',
      _coverageTrendsValue = '',
      _gpTrendsValue = '',
      _fbTrendsValue = '',
      _appVersion = '';

  String get appVersion => _appVersion;
  String get retailingTrendsValue => _retailingTrendsValue;
  String get coverageTrendsValue => _coverageTrendsValue;
  String get gpTrendsValue => _gpTrendsValue;
  String get fbTrendsValue => _fbTrendsValue;
  String _selectedCoverageTrendsFilter = 'Prod %';
  String get selectedCoverageTrendsFilter => _selectedCoverageTrendsFilter;
  String _selectedTrends = 'Geography';
  String get selectedTrends => _selectedTrends;
  String _selectedCoverageTrends = 'Geography';
  String get selectedCoverageTrends => _selectedCoverageTrends;
  String _selectedGPTrends = 'Geography';
  String get selectedGPTrends => _selectedGPTrends;
  String _selectedFBTrends = 'Geography';
  String get selectedFBTrends => _selectedFBTrends;

  String _selectedChannel = 'attr1';
  String get selectedChannel => _selectedChannel;
  String _selectedRetailingChannel = 'Level 1';
  String get selectedRetailingChannel => _selectedRetailingChannel;
  String _selectedCoverageChannel = 'Level 1';
  String get selectedCoverageChannel => _selectedCoverageChannel;
  String _selectedGPChannel = 'Level 1';
  String get selectedGPChannel => _selectedGPChannel;
  String _selectedFBChannel = 'Level 1';
  String get selectedFBChannel => _selectedFBChannel;
  String _selectedTrendsChannel = 'attr1';
  String get selectedTrendsChannel => _selectedTrendsChannel;
  String _selectedTrendsChannelValue = '';
  String get selectedTrendsChannelValue => _selectedTrendsChannelValue;
  String _selectedCategory = 'Category';
  String get selectedCategory => _selectedCategory;
  String _selectedGPCategory = 'Category';
  String get selectedGPCategory => _selectedGPCategory;
  String _selectedFBCategory = 'Category';
  String get selectedFBCategory => _selectedFBCategory;
  String _selectedTrendsCategory = 'Category';
  String get selectedTrendsCategory => _selectedTrendsCategory;
  String _selectedTempRetailingChannel = 'Level 1';
  String get selectedTempRetailingChannel => _selectedTempRetailingChannel;
  String _selectedTempCoverageChannel = 'Level 1';
  String get selectedTempCoverageCategory => _selectedTempCoverageChannel;
  String _selectedTempGPChannel = 'Level 1';
  String get selectedTempGPChannel => _selectedTempGPChannel;
  String _selectedTempFBChannel = 'Channel';
  String get selectedTempFBChannel => _selectedTempFBChannel;
  String _selectedTempCategory = 'Category';
  String get selectedTempCategory => _selectedTempCategory;
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

  String _selectedMonth =
      DateConverter().returnMonth(DateTime.now()).substring(0, 3);
  String get selectedMonth => _selectedMonth;
  String _selectedYear = DateTime.now().year.toString();
  String get selectedYear => _selectedYear;
  String? _selectedTempMonth =
      '${DateConverter().returnMonth(DateTime.now()).substring(0, 3)}-${DateTime.now().year}';
  String? get selectedTempMonth => _selectedTempMonth;
  String? _selectedTempYear = DateTime.now().year.toString();
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
      selectedRetailingCategoryFilters = [],
      selectedCoverageCategoryFilters = [],
      selectedGPCategoryFilters = [],
      selectedFBCategoryFilters = [],
      selectedSubBrandFilters = [],
      // subBrandsFilters = [],
      channelFilter = [],
      channelTrendsFilter = [],
      selectedRetailingChannelFilter = [],
      selectedCoverageChannelFilter = [],
      selectedGPChannelFilter = [],
      selectedFBChannelFilter = [],
      // selectedMultiDivisions = [],
      selectedRetailingMultiAllIndia = [],
      selectedFBMultiAllIndia = [],
      selectedCoverageMultiAllIndia = [],
      selectedGPMultiAllIndia = [],
      selectedRetailingMultiDivisions = [],
      selectedCoverageMultiDivisions = [],
      selectedGPMultiDivisions = [],
      selectedFBMultiDivisions = [],
      // selectedMultiClusters = [],
      selectedRetailingMultiClusters = [],
      selectedCoverageMultiClusters = [],
      selectedGPMultiClusters = [],
      selectedFBMultiClusters = [],
      selectedRetailingMultiSites = [],
      selectedCoverageMultiSites = [],
      selectedGPMultiSites = [],
      selectedFBMultiSites = [],
      selectedRetailingMultiBranches = [],
      selectedCoverageMultiBranches = [],
      selectedGPMultiBranches = [],
      selectedFBMultiBranches = [];
  List<String> activeMetrics = [
        'Retailing',
        'Coverage',
        'Golden Points',
        'Focus Brand'
      ],
      moreMetrics = []; // 'Inventory''Shipment (TBD)'
  //Models
  FiltersModel? _filtersModel;
  FiltersModel? get filtersModel => _filtersModel;

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    _appVersion = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    update();
  }

  void onChannelSalesChange(bool value) {
    _channelSales = value;
    update();
  }

  void onChangeCoverageTrends(String value) {
    _selectedCoverageTrendsFilter = value;
    update();
  }

  void getReatilingInit() {
    FirebaseAnalytics.instance.logEvent(
        name: 'retailing',
        parameters: {"message": 'Retailing Started ${getUserName()}'});
    if (_selectedGeoValue.toLowerCase() == 'all india') {
      _isRetailingDeepDiveInd = false;
    } else {
      _isRetailingDeepDiveInd = true;
    }

    debugPrint('===> Calling Retailing Init');
    if (retailingGeoModel == null) {
      getRetailingData();
    }
    if (channelRetailingModel == null) {
      getRetailingData(type: 'channel', name: 'geo');
    }
    if (categoryRetailingModel == null) {
      getRetailingData(type: 'category', name: 'category');
    }
    if (trendsRetailingModel == null) {
      getRetailingData(type: 'geo', name: 'trends');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void getCoverageInit() {
    FirebaseAnalytics.instance.logEvent(
        name: 'coverage',
        parameters: {"message": 'Coverage Started ${getUserName()}'});
    _isRetailingDeepDiveInd = true;
    if (coverageList.isEmpty) {
      getCoverageData();
    }
    if (channelCoverageList.isEmpty) {
      getCoverageData(type: 'channel', name: 'geo');
    }
    if (trendsCoverageList.isEmpty) {
      getCoverageData(type: 'trends', name: 'trends');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void getGPInit() {
    FirebaseAnalytics.instance.logEvent(
        name: 'gp', parameters: {"message": 'GP Started ${getUserName()}'});
    _isRetailingDeepDiveInd = true;
    if (gpList.isEmpty) {
      getGPData();
    }
    if (channelGPList.isEmpty) {
      getGPData(type: 'channel', name: 'geo');
    }
    if (categoryGPList.isEmpty) {
      getGPData(type: 'category', name: 'category');
    }
    if (trendsGPList.isEmpty) {
      getGPData(type: 'geo', name: 'trends');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void getFBInit() {
    FirebaseAnalytics.instance.logEvent(
        name: 'fb', parameters: {"message": 'FB Started ${getUserName()}'});
    _isRetailingDeepDiveInd = true;
    if (fbList.isEmpty) {
      getFocusBrandData();
    }
    if (channelFBList.isEmpty) {
      getFocusBrandData(type: 'channel', name: 'geo');
    }
    if (categoryFBList.isEmpty) {
      getFocusBrandData(type: 'category', name: 'category');
    }
    if (trendsFBList.isEmpty) {
      getFocusBrandData(type: 'geo', name: 'trends');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void onChangeSummaryDI(bool value) {
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_switch',
        parameters: {"message": 'Direct Indirect Started ${getUserName()}'});
    if (selectedGeo == 'All India') {
      _isSummaryDirect = value;
      FirebaseAnalytics.instance.logEvent(name: 'selected_switch', parameters: {
        "message": 'Selected Trends Category $_isSummaryDirect ${getUserName()}'
      });
      FirebaseCrashlytics.instance.log("Direct Indirect Selected");
    }
    update();
  }

  void onChangeDeepDiveIndirect(bool value) {
    if (selectedGeo == 'All India') {
      FirebaseAnalytics.instance.logEvent(name: 'selected_switch', parameters: {
        "message": 'Deep Dive Direct Indirect Selected ${getUserName()}'
      });
      FirebaseCrashlytics.instance.log("Deep Dive Direct Indirect Selected");
      _isRetailingDeepDiveInd = value;
      FirebaseAnalytics.instance.logEvent(name: 'selected_switch', parameters: {
        "message":
            'Selected Trends Category $_isRetailingDeepDiveInd ${getUserName()}'
      });
    }
    update();
  }

  void onSavePersonalizedData(
      {required List<String> active, required List<String> more}) {
    FirebaseCrashlytics.instance.log("Save Selected Personalized");
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Save Selected Personalized ${getUserName()}'});
    savePersonalizedActiveMetrics(json.encode(active));
    savePersonalizedMoreMetrics(json.encode(more));
    update();
  }

  void getPersonalizedData() {
    String activeJson = getPersonalizedActiveMetrics();
    String moreJson = getPersonalizedMoreMetrics();
    debugPrint('==>Active Data:$activeJson  ==>More Data:$moreJson');
    FirebaseCrashlytics.instance.log("Get Selected Personalized");
    if (activeJson.trim().isNotEmpty) {
      activeMetrics = List<String>.from(json.decode(activeJson));
    }
    if (moreJson.trim().isNotEmpty) {
      moreMetrics = List<String>.from(json.decode(moreJson));
    }
    update();
  }

  void onChangeCategory1(String value, {required String tabType}) {
    FirebaseCrashlytics.instance.log("On Category1 Changed");
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_filter',
        parameters: {"message": 'On Category Changed ${getUserName()}'});
    if (tabType == SummaryTypes.retailing.type) {
      _selectedCategory = value;
      FirebaseAnalytics.instance.logEvent(
          name: 'selected_filter_category',
          parameters: {
            "message": 'On Category Changed $_selectedCategory ${getUserName()}'
          });
    } else if (tabType == SummaryTypes.gp.type) {
      _selectedGPCategory = value;
      FirebaseAnalytics.instance
          .logEvent(name: 'selected_filter_gp', parameters: {
        "message": 'On Category Changed $_selectedGPCategory ${getUserName()}'
      });
    } else if (tabType == SummaryTypes.fb.type) {
      _selectedFBCategory = value;
      FirebaseAnalytics.instance
          .logEvent(name: 'selected_filter_fb', parameters: {
        "message": 'On Category Changed $_selectedFBCategory ${getUserName()}'
      });
    }

    update();
  }

  void onChangeCategory(String value, String category, {bool isInit = false}) {
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_filter',
        parameters: {"message": 'On Category Changed ${getUserName()}'});
    FirebaseCrashlytics.instance.log("On Category Changed");
    // _selectedTempCategory = category;
    // if (!isInit) selectedCategoryFilters.clear();
    if (filtersModel != null) {
      if (value.toLowerCase().startsWith('category')) {
        categoryFilters = filtersModel?.category ?? [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_category',
            parameters: {
              "message": 'On Category Changed $categoryFilters ${getUserName()}'
            });
      } else if (value.toLowerCase().startsWith('brand form')) {
        categoryFilters = filtersModel?.brandForm ?? [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_category',
            parameters: {
              "message": 'On Category Changed $categoryFilters ${getUserName()}'
            });
      } else if (value.trim().toLowerCase().startsWith('brand')) {
        categoryFilters = filtersModel?.brand ?? [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_category',
            parameters: {
              "message": 'On Category Changed $categoryFilters ${getUserName()}'
            });
      } else if (value.trim().toLowerCase().startsWith('sub-brand')) {
        // categoryFilters = filtersModel?.subBrandForm ?? [];
      }
    } else {
      debugPrint('====>Filter model is Null');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  void onChangeTrendsCategoryValue(String value) {
    FirebaseCrashlytics.instance.log("On Trends Changed");
    _selectedTrendsCategory = value;
    FirebaseAnalytics.instance
        .logEvent(name: 'selected_trend_analysis', parameters: {
      "message": 'On Trends Changed $_selectedTrendsCategory ${getUserName()}'
    });
    update();
  }

  void onChangeTrendsCategory(String value) {
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_trend_analysis',
        parameters: {"message": 'On Trends Changed ${getUserName()}'});
    FirebaseCrashlytics.instance.log("On Trends Changed");
    if (filtersModel != null) {
      if (value.toLowerCase().startsWith('category')) {
        categoryTrendsFilters = filtersModel?.category ?? [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_trends_category',
            parameters: {
              "message":
                  'On Category Trends Changed $categoryTrendsFilters ${getUserName()}'
            });
      } else if (value.toLowerCase().startsWith('brand form')) {
        categoryTrendsFilters = filtersModel?.brandForm ?? [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_trends_category',
            parameters: {
              "message":
                  'On Category Trends Changed $categoryTrendsFilters ${getUserName()}'
            });
      } else if (value.trim().toLowerCase().startsWith('brand')) {
        categoryTrendsFilters = filtersModel?.brand ?? [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_trends_category',
            parameters: {
              "message":
                  'On Category Trends Changed $categoryTrendsFilters ${getUserName()}'
            });
      } else if (value.trim().toLowerCase().startsWith('sub-brand')) {
        categoryTrendsFilters = [];
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_trends_category',
            parameters: {
              "message":
                  'On Category Trends Changed $categoryTrendsFilters ${getUserName()}'
            });
      }
    } else {
      debugPrint('====>Filter model is Null');
    }

    update();
  }

  void onChangeChannel1(String value, {String? tabType}) {
    FirebaseCrashlytics.instance.log("On Channel Changed");
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_filter',
        parameters: {"message": 'On Channel Changed ${getUserName()}'});
    _selectedChannel = value;
    if (tabType != null) {
      if (tabType == SummaryTypes.retailing.type) {
        _selectedRetailingChannel = value;
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_channel',
            parameters: {
              "message":
                  'On Channel Changed $_selectedRetailingChannel ${getUserName()}'
            });
      } else if (tabType == SummaryTypes.coverage.type) {
        _selectedCoverageChannel = value;
        FirebaseAnalytics.instance
            .logEvent(name: 'selected_filter_channel', parameters: {
          "message":
              'On Coverage Channel Changed $_selectedCoverageChannel ${getUserName()}'
        });
      } else if (tabType == SummaryTypes.gp.type) {
        _selectedGPChannel = value;
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_channel',
            parameters: {
              "message":
                  'On GP Channel Changed $_selectedGPChannel ${getUserName()}'
            });
      } else if (tabType == SummaryTypes.fb.type) {
        _selectedFBChannel = value;
        FirebaseAnalytics.instance.logEvent(
            name: 'selected_filter_channel',
            parameters: {
              "message":
                  'On FB Channel Changed $_selectedFBChannel ${getUserName()}'
            });
      }
    }

    update();
  }

  void onChangeTrendsChannel(String value) {
    FirebaseCrashlytics.instance.log("On Trends Channel Changed");

    _selectedTrendsChannel = value;
    FirebaseAnalytics.instance
        .logEvent(name: 'selected_trend_analysis', parameters: {
      "message": 'On Trends Changed $_selectedTrendsChannel ${getUserName()}'
    });
    update();
  }

  void onChangeChannel(String value, String tabType) {
    if (tabType == SummaryTypes.retailing.type) {
      if (filtersModel != null) {
        if (channelSales) {
          if (value.toLowerCase().startsWith('level 1')) {
            FirebaseCrashlytics.instance.log("On Level 1 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 1 Changed ${getUserName()}'});
            debugPrint('===> $value  ==>${filtersModel?.attr1}');

            channelFilter = _filtersModel?.attr1 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 1 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 2')) {
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 2 Changed ${getUserName()}'});
            FirebaseCrashlytics.instance.log("On Level 2 Changed");
            debugPrint('===> $value  ==>${filtersModel?.attr2}');
            channelFilter = _filtersModel?.attr2 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 2 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 3')) {
            FirebaseCrashlytics.instance.log("On Level 3 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 3 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.attr3 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 3 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 4')) {
            FirebaseCrashlytics.instance.log("On Level 4 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 4 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.attr4 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 4 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 5')) {
            FirebaseCrashlytics.instance.log("On Level 5 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 5 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.attr5 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 5 $channelFilter ${getUserName()}'
                });
          }
        } else {
          if (value.toLowerCase().startsWith('level 1')) {
            FirebaseCrashlytics.instance.log("On Level 1 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 1 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.indAttr1 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 1 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 2')) {
            FirebaseCrashlytics.instance.log("On Level 2 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 2 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.indAttr2 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 2 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 3')) {
            FirebaseCrashlytics.instance.log("On Level 3 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 3 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.indAttr3 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 3 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 4')) {
            FirebaseCrashlytics.instance.log("On Level 4 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 4 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.indAttr4 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 4 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 5')) {
            FirebaseCrashlytics.instance.log("On Level 5 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 5 Changed ${getUserName()}'});
            channelFilter = _filtersModel?.indAttr5 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 5 $channelFilter ${getUserName()}'
                });
          }
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            FirebaseCrashlytics.instance.log("On Level 1 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 1 Changed ${getUserName()}'});
            channelFilter = filtersModel?.attr1 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 1 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 2')) {
            FirebaseCrashlytics.instance.log("On Level 2 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 2 Changed ${getUserName()}'});
            channelFilter = filtersModel?.attr2 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 2 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 3')) {
            FirebaseCrashlytics.instance.log("On Level 3 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 3 Changed ${getUserName()}'});
            channelFilter = filtersModel?.attr3 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 3 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 4')) {
            FirebaseCrashlytics.instance.log("On Level 4 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 4 Changed ${getUserName()}'});
            channelFilter = filtersModel?.attr4 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 4 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 5')) {
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 5 Changed ${getUserName()}'});
            FirebaseCrashlytics.instance.log("On Level 5 Changed");
            channelFilter = filtersModel?.attr5 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 5 $channelFilter ${getUserName()}'
                });
          }
        });
      }
    } else {
      if (filtersModel != null) {
        debugPrint(
            '====>Filter aatr1 :${filtersModel?.otherAttrs?.attr1 ?? []}');
        if (value.toLowerCase().startsWith('level 1')) {
          FirebaseCrashlytics.instance.log("On Level 1 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {"message": 'On Level 1 Changed ${getUserName()}'});
          debugPrint('===> Channel Filter:s $value');
          channelFilter = filtersModel?.otherAttrs?.attr1 ?? [];
          FirebaseAnalytics.instance.logEvent(
              name: 'selected_filter_channel',
              parameters: {
                "message":
                    'On Channel Changed Level 1 $channelFilter ${getUserName()}'
              });
        } else if (value.toLowerCase().startsWith('level 2')) {
          FirebaseCrashlytics.instance.log("On Level 2 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {"message": 'On Level 2 Changed ${getUserName()}'});
          debugPrint('===> $value  ==>${filtersModel?.attr2}');
          channelFilter = filtersModel?.otherAttrs?.attr2 ?? [];
          FirebaseAnalytics.instance.logEvent(
              name: 'selected_filter_channel',
              parameters: {
                "message":
                    'On Channel Changed Level 2 $channelFilter ${getUserName()}'
              });
        } else if (value.toLowerCase().startsWith('level 3')) {
          FirebaseCrashlytics.instance.log("On Level 3 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {"message": 'On Level 3 Changed ${getUserName()}'});
          channelFilter = filtersModel?.otherAttrs?.attr3 ?? [];
          FirebaseAnalytics.instance.logEvent(
              name: 'selected_filter_channel',
              parameters: {
                "message":
                    'On Channel Changed Level 3 $channelFilter ${getUserName()}'
              });
        } else if (value.toLowerCase().startsWith('level 4')) {
          FirebaseCrashlytics.instance.log("On Level 4 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {"message": 'On Level 4 Changed ${getUserName()}'});
          channelFilter = filtersModel?.otherAttrs?.attr4 ?? [];
          FirebaseAnalytics.instance.logEvent(
              name: 'selected_filter_channel',
              parameters: {
                "message":
                    'On Channel Changed Level 4 $channelFilter ${getUserName()}'
              });
        } else if (value.toLowerCase().startsWith('level 5')) {
          FirebaseCrashlytics.instance.log("On Level 5 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {"message": 'On Level 5 Changed ${getUserName()}'});
          channelFilter = filtersModel?.otherAttrs?.attr5 ?? [];
          FirebaseAnalytics.instance.logEvent(
              name: 'selected_filter_channel',
              parameters: {
                "message":
                    'On Channel Changed Level 5 $channelFilter ${getUserName()}'
              });
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            FirebaseCrashlytics.instance.log("On Level 1 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 1 Changed ${getUserName()}'});
            channelFilter = filtersModel?.otherAttrs?.attr1 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 1 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 2')) {
            FirebaseCrashlytics.instance.log("On Level 2 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 2 Changed ${getUserName()}'});
            channelFilter = filtersModel?.otherAttrs?.attr2 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 2 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 3')) {
            FirebaseCrashlytics.instance.log("On Level 3 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 3 Changed ${getUserName()}'});
            channelFilter = filtersModel?.otherAttrs?.attr3 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 3 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 4')) {
            FirebaseCrashlytics.instance.log("On Level 4 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 4 Changed ${getUserName()}'});
            channelFilter = filtersModel?.otherAttrs?.attr4 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 4 $channelFilter ${getUserName()}'
                });
          } else if (value.toLowerCase().startsWith('level 5')) {
            FirebaseCrashlytics.instance.log("On Level 5 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {"message": 'On Level 5 Changed ${getUserName()}'});
            channelFilter = filtersModel?.otherAttrs?.attr5 ?? [];
            FirebaseAnalytics.instance.logEvent(
                name: 'selected_filter_channel',
                parameters: {
                  "message":
                      'On Channel Changed Level 5 $channelFilter ${getUserName()}'
                });
          }
        });
      }
    }
    update();
  }

  void onChangeTrendsChannel1(String value, {required String tabType}) {
    if (tabType == SummaryTypes.retailing.type) {
      if (filtersModel != null) {
        if (value.toLowerCase().startsWith('level 1')) {
          FirebaseCrashlytics.instance.log("On Trends Level 1 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 1 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.attr1 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 1 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 2')) {
          FirebaseCrashlytics.instance.log("On Trends Level 2 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 2 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.attr2 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 2 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 3')) {
          FirebaseCrashlytics.instance.log("On Trends Level 3 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 3 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.attr3 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 3 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 4')) {
          FirebaseCrashlytics.instance.log("On Trends Level 4 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 4 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.attr4 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 4 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 5')) {
          FirebaseCrashlytics.instance.log("On Trends Level 5 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 5 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.attr5 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 5 $channelTrendsFilter ${getUserName()}'
          });
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            FirebaseCrashlytics.instance.log("On Trends Level 1 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 1 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.attr1 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 1 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 2')) {
            FirebaseCrashlytics.instance.log("On Trends Level 2 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 2 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.attr2 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 2 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 3')) {
            FirebaseCrashlytics.instance.log("On Trends Level 3 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 3 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.attr3 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 3 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 4')) {
            FirebaseCrashlytics.instance.log("On Trends Level 4 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 4 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.attr4 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 4 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 5')) {
            FirebaseCrashlytics.instance.log("On Trends Level 5 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 5 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.attr5 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 5 $channelTrendsFilter ${getUserName()}'
            });
          }
        });
      }
    } else {
      debugPrint('===>Onchange ${filtersModel?.otherAttrs?.attr1.toString()}');
      if (filtersModel != null) {
        if (value.toLowerCase().startsWith('level 1')) {
          FirebaseCrashlytics.instance.log("On Trends Level 1 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 1 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.otherAttrs?.attr1 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 1 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 2')) {
          FirebaseCrashlytics.instance.log("On Trends Level 2 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 2 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.otherAttrs?.attr2 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 2 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 3')) {
          FirebaseCrashlytics.instance.log("On Trends Level 3 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 3 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.otherAttrs?.attr3 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 3 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 4')) {
          FirebaseCrashlytics.instance.log("On Trends Level 4 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 4 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.otherAttrs?.attr4 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 4 $channelTrendsFilter ${getUserName()}'
          });
        } else if (value.toLowerCase().startsWith('level 5')) {
          FirebaseCrashlytics.instance.log("On Trends Level 5 Changed");
          FirebaseAnalytics.instance.logEvent(
              name: 'level_filter',
              parameters: {
                "message": 'On Trends Level 5 Changed ${getUserName()}'
              });
          channelTrendsFilter = filtersModel?.otherAttrs?.attr5 ?? [];
          FirebaseAnalytics.instance
              .logEvent(name: 'selected_filter_trends_channel', parameters: {
            "message":
                'On Trends Channel Changed Level 5 $channelTrendsFilter ${getUserName()}'
          });
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            FirebaseCrashlytics.instance.log("On Trends Level 1 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 1 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.otherAttrs?.attr1 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 1 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 2')) {
            FirebaseCrashlytics.instance.log("On Trends Level 2 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 2 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.otherAttrs?.attr2 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 2 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 3')) {
            FirebaseCrashlytics.instance.log("On Trends Level 3 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 3 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.otherAttrs?.attr3 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 3 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 4')) {
            FirebaseCrashlytics.instance.log("On Trends Level 4 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 4 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.otherAttrs?.attr4 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 4 $channelTrendsFilter ${getUserName()}'
            });
          } else if (value.toLowerCase().startsWith('level 5')) {
            FirebaseCrashlytics.instance.log("On Trends Level 5 Changed");
            FirebaseAnalytics.instance.logEvent(
                name: 'level_filter',
                parameters: {
                  "message": 'On Trends Level 5 Changed ${getUserName()}'
                });
            channelTrendsFilter = filtersModel?.otherAttrs?.attr5 ?? [];
            FirebaseAnalytics.instance
                .logEvent(name: 'selected_filter_trends_channel', parameters: {
              "message":
                  'On Trends Channel Changed Level 5 $channelTrendsFilter ${getUserName()}'
            });
          }
        });
      }
    }
    update();
  }

  void onChangeCategoryValue(String value, String cat, String tabType) {
    FirebaseCrashlytics.instance.log("On Changed Category Value");
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_category',
        parameters: {"message": 'On Changed Category Value  ${getUserName()}'});
    if (_selectedTempCategory.toLowerCase() != cat.toLowerCase()) {
      _selectedTempCategory = cat;
      if (tabType == SummaryTypes.retailing.type) {
        //retaling tab
        selectedRetailingCategoryFilters.clear();
      } else if (tabType == SummaryTypes.coverage.type) {
        //Coverage tab
        selectedCoverageCategoryFilters.clear();
      } else if (tabType == SummaryTypes.gp.type) {
        //Golden Points tab
        selectedGPCategoryFilters.clear();
      } else if (tabType == SummaryTypes.fb.type) {
        //Focus Brand tab
        selectedFBCategoryFilters.clear();
      }
    }
    if (tabType == SummaryTypes.retailing.type) {
      //retaling tab
      if (selectedRetailingCategoryFilters.contains(value)) {
        selectedRetailingCategoryFilters.remove(value);
      } else {
        selectedRetailingCategoryFilters.add(value);
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      //Coverage tab
      if (selectedCoverageCategoryFilters.contains(value)) {
        selectedCoverageCategoryFilters.remove(value);
      } else {
        selectedCoverageCategoryFilters.add(value);
      }
    } else if (tabType == SummaryTypes.gp.type) {
      //Golden Points tab
      if (selectedGPCategoryFilters.contains(value)) {
        selectedGPCategoryFilters.remove(value);
      } else {
        selectedGPCategoryFilters.add(value);
      }
    } else if (tabType == SummaryTypes.fb.type) {
      //Focus Brand tab
      if (selectedFBCategoryFilters.contains(value)) {
        selectedFBCategoryFilters.remove(value);
      } else {
        selectedFBCategoryFilters.add(value);
      }
    }

    update();
  }

  void onChangeCategoryTrendsValue(String value, String tabType) {
    FirebaseCrashlytics.instance.log("On Trends Value Changed");
    debugPrint('====>Trends value$value');
    _selectedTrendsCategoryValue = value;
    _selectedTrendsChannelValue = '';
    _selectedTrendsGeoValue = '';
    if (tabType == SummaryTypes.retailing.type) {
      _retailingTrendsValue = value;
    } else if (tabType == SummaryTypes.coverage.type) {
      _coverageTrendsValue = value;
    } else if (tabType == SummaryTypes.gp.type) {
      _gpTrendsValue = value;
    } else if (tabType == SummaryTypes.fb.type) {
      _fbTrendsValue = value;
    }
    update();
  }

  void onChangeFiltersAll({String type = 'branch', required String tabType}) {
    FirebaseCrashlytics.instance.log("On Filter Changed");
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_all',
        parameters: {"message": 'On Filter Changed ${getUserName()}'});
    if (type == 'branch') {
      FirebaseCrashlytics.instance.log("On Branch Filter Changed");
      FirebaseAnalytics.instance.logEvent(
          name: 'deep_dive_selected_all',
          parameters: {"message": 'On Branch Filter Changed ${getUserName()}'});
      if (eq(selectedMultiFilters, branchFilter)) {
        selectedMultiFilters.clear();
      } else {
        selectedMultiFilters.clear();
        selectedMultiFilters.addAll(branchFilter);
      }
    } else if (type == 'category') {
      FirebaseCrashlytics.instance.log("On Category Filter Changed");
      FirebaseAnalytics.instance.logEvent(
          name: 'deep_dive_selected_all',
          parameters: {
            "message": 'On Category Filter Changed ${getUserName()}'
          });
      if (tabType == SummaryTypes.retailing.type) {
        //retaling tab
        if (eq(selectedRetailingCategoryFilters, categoryFilters)) {
          selectedRetailingCategoryFilters.clear();
        } else {
          selectedRetailingCategoryFilters.clear();
          selectedRetailingCategoryFilters.addAll(categoryFilters);
        }
      } else if (tabType == SummaryTypes.coverage.type) {
        //Coverage tab
        if (eq(selectedCoverageCategoryFilters, categoryFilters)) {
          selectedCoverageCategoryFilters.clear();
        } else {
          selectedCoverageCategoryFilters.clear();
          selectedCoverageCategoryFilters.addAll(categoryFilters);
        }
      } else if (tabType == SummaryTypes.gp.type) {
        //Golden Points tab
        if (eq(selectedGPCategoryFilters, categoryFilters)) {
          selectedGPCategoryFilters.clear();
        } else {
          selectedGPCategoryFilters.clear();
          selectedGPCategoryFilters.addAll(categoryFilters);
        }
      } else if (tabType == SummaryTypes.fb.type) {
        //Focus Brand tab
        if (eq(selectedFBCategoryFilters, categoryFilters)) {
          selectedFBCategoryFilters.clear();
        } else {
          selectedFBCategoryFilters.clear();
          selectedFBCategoryFilters.addAll(categoryFilters);
        }
      }
    }

    update();
  }

  void onChangeChannelValue(String value, String tabType, String channel) {
    FirebaseCrashlytics.instance.log("On Changed Channel Value");
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_channel',
        parameters: {"message": 'On Channel Filter Changed ${getUserName()}'});
    debugPrint('====>Channel filter==>');
    if (tabType == SummaryTypes.retailing.type) {
      if (_selectedTempRetailingChannel != channel) {
        _selectedTempRetailingChannel = channel;
        selectedRetailingChannelFilter = [];
      }
      if (selectedRetailingChannelFilter.contains(value)) {
        selectedRetailingChannelFilter.remove(value);
      } else {
        selectedRetailingChannelFilter.add(value);
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      if (_selectedTempCoverageChannel != channel) {
        _selectedTempCoverageChannel = channel;
        selectedCoverageChannelFilter = [];
      }
      if (selectedCoverageChannelFilter.contains(value)) {
        selectedCoverageChannelFilter.remove(value);
      } else {
        selectedCoverageChannelFilter.add(value);
      }
    } else if (tabType == SummaryTypes.gp.type) {
      if (_selectedTempGPChannel != channel) {
        _selectedTempGPChannel = channel;
        selectedGPChannelFilter = [];
      }
      if (selectedGPChannelFilter.contains(value)) {
        selectedGPChannelFilter.remove(value);
      } else {
        selectedGPChannelFilter.add(value);
      }
    } else if (tabType == SummaryTypes.fb.type) {
      if (_selectedTempFBChannel != channel) {
        _selectedTempFBChannel = channel;
        selectedFBChannelFilter = [];
      }
      if (selectedFBChannelFilter.contains(value)) {
        selectedFBChannelFilter.remove(value);
      } else {
        selectedFBChannelFilter.add(value);
      }
    }
    update();
  }

  Function eq = const ListEquality().equals;

  void onChangeTrendsChannelValue(String value, String tabType,
      {bool isChannel = true}) {
    FirebaseCrashlytics.instance.log("On Changed Trends Value");
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_trends',
        parameters: {"message": 'On Trends Filter Changed ${getUserName()}'});
    if (isChannel) {
      _selectedTrendsGeoValue = '';
      _selectedTrendsCategoryValue = '';
      _selectedTrendsChannelValue = value;
    } else {
      _selectedTrendsGeoValue = '';
      _selectedTrendsCategoryValue = value;
      _selectedTrendsChannelValue = '';
    }
    // _selectedTrendsChannelValue = value;
    // _selectedTrendsCategoryValue = '';
    // _selectedTrendsGeoValue = '';
    if (tabType == SummaryTypes.retailing.type) {
      _retailingTrendsValue = value;
    } else if (tabType == SummaryTypes.coverage.type) {
      _coverageTrendsValue = value;
    } else if (tabType == SummaryTypes.gp.type) {
      _gpTrendsValue = value;
    } else if (tabType == SummaryTypes.fb.type) {
      _fbTrendsValue = value;
    }
    update();
  }

  void onChangeChannelAllSelect(String tabType, String channel) {
    FirebaseCrashlytics.instance.log("On Changed Channel All Select");
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_all',
        parameters: {
          "message": 'On Changed Channel All Select ${getUserName()}'
        });
    if (tabType == SummaryTypes.retailing.type) {
      if (_selectedTempRetailingChannel != channel) {
        _selectedTempRetailingChannel = channel;
        selectedRetailingChannelFilter = [];
      }
      if (eq(selectedRetailingChannelFilter, channelFilter)) {
        selectedRetailingChannelFilter = [];
      } else {
        selectedRetailingChannelFilter = [];
        selectedRetailingChannelFilter.addAll(channelFilter);
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      if (_selectedTempCoverageChannel != channel) {
        _selectedTempCoverageChannel = channel;
        selectedCoverageChannelFilter = [];
      }
      if (eq(selectedCoverageChannelFilter, channelFilter)) {
        selectedCoverageChannelFilter = [];
      } else {
        selectedCoverageChannelFilter = [];
        selectedCoverageChannelFilter.addAll(channelFilter);
      }
    } else if (tabType == SummaryTypes.gp.type) {
      if (_selectedTempGPChannel != channel) {
        _selectedTempGPChannel = channel;
        selectedGPChannelFilter = [];
      }
      if (eq(selectedGPChannelFilter, channelFilter)) {
        selectedGPChannelFilter = [];
      } else {
        selectedGPChannelFilter = [];
        selectedGPChannelFilter.addAll(channelFilter);
      }
    } else if (tabType == SummaryTypes.fb.type) {
      if (_selectedTempRetailingChannel != channel) {
        _selectedTempRetailingChannel = channel;
        selectedRetailingChannelFilter = [];
      }
      if (eq(selectedFBChannelFilter, channelFilter)) {
        selectedFBChannelFilter = [];
      } else {
        selectedFBChannelFilter = [];
        selectedFBChannelFilter.addAll(channelFilter);
      }
    }

    update();
  }

  void onTrendsFilterSelect(String value, String tabType) {
    FirebaseCrashlytics.instance.log("On Trends Filter Select");
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_trends',
        parameters: {"message": 'On Trends Filter Changed ${getUserName()}'});
    if (tabType == SummaryTypes.retailing.type) {
      _selectedTrends = value;
    } else if (tabType == SummaryTypes.coverage.type) {
      _selectedCoverageTrends = value;
    } else if (tabType == SummaryTypes.gp.type) {
      _selectedGPTrends = value;
    } else if (tabType == SummaryTypes.fb.type) {
      _selectedFBTrends = value;
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    // getAllFilters();
    getPersonalizedData();
    await getInitValues(getOnlyShared: true);
    getInitData();
    getAppVersion();

    filters = ['All India'];
    multiFilters = ['All India'];
    geoFilters = [
      {
        "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
        //"${selectedMonth!.substring(0, 3)}-$selectedYear",
        _selectedGeo.startsWith('All India')
            ? "allIndia"
            : _selectedGeo.startsWith('Focus Area')
                ? "site"
                : _selectedGeo.startsWith('Cluster')
                    ? "district"
                    : _selectedGeo.toLowerCase(): selectedGeoValue,
        "category": [],
      }
    ];
    // await getPersonaSelected();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getInitValues({bool getOnlyShared = false}) async {
    globals.navigate = true;
    FirebaseCrashlytics.instance.log("Init Values set");
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Init values set ${getUserName()}'});
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
      FirebaseCrashlytics.instance.log("Selected Geo : $selectedGeo");
      _selectedGeo = getGeo();
      _selectedTrendsGeo = getGeo();
      _selectedTrendsGeoValue = getGeoValue();

      onGeoChange(_selectedGeo);
      if (_selectedGeo.toLowerCase() == 'All India'.toLowerCase()) {
        FirebaseCrashlytics.instance.log("Applied Filter is All India");
        debugPrint('==>Applied Filter is All India');
        _isRetailingDeepDiveInd = false;
      } else {
        debugPrint('==>Applied Filter is not All India');
        FirebaseCrashlytics.instance.log("Applied Filter is not All India");
        _isRetailingDeepDiveInd = true;
        _isSummaryDirect = true;
      }
    }
    if (getGeoValue().trim().isNotEmpty) {
      _selectedTempGeoValue = getGeoValue();
      _selectedGeoValue = getGeoValue();
      _selectedTrendsGeoValue = getGeoValue();
      _retailingTrendsValue = getGeoValue();
      _coverageTrendsValue = getGeoValue();
      _gpTrendsValue = getGeoValue();
      _fbTrendsValue = getGeoValue();
    }
    if (!getOnlyShared) {
      await Future.wait([
        getSummaryData().then((value) {
          getMonthFilters(year: DateTime.now().year.toString()).then(
            (v) => getAllFilters().then((v) async {
              categoryFilters = filtersModel?.category ?? [];
              FirebaseCrashlytics.instance.log("Changed Filter for All");
              onChangeFiltersAll(
                  type: 'category', tabType: SummaryTypes.retailing.type);
              onChangeFiltersAll(
                  type: 'category', tabType: SummaryTypes.gp.type);
              onChangeFiltersAll(
                  type: 'category', tabType: SummaryTypes.fb.type);
              //getting retailing saved filters and

              final mapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.RETAILING_GEO) ?? '{}');

              if (mapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = mapDecoded;
                if (_savedFilters.containsKey('allIndia')) {
                  selectedRetailingMultiAllIndia = List<String>.from(
                      _savedFilters['allIndia'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_allIndia',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingMultiAllIndia ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('division')) {
                  selectedRetailingMultiDivisions = List<String>.from(
                      _savedFilters['division'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_division',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingMultiDivisions ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('branches')) {
                  selectedRetailingMultiBranches = List<String>.from(
                      _savedFilters['branches'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_branches',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingMultiBranches ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('cluster')) {
                  selectedRetailingMultiClusters =
                      List<String>.from(_savedFilters['cluster'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_cluster',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingMultiClusters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('sites')) {
                  selectedRetailingMultiSites =
                      List<String>.from(_savedFilters['sites'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_sites',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingMultiSites ${getUserName()}'
                      });
                }
              }

              //for retailing category
              final categoryMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.RETAILING_CATEGORY) ??
                      '{}');
              if (categoryMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = categoryMapDecoded;
                FirebaseCrashlytics.instance
                    .log("Category saved $_savedFilters");
                debugPrint('====>Category saved $_savedFilters');
                if (_savedFilters.containsKey('category')) {
                  selectedRetailingCategoryFilters = List<String>.from(
                      _savedFilters['category'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_category',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingCategoryFilters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedCategory = _savedFilters['selected'];
                }
              }
              final channelMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.RETAILING_CHANNEL) ??
                      '{}');
              if (channelMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = channelMapDecoded;
                if (_savedFilters.containsKey('channel')) {
                  FirebaseCrashlytics.instance
                      .log("Channel saved $_savedFilters");
                  debugPrint('====>Channel saved $_savedFilters');
                  selectedRetailingChannelFilter =
                      List<String>.from(_savedFilters['channel'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_retailing_channel',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedRetailingChannelFilter ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedRetailingChannel = _savedFilters['selected'];
                }
              } else {
                selectedRetailingChannelFilter = filtersModel?.attr1 ?? [];
              }
              // final trendMapDecoded = jsonDecode(
              //     await storage.read(key: AppConstants.RETAILING_TRENDS) ?? '{}');
              // if (trendMapDecoded.isNotEmpty) {
              //   Map<String, dynamic> _savedFilters = trendMapDecoded;
              //   if (_savedFilters.containsKey('trends')) {
              //     if (_savedFilters.containsKey('category') &&
              //         _savedFilters
              //             .containsKey('category')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsCategoryValue = _savedFilters['trends'];
              //       _selectedTrendsCategory = _savedFilters['category'];
              //       _selectedTrends = _selectedTrendsCategory;
              //       _retailingTrendsValue = _selectedTrendsCategoryValue;
              //     } else if (_savedFilters.containsKey('channel') &&
              //         _savedFilters
              //             .containsKey('channel')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsChannelValue = _savedFilters['trends'];
              //       _selectedChannel = _savedFilters['channel'];
              //       _selectedTrends = _selectedChannel;
              //       _retailingTrendsValue = _selectedTrendsChannelValue;
              //     } else if (_savedFilters.containsKey('geo') &&
              //         _savedFilters.containsKey('geo').toString().isNotEmpty) {
              //       _selectedTrendsGeoValue = _savedFilters['trends'];
              //       _selectedTrendsGeo = _savedFilters['geo'];
              //       _selectedTrends = _selectedTrendsGeo;
              //       _retailingTrendsValue = _selectedTrendsGeoValue;
              //     }
              // }
              // }

              //coverage
              //getting coverage saved filters and setting it's values to the variables

              final coveragemapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.COVERAGE_GEO) ?? '{}');

              if (coveragemapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = coveragemapDecoded;
                if (_savedFilters.containsKey('allIndia')) {
                  selectedCoverageMultiAllIndia = List<String>.from(
                      _savedFilters['allIndia'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_coverage_allIndia',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedCoverageMultiAllIndia ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('division')) {
                  selectedCoverageMultiDivisions = List<String>.from(
                      _savedFilters['division'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_coverage_division',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedCoverageMultiDivisions ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('branches')) {
                  selectedCoverageMultiBranches = List<String>.from(
                      _savedFilters['branches'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_coverage_branches',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedCoverageMultiBranches ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('cluster')) {
                  selectedCoverageMultiClusters =
                      List<String>.from(_savedFilters['cluster'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_coverage_cluster',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedCoverageMultiClusters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('sites')) {
                  selectedCoverageMultiSites =
                      List<String>.from(_savedFilters['sites'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_coverage_sites',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedCoverageMultiSites ${getUserName()}'
                      });
                }
              }

              //for coverage category

              ///"category": selectedCoverageCategoryFilters,
              // "selected": selectedCategory
              //  "channel": selectedCoverageChannelFilter,
              // "selected": selectedCoverageChannel

              // final coverageCategoryMapDecoded = jsonDecode(
              //     await storage.read(key: AppConstants.COVERAGE_CATEGORY) ??
              //         '{}');
              // if (coverageCategoryMapDecoded.isNotEmpty) {
              //   Map<String, dynamic> _savedFilters = coverageCategoryMapDecoded;
              //   debugPrint('====>Category saved $_savedFilters');
              //   if (_savedFilters.containsKey('category')) {
              //     selectedCoverageCategoryFilters =
              //         List<String>.from(_savedFilters['category'].map((v) => v));
              //   }
              //   if (_savedFilters.containsKey('selected')) {
              //     _selectedCategory = _savedFilters['selected'];
              //   }
              // }
              final coverageChannelMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.COVERAGE_CHANNEL) ??
                      '{}');
              if (coverageChannelMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = coverageChannelMapDecoded;
                if (_savedFilters.containsKey('channel')) {
                  debugPrint('====>Channel saved $_savedFilters');
                  selectedCoverageChannelFilter =
                      List<String>.from(_savedFilters['channel'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_coverage_channel',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedCoverageChannelFilter ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedCoverageChannel = _savedFilters['selected'];
                }
              } else {
                selectedCoverageChannelFilter =
                    filtersModel?.otherAttrs?.attr1 ?? [];
              }
              // final coverageTrendMapDecoded = jsonDecode(
              //     await storage.read(key: AppConstants.RETAILING_TRENDS) ?? '{}');

              // if (coverageTrendMapDecoded.isNotEmpty) {
              //   Map<String, dynamic> _savedFilters = coverageTrendMapDecoded;
              //   if (_savedFilters.containsKey('trends')) {
              //     if (_savedFilters.containsKey('category') &&
              //         _savedFilters
              //             .containsKey('category')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsCategoryValue = _savedFilters['trends'];
              //       _selectedTrendsCategory = _savedFilters['category'];
              //       _selectedCoverageTrends = _selectedTrendsCategory;
              //       _coverageTrendsValue = _selectedTrendsCategoryValue;
              //     } else if (_savedFilters.containsKey('channel') &&
              //         _savedFilters
              //             .containsKey('channel')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsChannelValue = _savedFilters['trends'];
              //       _selectedChannel = _savedFilters['channel'];
              //       _selectedCoverageTrends = _selectedChannel;
              //       _coverageTrendsValue = _selectedTrendsChannelValue;
              //     } else if (_savedFilters.containsKey('geo') &&
              //         _savedFilters.containsKey('geo').toString().isNotEmpty) {
              //       _selectedTrendsGeoValue = _savedFilters['trends'];
              //       _selectedTrendsGeo = _savedFilters['geo'];
              //       _selectedCoverageTrends = _selectedTrendsGeo;
              //       _coverageTrendsValue = _selectedTrendsGeoValue;
              //     }
              //   }
              // }

              ////////////////////
              /// //getting gp saved filters and

              final gpMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.GP_GEO) ?? '{}');

              if (gpMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = gpMapDecoded;
                if (_savedFilters.containsKey('allIndia')) {
                  selectedGPMultiAllIndia = List<String>.from(
                      _savedFilters['allIndia'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_allIndia',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPMultiAllIndia ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('division')) {
                  selectedGPMultiDivisions = List<String>.from(
                      _savedFilters['division'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_division',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPMultiDivisions ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('branches')) {
                  selectedGPMultiBranches = List<String>.from(
                      _savedFilters['branches'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_branches',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPMultiBranches ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('cluster')) {
                  selectedGPMultiClusters =
                      List<String>.from(_savedFilters['cluster'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_cluster',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPMultiClusters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('sites')) {
                  selectedGPMultiSites =
                      List<String>.from(_savedFilters['sites'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_sites',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPMultiSites ${getUserName()}'
                      });
                }
              }

              //for gp category
              final gpCategoryMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.GP_CATEGORY) ?? '{}');
              if (gpCategoryMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = gpCategoryMapDecoded;
                debugPrint('====>Category saved $_savedFilters');
                if (_savedFilters.containsKey('category')) {
                  selectedGPCategoryFilters = List<String>.from(
                      _savedFilters['category'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_category',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPCategoryFilters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedGPCategory = _savedFilters['selected'];
                }
              }
              final gpChannelMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.GP_CHANNEL) ?? '{}');
              if (gpChannelMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = gpChannelMapDecoded;
                if (_savedFilters.containsKey('channel')) {
                  debugPrint('====>Channel saved $_savedFilters');
                  selectedGPChannelFilter =
                      List<String>.from(_savedFilters['channel'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_gp_channel',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedGPChannelFilter ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedGPChannel = _savedFilters['selected'];
                }
              } else {
                selectedGPChannelFilter = filtersModel?.attr1 ?? [];
              }
              // final gpTrendMapDecoded = jsonDecode(
              //     await storage.read(key: AppConstants.GP_TRENDS) ?? '{}');
              // if (gpTrendMapDecoded.isNotEmpty) {
              //   Map<String, dynamic> _savedFilters = gpTrendMapDecoded;
              //   if (_savedFilters.containsKey('trends')) {
              //     if (_savedFilters.containsKey('category') &&
              //         _savedFilters
              //             .containsKey('category')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsCategoryValue = _savedFilters['trends'];
              //       _selectedTrendsCategory = _savedFilters['category'];
              //       _selectedTrends = _selectedTrendsCategory;
              //       _retailingTrendsValue = _selectedTrendsCategoryValue;
              //     } else if (_savedFilters.containsKey('channel') &&
              //         _savedFilters
              //             .containsKey('channel')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsChannelValue = _savedFilters['trends'];
              //       _selectedChannel = _savedFilters['channel'];
              //       _selectedTrends = _selectedChannel;
              //       _retailingTrendsValue = _selectedTrendsChannelValue;
              //     } else if (_savedFilters.containsKey('geo') &&
              //         _savedFilters.containsKey('geo').toString().isNotEmpty) {
              //       _selectedTrendsGeoValue = _savedFilters['trends'];
              //       _selectedTrendsGeo = _savedFilters['geo'];
              //       _selectedTrends = _selectedTrendsGeo;
              //       _retailingTrendsValue = _selectedTrendsGeoValue;
              //     }
              //   }
              // }

              ////////////////////
              /// //getting fb saved filters and

              final fbMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.FB_GEO) ?? '{}');

              if (fbMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = fbMapDecoded;
                if (_savedFilters.containsKey('allIndia')) {
                  selectedFBMultiAllIndia = List<String>.from(
                      _savedFilters['allIndia'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_allIndia',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBMultiAllIndia ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('division')) {
                  selectedFBMultiDivisions = List<String>.from(
                      _savedFilters['division'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_division',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBMultiDivisions ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('branches')) {
                  selectedFBMultiBranches = List<String>.from(
                      _savedFilters['branches'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_branches',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBMultiBranches ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('cluster')) {
                  selectedFBMultiClusters =
                      List<String>.from(_savedFilters['cluster'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_cluster',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBMultiClusters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('sites')) {
                  selectedFBMultiSites =
                      List<String>.from(_savedFilters['sites'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_sites',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBMultiSites ${getUserName()}'
                      });
                }
              }

              //for fb category
              final fbCategoryMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.FB_CATEGORY) ?? '{}');
              if (fbCategoryMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = fbCategoryMapDecoded;
                debugPrint('====>Category saved $_savedFilters');
                if (_savedFilters.containsKey('category')) {
                  selectedFBCategoryFilters = List<String>.from(
                      _savedFilters['category'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_category',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBCategoryFilters ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedFBCategory = _savedFilters['selected'];
                }
              }
              final fbChannelMapDecoded = jsonDecode(
                  await storage.read(key: AppConstants.FB_CHANNEL) ?? '{}');
              if (fbChannelMapDecoded.isNotEmpty) {
                Map<String, dynamic> _savedFilters = fbChannelMapDecoded;
                if (_savedFilters.containsKey('channel')) {
                  debugPrint('====>Channel saved $_savedFilters');
                  selectedFBChannelFilter =
                      List<String>.from(_savedFilters['channel'].map((v) => v));
                  FirebaseAnalytics.instance.logEvent(
                      name: 'deep_dive_fb_channel',
                      parameters: {
                        "message":
                            'Selected Multi Filter $selectedFBChannelFilter ${getUserName()}'
                      });
                }
                if (_savedFilters.containsKey('selected')) {
                  _selectedFBChannel = _savedFilters['selected'];
                }
              } else {
                selectedFBChannelFilter = filtersModel?.attr1 ?? [];
              }
              // final fbTrendMapDecoded = jsonDecode(
              //     await storage.read(key: AppConstants.GP_TRENDS) ?? '{}');
              // if (fbTrendMapDecoded.isNotEmpty) {
              //   Map<String, dynamic> _savedFilters = fbTrendMapDecoded;
              //   if (_savedFilters.containsKey('trends')) {
              //     if (_savedFilters.containsKey('category') &&
              //         _savedFilters
              //             .containsKey('category')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsCategoryValue = _savedFilters['trends'];
              //       _selectedTrendsCategory = _savedFilters['category'];
              //       _selectedTrends = _selectedTrendsCategory;
              //       _retailingTrendsValue = _selectedTrendsCategoryValue;
              //     } else if (_savedFilters.containsKey('channel') &&
              //         _savedFilters
              //             .containsKey('channel')
              //             .toString()
              //             .isNotEmpty) {
              //       _selectedTrendsChannelValue = _savedFilters['trends'];
              //       _selectedChannel = _savedFilters['channel'];
              //       _selectedTrends = _selectedChannel;
              //       _retailingTrendsValue = _selectedTrendsChannelValue;
              //     } else if (_savedFilters.containsKey('geo') &&
              //         _savedFilters.containsKey('geo').toString().isNotEmpty) {
              //       _selectedTrendsGeoValue = _savedFilters['trends'];
              //       _selectedTrendsGeo = _savedFilters['geo'];
              //       _selectedTrends = _selectedTrendsGeo;
              //       _retailingTrendsValue = _selectedTrendsGeoValue;
              //     }
              //   }
              // }

              categoryTrendsFilters = filtersModel?.category ?? [];
              channelFilter = filtersModel?.attr1 ?? [];
              channelTrendsFilter = filtersModel?.attr1 ?? [];
              await Future.wait([
                getRetailingData(),
                getRetailingData(type: 'category', name: 'category'),
                getRetailingData(type: 'channel', name: 'geo'),
                getRetailingData(type: 'geo', name: 'trends'),
              ]);

              //gp
              await Future.wait([
                getGPData(),
                getGPData(type: 'category', name: 'category'),
                getGPData(type: 'channel', name: 'geo'),
                getGPData(type: 'geo', name: 'trends'),
              ]);
              //fb
              await Future.wait([
                getFocusBrandData(),
                getFocusBrandData(type: 'category', name: 'category'),
                getFocusBrandData(type: 'channel', name: 'geo'),
                getFocusBrandData(type: 'geo', name: 'trends'),
              ]);
              //Coverage
              await Future.wait([
                getCoverageData(),
                getCoverageData(type: 'channel', name: 'geo'),
                getCoverageData(type: 'trends', name: 'trends'),
              ]);
            }),
          );
        }),
      ]);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  void channelFilterInit(String tabType) async {
    if (tabType == SummaryTypes.retailing.type) {
      final channelMapDecoded = jsonDecode(
          await storage.read(key: AppConstants.RETAILING_CHANNEL) ?? '{}');
      if (channelMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = channelMapDecoded;
        if (_savedFilters.containsKey('channel')) {
          FirebaseCrashlytics.instance.log("Channel saved $_savedFilters");
          debugPrint('====>Channel saved $_savedFilters');
          selectedRetailingChannelFilter =
              List<String>.from(_savedFilters['channel'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedRetailingChannel = _savedFilters['selected'];
        }
      } else {
        selectedRetailingChannelFilter = filtersModel?.attr1 ?? [];
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      final coverageChannelMapDecoded = jsonDecode(
          await storage.read(key: AppConstants.COVERAGE_CHANNEL) ?? '{}');
      if (coverageChannelMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = coverageChannelMapDecoded;
        if (_savedFilters.containsKey('channel')) {
          debugPrint('====>Channel saved $_savedFilters');
          selectedCoverageChannelFilter =
              List<String>.from(_savedFilters['channel'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedCoverageChannel = _savedFilters['selected'];
        }
      } else {
        selectedCoverageChannelFilter = filtersModel?.otherAttrs?.attr1 ?? [];
      }
    } else if (tabType == SummaryTypes.gp.type) {
      final gpChannelMapDecoded =
          jsonDecode(await storage.read(key: AppConstants.GP_CHANNEL) ?? '{}');
      if (gpChannelMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = gpChannelMapDecoded;
        if (_savedFilters.containsKey('channel')) {
          debugPrint('====>Channel saved $_savedFilters');
          selectedGPChannelFilter =
              List<String>.from(_savedFilters['channel'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedGPChannel = _savedFilters['selected'];
        }
      } else {
        selectedGPChannelFilter = filtersModel?.attr1 ?? [];
      }
    } else if (tabType == SummaryTypes.fb.type) {
      final fbChannelMapDecoded =
          jsonDecode(await storage.read(key: AppConstants.FB_CHANNEL) ?? '{}');
      if (fbChannelMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = fbChannelMapDecoded;
        if (_savedFilters.containsKey('channel')) {
          debugPrint('====>Channel saved $_savedFilters');
          selectedFBChannelFilter =
              List<String>.from(_savedFilters['channel'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedFBChannel = _savedFilters['selected'];
        }
      } else {
        selectedFBChannelFilter = filtersModel?.attr1 ?? [];
      }
    }
  }

  void categoryFilterInit(String tabType) async {
    if (tabType == SummaryTypes.retailing.type) {
      final categoryMapDecoded = jsonDecode(
          await storage.read(key: AppConstants.RETAILING_CATEGORY) ?? '{}');
      if (categoryMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = categoryMapDecoded;
        FirebaseCrashlytics.instance.log("Category saved $_savedFilters");
        debugPrint('====>Category saved $_savedFilters');
        if (_savedFilters.containsKey('category')) {
          selectedRetailingCategoryFilters =
              List<String>.from(_savedFilters['category'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedCategory = _savedFilters['selected'];
        }
      }
    } else if (tabType == SummaryTypes.coverage.type) {
    } else if (tabType == SummaryTypes.gp.type) {
      final gpCategoryMapDecoded =
          jsonDecode(await storage.read(key: AppConstants.GP_CATEGORY) ?? '{}');
      if (gpCategoryMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = gpCategoryMapDecoded;
        debugPrint('====>Category saved $_savedFilters');
        if (_savedFilters.containsKey('category')) {
          selectedGPCategoryFilters =
              List<String>.from(_savedFilters['category'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedGPCategory = _savedFilters['selected'];
        }
      } else {
        selectedCoverageChannelFilter = filtersModel?.otherAttrs?.attr1 ?? [];
      }
    } else if (tabType == SummaryTypes.fb.type) {
      final fbCategoryMapDecoded =
          jsonDecode(await storage.read(key: AppConstants.FB_CATEGORY) ?? '{}');
      if (fbCategoryMapDecoded.isNotEmpty) {
        Map<String, dynamic> _savedFilters = fbCategoryMapDecoded;
        debugPrint('====>Category saved $_savedFilters');
        if (_savedFilters.containsKey('category')) {
          selectedFBCategoryFilters =
              List<String>.from(_savedFilters['category'].map((v) => v));
        }
        if (_savedFilters.containsKey('selected')) {
          _selectedFBCategory = _savedFilters['selected'];
        }
      }
    }
  }

  void geoFilterInit() {
    _selectedTempGeo = selectedGeo;
    _selectedTempGeoValue = selectedGeoValue;
    update();
  }

  Future<void> onChangeMonthFilter(String value, String year,
      {required bool isLoadRetailing,
      required bool isSummary,
      String priority = 'Retailing',
      String tabType = 'All'}) async {
    debugPrint('====>Selected Month $value $year');
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_month',
        parameters: {"message": 'Selected Month Changed ${getUserName()}'});

    _selectedTempMonth = value;
    _selectedMonth = value;
    _selectedYear = year;
    FirebaseAnalytics.instance.logEvent(
        name: 'data_refreash',
        parameters: {"message": 'Data Refreshing ${getUserName()}'});
    // _selectedMonth = _selectedTempMonth ?? '';
    setMonth(_selectedMonth);
    setYear(year);
    FirebaseAnalytics.instance.logEvent(name: 'data_refreash', parameters: {
      "message": 'Selected Month $_selectedTempMonth ${getUserName()}'
    });
    if (isSummary) {
      Logger().i('===>Summary Await is calling');
      await getSummaryData();
    }
    debugPrint('====>Before Calling Retailing $isLoadRetailing');
    if (isLoadRetailing) {
      if (SummaryTypes.retailing.type == tabType) {
        //retailing screen data
        debugPrint('====>Calling Retailing data');
        getRetailingData();
        getRetailingData(type: 'category', name: 'category');
        getRetailingData(type: 'channel', name: 'geo');
        getRetailingData(type: 'geo', name: 'trends');
      } else if (SummaryTypes.coverage.type == tabType) {
        //Coverage screen data
        getCoverageData();
        // getCoverageData(type: 'category', name: 'category');
        getCoverageData(type: 'channel', name: 'geo');
        getCoverageData(type: 'trends', name: 'trends');
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
        debugPrint('==>Reloading all');
        reloadAllDeepDive(isSummary: isSummary, priority: priority);
      }
    }

    update();
  }

  void onChangeYearFilter(String value) {
    // _selectedTempYear = value;
    getMonthFilters(year: value);
    update();
  }

  void onChangeTempYear(String value, {bool isFirst = false}) {
    _selectedTempYear = value;
    if (isFirst) {
      getMonthFilters(year: value, monthLoading: true).then((value) {
        _selectedTempMonth = monthFilters.first;
      });
    }
    update();
  }

  void onChangeTempMonth(String value) {
    _selectedTempMonth = value;
    update();
  }

  void selectedMonthInit() {
    onChangeTempYear(selectedYear, isFirst: true);
    onChangeTempMonth(selectedMonth);
    update();
  }

  void onChangeGeo(String geo, String geoValue) {
    FirebaseAnalytics.instance.logEvent(
        name: 'selected_filter',
        parameters: {"message": 'Selected Geo Changed ${getUserName()}'});
    _selectedGeo = geo;
    _selectedGeoValue = geoValue;
    saveGeo(geo);
    saveGeoValue(geoValue);
    update();
  }

  // Future<void> onChangeDate(
  //     {bool isLoadRetailing = false,
  //     String tabType = 'Retailing',
  //     bool isSummary = false}) async {
  //   FirebaseAnalytics.instance.logEvent(
  //       name: 'data_refreash',
  //       parameters: {"message": 'Data Refreshing ${getUserName()}'});
  //   _selectedMonth = _selectedTempMonth;
  //   setMonth(_selectedTempMonth ?? '');
  //   FirebaseAnalytics.instance.logEvent(name: 'data_refreash', parameters: {
  //     "message": 'Selected Month $_selectedTempMonth ${getUserName()}'
  //   });
  //   if (isSummary) {
  //     await getSummaryData();
  //   } else {
  //     getSummaryData();
  //   }
  //   if (isLoadRetailing) {
  //     if (SummaryTypes.retailing.type == tabType) {
  //       //retailing screen data

  //       await Future.wait([
  //         getRetailingData(),
  //         getRetailingData(type: 'category', name: 'category'),
  //         getRetailingData(type: 'channel', name: 'geo'),
  //         getRetailingData(type: 'geo', name: 'trends'),
  //       ]);
  //     } else if (SummaryTypes.coverage.type == tabType) {
  //       //Coverage screen data
  //       getCoverageData();
  //       // getCoverageData(type: 'category', name: 'category');
  //       getCoverageData(type: 'channel', name: 'geo');
  //       getCoverageData(type: 'trends', name: 'trends');
  //     } else if (SummaryTypes.gp.type == tabType) {
  //       //retailing screen data
  //       getGPData();
  //       getGPData(type: 'category', name: 'category');
  //       getGPData(type: 'channel', name: 'geo');
  //       getGPData(type: 'geo', name: 'trends');
  //     } else if (SummaryTypes.fb.type == tabType) {
  //       //retailing screen data
  //       getFocusBrandData();
  //       getFocusBrandData(type: 'category', name: 'category');
  //       getFocusBrandData(type: 'channel', name: 'geo');
  //       getFocusBrandData(type: 'geo', name: 'trends');
  //     } else if (tabType == "All") {
  //       reloadAllDeepDive();
  //     }
  //   }

  //   update();
  // }

  void onMultiGeoChange(String value) {
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_geo',
        parameters: {"message": 'Selected Multi Geo Changed ${getUserName()}'});
    _selectedMultiGeo = value;
    update();
  }

  void onGeoChange(String value, {bool isMultiSelect = false}) {
    if (isMultiSelect) {
      //multiFilters
      FirebaseAnalytics.instance.logEvent(
          name: 'deep_dive_selected_geo',
          parameters: {
            "message": 'Selected Multi Geo Changed ${getUserName()}'
          });
      selectedMultiFilters.clear();
      if (filtersModel != null) {
        if (value.startsWith('All India')) {
          multiFilters = ['All India'];
        } else if (value.startsWith('Division')) {
          multiFilters = filtersModel!.division;
        } else if (value.startsWith('Cluster')) {
          multiFilters = filtersModel!.district;
        } else if (value.startsWith('Focus Area')) {
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
            multiFilters = filtersModel?.district ?? [];
          } else if (value.startsWith('Focus Area')) {
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
          filters = filtersModel!.district;
        } else if (value.startsWith('Focus Area')) {
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
            filters = filtersModel?.district ?? [];
          } else if (value.startsWith('Focus Area')) {
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

  void onChangeGeoTrends(String value) {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Selected Geo Changed ${getUserName()}'});
    _selectedTrendsGeo = value;

    _selectedTrends = value;
    selectedRetailingChannelFilter = [];
    selectedCoverageChannelFilter = [];
    selectedGPChannelFilter = [];
    selectedFBChannelFilter = [];
    // _selectedTrendsCategoryValue = '';
    // _gpTrendsValue = '';
    update();
  }

  void onTrendsGeoChange(String value) {
    FirebaseAnalytics.instance.logEvent(name: 'logs', parameters: {
      "message": 'Selected Trends Geo Changed ${getUserName()}'
    });
    _selectedTrendsChannelValue = '';
    _gpTrendsValue = '';
    if (filtersModel != null) {
      if (value.startsWith('All India')) {
        trendsFilter = ['All India'];
      } else if (value.startsWith('Division')) {
        trendsFilter = filtersModel!.division;
      } else if (value.startsWith('Cluster')) {
        trendsFilter = filtersModel!.district;
      } else if (value.startsWith('Focus Area')) {
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
          trendsFilter = filtersModel?.district ?? [];
        } else if (value.startsWith('Focus Area')) {
          trendsFilter = filtersModel?.site ?? [];
        } else if (value.startsWith('Branch')) {
          trendsFilter = [];
        }
      });
    }

    update();
  }

  void onApplyFilter({
    bool isLoadRetailing = false,
    String tabType = 'Retailing',
    bool isSummary = false,
  }) async {
    //Apply geo filter
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Apply Filters click ${getUserName()}'});
    debugPrint(
        '===>selected Filter $selectedTempGeo  -- $selectedTempGeoValue');
    _selectedGeo = _selectedTempGeo;
    _selectedGeoValue = _selectedTempGeoValue;
    if (_selectedTempGeo.toLowerCase() == 'All India'.toLowerCase()) {
      debugPrint('==>Applied Filter is All India');
      FirebaseAnalytics.instance.logEvent(name: 'logs', parameters: {
        "message": 'Applied Filter is All India ${getUserName()}'
      });
      _isRetailingDeepDiveInd = false;
    } else {
      debugPrint('==>Applied Filter is not All India');
      _isRetailingDeepDiveInd = true;
      _isSummaryDirect = true;
    }

    saveGeo(_selectedTempGeo);
    saveGeoValue(_selectedTempGeoValue);
    FirebaseAnalytics.instance.logEvent(name: 'logs', parameters: {
      "message": 'Applied Filter is $_selectedTempGeoValue ${getUserName()}'
    });
    debugPrint('===>Trends Value:$_selectedTrendsGeoValue');
    if (SummaryTypes.retailing.type == tabType) {
      if (_selectedTrendsGeoValue.trim().isNotEmpty) {
        _retailingTrendsValue = _selectedTempGeoValue;
      }
      _coverageTrendsValue = _selectedTempGeoValue;
      _gpTrendsValue = _selectedTempGeoValue;
      _fbTrendsValue = _selectedTempGeoValue;
    } else if (SummaryTypes.coverage.type == tabType) {
      if (_selectedTrendsGeoValue.trim().isNotEmpty) {
        _coverageTrendsValue = _selectedTempGeoValue;
      }
      _retailingTrendsValue = _selectedTempGeoValue;
      _gpTrendsValue = _selectedTempGeoValue;
      _fbTrendsValue = _selectedTempGeoValue;
    } else if (SummaryTypes.gp.type == tabType) {
      if (_selectedTrendsGeoValue.trim().isNotEmpty) {
        _gpTrendsValue = _selectedTempGeoValue;
      }
      _retailingTrendsValue = _selectedTempGeoValue;
      _coverageTrendsValue = _selectedTempGeoValue;
      _fbTrendsValue = _selectedTempGeoValue;
    } else if (SummaryTypes.fb.type == tabType) {
      if (_selectedTrendsGeoValue.trim().isNotEmpty) {
        _fbTrendsValue = _selectedTempGeoValue;
      }
      _retailingTrendsValue = _selectedTempGeoValue;
      _coverageTrendsValue = _selectedTempGeoValue;
      _gpTrendsValue = _selectedTempGeoValue;
    } else if (tabType == 'All') {
      _fbTrendsValue = _selectedTempGeoValue;
      _retailingTrendsValue = _selectedTempGeoValue;
      _coverageTrendsValue = _selectedTempGeoValue;
      _gpTrendsValue = _selectedTempGeoValue;
    }
    //  else {
    // if (_selectedTrendsGeoValue.isEmpty) {
    //   _retailingTrendsValue = _selectedTempGeoValue;
    // }
    // if (_coverageTrendsValue.isEmpty) {
    //   _coverageTrendsValue = _selectedTempGeoValue;
    // }
    // if (_gpTrendsValue.isEmpty) {
    //   _gpTrendsValue = _selectedTempGeoValue;
    // }
    // if (_fbTrendsValue.isEmpty) {
    //   _fbTrendsValue = _selectedTempGeoValue;
    // }
    // }

    if (isSummary) {
      await getSummaryData();
    }

    if (isLoadRetailing) {
      //retailing screen data

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
        reloadAllDeepDive(isSummary: isSummary, priority: 'Retailing');
      }
    }
    update();
  }

  Future<void> reloadAllDeepDive(
      {required String priority, bool isSummary = false}) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Data Reloaded ${getUserName()}'});
    //retailing screen data
    debugPrint('====>Reload All Deep Dive Calling $priority');
    if (priority == SummaryTypes.retailing.type) {
      //call all the retaling deep dive APIs
      await retailingDeepDive();
      if (!isSummary) {
        getSummaryData();
      }
      coverageDeepDive();
      gpDeepDive();
      fbDeepDive();
    } else if (priority == SummaryTypes.coverage.type) {
      //call all the coverage deep dive APIs
      await coverageDeepDive();
      if (!isSummary) {
        getSummaryData();
      }
      retailingDeepDive();
      gpDeepDive();
      fbDeepDive();
    } else if (priority == SummaryTypes.gp.type) {
      //call all the gp deep dive APIs
      await gpDeepDive();
      if (!isSummary) {
        getSummaryData();
      }
      retailingDeepDive();
      coverageDeepDive();
      fbDeepDive();
    } else if (priority == SummaryTypes.fb.type) {
      //call all the fb deep dive APIs
      await fbDeepDive();

      if (!isSummary) {
        getSummaryData();
      }
      retailingDeepDive();
      coverageDeepDive();
      gpDeepDive();
    } else {
      //Reloading all the data
      await getSummaryData();
      retailingDeepDive();
      coverageDeepDive();
      gpDeepDive();
      fbDeepDive();
    }

    update();
  }

  Future<void> retailingDeepDive() async {
    debugPrint('====>Retailing Deep Dive Loading');
    getRetailingData();
    getRetailingData(type: 'category', name: 'category');
    getRetailingData(type: 'channel', name: 'geo');
    getRetailingData(type: 'geo', name: 'trends');
  }

  Future<void> coverageDeepDive() async {
    await Future.wait([
      //Coverage screen data
      getCoverageData(),
      getCoverageData(type: 'channel', name: 'geo'),
      getCoverageData(type: 'trends', name: 'trends'),
    ]);
  }

  Future<void> gpDeepDive() async {
    await Future.wait([
      //golden points screen data
      getGPData(),
      getGPData(type: 'category', name: 'category'),
      getGPData(type: 'channel', name: 'geo'),
      getGPData(type: 'geo', name: 'trends'),
    ]);
  }

  Future<void> fbDeepDive() async {
    await Future.wait([
      //focus brand screen data
      getFocusBrandData(),
      getFocusBrandData(type: 'category', name: 'category'),
      getFocusBrandData(type: 'channel', name: 'geo'),
      getFocusBrandData(type: 'geo', name: 'trends'),
    ]);
  }

  void onApplyMultiFilter(
    String name,
    String type, {
    String tabType = 'Retailing',
    bool isTrendsFilter = false,
    required String subType,
  }) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Apply Filters ${getUserName()}'});
    if (SummaryTypes.retailing.type == tabType) {
      //retailing screen data
      if (subType == 'geo') {
        Map<String, dynamic> retailingGeoFilters = {
          "allIndia": selectedRetailingMultiAllIndia,
          "division": selectedRetailingMultiDivisions,
          "branches": selectedRetailingMultiBranches,
          "cluster": selectedRetailingMultiClusters,
          "sites": selectedRetailingMultiSites,
        };
        final mapEncoded = jsonEncode(retailingGeoFilters);
        await storage.write(
          key: AppConstants.RETAILING_GEO,
          value: mapEncoded,
        );
      } else if (subType == 'category') {
        //selectedRetailingCategoryFilters
        Map<String, dynamic> retailingCategoryFilters = {
          "category": selectedRetailingCategoryFilters,
          "selected": selectedCategory
        };
        final mapEncoded = jsonEncode(retailingCategoryFilters);
        await storage.write(
          key: AppConstants.RETAILING_CATEGORY,
          value: mapEncoded,
        );
      } else if (subType == 'channel') {
        //
        Map<String, dynamic> retailingChannelFilters = {
          "channel": selectedRetailingChannelFilter,
          "selected": selectedRetailingChannel
        };
        final mapEncoded = jsonEncode(retailingChannelFilters);
        await storage.write(
          key: AppConstants.RETAILING_CHANNEL,
          value: mapEncoded,
        );
      } else if (subType == 'trends') {
        Map<String, dynamic> retailingChannelFilters = {
          "trends": _selectedTrendsChannelValue.isNotEmpty
              ? _selectedTrendsChannelValue
              : _selectedTrendsCategoryValue.isNotEmpty
                  ? selectedTrendsCategoryValue
                  : _selectedTrendsGeoValue.isNotEmpty
                      ? _selectedTrendsGeoValue
                      : "All India",
          "category": selectedTrendsCategory,
          "channel": selectedChannel,
          "geo": selectedTrendsGeo,
        };
        final mapEncoded = jsonEncode(retailingChannelFilters);
        await storage.write(
          key: AppConstants.RETAILING_TRENDS,
          value: mapEncoded,
        );
      } else {
        // clear all the saved data from local storage
        await storage.delete(key: AppConstants.RETAILING_GEO);
      }
      getRetailingData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    } else if (SummaryTypes.coverage.type == tabType) {
      if (subType == 'geo') {
        Map<String, dynamic> coverageGeoFilters = {
          "allIndia": selectedCoverageMultiAllIndia,
          "division": selectedCoverageMultiDivisions,
          "branches": selectedCoverageMultiBranches,
          "cluster": selectedCoverageMultiClusters,
          "sites": selectedCoverageMultiSites,
        };
        final mapEncoded = jsonEncode(coverageGeoFilters);
        await storage.write(
          key: AppConstants.COVERAGE_GEO,
          value: mapEncoded,
        );
      } else if (subType == 'category') {
        //selectedRetailingCategoryFilters
        Map<String, dynamic> coverageCategoryFilters = {
          "category": selectedCoverageCategoryFilters,
          "selected": selectedCategory
        };

        final mapEncoded = jsonEncode(coverageCategoryFilters);
        await storage.write(
          key: AppConstants.COVERAGE_CATEGORY,
          value: mapEncoded,
        );
      } else if (subType == 'channel') {
        //
        Map<String, dynamic> coverageChannelFilters = {
          "channel": selectedCoverageChannelFilter,
          "selected": selectedCoverageChannel
        };
        final mapEncoded = jsonEncode(coverageChannelFilters);
        await storage.write(
          key: AppConstants.COVERAGE_CHANNEL,
          value: mapEncoded,
        );
      } else if (subType == 'trends') {
        Map<String, dynamic> coverageChannelFilters = {
          "trends": _selectedTrendsChannelValue.isNotEmpty
              ? _selectedTrendsChannelValue
              : _selectedTrendsCategoryValue.isNotEmpty
                  ? selectedTrendsCategoryValue
                  : _selectedTrendsGeoValue.isNotEmpty
                      ? _selectedTrendsGeoValue
                      : "All India",
          "category": selectedTrendsCategory,
          "channel": selectedChannel,
          "geo": selectedTrendsGeo,
        };
        final mapEncoded = jsonEncode(coverageChannelFilters);
        await storage.write(
          key: AppConstants.COVERAGE_TRENDS,
          value: mapEncoded,
        );
      }
      //Coverage screen data
      getCoverageData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    } else if (SummaryTypes.gp.type == tabType) {
      if (subType == 'geo') {
        Map<String, dynamic> gpGeoFilters = {
          "allIndia": selectedGPMultiAllIndia,
          "division": selectedGPMultiDivisions,
          "branches": selectedGPMultiBranches,
          "cluster": selectedGPMultiClusters,
          "sites": selectedGPMultiSites,
        };
        final mapEncoded = jsonEncode(gpGeoFilters);
        await storage.write(
          key: AppConstants.GP_GEO,
          value: mapEncoded,
        );
      } else if (subType == 'category') {
        //selectedRetailingCategoryFilters
        Map<String, dynamic> gpCategoryFilters = {
          "category": selectedGPCategoryFilters,
          "selected": selectedGPCategory
        };
        final mapEncoded = jsonEncode(gpCategoryFilters);
        await storage.write(
          key: AppConstants.GP_CATEGORY,
          value: mapEncoded,
        );
      } else if (subType == 'channel') {
        //
        Map<String, dynamic> gpChannelFilters = {
          "channel": selectedGPChannelFilter,
          "selected": selectedGPChannel
        };
        final mapEncoded = jsonEncode(gpChannelFilters);
        await storage.write(
          key: AppConstants.GP_CHANNEL,
          value: mapEncoded,
        );
      } else if (subType == 'trends') {
        Map<String, dynamic> gpChannelFilters = {
          "trends": _selectedTrendsChannelValue.isNotEmpty
              ? _selectedTrendsChannelValue
              : _selectedTrendsCategoryValue.isNotEmpty
                  ? selectedTrendsCategoryValue
                  : _selectedTrendsGeoValue.isNotEmpty
                      ? _selectedTrendsGeoValue
                      : "All India",
          "category": selectedTrendsCategory,
          "channel": selectedChannel,
          "geo": selectedTrendsGeo,
        };
        final mapEncoded = jsonEncode(gpChannelFilters);
        await storage.write(
          key: AppConstants.GP_TRENDS,
          value: mapEncoded,
        );
      }
      //retailing screen data
      getGPData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    } else if (SummaryTypes.fb.type == tabType) {
      if (subType == 'geo') {
        Map<String, dynamic> fbGeoFilters = {
          "allIndia": selectedFBMultiAllIndia,
          "division": selectedFBMultiDivisions,
          "branches": selectedFBMultiBranches,
          "cluster": selectedFBMultiClusters,
          "sites": selectedFBMultiSites,
        };
        final mapEncoded = jsonEncode(fbGeoFilters);
        await storage.write(
          key: AppConstants.FB_GEO,
          value: mapEncoded,
        );
      } else if (subType == 'category') {
        //selectedRetailingCategoryFilters
        Map<String, dynamic> fbCategoryFilters = {
          "category": selectedFBCategoryFilters,
          "selected": selectedFBCategory
        };
        final mapEncoded = jsonEncode(fbCategoryFilters);
        await storage.write(
          key: AppConstants.FB_CATEGORY,
          value: mapEncoded,
        );
      } else if (subType == 'channel') {
        //
        Map<String, dynamic> fbChannelFilters = {
          "channel": selectedFBChannelFilter,
          "selected": selectedFBChannel
        };
        final mapEncoded = jsonEncode(fbChannelFilters);
        await storage.write(
          key: AppConstants.FB_CHANNEL,
          value: mapEncoded,
        );
      } else if (subType == 'trends') {
        Map<String, dynamic> fbChannelFilters = {
          "trends": _selectedTrendsChannelValue.isNotEmpty
              ? _selectedTrendsChannelValue
              : _selectedTrendsCategoryValue.isNotEmpty
                  ? selectedTrendsCategoryValue
                  : _selectedTrendsGeoValue.isNotEmpty
                      ? _selectedTrendsGeoValue
                      : "All India",
          "category": selectedTrendsCategory,
          "channel": selectedChannel,
          "geo": selectedTrendsGeo,
        };
        final mapEncoded = jsonEncode(fbChannelFilters);
        await storage.write(
          key: AppConstants.FB_TRENDS,
          value: mapEncoded,
        );
      }
      //retailing screen data
      getFocusBrandData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    }
    update();
  }

  Future<void> onChangeFilters(
    String value, {
    bool isLoadRetailing = false,
    String tabType = 'All',
    bool isSummary = false,
  }) async {
    _selectedTempGeoValue = value;
    onChangeGeoTrends('Geography');
    onChangeTrendsFilters(value, tabType);
    onApplyFilter(
      isLoadRetailing: isLoadRetailing,
      tabType: tabType,
      isSummary: isSummary,
    );
    update();
  }

  void onChangeTrendsFilters(String value, String tabType) {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Changed in Trends Filter ${getUserName()}'});
    _selectedTrendsGeoValue = value;
    _selectedTrendsCategoryValue = '';
    _selectedTrendsChannelValue = '';

    if (tabType == SummaryTypes.retailing.type) {
      _retailingTrendsValue = value;
      if (value.toLowerCase().contains('allindia')) {
        // _isRetailingDeepDiveInd = false;
      } else {
        _isRetailingDeepDiveInd = true;
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      _coverageTrendsValue = value;
    } else if (tabType == SummaryTypes.gp.type) {
      _gpTrendsValue = value;
    } else if (tabType == SummaryTypes.fb.type) {
      _fbTrendsValue = value;
    }
    //
    update();
  }

  void clearRetailingGeo() {
    selectedRetailingMultiAllIndia.clear();
    selectedRetailingMultiDivisions.clear();
    selectedRetailingMultiClusters.clear();
    selectedRetailingMultiSites.clear();
    selectedRetailingMultiBranches.clear();
    selectedRetailingMultiDivisions.clear();
    selectedRetailingMultiDivisions.clear();
    update();
  }

  void clearMultiFilter(String name, String type,
      {String tabType = 'Retailing'}) {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Clear Multi Filter ${getUserName()}'});
    selectedRetailingMultiAllIndia.clear();
    selectedRetailingMultiDivisions.clear();
    selectedCoverageMultiDivisions.clear();
    selectedGPMultiDivisions.clear();
    selectedFBMultiDivisions.clear();
    selectedRetailingMultiClusters.clear();
    selectedCoverageMultiClusters.clear();
    selectedGPMultiClusters.clear();
    selectedFBMultiClusters.clear();
    selectedRetailingMultiSites.clear();
    selectedCoverageMultiSites.clear();
    selectedGPMultiSites.clear();
    selectedFBMultiSites.clear();
    selectedRetailingMultiBranches.clear();
    selectedCoverageMultiBranches.clear();
    selectedGPMultiBranches.clear();
    selectedFBMultiBranches.clear();
    selectedMultiFilters.clear();
    onApplyMultiFilter(name, type, tabType: tabType, subType: '');
  }

  void onChangeMultiFilters(String value,
      {String tabType = 'retailing', required String selectedMultiGeoFilter}) {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'On Changed Multi Filter ${getUserName()}'});
    //

    if (selectedMultiGeoFilter == 'All India') {
      // selectedRetailingMultiAllIndia
      debugPrint('====>All India --Value: $value');
      if (tabType == SummaryTypes.retailing.type) {
        if (selectedRetailingMultiAllIndia.contains(value)) {
          selectedRetailingMultiAllIndia.remove(value);
        } else {
          selectedRetailingMultiAllIndia.add(value);
        }
      } else if (tabType == SummaryTypes.coverage.type) {
        debugPrint('====>Coverage');
        if (selectedCoverageMultiAllIndia.contains(value)) {
          selectedCoverageMultiAllIndia.remove(value);
        } else {
          selectedCoverageMultiAllIndia.add(value);
        }
      } else if (tabType == SummaryTypes.gp.type) {
        if (selectedGPMultiAllIndia.contains(value)) {
          selectedGPMultiAllIndia.remove(value);
        } else {
          selectedGPMultiAllIndia.add(value);
        }
      } else if (tabType == SummaryTypes.fb.type) {
        if (selectedFBMultiAllIndia.contains(value)) {
          selectedFBMultiAllIndia.remove(value);
        } else {
          selectedFBMultiAllIndia.add(value);
        }
      }
      update();
    } else if (selectedMultiGeoFilter.toLowerCase() ==
        'Division'.toLowerCase()) {
      debugPrint('===>Adding Division $value');
      if (tabType == SummaryTypes.retailing.type) {
        if (selectedRetailingMultiDivisions.contains(value)) {
          selectedRetailingMultiDivisions.remove(value);
        } else {
          selectedRetailingMultiDivisions.add(value);
        }
      } else if (tabType == SummaryTypes.coverage.type) {
        if (selectedCoverageMultiDivisions.contains(value)) {
          selectedCoverageMultiDivisions.remove(value);
        } else {
          selectedCoverageMultiDivisions.add(value);
        }
      } else if (tabType == SummaryTypes.gp.type) {
        if (selectedGPMultiDivisions.contains(value)) {
          selectedGPMultiDivisions.remove(value);
        } else {
          selectedGPMultiDivisions.add(value);
        }
      } else if (tabType == SummaryTypes.fb.type) {
        if (selectedFBMultiDivisions.contains(value)) {
          selectedFBMultiDivisions.remove(value);
        } else {
          selectedFBMultiDivisions.add(value);
        }
      }
      update();
    } else if (selectedMultiGeoFilter.toLowerCase() ==
        'Cluster'.toLowerCase()) {
      if (tabType == SummaryTypes.retailing.type) {
        if (selectedRetailingMultiClusters.contains(value)) {
          selectedRetailingMultiClusters.remove(value);
        } else {
          selectedRetailingMultiClusters.add(value);
        }
      } else if (tabType == SummaryTypes.coverage.type) {
        if (selectedCoverageMultiClusters.contains(value)) {
          selectedCoverageMultiClusters.remove(value);
        } else {
          selectedCoverageMultiClusters.add(value);
        }
      } else if (tabType == SummaryTypes.gp.type) {
        if (selectedGPMultiClusters.contains(value)) {
          selectedGPMultiClusters.remove(value);
        } else {
          selectedGPMultiClusters.add(value);
        }
      } else if (tabType == SummaryTypes.fb.type) {
        if (selectedFBMultiClusters.contains(value)) {
          selectedFBMultiClusters.remove(value);
        } else {
          selectedFBMultiClusters.add(value);
        }
      }
    } else if (selectedMultiGeoFilter.toLowerCase() ==
        'Focus Area'.toLowerCase()) {
      if (tabType == SummaryTypes.retailing.type) {
        if (selectedRetailingMultiSites.contains(value)) {
          selectedRetailingMultiSites.remove(value);
        } else {
          selectedRetailingMultiSites.add(value);
        }
      } else if (tabType == SummaryTypes.coverage.type) {
        if (selectedCoverageMultiSites.contains(value)) {
          selectedCoverageMultiSites.remove(value);
        } else {
          selectedCoverageMultiSites.add(value);
        }
      } else if (tabType == SummaryTypes.gp.type) {
        if (selectedGPMultiSites.contains(value)) {
          selectedGPMultiSites.remove(value);
        } else {
          selectedGPMultiSites.add(value);
        }
      } else if (tabType == SummaryTypes.fb.type) {
        if (selectedFBMultiSites.contains(value)) {
          selectedFBMultiSites.remove(value);
        } else {
          selectedFBMultiSites.add(value);
        }
      }
    } else if (selectedMultiGeoFilter.toLowerCase() == 'Branch'.toLowerCase()) {
      debugPrint('===>Adding Branch');
      if (tabType == SummaryTypes.retailing.type) {
        if (selectedRetailingMultiBranches.contains(value)) {
          selectedRetailingMultiBranches.remove(value);
        } else {
          selectedRetailingMultiBranches.add(value);
        }
      } else if (tabType == SummaryTypes.coverage.type) {
        if (selectedCoverageMultiBranches.contains(value)) {
          selectedCoverageMultiBranches.remove(value);
        } else {
          selectedCoverageMultiBranches.add(value);
        }
      } else if (tabType == SummaryTypes.gp.type) {
        if (selectedGPMultiBranches.contains(value)) {
          selectedGPMultiBranches.remove(value);
        } else {
          selectedGPMultiBranches.add(value);
        }
      } else if (tabType == SummaryTypes.fb.type) {
        if (selectedFBMultiBranches.contains(value)) {
          selectedFBMultiBranches.remove(value);
        } else {
          selectedFBMultiBranches.add(value);
        }
      }
      // if (selectedMultiBranches.contains(value)) {
      //   selectedMultiBranches.remove(value);
      // } else {
      //   selectedMultiBranches.add(value);
      // }
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

  bool getUserGuide() {
    return homeRepo.getUserGuide();
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

  bool getPersona() {
    return homeRepo.getPersona();
  }

  String getGeoValue() {
    return homeRepo.getGeoValue();
  }

  Future<bool> setSeen(bool seen) async {
    return await homeRepo.saveUserSeen(seen);
  }

  Future<bool> saveUserGuide(bool seen) async {
    return await homeRepo.saveUserGuide(seen);
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
  RetailingGeoModel? retailingGeoModel;
  RetailingGeoModel? categoryRetailingModel;
  RetailingGeoModel? channelRetailingModel;
  RetailingTrendsModel? trendsRetailingModel;

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
  List<String> monthFilters = [], yearFilter = [];
  List<TrendsModel> trendsList = [];
  List<CoverageTrendsModel> trendsCoverageList = [];
  List<GPTrendsModel> trendsGPList = [];
  List<FBTrendsModel> trendsFBList = [];
  List<Map<String, dynamic>> geoFilters = [];

  Future<ResponseModel> getSummaryData({bool isAutoRefresh = false}) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Get Summary Data ${getUserName()}'});
    _isSummaryPageLoading = true;
    summaryData = [];
    update();
    // var stopWatch = Stopwatch();
    // stopWatch.reset();
    // stopWatch.start();
    // Logger().log(Level.debug,
    //     '===> Summary Data Start: ${stopWatch.elapsed.toString()}');
    Response response = await homeRepo.getSummaryData({
      "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
      //"${selectedMonth!.substring(0, 3)}-$selectedYear",
      _selectedGeo.startsWith('All India')
              ? "allIndia"
              : _selectedGeo.startsWith('Focus Area')
                  ? "site"
                  : _selectedGeo.startsWith('Cluster')
                      ? "district"
                      : _selectedGeo.toLowerCase():
          _selectedGeo.startsWith('All India')
              ? ["allIndia"]
              : [_selectedGeoValue],
    });
    ResponseModel responseModel;
    Logger().w('Summary Page Data :=> ${response.bodyString}');
    if (response.statusCode == 200) {
      summaryData = summaryModelFromJson(response.bodyString.toString());
      responseModel = ResponseModel(true, 'Success');
      if (isAutoRefresh) {
        //call the api to false the firebase autorefresh var false
        updateFirebaseVar();
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    // Logger().log(
    //     Level.debug, '===> Summary Data End: ${stopWatch.elapsed.toString()}');
    // stopWatch.stop();
    // stopWatch.reset();
    _isSummaryPageLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateFirebaseVar() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirebaseVarLoading = true;
      update();
    });

    Response response =
        await homeRepo.updateFirebaseVar({"refresh_data": false});
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      debugPrint('====>Firebase auto refresh done ');
      globals.autoRefresh = true;
      responseModel = ResponseModel(false, response.statusText ?? "");
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }

    _isFirebaseVarLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getMonthFilters(
      {String year = '2024', bool monthLoading = false}) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs', parameters: {"message": 'Month Data ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (monthLoading) {
        _isMonthLoading = true;
      } else {
        _isFilterLoading = true;
      }
      update();
    });
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(
        Level.debug, '===> Filter Data Start: ${stopWatch.elapsed.toString()}');
    Response response = await homeRepo.getFilters({"year": year});

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (response.body["data"].isNotEmpty) {
          final data = response.body["data"][0]["months"];
          final _years = response.body["data"][0]["year"];
          if (data != null) {
            monthFilters = List<String>.from(data!.map((x) => x));
          }
          if (_years != null) {
            yearFilter = List<String>.from(_years!.map((x) => x));
          }
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    //Api Calling Response time
    Logger().log(
        Level.debug, '===> Filter Data End : ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    //
    if (monthLoading) {
      _isMonthLoading = false;
    } else {
      _isFilterLoading = false;
    }

    update();
    return responseModel;
  }

  Future<ResponseModel> getRetailingData(
      {String type = 'geo',
      String name = 'geo',
      bool isTrendsFilter = false}) async {
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    FirebaseAnalytics.instance.logEvent(
        name: 'retailing',
        parameters: {"message": 'Retailing Data Reloaded ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        _isRetailingTrendsLoading = true;
        RetailingTrendsModel retailingTrendsModel =
            RetailingTrendsModel(ind: TrendsModel(), indDir: TrendsModel());
        trendsRetailingModel = retailingTrendsModel;
        var elapsedString = stopWatch.elapsed.toString();
        Logger().log(
            Level.debug, '===> Retailing Trends Data Start $elapsedString');
      } else if (type.startsWith('geo')) {
        Logger().log(Level.debug,
            '===> Retailing Geo Data Start ${stopWatch.elapsed.toString()}');
        _isRetailingGeoLoading = true;
      } else if (type.startsWith('category')) {
        _isRetailingCategoryLoading = true;
        categoryRetailingModel?.ind?.clear();
        categoryRetailingModel?.indDir?.clear();
        Logger().log(Level.debug,
            '===> Retailing Category Data Start ${stopWatch.elapsed.toString()}');
      } else if (type.startsWith('channel')) {
        _isRetailingChannelLoading = true;
        channelRetailingModel?.ind?.clear();
        channelRetailingModel?.indDir?.clear();
        Logger().log(Level.debug,
            '===> Retailing Channel Data Start ${stopWatch.elapsed.toString()}');
      } else {
        _isLoading = true;
      }

      update();
    });

    Map<String, dynamic> _body = {
      "name": name,
      "type": type,
      "query": name.toLowerCase().startsWith('trend')
          ? [
              {
                "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                if (isTrendsFilter && _selectedTrendsGeoValue.isEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedTrendsGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeoValue,
                if (!isTrendsFilter)
                  _selectedGeo.startsWith('All India')
                      ? "allIndia"
                      : _selectedGeo.startsWith('Focus Area')
                          ? "site"
                          : _selectedGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedGeo.toLowerCase(): _selectedGeoValue,
                if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedTrendsGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeoValue,
                if (_selectedTrendsCategoryValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsCategory.toLowerCase() == 'brand form'
                          ? 'brandForm'
                          : _selectedTrendsCategory.toLowerCase():
                      _selectedTrendsCategoryValue,
                if (_selectedTrendsChannelValue.isNotEmpty)
                  selectedChannel.toLowerCase() == 'level 1'
                      ? 'attr1'
                      : selectedChannel.toLowerCase() == 'level 2'
                          ? 'attr2'
                          : selectedChannel.toLowerCase() == 'level 3'
                              ? 'attr3'
                              : selectedChannel.toLowerCase() == 'level 4'
                                  ? 'attr4'
                                  : selectedChannel.toLowerCase() == 'level 5'
                                      ? 'attr5'
                                      : 'attr1': _selectedTrendsChannelValue,
                //
                if (selectedTrendsCategoryValue.isNotEmpty && !isTrendsFilter)
                  _selectedTrendsCategory.toLowerCase() == 'brand form'
                          ? 'brandForm'
                          : selectedTrendsCategory.toLowerCase():
                      selectedTrendsCategoryValue,
              },
            ]
          : type.startsWith('channel')
              ? [
                  {
                    "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                    _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeo.startsWith('Focus Area')
                                ? "site"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedGeo.toLowerCase():
                        _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeoValue,
                    if (selectedRetailingChannelFilter.isNotEmpty)
                      selectedRetailingChannel.toLowerCase() == 'level 1'
                              ? 'attr1'
                              : selectedRetailingChannel.toLowerCase() == 'level 2'
                                  ? 'attr2'
                                  : selectedRetailingChannel.toLowerCase() ==
                                          'level 3'
                                      ? 'attr3'
                                      : selectedRetailingChannel
                                                  .toLowerCase() ==
                                              'level 4'
                                          ? 'attr4'
                                          : selectedRetailingChannel
                                                      .toLowerCase() ==
                                                  'level 5'
                                              ? 'attr5'
                                              : 'attr1':
                          selectedRetailingChannelFilter,
                    if (selectedRetailingChannelFilter.isEmpty) "attr1": [],
                  }
                ]
              : name.startsWith('geo')
                  ? [
                      {
                        "date":
                            "${selectedMonth.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Focus Area')
                                    ? "site"
                                    : _selectedGeo.startsWith('Cluster')
                                        ? "district"
                                        : _selectedGeo.toLowerCase():
                            _selectedGeoValue,
                      },
                      ...selectedRetailingMultiAllIndia
                          .map((e) => {
                                "date":
                                    "${selectedMonth.substring(0, 3)}-$selectedYear",
                                "allIndia": e,
                              })
                          .toList(),
                      ...selectedRetailingMultiDivisions
                          .map((e) => {
                                "date":
                                    "${selectedMonth.substring(0, 3)}-$selectedYear",
                                "division": e,
                              })
                          .toList(),
                      ...selectedRetailingMultiClusters
                          .map((e) => {
                                "date":
                                    "${selectedMonth.substring(0, 3)}-$selectedYear",
                                "district": e,
                              })
                          .toList(),
                      ...selectedRetailingMultiSites
                          .map((e) => {
                                "date":
                                    "${selectedMonth.substring(0, 3)}-$selectedYear",
                                "site": e,
                              })
                          .toList(),
                      ...selectedRetailingMultiBranches
                          .map((e) => {
                                "date":
                                    "${selectedMonth.substring(0, 3)}-$selectedYear",
                                "branch": e,
                              })
                          .toList(),
                      ...selectedMultiFilters
                          .map((e) => {
                                "date":
                                    "${selectedMonth.substring(0, 3)}-$selectedYear",
                                "allIndia": e,
                              })
                          .toList(),
                    ]
                  : [
                      {
                        "date":
                            "${selectedMonth.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Focus Area')
                                    ? "site"
                                    : _selectedGeo.startsWith('Cluster')
                                        ? "district"
                                        : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedRetailingCategoryFilters.isNotEmpty)
                          selectedCategory.toLowerCase().contains('sub-brand')
                                  ? 'subBrandForm'
                                  : selectedCategory
                                          .toLowerCase()
                                          .contains('brand form')
                                      ? 'brandForm'
                                      : selectedCategory.toLowerCase():
                              selectedRetailingCategoryFilters,
                        if (selectedRetailingCategoryFilters.isEmpty)
                          "category": [],
                      },
                    ]
    };
    debugPrint('===>Body : $_body');

    Response response = await homeRepo.getRetailingData(_body);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          final data = response.body["data"];
          if (data != null && data.isNotEmpty) {
            trendsRetailingModel = RetailingTrendsModel.fromJson(data);
          }
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            debugPrint('===>Geo Data:${json.encode(response.body)}');
            final data = response.body["data"];
            if (data != null && data.isNotEmpty) {
              retailingGeoModel = RetailingGeoModel.fromJson(data);
            }
          } else if (type.startsWith('category')) {
            // Logger().i('===>Category Data:${json.encode(response.body)}');
            if (response.body["data"] != null) {
              categoryRetailingModel =
                  RetailingGeoModel.fromJson(response.body["data"]);
            }
          } else if (type.startsWith('channel')) {
            if (response.body["data"] != null) {
              channelRetailingModel =
                  RetailingGeoModel.fromJson(response.body["data"]);
            }
          } else if (type.startsWith('trends')) {
            trendsList = response.body["data"] == null
                ? []
                : List<TrendsModel>.from(
                    response.body["data"]!.map((x) => TrendsModel.fromJson(x)));
          }
        }
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        //set value as empty

        if (type.startsWith('trends')) {
          trendsList = response.body["data"] == null
              ? []
              : List<TrendsModel>.from(
                  response.body["data"]!.map((x) => TrendsModel.fromJson(x)));
        }
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      // showCustomSnackBar('${response.body}');

      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      Logger().log(Level.debug,
          '===> Retailing Trends Data End ${stopWatch.elapsed.toString()}');
      _isRetailingTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      Logger().log(Level.debug,
          '===> Retailing Geo Data End ${stopWatch.elapsed.toString()}');
      _isRetailingGeoLoading = false;
    } else if (type.startsWith('category')) {
      Logger().log(Level.debug,
          '===> Retailing Category Data End ${stopWatch.elapsed.toString()}');
      _isRetailingCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      Logger().log(Level.debug,
          '===> Retailing Channel Data End ${stopWatch.elapsed.toString()}');
      _isRetailingChannelLoading = false;
    } else {
      _isLoading = false;
    }
    stopWatch.stop();
    stopWatch.reset();

    update();
    return responseModel;
  }

  Future<ResponseModel> getAllFilters({String filter = '2023'}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(
        Level.debug, '===> Filter Data Start ${stopWatch.elapsed.toString()}');
    Response response = await homeRepo.getFilters({"filter": filter});

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          _filtersModel = FiltersModel.fromJson(data[0]);
          if (_filtersModel != null) {
            _filtersModel?.district.removeWhere(
                (element) => element == 'Sri Lanka' || element == 'Nepal');
            _filtersModel?.site.removeWhere(
                (element) => element == 'Sri Lanka' || element == 'Nepal');
          }
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    Logger().log(
        Level.debug, '===> Filter Data End ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
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
    //
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(Level.debug,
        '===> Category Search Data Start ${stopWatch.elapsed.toString()}');
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
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    Logger().log(Level.debug,
        '===> Category Search Data End ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  //coverage
  Future<ResponseModel> getCoverageData(
      {String type = 'geo',
      String name = 'geo',
      bool isTrendsFilter = false,
      List<Map<String, dynamic>>? allFilter}) async {
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    FirebaseAnalytics.instance.logEvent(
        name: 'coverage',
        parameters: {"message": 'Coverage Data Reloaded ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        Logger().log(Level.debug,
            '===> Coverage Trends Data Start ${stopWatch.elapsed.toString()}');
        _isCoverageTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        Logger().log(Level.debug,
            '===> Coverage Geo Data Start ${stopWatch.elapsed.toString()}');
        _isCoverageGeoLoading = true;
      } else if (type.startsWith('category')) {
        Logger().log(Level.debug,
            '===> Coverage Category Data Start ${stopWatch.elapsed.toString()}');
        _isCoverageCategoryLoading = true;
        if (categoryCoverageList.isNotEmpty) {
          List<List<String>> categoryListTemp = [];
          categoryListTemp.addAll(categoryCoverageList);
          categoryCoverageList.clear();
          categoryCoverageList.add(categoryListTemp[0]);
        }
      } else if (type.startsWith('channel')) {
        Logger().log(Level.debug,
            '===> Coverage Channel Data Start ${stopWatch.elapsed.toString()}');
        _isCoverageChannelLoading = true;
        if (channelCoverageList.isNotEmpty) {
          List<List<String>> channelListTemp = [];
          channelListTemp.addAll(channelCoverageList);
          channelCoverageList.clear();
          channelCoverageList.add(channelListTemp[0]);
        }
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
                "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                if (isTrendsFilter && _selectedTrendsGeoValue.isEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedTrendsGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (!isTrendsFilter)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedTrendsGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeoValue,
                // if (_selectedTrendsCategoryValue.isNotEmpty)
                //   _selectedTrendsCategory.toLowerCase():
                //       _selectedTrendsCategoryValue,
                if (_selectedTrendsChannelValue.isNotEmpty)
                  selectedChannel.toLowerCase() == 'level 1'
                      ? 'attr1'
                      : selectedChannel.toLowerCase() == 'level 2'
                          ? 'attr2'
                          : selectedChannel.toLowerCase() == 'level 3'
                              ? 'attr3'
                              : selectedChannel.toLowerCase() == 'level 4'
                                  ? 'attr4'
                                  : selectedChannel.toLowerCase() == 'level 5'
                                      ? 'attr5'
                                      : 'attr1': _selectedTrendsChannelValue,
              },
            ]
          : type.startsWith('channel')
              ? allFilter ??
                  [
                    {
                      "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.startsWith('Focus Area')
                                  ? "site"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedCoverageChannelFilter.isNotEmpty)
                        selectedCoverageChannel.toLowerCase() == 'level 1'
                                ? 'attr1'
                                : selectedCoverageChannel.toLowerCase() == 'level 2'
                                    ? 'attr2'
                                    : selectedCoverageChannel.toLowerCase() ==
                                            'level 3'
                                        ? 'attr3'
                                        : selectedCoverageChannel
                                                    .toLowerCase() ==
                                                'level 4'
                                            ? 'attr4'
                                            : selectedCoverageChannel
                                                        .toLowerCase() ==
                                                    'level 5'
                                                ? 'attr5'
                                                : 'attr1':
                            selectedCoverageChannelFilter,
                      if (selectedCoverageChannelFilter.isEmpty) "attr1": [],
                    }
                  ]
              : name.startsWith('geo')
                  ? allFilter ??
                      [
                        {
                          "date":
                              "${selectedMonth.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Focus Area')
                                      ? "site"
                                      : _selectedGeo.startsWith('Cluster')
                                          ? "district"
                                          : _selectedGeo.toLowerCase():
                              _selectedGeoValue,
                        },
                        ...selectedCoverageMultiAllIndia
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                        ...selectedCoverageMultiDivisions
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedCoverageMultiClusters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "district": e,
                                })
                            .toList(),
                        ...selectedCoverageMultiSites
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedCoverageMultiBranches
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date":
                            "${selectedMonth.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Focus Area')
                                    ? "site"
                                    : _selectedGeo.startsWith('Cluster')
                                        ? "district"
                                        : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedCoverageCategoryFilters.isNotEmpty)
                          selectedCategory.toLowerCase().contains('sub-brand')
                                  ? 'subBrandForm'
                                  : selectedCategory.toLowerCase():
                              selectedCoverageCategoryFilters,
                        if (selectedCoverageCategoryFilters.isEmpty)
                          "category": [],
                      },
                    ]
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          // Logger().f('===>Coverage Trends Data:${json.encode(response.body)}');

          trendsCoverageList = response.body["data"] == null
              ? []
              : List<CoverageTrendsModel>.from(response.body["data"]!
                  .map((x) => CoverageTrendsModel.fromJson(x)));
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            // debugPrint('===>Geo Data:${json.encode(response.body)}');
            coverageList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            // Logger().i('===>Category Data:${json.encode(response.body)}');
            categoryCoverageList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            // Logger().f('===>Category Data:${json.encode(response.body)}');
            // debugPrint(
            //     '===>Coverage Channel Data:${json.encode(response.body)}');
            channelCoverageList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            // Logger().f('===>Trends Data:${json.encode(response.body)}');
            trendsCoverageList = response.body["data"] == null
                ? []
                : List<CoverageTrendsModel>.from(response.body["data"]!
                    .map((x) => CoverageTrendsModel.fromJson(x)));
          }
        }
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        // Logger().e(response.body);
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      // Logger().e(response.body);
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      Logger().log(Level.debug,
          '===> Coverage Trends Data end ${stopWatch.elapsed.toString()}');
      _isCoverageTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      Logger().log(Level.debug,
          '===> Coverage Geo Data end ${stopWatch.elapsed.toString()}');
      _isCoverageGeoLoading = false;
    } else if (type.startsWith('category')) {
      Logger().log(Level.debug,
          '===> Coverage Category Data end ${stopWatch.elapsed.toString()}');
      _isCoverageCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      Logger().log(Level.debug,
          '===> Coverage Channel Data end ${stopWatch.elapsed.toString()}');
      _isCoverageChannelLoading = false;
    } else {
      _isLoading = false;
    }
    stopWatch.stop();
    stopWatch.reset();

    update();
    return responseModel;
  }

//Golden Points
  Future<ResponseModel> getGPData(
      {String type = 'geo',
      String name = 'geo',
      bool isTrendsFilter = false}) async {
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    FirebaseAnalytics.instance.logEvent(
        name: 'gp',
        parameters: {"message": 'GP Data Reloaded ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        Logger().log(Level.debug,
            '===> Golden Points Trends Data Start ${stopWatch.elapsed.toString()}');
        _isGPTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        Logger().log(Level.debug,
            '===> Golden Points Geo Data Start ${stopWatch.elapsed.toString()}');
        _isGPGeoLoading = true;
      } else if (type.startsWith('category')) {
        categoryGPList.clear();
        // categoryGPList.add(categoryListTemp[0]);

        Logger().log(Level.debug,
            '===> Golden Points Category Data Start ${stopWatch.elapsed.toString()}');
        _isGPCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        channelGPList.clear();

        Logger().log(Level.debug,
            '===> Golden Points Channel Data Start ${stopWatch.elapsed.toString()}');
        _isGPChannelLoading = true;
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
                  "date": "${selectedMonth.substring(0, 3)}-$selectedYear",

                  if (!isTrendsFilter)
                    _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeo.startsWith('Focus Area')
                                ? "site"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedGeo.toLowerCase():
                        _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeoValue,
                  if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                    _selectedTrendsGeo.startsWith('Cluster')
                            ? "district"
                            : _selectedTrendsGeo.toLowerCase():
                        _selectedTrendsGeoValue,
                  ////
                  if (isTrendsFilter)
                    _selectedTrendsGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedTrendsGeo.startsWith('Focus Area')
                                ? "site"
                                : _selectedTrendsGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedTrendsGeo.toLowerCase():
                        _selectedTrendsGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedTrendsGeoValue,
                  if (!isTrendsFilter)
                    _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeo.startsWith('Focus Area')
                                ? "site"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedGeo.toLowerCase():
                        _selectedGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedGeoValue,
                  if (selectedTrendsCategoryValue.isNotEmpty)
                    selectedTrendsCategory.toLowerCase().contains('sub-brand')
                            ? 'subBrandGroup'
                            : selectedTrendsCategory
                                    .toLowerCase()
                                    .contains('brand form')
                                ? 'brandForm'
                                : selectedTrendsCategory.toLowerCase():
                        selectedTrendsCategoryValue,
                  if (_selectedTrendsChannelValue.isNotEmpty)
                    selectedChannel.toLowerCase() == 'level 1'
                        ? 'attr1'
                        : selectedChannel.toLowerCase() == 'level 2'
                            ? 'attr2'
                            : selectedChannel.toLowerCase() == 'level 3'
                                ? 'attr3'
                                : selectedChannel.toLowerCase() == 'level 4'
                                    ? 'attr4'
                                    : selectedChannel.toLowerCase() == 'level 5'
                                        ? 'attr5'
                                        : 'attr1': _selectedTrendsChannelValue,
                },
              ]
            : type.startsWith('channel')
                ? [
                    {
                      "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.startsWith('Focus Area')
                                  ? "site"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedGPChannelFilter.isNotEmpty)
                        selectedGPChannel.toLowerCase() == 'level 1'
                            ? 'attr1'
                            : selectedGPChannel.toLowerCase() == 'level 2'
                                ? 'attr2'
                                : selectedGPChannel.toLowerCase() == 'level 3'
                                    ? 'attr3'
                                    : selectedGPChannel.toLowerCase() ==
                                            'level 4'
                                        ? 'attr4'
                                        : selectedGPChannel.toLowerCase() ==
                                                'level 5'
                                            ? 'attr5'
                                            : 'attr1': selectedGPChannelFilter,
                      if (selectedGPChannelFilter.isEmpty) "attr1": [],
                    }
                  ]
                : name.startsWith('geo')
                    ? [
                        {
                          "date":
                              "${selectedMonth.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Focus Area')
                                      ? "site"
                                      : _selectedGeo.startsWith('Cluster')
                                          ? "district"
                                          : _selectedGeo.toLowerCase():
                              _selectedGeoValue,
                        },
                        ...selectedGPMultiAllIndia
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                        ...selectedGPMultiDivisions
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedGPMultiClusters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "district": e,
                                })
                            .toList(),
                        ...selectedGPMultiSites
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedGPMultiBranches
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                    : [
                        {
                          "date":
                              "${selectedMonth.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Focus Area')
                                      ? "site"
                                      : _selectedGeo.startsWith('Cluster')
                                          ? "district"
                                          : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                          if (selectedGPCategoryFilters.isNotEmpty)
                            _selectedGPCategory
                                        .toLowerCase()
                                        .contains('sub-brand')
                                    ? 'subBrandGroup'
                                    : _selectedGPCategory
                                            .toLowerCase()
                                            .contains('brand form')
                                        ? 'brandForm'
                                        : _selectedGPCategory.toLowerCase():
                                selectedGPCategoryFilters,
                          if (selectedGPCategoryFilters.isEmpty) 'category': []
                        },
                      ],
      },
    );
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          // Logger().f('===>Trends Data:${json.encode(response.body)}');
          trendsGPList = response.body["data"] == null
              ? []
              : List<GPTrendsModel>.from(
                  response.body["data"]!.map((x) => GPTrendsModel.fromJson(x)));
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            // debugPrint('===>Geo Data:${json.encode(response.body)}');
            gpList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            // Logger().i('===>Category Data:${json.encode(response.body)}');

            categoryGPList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            // Logger().f('===>Category Data:${json.encode(response.body)}');
            // debugPrint('===>GP Channel Data:${json.encode(response.body)}');
            channelGPList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            // Logger().f('===>Trends Data:${json.encode(response.body)}');
            trendsGPList = response.body["data"] == null
                ? []
                : List<GPTrendsModel>.from(response.body["data"]!
                    .map((x) => GPTrendsModel.fromJson(x)));
          }
        }
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        if (name.startsWith('trends')) {
          // Logger().f('===>Trends Data:${json.encode(response.body)}');
          trendsGPList = response.body["data"] == null
              ? []
              : List<GPTrendsModel>.from(
                  response.body["data"]!.map((x) => GPTrendsModel.fromJson(x)));
        }
        // String msg = response.body["message"] ?? '';
        // showCustomSnackBar(msg);
        // Logger().i("===>Name:$name --Type:$type  :${response.body}");
        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      // Logger().e(
      //     "===>Status Code:${response.statusCode} Name:$name --Type:$type  :${response.body}");
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      Logger().log(Level.debug,
          '===> Golden Points Trends Data end ${stopWatch.elapsed.toString()}');
      _isGPTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      Logger().log(Level.debug,
          '===> Golden Points Geo Data end ${stopWatch.elapsed.toString()}');
      _isGPGeoLoading = false;
    } else if (type.startsWith('category')) {
      Logger().log(Level.debug,
          '===> Golden Points Category Data end ${stopWatch.elapsed.toString()}');
      _isGPCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      Logger().log(Level.debug,
          '===> Golden Points Channel Data end ${stopWatch.elapsed.toString()}');
      _isGPChannelLoading = false;
    } else {
      _isLoading = false;
    }
    stopWatch.stop();
    stopWatch.reset();
    update();
    return responseModel;
  }

//Focus Brand
  Future<ResponseModel> getFocusBrandData(
      {String type = 'geo',
      String name = 'geo',
      bool isTrendsFilter = false,
      List<Map<String, dynamic>>? allFilter}) async {
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    FirebaseAnalytics.instance.logEvent(
        name: 'fb',
        parameters: {"message": 'FB Data Reloaded ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.startsWith('trends')) {
        Logger().log(Level.debug,
            '===> FocuscBrand Trends Data Start ${stopWatch.elapsed.toString()}');
        _isFBTrendsLoading = true;
      } else if (type.startsWith('geo')) {
        Logger().log(Level.debug,
            '===> Focus Brand Geo Data Start ${stopWatch.elapsed.toString()}');
        _isFBGeoLoading = true;
      } else if (type.startsWith('category')) {
        //categoryFBList
        categoryFBList.clear();
        _isFBCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        _isFBChannelLoading = true;
        channelFBList.clear();
      } else {
        _isLoading = true;
      }
      update();
    });
    // debugPrint('=====>FocusBrand Type:$type Name: $name');
    Response response = await homeRepo.getFocusBrandData({
      "name": name,
      "type": type,
      "query": name.toLowerCase().startsWith('trend')
          ? [
              {
                "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                if (isTrendsFilter && _selectedTrendsGeoValue.isEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedTrendsGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (!isTrendsFilter)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Focus Area')
                              ? "site"
                              : _selectedTrendsGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeoValue,
                //
                if (selectedTrendsCategoryValue.isNotEmpty && !isTrendsFilter)
                  selectedTrendsCategory.toLowerCase().contains('brand form')
                          ? 'brandForm'
                          : selectedTrendsCategory.toLowerCase():
                      selectedTrendsCategoryValue,
                if (_selectedTrendsChannelValue.isNotEmpty)
                  selectedChannel.toLowerCase() == 'level 1'
                      ? 'attr1'
                      : selectedChannel.toLowerCase() == 'level 2'
                          ? 'attr2'
                          : selectedChannel.toLowerCase() == 'level 3'
                              ? 'attr3'
                              : selectedChannel.toLowerCase() == 'level 4'
                                  ? 'attr4'
                                  : selectedChannel.toLowerCase() == 'level 5'
                                      ? 'attr5'
                                      : 'attr1': _selectedTrendsChannelValue,
              },
            ]
          : type.startsWith('channel')
              ? allFilter ??
                  [
                    {
                      "date": "${selectedMonth.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.startsWith('Focus Area')
                                  ? "site"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedFBChannelFilter.isNotEmpty)
                        selectedFBChannel.toLowerCase() == 'level 1'
                            ? 'attr1'
                            : selectedFBChannel.toLowerCase() == 'level 2'
                                ? 'attr2'
                                : selectedFBChannel.toLowerCase() == 'level 3'
                                    ? 'attr3'
                                    : selectedFBChannel.toLowerCase() ==
                                            'level 4'
                                        ? 'attr4'
                                        : selectedFBChannel.toLowerCase() ==
                                                'level 5'
                                            ? 'attr5'
                                            : 'attr1': selectedFBChannelFilter,
                      if (selectedFBChannelFilter.isEmpty) "attr1": [],
                    }
                  ]
              : name.startsWith('geo')
                  ? allFilter ??
                      [
                        {
                          "date":
                              "${selectedMonth.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Focus Area')
                                      ? "site"
                                      : _selectedGeo.startsWith('Cluster')
                                          ? "district"
                                          : _selectedGeo.toLowerCase():
                              _selectedGeoValue,
                        },
                        ...selectedFBMultiAllIndia
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                        ...selectedFBMultiDivisions
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedFBMultiClusters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "district": e,
                                })
                            .toList(),
                        ...selectedFBMultiSites
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedFBMultiBranches
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date":
                                      "${selectedMonth.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date":
                            "${selectedMonth.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Focus Area')
                                    ? "site"
                                    : _selectedGeo.startsWith('Cluster')
                                        ? "district"
                                        : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedFBCategoryFilters.isNotEmpty)
                          selectedFBCategory
                                      .toLowerCase()
                                      .contains('brand form')
                                  ? 'brandForm'
                                  : selectedFBCategory
                                          .toLowerCase()
                                          .contains('sub-brand')
                                      ? 'subBrandForm'
                                      : selectedFBCategory.toLowerCase():
                              selectedFBCategoryFilters,
                        if (selectedFBCategoryFilters.isEmpty) 'category': []
                      },
                    ]
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        if (name.startsWith('trends')) {
          // Logger().f('===>Trends Data:${json.encode(response.body)}');
          trendsFBList = response.body["data"] == null
              ? []
              : List<FBTrendsModel>.from(
                  response.body["data"]!.map((x) => FBTrendsModel.fromJson(x)));
          // Logger()
          //     .f('===>Trends Data Length:${trendsFBList.first.data?.length}');
        } else {
          if (type.startsWith('geo')) {
            //CustomShimmer
            debugPrint('===>Geo Data:${json.encode(response.body)}');
            fbList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('category')) {
            // Logger().i('===>Category Data:${json.encode(response.body)}');
            categoryFBList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('channel')) {
            // Logger().f('===>Channel Data:${json.encode(response.body)}');
            debugPrint('===>FB Channel Data:${json.encode(response.body)}');
            channelFBList = response.body["data"] == null
                ? []
                : List<List<String>>.from(response.body["data"]
                    .map((x) => List<String>.from(x.map((x) => x.toString()))));
          } else if (type.startsWith('trends')) {
            // Logger().f('===>Trends Data:${json.encode(response.body)}');

            trendsFBList = response.body["data"] == null
                ? []
                : List<FBTrendsModel>.from(response.body["data"]!
                    .map((x) => FBTrendsModel.fromJson(x)));
          }
        }
//trendsList
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        // set value as empty
        // showCustomSnackBar(response.body["message"] ?? '');

        responseModel = ResponseModel(false, 'Somehting went wrong!');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      // Logger().e('==>Focus Brand $type $name ${response.body}');
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (name.startsWith('trends')) {
      Logger().log(Level.debug,
          '===> Focus Brand Trends Data end ${stopWatch.elapsed.toString()}');
      _isFBTrendsLoading = false;
    } else if (type.startsWith('geo')) {
      Logger().log(Level.debug,
          '===> Focus Brand Geo Data end ${stopWatch.elapsed.toString()}');
      _isFBGeoLoading = false;
    } else if (type.startsWith('category')) {
      Logger().log(Level.debug,
          '===> Focus Brand Category Data end ${stopWatch.elapsed.toString()}');
      _isFBCategoryLoading = false;
    } else if (type.startsWith('channel')) {
      Logger().log(Level.debug,
          '===> Focus Brand Channel Data end ${stopWatch.elapsed.toString()}');
      _isFBChannelLoading = false;
    } else {
      _isLoading = false;
    }
    stopWatch.stop();
    stopWatch.reset();
    update();
    return responseModel;
  }

  Future<ResponseModel> postPersonaSelected() async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Persona Selected ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(
        Level.debug, '===> FeedBack Start: ${stopWatch.elapsed.toString()}');
    SharedPreferences session = await SharedPreferences.getInstance();
    Response response = await homeRepo.getFeedback({
      "endPoint": "appPersona",
      "query": {
        "uid": session.getString(AppConstants.UID),
        "token": globals.FCMToken,
        "persona": "Sales Team",
        "geo": "allIndia",
        "module": "Business Overview"
      }
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        debugPrint('FeedBack ================= Success');
        responseModel = ResponseModel(true, 'Success');
      } else {
        debugPrint('FeedBack ================= Something went wrong');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    //Api Calling Response time
    Logger().log(
        Level.debug, '===> FeedBack End : ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    //
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postFeedbackReport(
      {required String userName,
      required String rating,
      required String feedback}) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs', parameters: {"message": 'Feed Back ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(
        Level.debug, '===> Feedback Start: ${stopWatch.elapsed.toString()}');

    Response response = await homeRepo.getFeedback({
      "endPoint": "feedbackMail",
      "userName": userName,
      "rating": rating,
      "feedback": feedback,
    });

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        print('Feedback ================= Success');
        responseModel = ResponseModel(true, 'Success');
        showCustomSnackBar("Thank you for your feedback.",
            isError: false, isBlack: false);
      } else {
        print('Feedback ================= Something went wrong');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    //Api Calling Response time
    Logger().log(
        Level.debug, '===> Feedback End : ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    //
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postBugReport(
      {required PickedFile file,
      required String title,
      required String comment}) async {
    FirebaseAnalytics.instance.logEvent(
        name: 'logs',
        parameters: {"message": 'Bugs Reported ${getUserName()}'});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger()
        .log(Level.debug, '===> Bug Start: ${stopWatch.elapsed.toString()}');
    Response response = await homeRepo.postBug({
      "endPoint": "feedbackMail",
      "userName": getUserName(),
      "title": title,
      "comment": comment,
    }, [
      MultipartBody('file', file)
    ]);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        print('Bug ================= Success');
        responseModel = ResponseModel(true, 'Success');
        showCustomSnackBar("Thank you for your feedback.",
            isError: false, isBlack: false);
      } else {
        print('Bug ================= Something went wrong');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        homeRepo.clearSharedData();
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    //Api Calling Response time
    Logger().log(Level.debug, '===> Bug End : ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    //
    _isFilterLoading = false;
    update();
    return responseModel;
  }
}
