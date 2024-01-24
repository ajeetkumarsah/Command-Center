import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
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
import 'package:command_centre/mobile_dashboard/data/models/response/retailing_geo_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/coverage_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/retailing_trends_model.dart';


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
      _isSummaryDirect = true,
      _isDirectIndirectLoading = false,
      _isSummaryPageLoading = false,
      _isRetailingDeepDiveInd = true;
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
      _fbTrendsValue = '';

  String get retailingTrendsValue => _retailingTrendsValue;
  String get coverageTrendsValue => _coverageTrendsValue;
  String get gpTrendsValue => _gpTrendsValue;
  String get fbTrendsValue => _fbTrendsValue;
  String _selectedCoverageTrendsFilter = 'Billing %';
  String get selectedCoverageTrendsFilter => _selectedCoverageTrendsFilter;
  String _selectedTrends = 'Channel';
  String get selectedTrends => _selectedTrends;
  String _selectedCoverageTrends = 'Channel';
  String get selectedCoverageTrends => _selectedCoverageTrends;
  String _selectedGPTrends = 'Channel';
  String get selectedGPTrends => _selectedGPTrends;
  String _selectedFBTrends = 'Channel';
  String get selectedFBTrends => _selectedFBTrends;

  String _selectedChannel = 'attr1';
  String get selectedChannel => _selectedChannel;
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

  String? _selectedMonth = 'Dec-2023';
  String? get selectedMonth => _selectedMonth;
  String? _selectedYear = '2023';
  String? get selectedYear => _selectedYear;
  String? _selectedTempMonth = 'Dec-2023';
  String? get selectedTempMonth => _selectedTempMonth;
  String? _selectedTempYear = 'Date';
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
      selectedRetailingChannelFilter = [],
      selectedCoverageChannelFilter = [],
      selectedGPChannelFilter = [],
      selectedFBChannelFilter = [],
      // selectedMultiDivisions = [],
      selectedRetailingMultiAllIndia = [],
      selectedFBMultiAllIndia = [],
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
      selectedMultiBranches = [];
  List<String> activeMetrics = [
        'Retailing',
        'Coverage',
        'Golden Points',
        'Focus Brand'
      ],
      moreMetrics = ['Shipment (TBD)']; // 'Inventory'
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

  void getReatilingInit() {
    _isRetailingDeepDiveInd = true;
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
    if (selectedGeo == 'All India') {
      _isSummaryDirect = value;
    }
    update();
  }

  void onChangeDeepDiveIndirect(bool value) {
    if (selectedGeo == 'All India') {
      _isRetailingDeepDiveInd = value;
    }
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

  void onChangeCategory1(String value, {required String tabType}) {
    if (tabType == SummaryTypes.retailing.type) {
      _selectedCategory = value;
    } else if (tabType == SummaryTypes.gp.type) {
      _selectedGPCategory = value;
    } else if (tabType == SummaryTypes.fb.type) {
      _selectedFBCategory = value;
    }

    update();
  }

  void onChangeCategory(String value, String category, {bool isInit = false}) {
    // _selectedTempCategory = category;
    // if (!isInit) selectedCategoryFilters.clear();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  void onChangeTrendsCategoryValue(String value) {
    _selectedTrendsCategory = value;

    update();
  }

  void onChangeTrendsCategory(String value) {
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

  void onChangeChannel1(String value) {
    _selectedChannel = value;
    update();
  }

  void onChangeTrendsChannel(String value) {
    _selectedTrendsChannel = value;
    update();
  }

  void onChangeChannel(String value, String tabType) {
    // if (tabType == SummaryTypes.retailing.type) {
    //   selectedRetailingChannelFilter.clear();
    // } else if (tabType == SummaryTypes.coverage.type) {
    //   selectedCoverageChannelFilter.clear();
    // } else if (tabType == SummaryTypes.gp.type) {
    //   selectedGPChannelFilter.clear();
    // } else if (tabType == SummaryTypes.fb.type) {
    //   selectedFBChannelFilter.clear();
    // }
    if (tabType == SummaryTypes.retailing.type) {
      if (filtersModel != null) {
        if (value.toLowerCase().startsWith('level 1')) {
          debugPrint('===> $value');
          channelFilter = filtersModel?.attr1 ?? [];
        } else if (value.toLowerCase().startsWith('level 2')) {
          debugPrint('===> $value  ==>${filtersModel?.attr2}');
          channelFilter = filtersModel?.attr2 ?? [];
        } else if (value.toLowerCase().startsWith('level 3')) {
          channelFilter = filtersModel?.attr3 ?? [];
        } else if (value.toLowerCase().startsWith('level 4')) {
          channelFilter = filtersModel?.attr4 ?? [];
        } else if (value.toLowerCase().startsWith('level 5')) {
          channelFilter = filtersModel?.attr5 ?? [];
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            channelFilter = filtersModel?.attr1 ?? [];
          } else if (value.toLowerCase().startsWith('level 2')) {
            channelFilter = filtersModel?.attr2 ?? [];
          } else if (value.toLowerCase().startsWith('level 3')) {
            channelFilter = filtersModel?.attr3 ?? [];
          } else if (value.toLowerCase().startsWith('level 4')) {
            channelFilter = filtersModel?.attr4 ?? [];
          } else if (value.toLowerCase().startsWith('level 5')) {
            channelFilter = filtersModel?.attr5 ?? [];
          }
        });
      }
    } else {
      if (filtersModel != null) {
        if (value.toLowerCase().startsWith('level 1')) {
          debugPrint('===> $value');
          channelFilter = filtersModel?.otherAttrs?.attr1 ?? [];
        } else if (value.toLowerCase().startsWith('level 2')) {
          debugPrint('===> $value  ==>${filtersModel?.attr2}');
          channelFilter = filtersModel?.otherAttrs?.attr2 ?? [];
        } else if (value.toLowerCase().startsWith('level 3')) {
          channelFilter = filtersModel?.otherAttrs?.attr3 ?? [];
        } else if (value.toLowerCase().startsWith('level 4')) {
          channelFilter = filtersModel?.otherAttrs?.attr4 ?? [];
        } else if (value.toLowerCase().startsWith('level 5')) {
          channelFilter = filtersModel?.otherAttrs?.attr5 ?? [];
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            channelFilter = filtersModel?.otherAttrs?.attr1 ?? [];
          } else if (value.toLowerCase().startsWith('level 2')) {
            channelFilter = filtersModel?.otherAttrs?.attr2 ?? [];
          } else if (value.toLowerCase().startsWith('level 3')) {
            channelFilter = filtersModel?.otherAttrs?.attr3 ?? [];
          } else if (value.toLowerCase().startsWith('level 4')) {
            channelFilter = filtersModel?.otherAttrs?.attr4 ?? [];
          } else if (value.toLowerCase().startsWith('level 5')) {
            channelFilter = filtersModel?.otherAttrs?.attr5 ?? [];
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
          channelTrendsFilter = filtersModel?.attr1 ?? [];
        } else if (value.toLowerCase().startsWith('level 2')) {
          channelTrendsFilter = filtersModel?.attr2 ?? [];
        } else if (value.toLowerCase().startsWith('level 3')) {
          channelTrendsFilter = filtersModel?.attr3 ?? [];
        } else if (value.toLowerCase().startsWith('level 4')) {
          channelTrendsFilter = filtersModel?.attr4 ?? [];
        } else if (value.toLowerCase().startsWith('level 5')) {
          channelTrendsFilter = filtersModel?.attr5 ?? [];
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            channelTrendsFilter = filtersModel?.attr1 ?? [];
          } else if (value.toLowerCase().startsWith('level 2')) {
            channelTrendsFilter = filtersModel?.attr2 ?? [];
          } else if (value.toLowerCase().startsWith('level 3')) {
            channelTrendsFilter = filtersModel?.attr3 ?? [];
          } else if (value.toLowerCase().startsWith('level 4')) {
            channelTrendsFilter = filtersModel?.attr4 ?? [];
          } else if (value.toLowerCase().startsWith('level 5')) {
            channelTrendsFilter = filtersModel?.attr5 ?? [];
          }
        });
      }
    } else {
      debugPrint('===>Onchange ${filtersModel?.otherAttrs?.attr1.toString()}');
      if (filtersModel != null) {
        if (value.toLowerCase().startsWith('level 1')) {
          channelTrendsFilter = filtersModel?.otherAttrs?.attr1 ?? [];
        } else if (value.toLowerCase().startsWith('level 2')) {
          channelTrendsFilter = filtersModel?.otherAttrs?.attr2 ?? [];
        } else if (value.toLowerCase().startsWith('level 3')) {
          channelTrendsFilter = filtersModel?.otherAttrs?.attr3 ?? [];
        } else if (value.toLowerCase().startsWith('level 4')) {
          channelTrendsFilter = filtersModel?.otherAttrs?.attr4 ?? [];
        } else if (value.toLowerCase().startsWith('level 5')) {
          channelTrendsFilter = filtersModel?.otherAttrs?.attr5 ?? [];
        }
      } else {
        getAllFilters().then((v) {
          if (value.toLowerCase().startsWith('level 1')) {
            channelTrendsFilter = filtersModel?.otherAttrs?.attr1 ?? [];
          } else if (value.toLowerCase().startsWith('level 2')) {
            channelTrendsFilter = filtersModel?.otherAttrs?.attr2 ?? [];
          } else if (value.toLowerCase().startsWith('level 3')) {
            channelTrendsFilter = filtersModel?.otherAttrs?.attr3 ?? [];
          } else if (value.toLowerCase().startsWith('level 4')) {
            channelTrendsFilter = filtersModel?.otherAttrs?.attr4 ?? [];
          } else if (value.toLowerCase().startsWith('level 5')) {
            channelTrendsFilter = filtersModel?.otherAttrs?.attr5 ?? [];
          }
        });
      }
    }

    update();
  }

  void onChangeCategoryValue(String value, String cat) {
    if (_selectedTempCategory.toLowerCase() != cat.toLowerCase()) {
      _selectedTempCategory = cat;
      selectedCategoryFilters.clear();
    }
    if (selectedCategoryFilters.contains(value)) {
      selectedCategoryFilters.remove(value);
    } else {
      selectedCategoryFilters.add(value);
    }
    update();
  }

  void onChangeCategoryTrendsValue(String value, String tabType) {
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

  void onChangeFiltersAll({type = 'branch'}) {
    if (type == 'branch') {
      if (eq(selectedMultiFilters, branchFilter)) {
        selectedMultiFilters.clear();
      } else {
        selectedMultiFilters.clear();
        selectedMultiFilters.addAll(branchFilter);
      }
    } else if (type == 'category') {
      if (eq(selectedCategoryFilters, categoryFilters)) {
        selectedCategoryFilters.clear();
      } else {
        selectedCategoryFilters.clear();
        selectedCategoryFilters.addAll(categoryFilters);
      }
    }

    update();
  }

  void onChangeChannelValue(String value, String tabType, String channel) {
    if (tabType == SummaryTypes.retailing.type) {
      if (_selectedTempRetailingChannel != channel) {
        _selectedTempRetailingChannel = channel;
        selectedRetailingChannelFilter.clear();
      }
      if (selectedRetailingChannelFilter.contains(value)) {
        selectedRetailingChannelFilter.remove(value);
      } else {
        selectedRetailingChannelFilter.add(value);
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      if (_selectedTempCoverageChannel != channel) {
        _selectedTempCoverageChannel = channel;
        selectedRetailingChannelFilter.clear();
      }
      if (selectedCoverageChannelFilter.contains(value)) {
        selectedCoverageChannelFilter.remove(value);
      } else {
        selectedCoverageChannelFilter.add(value);
      }
    } else if (tabType == SummaryTypes.gp.type) {
      if (_selectedTempGPChannel != channel) {
        _selectedTempGPChannel = channel;
        selectedRetailingChannelFilter.clear();
      }
      if (selectedGPChannelFilter.contains(value)) {
        selectedGPChannelFilter.remove(value);
      } else {
        selectedGPChannelFilter.add(value);
      }
    } else if (tabType == SummaryTypes.fb.type) {
      if (_selectedTempFBChannel != channel) {
        _selectedTempFBChannel = channel;
        selectedRetailingChannelFilter.clear();
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

  void onChangeChannelAllSelect(String tabType) {
    if (tabType == SummaryTypes.retailing.type) {
      if (eq(selectedRetailingChannelFilter, channelFilter)) {
        debugPrint('===>Select All Clear');
        selectedRetailingChannelFilter.clear();
      } else {
        debugPrint('===>Select All ADD');
        selectedRetailingChannelFilter.addAll(channelFilter);
      }
    } else if (tabType == SummaryTypes.coverage.type) {
      if (eq(selectedCoverageChannelFilter, channelFilter)) {
        debugPrint('===>Select All Clear');
        selectedCoverageChannelFilter.clear();
      } else {
        debugPrint('===>Select All ADD');
        selectedCoverageChannelFilter.addAll(channelFilter);
      }
    } else if (tabType == SummaryTypes.gp.type) {
      if (eq(selectedGPChannelFilter, channelFilter)) {
        debugPrint('===>Select All Clear');
        selectedGPChannelFilter.clear();
      } else {
        debugPrint('===>Select All ADD');
        selectedGPChannelFilter.addAll(channelFilter);
      }
    } else if (tabType == SummaryTypes.fb.type) {
      if (eq(selectedFBChannelFilter, channelFilter)) {
        debugPrint('===>Select All Clear');
        selectedFBChannelFilter.clear();
      } else {
        debugPrint('===>Select All ADD');
        selectedFBChannelFilter.addAll(channelFilter);
      }
    }

    update();
  }

  void onTrendsFilterSelect(String value, String tabType) {
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
        "date": selectedMonth,
        //"${selectedMonth!.substring(0, 3)}-$selectedYear",
        _selectedGeo.startsWith('All India')
            ? "allIndia"
            : _selectedGeo.startsWith('Site')
                ? "site"
                : _selectedGeo.startsWith('Cluster')
                    ? "district"
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

  void getInitValues({bool getOnlyShared = false}) async {
    // getPersonalizedData();
    if (getMonth().trim().isNotEmpty) {
      _selectedMonth = getMonth();
      _selectedTempMonth = getMonth();
    }
    if (getYear().trim().isNotEmpty) {
      _selectedYear = getYear();
      // _selectedTempYear = getYear();
    }
    if (getGeo().trim().isNotEmpty) {
      _selectedTempGeo = getGeo();
      debugPrint('===>Selected Geo : $selectedGeo');
      _selectedGeo = getGeo();
      _selectedTrendsGeo = getGeo();
      _selectedTrendsGeoValue = getGeoValue();
      onGeoChange(_selectedGeo);
    }
    if (getGeoValue().trim().isNotEmpty) {
      _selectedTempGeoValue = getGeoValue();
      _selectedGeoValue = getGeoValue();
      _selectedTrendsGeoValue = getGeoValue();
    }
    if (!getOnlyShared) {
      var futures = await Future.wait([
        getSummaryData(),
        getAllFilters().then((value) {
          categoryFilters = filtersModel?.category ?? [];
          categoryTrendsFilters = filtersModel?.category ?? [];
          channelFilter = filtersModel?.attr1 ?? [];
          channelTrendsFilter = filtersModel?.attr1 ?? [];
        }),
      ]);
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
    // _selectedTempYear = value;
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
      {bool isLoadRetailing = false, String tabType = 'Retailing'}) async {
    _selectedMonth = _selectedTempMonth;
    setMonth(_selectedTempMonth ?? '');
    await getSummaryData();
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
        reloadAllDeepDive();
      }
    }
    update();
  }

  void onMultiGeoChange(String value) {
    _selectedMultiGeo = value;
    update();
  }

  void onGeoChange(String value, {bool isMultiSelect = false}) {
    if (isMultiSelect) {
      //multiFilters

      selectedMultiFilters.clear();
      if (filtersModel != null) {
        if (value.startsWith('All India')) {
          multiFilters = ['All India'];
        } else if (value.startsWith('Division')) {
          multiFilters = filtersModel!.division;
        } else if (value.startsWith('Cluster')) {
          multiFilters = filtersModel!.district;
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
            multiFilters = filtersModel?.district ?? [];
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
          filters = filtersModel!.district;
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
            filters = filtersModel?.district ?? [];
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

  void onChangeGeoTrends(String value) {
    _selectedTrendsGeo = value;
    selectedRetailingChannelFilter.clear();
    selectedCoverageChannelFilter.clear();
    selectedGPChannelFilter.clear();
    selectedFBChannelFilter.clear();
    // _selectedTrendsCategoryValue = '';
    // _gpTrendsValue = '';
    update();
  }

  void onTrendsGeoChange(String value) {
    _selectedTrendsChannelValue = '';
    _gpTrendsValue = '';
    if (filtersModel != null) {
      if (value.startsWith('All India')) {
        trendsFilter = ['All India'];
      } else if (value.startsWith('Division')) {
        trendsFilter = filtersModel!.division;
      } else if (value.startsWith('Cluster')) {
        trendsFilter = filtersModel!.district;
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
          trendsFilter = filtersModel?.district ?? [];
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
      {bool isLoadRetailing = false, String tabType = 'Retailing'}) async {
    debugPrint(
        '===>selected Filter $selectedTempGeo  -- $selectedTempGeoValue');
    _selectedGeo = _selectedTempGeo;
    _selectedGeoValue = _selectedTempGeoValue;
    if (_selectedGeo == 'All India') {
    } else {
      _isRetailingDeepDiveInd = true;
      _isSummaryDirect = true;
    }

    saveGeo(_selectedTempGeo);
    saveGeoValue(_selectedTempGeoValue);
    await getSummaryData();
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

  void onApplyMultiFilter(
    String name,
    String type, {
    String tabType = 'Retailing',
    bool isTrendsFilter = false,
  }) {
    if (SummaryTypes.retailing.type == tabType) {
      //retailing screen data
      getRetailingData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    } else if (SummaryTypes.coverage.type == tabType) {
      //Coverage screen data
      getCoverageData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    } else if (SummaryTypes.gp.type == tabType) {
      //retailing screen data
      getGPData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    } else if (SummaryTypes.fb.type == tabType) {
      //retailing screen data
      getFocusBrandData(type: type, name: name, isTrendsFilter: isTrendsFilter);
    }
    update();
  }

  void onChangeFilters(String value) {
    _selectedTempGeoValue = value;
    update();
  }

  void onChangeTrendsFilters(String value, String tabType) {
    _selectedTrendsGeoValue = value;
    _selectedTrendsCategoryValue = '';
    _selectedTrendsChannelValue = '';

    if (tabType == SummaryTypes.retailing.type) {
      _retailingTrendsValue = value;
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

  void clearMultiFilter(String name, String type,
      {String tabType = 'Retailing'}) {
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
    selectedMultiBranches.clear();
    selectedMultiFilters.clear();
    onApplyMultiFilter(name, type, tabType: tabType);
  }

  void onChangeMultiFilters(String value,
      {String tabType = 'retailing', required String selectedMultiGeoFilter}) {
    //

    if (selectedMultiGeoFilter == 'All India') {
      // selectedRetailingMultiAllIndia
      debugPrint('====>All India $value');
      if (tabType == SummaryTypes.retailing.type) {
        if (selectedRetailingMultiAllIndia.contains(value)) {
          selectedRetailingMultiAllIndia.remove(value);
        } else {
          selectedRetailingMultiAllIndia.add(value);
        }
      }
      //  else if (tabType == SummaryTypes.coverage.type) {
      //   if (selectedCoverageMultiDivisions.contains(value)) {
      //     selectedCoverageMultiDivisions.remove(value);
      //   } else {
      //     selectedCoverageMultiDivisions.add(value);
      //   }
      // } else if (tabType == SummaryTypes.gp.type) {
      //   if (selectedGPMultiDivisions.contains(value)) {
      //     selectedGPMultiDivisions.remove(value);
      //   } else {
      //     selectedGPMultiDivisions.add(value);
      //   }
      // }
      else if (tabType == SummaryTypes.fb.type) {
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
    } else if (selectedMultiGeoFilter.toLowerCase() == 'Site'.toLowerCase()) {
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

  bool getPersona() {
    return homeRepo.getPersona();
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
  List<String> monthFilters = [];
  List<TrendsModel> trendsList = [];
  List<CoverageTrendsModel> trendsCoverageList = [];
  List<GPTrendsModel> trendsGPList = [];
  List<FBTrendsModel> trendsFBList = [];
  List<Map<String, dynamic>> geoFilters = [];

  Future<ResponseModel> getSummaryData() async {
    _isSummaryPageLoading = true;
    update();
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(Level.debug,
        '===> Summary Data Start: ${stopWatch.elapsed.toString()}');

    Response response = await homeRepo.getSummaryData({
      "date": _selectedTempMonth,
      //"${selectedMonth!.substring(0, 3)}-$selectedYear",
      _selectedGeo.startsWith('All India')
              ? "allIndia"
              : _selectedGeo.startsWith('Site')
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
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    Logger().log(
        Level.debug, '===> Summary Data End: ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    _isSummaryPageLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getMonthFilters({String year = '2023'}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
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
        final data = response.body["data"];
        if (data != null) {
          monthFilters = List<String>.from(data!.map((x) => x));
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
    //Api Calling Response time
    Logger().log(
        Level.debug, '===> Filter Data End : ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    //
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getRetailingData(
      {String type = 'geo',
      String name = 'geo',
      bool isTrendsFilter = false,
      List<Map<String, dynamic>>? allFilter}) async {
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();

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
        RetailingGeoModel categoryListTemp =
            RetailingGeoModel(ind: [], indDir: []);
        categoryListTemp.ind?.addAll(categoryRetailingModel?.ind ?? []);
        categoryListTemp.indDir?.addAll(categoryRetailingModel?.indDir ?? []);
        categoryRetailingModel = RetailingGeoModel(ind: [], indDir: []);
        categoryRetailingModel?.ind?.add(categoryListTemp.ind?[0] ?? []);
        categoryRetailingModel?.indDir?.add(categoryListTemp.indDir?[0] ?? []);
        Logger().log(Level.debug,
            '===> Retailing Category Data Start ${stopWatch.elapsed.toString()}');
      } else if (type.startsWith('channel')) {
        _isRetailingChannelLoading = true;
        RetailingGeoModel channelListTemp =
            RetailingGeoModel(ind: [], indDir: []);
        channelListTemp.ind?.addAll(channelRetailingModel?.ind ?? []);
        channelListTemp.indDir?.addAll(channelRetailingModel?.indDir ?? []);
        channelRetailingModel = RetailingGeoModel(ind: [], indDir: []);
        channelRetailingModel?.ind?.add(channelListTemp.ind?[0] ?? []);
        channelRetailingModel?.indDir?.add(channelListTemp.indDir?[0] ?? []);
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
                "date": _selectedTempMonth,
                if (isTrendsFilter && _selectedTrendsGeoValue.isEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (!isTrendsFilter)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
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
              ? allFilter ??
                  [
                    {
                      "date": _selectedTempMonth,
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedRetailingChannelFilter.isNotEmpty)
                        selectedChannel.toLowerCase() == 'level 1'
                                ? 'attr1'
                                : selectedChannel.toLowerCase() == 'level 2'
                                    ? 'attr2'
                                    : selectedChannel.toLowerCase() == 'level 3'
                                        ? 'attr3'
                                        : selectedChannel.toLowerCase() == 'level 4'
                                            ? 'attr4'
                                            : selectedChannel.toLowerCase() ==
                                                    'level 5'
                                                ? 'attr5'
                                                : 'attr1':
                            selectedRetailingChannelFilter,
                      if (selectedRetailingChannelFilter.isEmpty) "attr1": [],
                    }
                  ]
              : name.startsWith('geo')
                  ? allFilter ??
                      [
                        {
                          "date": selectedTempMonth,
                          // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                        },
                        ...selectedRetailingMultiAllIndia
                            .map((e) => {
                                  "date": _selectedTempMonth,
                                  "allIndia": e,
                                })
                            .toList(),
                        ...selectedRetailingMultiDivisions
                            .map((e) => {
                                  "date": _selectedTempMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedRetailingMultiClusters
                            .map((e) => {
                                  "date": _selectedTempMonth,
                                  // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "district": e,
                                })
                            .toList(),
                        ...selectedRetailingMultiSites
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedMultiBranches
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date": selectedMonth,
                        // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedCategoryFilters.isNotEmpty)
                          selectedCategory.toLowerCase().contains('sub-brand')
                                  ? 'subBrandForm'
                                  : selectedCategory
                                          .toLowerCase()
                                          .contains('brand form')
                                      ? 'brandForm'
                                      : selectedCategory.toLowerCase():
                              selectedCategoryFilters,

                        if (selectedCategoryFilters.isEmpty) "category": [],
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
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
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
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
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
                "date": selectedMonth,
                if (isTrendsFilter && _selectedTrendsGeoValue.isEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (!isTrendsFilter)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
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
                      "date": selectedMonth,
                      //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedCoverageChannelFilter.isNotEmpty)
                        selectedChannel.toLowerCase() == 'level 1'
                                ? 'attr1'
                                : selectedChannel.toLowerCase() == 'level 2'
                                    ? 'attr2'
                                    : selectedChannel.toLowerCase() == 'level 3'
                                        ? 'attr3'
                                        : selectedChannel.toLowerCase() == 'level 4'
                                            ? 'attr4'
                                            : selectedChannel.toLowerCase() ==
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
                          "date": selectedMonth,
                          //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                        },
                        ...selectedCoverageMultiDivisions
                            .map((e) => {
                                  "date": selectedMonth,
                                  // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedCoverageMultiClusters
                            .map((e) => {
                                  "date": selectedMonth,
                                  // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "district": e,
                                })
                            .toList(),
                        ...selectedCoverageMultiSites
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedMultiBranches
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date": selectedMonth,
                                  // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date": selectedMonth,
                        // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
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
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
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
      bool isTrendsFilter = false,
      List<Map<String, dynamic>>? allFilter}) async {
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();

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
        List<List<String>> categoryListTemp = [];
        categoryListTemp.addAll(categoryGPList);
        categoryGPList.clear();
        categoryGPList.add(categoryListTemp[0]);
        Logger().log(Level.debug,
            '===> Golden Points Category Data Start ${stopWatch.elapsed.toString()}');
        _isGPCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        List<List<String>> channelListTemp = [];
        channelListTemp.addAll(channelGPList);
        channelGPList.clear();
        channelGPList.add(channelListTemp[0]);
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
                  "date": selectedMonth,

                  if (!isTrendsFilter)
                    _selectedGeo.startsWith('All India')
                            ? "allIndia"
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
                            : _selectedTrendsGeo.startsWith('Cluster')
                                ? "district"
                                : _selectedTrendsGeo.toLowerCase():
                        _selectedTrendsGeo.startsWith('All India')
                            ? "allIndia"
                            : _selectedTrendsGeoValue,
                  if (!isTrendsFilter)
                    _selectedGeo.startsWith('All India')
                            ? "allIndia"
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
                ? allFilter ??
                    [
                      {
                        "date": selectedMonth,
                        //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,

                        if (selectedGPChannelFilter.isNotEmpty)
                          selectedChannel.toLowerCase() == 'level 1'
                              ? 'attr1'
                              : selectedChannel.toLowerCase() == 'level 2'
                                  ? 'attr2'
                                  : selectedChannel.toLowerCase() == 'level 3'
                                      ? 'attr3'
                                      : selectedChannel.toLowerCase() ==
                                              'level 4'
                                          ? 'attr4'
                                          : selectedChannel.toLowerCase() ==
                                                  'level 5'
                                              ? 'attr5'
                                              : 'attr1': selectedGPChannelFilter,
                        if (selectedGPChannelFilter.isEmpty) "attr1": [],
                      }
                    ]
                : name.startsWith('geo')
                    ? allFilter ??
                        [
                          {
                            "date": selectedMonth,
                            //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                            _selectedGeo.startsWith('All India')
                                    ? "allIndia"
                                    : _selectedGeo.startsWith('Cluster')
                                        ? "district"
                                        : _selectedGeo.toLowerCase():
                                _selectedGeo.startsWith('All India')
                                    ? "allIndia"
                                    : _selectedGeoValue,
                          },
                          ...selectedGPMultiDivisions
                              .map((e) => {
                                    "date": selectedMonth,
                                    // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "division": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedGPMultiClusters
                              .map((e) => {
                                    "date": selectedMonth,
                                    // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "district": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedGPMultiSites
                              .map((e) => {
                                    "date": selectedMonth,
                                    // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "site": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedMultiBranches
                              .map((e) => {
                                    "date": selectedMonth,
                                    // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "branch": e,
                                    "category": [],
                                  })
                              .toList(),
                          ...selectedMultiFilters
                              .map((e) => {
                                    "date": selectedMonth,
                                    // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                    "allIndia": e,
                                    "category": [],
                                  })
                              .toList(),
                        ]
                    : [
                        {
                          "date": selectedMonth,
                          // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                          if (selectedCategoryFilters.isNotEmpty)
                            _selectedGPCategory
                                        .toLowerCase()
                                        .contains('sub-brand')
                                    ? 'subBrandGroup'
                                    : _selectedGPCategory
                                            .toLowerCase()
                                            .contains('brand form')
                                        ? 'brandForm'
                                        : _selectedGPCategory.toLowerCase():
                                selectedCategoryFilters,
                          if (selectedCategoryFilters.isEmpty) 'category': []
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
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
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
        if (categoryFBList.isNotEmpty) {
          List<List<String>> categoryListTemp = [];
          categoryListTemp.addAll(categoryFBList);
          categoryFBList.clear();
          categoryFBList.add(categoryListTemp[0]);
        }

        Logger().log(Level.debug,
            '===> Focus Brand Category Data Start ${stopWatch.elapsed.toString()}');
        _isFBCategoryLoading = true;
      } else if (type.startsWith('channel')) {
        _isFBChannelLoading = true;

        if (channelFBList.isNotEmpty) {
          List<List<String>> channelListTemp = [];
          channelListTemp.addAll(channelFBList);
          channelFBList.clear();
          channelFBList.add(channelListTemp[0]);
        }
        Logger().log(Level.debug,
            '===> Focus Brand Channel Data Start ${stopWatch.elapsed.toString()}');
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
                "date": selectedMonth,
                if (isTrendsFilter && _selectedTrendsGeoValue.isEmpty)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedTrendsGeo.toLowerCase():
                      _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedTrendsGeoValue,
                if (!isTrendsFilter)
                  _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeo.startsWith('Cluster')
                              ? "district"
                              : _selectedGeo.toLowerCase():
                      _selectedGeo.startsWith('All India')
                          ? "allIndia"
                          : _selectedGeoValue,
                if (_selectedTrendsGeoValue.isNotEmpty && isTrendsFilter)
                  _selectedTrendsGeo.startsWith('All India')
                          ? "allIndia"
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
                      "date": selectedMonth,
                      // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                      _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeo.startsWith('Cluster')
                                  ? "district"
                                  : _selectedGeo.toLowerCase():
                          _selectedGeo.startsWith('All India')
                              ? "allIndia"
                              : _selectedGeoValue,
                      if (selectedFBChannelFilter.isNotEmpty)
                        selectedChannel.toLowerCase() == 'level 1'
                            ? 'attr1'
                            : selectedChannel.toLowerCase() == 'level 2'
                                ? 'attr2'
                                : selectedChannel.toLowerCase() == 'level 3'
                                    ? 'attr3'
                                    : selectedChannel.toLowerCase() == 'level 4'
                                        ? 'attr4'
                                        : selectedChannel.toLowerCase() ==
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
                          "date": selectedMonth,
                          //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                          _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeo.startsWith('Cluster')
                                      ? "district"
                                      : _selectedGeo.toLowerCase():
                              _selectedGeo.startsWith('All India')
                                  ? "allIndia"
                                  : _selectedGeoValue,
                        },
                        ...selectedFBMultiDivisions
                            .map((e) => {
                                  "date": selectedMonth,
                                  // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "division": e,
                                })
                            .toList(),
                        ...selectedFBMultiClusters
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "district": e,
                                })
                            .toList(),
                        ...selectedFBMultiSites
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "site": e,
                                })
                            .toList(),
                        ...selectedMultiBranches
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "branch": e,
                                })
                            .toList(),
                        ...selectedMultiFilters
                            .map((e) => {
                                  "date": selectedMonth,
                                  //"${selectedMonth!.substring(0, 3)}-$selectedYear",
                                  "allIndia": e,
                                })
                            .toList(),
                      ]
                  : [
                      {
                        "date": selectedMonth,
                        // "${selectedMonth!.substring(0, 3)}-$selectedYear",
                        _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeo.startsWith('Cluster')
                                    ? "district"
                                    : _selectedGeo.toLowerCase():
                            _selectedGeo.startsWith('All India')
                                ? "allIndia"
                                : _selectedGeoValue,
                        if (selectedCategoryFilters.isNotEmpty)
                          selectedFBCategory
                                      .toLowerCase()
                                      .contains('brand form')
                                  ? 'brandForm'
                                  : selectedFBCategory
                                          .toLowerCase()
                                          .contains('sub-brand')
                                      ? 'subBrandForm'
                                      : selectedFBCategory.toLowerCase():
                              selectedCategoryFilters,
                        if (selectedCategoryFilters.isEmpty) 'category': []
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
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
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
}
