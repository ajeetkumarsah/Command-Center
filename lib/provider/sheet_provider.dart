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
  int selectedChannelIndexFB = 0;
  int selectedChannelIndexGP = 0;

  int removeIndexFB = 0;
  int removeIndexGP = 0;
  int removeIndexCC = 0;
  int removeIndexRe = 0;

  int removeIndexRetailingSummary = 0;
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

  bool isMenuActive = false;
  bool isDivisionActive = false;
  bool isRemoveActive = false;

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
  List<dynamic> fbErrorMsg = [];
  List<dynamic> fb1ErrorMsg = [];
  List<dynamic> fb2ErrorMsg = [];
  List<dynamic> fb3ErrorMsg = [];
  List<dynamic> retailingErrorMsg = [];
  List<dynamic> retailing1ErrorMsg = [];
  List<dynamic> retailing2ErrorMsg = [];
  List<dynamic> retailing3ErrorMsg = [];
  List<dynamic> coverageErrorMsg = [];
  List<dynamic> coverage1ErrorMsg = [];
  List<dynamic> coverage2ErrorMsg = [];
  List<dynamic> coverage3ErrorMsg = [];
  List<dynamic> gpErrorMsg = [];
  List<dynamic> gp1ErrorMsg = [];
  List<dynamic> gp2ErrorMsg = [];
  List<dynamic> gp3ErrorMsg = [];

  List get getRetailingItem => retailingList;

  List get getgpItem => gpList;

  List get getCoverageItem => coverageList;

  List get getfbItem => fbList;

  List get getproductivityItem => productivityList;

  List get getccItem => ccList;

  void setFbErrorMsg(value){
    fbErrorMsg = value;
    notifyListeners();
  }

  void setFb1ErrorMsg(value){
    fb1ErrorMsg = value;
    notifyListeners();
  }

  void setFb2ErrorMsg(value){
    fb2ErrorMsg = value;
    notifyListeners();
  }

  void setFb3ErrorMsg(value){
    fb3ErrorMsg = value;
    notifyListeners();
  }

  void setRetailingErrorMsg(value){
    retailingErrorMsg = value;
    notifyListeners();
  }

  void setRetailing1ErrorMsg(value){
    retailing1ErrorMsg = value;
    notifyListeners();
  }

  void setRetailing2ErrorMsg(value){
    retailing2ErrorMsg = value;
    notifyListeners();
  }

  void setRetailing3ErrorMsg(value){
    retailing3ErrorMsg = value;
    notifyListeners();
  }

  void setCoverageErrorMsg(value){
    coverageErrorMsg = value;
    notifyListeners();
  }

  void setCoverage1ErrorMsg(value){
    coverage1ErrorMsg = value;
    notifyListeners();
  }

  void setCoverage2ErrorMsg(value){
    coverage2ErrorMsg = value;
    notifyListeners();
  }

  void setCoverage3ErrorMsg(value){
    coverage3ErrorMsg = value;
    notifyListeners();
  }

  void setGpErrorMsg(value){
    gpErrorMsg = value;
    notifyListeners();
  }

  void setGp1ErrorMsg(value){
    gp1ErrorMsg = value;
    notifyListeners();
  }

  void setGp2ErrorMsg(value){
    gp2ErrorMsg = value;
    notifyListeners();
  }

  void setGp3ErrorMsg(value){
    gp3ErrorMsg = value;
    notifyListeners();
  }

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

  bool _isExpandedCategoryFilter = false;

  bool get isExpandedCategoryFilter => _isExpandedCategoryFilter;

  set isExpandedCategoryFilter(bool value) {
    _isExpandedCategoryFilter = value;
    notifyListeners();
  }

  bool _isExpandedMonthCDFilter = false;

  bool get isExpandedMonthCDFilter => _isExpandedMonthCDFilter;

  set isExpandedMonthCDFilter(bool value) {
    _isExpandedMonthCDFilter = value;
    notifyListeners();
  }

  String _selectedChannelFilter = 'Select..';

  String get selectedChannelFilter => _selectedChannelFilter;

  set selectedChannelFilter(String value) {
    _selectedChannelFilter = value;
    notifyListeners();
  }

  List _selectedChannelCategory = ['Select..'];

  List get selectedChannelCategory => _selectedChannelCategory;

  set selectedChannelCategory(List value) {
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

  int _isCloseSelect = 0;

  int get isCloseSelect => _isCloseSelect;

  set isCloseSelect(int value) {
    _isCloseSelect = value;
    notifyListeners();
  }

  int _isCloseSelectCD = 0;

  int get isCloseSelectCD => _isCloseSelectCD;

  set isCloseSelectCD(int value) {
    _isCloseSelectCD = value;
    notifyListeners();
  }

  String channelFilterSelected = '';

  List selectedChannelFromAPI = [];
}
