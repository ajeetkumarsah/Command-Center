import 'package:flutter/material.dart';

import '../model/all_metrics.dart';
import '../web_dashboard/model/retailing_model.dart';

class SheetProvider extends ChangeNotifier {
  String division = '';
  String state = '';
  String month = '';
  String selectedMonth = '';
  String selectedCard = '';
  String selectedIcon = '';
  String selectedEl = '';
  String selectedChannel = '';
  String selectedChannelMonthFilter = '';
  String storeCoverageData = '';

  String selectedChannelSite = '';

  String selectedChannelDivision = '';
  String selectedCategoryChannel = '';
  String selectedCategoryFilter = '';
  String selectedCategoryFilterbr = '';
  String selectedCategoryFiltersbf = '';
  String selectedCategoryFiltersbfg = '';
  String selectedCategoryBodyFilter = '';
  int selectedChannelIndex = 0;

  int removeIndexFB = 0;
  int removeIndexGP = 0;
  int removeIndexCC = 0;
  int removeIndexRe = 0;

  int removeIndexRetailing = 0;
  int removeIndexGoldenPoint = 0;
  int removeIndexFocusBrand = 0;
  int removeIndexCoverage = 0;
  int removeIndexProductivity = 0;
  int removeIndexCallC = 0;

  int newIndex = -1;
  String selectedValue = 'All India';
  int selectedContainerIndex = 0;
  int removeIndex = -1;
  bool dailyReport = true;
  bool selectMonth = false;
  bool isLoaderActive = false;

  List<dynamic> allSummaryGPList = [];
  List<dynamic> allSummaryFBList = [];
  List<dynamic> allSummaryRetailingList = [];
  List<dynamic> allSummaryCCList = [];
  List<dynamic> allSummaryProdList = [];
  List<dynamic> allSummaryCoverageList = [];
  // bool isExpanded = false;
  List<AllMetrics> newItemList = [];
  List<dynamic> retailingList = [];
  List<dynamic> gpList = [];
  List<dynamic> coverageList = [];
  List<dynamic> fbList = [];
  List<dynamic> productivityList = [];
  List<dynamic> ccList = [];

  List get getRetailingItem => retailingList;

  List get getgpItem => gpList;

  List get getCoverageItem => coverageList;

  List get getfbItem => fbList;

  List get getproductivityItem => productivityList;

  List get getccItem => ccList;

  void addRetailingItem(item) {
    retailingList.add(item);
    notifyListeners();
  }

  void addGPItem(item) {
    gpList.add(item);
    notifyListeners();
  }

  void addCoverageItem(item) {
    coverageList.add(item);
    notifyListeners();
  }

  void addFBItem(item) {
    fbList.add(item);
    notifyListeners();
  }

  void addProductivityItem(item) {
    productivityList.add(item);
    notifyListeners();
  }

  void addccItem(item) {
    ccList.add(item);
    notifyListeners();
  }

  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  bool _isExpandedDivision = false;

  bool get isExpandedDivision => _isExpandedDivision;

  set isExpandedDivision(bool value) {
    _isExpandedDivision = value;
    notifyListeners();
  }

  bool _isExpandedBranch = false;

  bool get isExpandedBranch => _isExpandedBranch;

  set isExpandedBranch(bool value) {
    _isExpandedBranch = value;
    notifyListeners();
  }

  bool _isFilterSelected = false;

  bool get isFilterSelected => _isFilterSelected;

  set isFilterSelected(bool value) {
    _isFilterSelected = value;
    notifyListeners();
  }

  bool _isDefaultMonth = false;

  bool get isDefaultMonth => _isDefaultMonth;

  set isDefaultMonth(bool value) {
    _isDefaultMonth = value;
    notifyListeners();
  }

  bool _isCoverageGeoAdd = false;

  bool get isCoverageGeoAdd => _isCoverageGeoAdd;

  set isCoverageGeoAdd(bool value) {
    _isCoverageGeoAdd = value;
    notifyListeners();
  }

  bool _isExpandedChannel = false;

  bool get isExpandedChannel => _isExpandedChannel;

  set isExpandedChannel(bool value) {
    _isExpandedChannel = value;
    notifyListeners();
  }

  bool _isExpandedSubChannel = false;

  bool get isExpandedSubChannel => _isExpandedSubChannel;

  set isExpandedSubChannel(bool value) {
    _isExpandedSubChannel = value;
    notifyListeners();
  }

  bool _isSelectedChannel = false;

  bool get isSelectedChannel => _isSelectedChannel;

  set isSelectedChannel(bool value) {
    _isSelectedChannel = value;
    notifyListeners();
  }

  int _isCurrentTab = 0;

  int get isCurrentTab => _isCurrentTab;

  set isCurrentTab(int value) {
    _isCurrentTab = value;
    notifyListeners();
  }

  int _isCurrentTabGP = 0;

  int get setCurrentTabGP => _isCurrentTabGP;

  set setCurrentTabGP(int value) {
    _isCurrentTabGP = value;
    notifyListeners();
  }

  int _isCurrentTabCoverage = 0;

  int get setCurrentTabCoverage => _isCurrentTabCoverage;

  set setCurrentTabCoverage(int value) {
    _isCurrentTabCoverage = value;
    notifyListeners();
  }

  String _selectedChannelMonth = 'Select..';

  String get selectedChannelMonth => _selectedChannelMonth;

  set selectedChannelMonth(String value) {
    _selectedChannelMonth = value;
    notifyListeners();
  }

  String selectedChannelMonthData = 'Select..';

  bool _isExpandedMonthFilter = false;

  bool get isExpandedMonthFilter => _isExpandedMonthFilter;

  set isExpandedMonthFilter(bool value) {
    _isExpandedMonthFilter = value;
    notifyListeners();
  }

  String _selectedChannelFilter = 'Select..';

  String get selectedChannelFilter => _selectedChannelFilter;

  set selectedChannelFilter(String value) {
    _selectedChannelFilter = value;
    notifyListeners();
  }

  String _selectedChannelCategory = 'Select..';

  String get selectedChannelCategory => _selectedChannelCategory;

  set selectedChannelCategory(String value) {
    _selectedChannelCategory = value;
    notifyListeners();
  }

  String myStringFB = 'Select..';
  String myStringGP = 'Select..';
  String myStringCoverage = 'Select..';
  String myStringMonth = 'Jun-2023';
  String myStringMonthFB = 'Jun-2023';
  String myStringMonthGP = 'Jun-2023';
  int tabsIndex = 0;

  bool _isLoadedPage = true;

  bool get isLoadedPage => _isLoadedPage;

  set isLoadedPage(bool value) {
    _isLoadedPage = value;
    notifyListeners();
  }

  bool _isLoadingPage = false;

  bool get isLoadingPage => _isLoadingPage;

  set isLoadingPage(bool value) {
    _isLoadingPage = value;
    notifyListeners();
  }

  String channelFilterSelected = '';

  String selectedChannelFromAPI = '';
}
