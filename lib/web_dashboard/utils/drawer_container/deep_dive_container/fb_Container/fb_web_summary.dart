import 'package:command_centre/web_dashboard/utils/comman_utils/excel_button.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/back_button_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/custom_header_title_category.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/custome_header_title.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_geo_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_month_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/table_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_body_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_sizedbox_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_all_category.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/allIndia_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/category_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/division_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/month_wise_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/site_table.dart';
import 'package:command_centre/web_dashboard/utils/table/table_tabs/division_table_tab.dart';
import 'package:command_centre/web_dashboard/utils/table/table_tabs/site_table_tab.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../model/data_table_model.dart';
import '../../../../../../provider/sheet_provider.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../utils/style/text_style.dart';

class FBWebSummary extends StatefulWidget {
  final Function() onTap;
  final Function() onApplyPressedMonth;
  final Function() onApplyPressedMonthCHRTab;
  final int selectedIndex;
  final bool highlighted;
  final bool addMonthBool;
  final List divisionList;
  final List siteList;
  final List branchList;
  final int selectedGeo;
  final List clusterList;
  final List<dynamic> dataList;
  final List<dynamic> dataListTabs;
  final List<dynamic> dataListBillingTabs;
  final List<dynamic> dataListCCTabs;
  final Function(String?) onChangedFilter;
  final Function(String?) onChangedFilterMonth;
  final Function(String?) onChangedFilterBrand;
  final List<String> selectedItemValueChannel;
  final List<String> selectedItemValueChannelMonth;
  final List<String> selectedItemValueChannelBrand;
  final Function() categoryApply;
  final Function() onClosedTap;
  final Function() onRemoveFilter;
  final Function() onRemoveFilterCategory;
  final String selectedCategoryList;
  final String selectedMonthList;
  final Function() onTapMonthFilter;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final Function() onTap4;
  final Function() onTapChannelFilter;
  final Function() onTapRemoveFilter;
  final Function() tryAgain;
  final Function() tryAgain1;
  final Function() tryAgain2;
  final Function() tryAgain3;
  final int selectedIndex1;
  final List<String> selectedItemValueCategory;
  final List<String> selectedItemValueBrand;
  final List<String> selectedItemValueBrandForm;
  final List<String> selectedItemValueBrandFromGroup;

  const FBWebSummary(
      {Key? key,
      required this.onTap,
      required this.selectedIndex,
      required this.highlighted,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo,
      required this.clusterList,
      required this.onApplyPressedMonth,
      required this.addMonthBool,
      required this.dataList,
      required this.onChangedFilter,
      required this.selectedItemValueChannel,
      required this.onChangedFilterMonth,
      required this.selectedItemValueChannelMonth,
      required this.onApplyPressedMonthCHRTab,
      required this.dataListTabs,
      required this.dataListBillingTabs,
      required this.dataListCCTabs,
      required this.onChangedFilterBrand,
      required this.selectedItemValueChannelBrand,
      required this.categoryApply,
      required this.onClosedTap,
      required this.onRemoveFilter,
      required this.selectedMonthList,
      required this.onTapMonthFilter,
      required this.onTap1,
      required this.onTap2,
      required this.onTap3,
      required this.onTap4,
      required this.selectedIndex1,
      required this.onRemoveFilterCategory,
      required this.selectedCategoryList,
      required this.selectedItemValueCategory,
      required this.selectedItemValueBrand,
      required this.selectedItemValueBrandForm,
      required this.selectedItemValueBrandFromGroup,
      required this.onTapChannelFilter, required this.onTapRemoveFilter, required this.tryAgain, required this.tryAgain1, required this.tryAgain2, required this.tryAgain3})
      : super(key: key);

  @override
  State<FBWebSummary> createState() => _FBWebSummaryState();
}

class _FBWebSummaryState extends State<FBWebSummary> {
  List arrayRetailing = [
    'Consolidated View By Site',
    'Consolidated View By Category',
    'FB %',
    'FB Absolute',
  ];

  late ScrollController _scrollController1;
  late ScrollController scrollController2;
  bool addGeoBool = false;
  int selectedIndex = 0;
  int selectedIndexLocation = 0;
  int selectedIndexLocation1 = 0;
  int selectedIndexLocation2 = 0;
  int selectedIndexLocation3 = 0;
  late List<DataTableWebModel> rowData;
  List clusterCount = [];
  late ScrollController _scrollControllerTable;
  String selectedMonth = '';
  String _selectedMonth = '';
  String _selectedCategory = '';

  postRequest(context) async {
    if (true) {
      setState(() {

        final Map<String, Map<String, String>> excelData = {};
        final Set<String> uniqueMonths = {};
        final List<String> allDates = [];

        // Iterate through the JSON data and populate the excelData map
        for (var monthData in widget.dataList) {
          for (var monthEntry in monthData) {
            final month = monthEntry['month'];
            uniqueMonths.add(month);
            final data = monthEntry['data'];
            for (var dateEntry in data) {
              final date = dateEntry['date'];
              final retailing = dateEntry['retailing'];
              final key = '$date';
              allDates.add(key);
              if (!excelData.containsKey(key)) {
                excelData[key] = {'Date': date};
              }
              excelData[key]![month] = retailing;
            }
          }
        }
        // Get sorted list of dates
        final sortedDates = allDates.toSet().toList()..sort();
        // Create an Excel workbook and sheet
        final excel = Excel.createExcel();
        final sheet = excel['Sheet1'];
        // Write headers
        final headers = ['Date', ...uniqueMonths];
        sheet.appendRow(headers);
        // Write sorted data to the sheet
        for (var date in sortedDates) {
          final entry = excelData[date]!;
          sheet.appendRow(headers.map((header) => entry[header] ?? '').toList());
        }
        // Save the Excel file
        excel.save();

      });
    } else {
    }
  }

  // final TextEditingController _textController = TextEditingController();
  // String _displayText = '';
  // String _selectedValue = '';
  //
  // void _updateText(String newText) {
  //   setState(() {
  //     _displayText = newText;
  //   });
  // }
  //
  // void _showPopup(BuildContext context, String initialValue) async {
  //   final TextEditingController textController =
  //       TextEditingController(text: initialValue);
  //
  //   final selectedValue = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Enter New Text'),
  //         content: TextField(
  //           controller: textController,
  //           decoration: const InputDecoration(hintText: 'Enter new text...'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(textController.text);
  //             },
  //             child: const Text('Update'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   if (selectedValue != null && selectedValue.isNotEmpty) {
  //     // Check if the new selected value is not a duplicate
  //     if (!widget.dataList.contains(selectedValue)) {
  //       int index = widget.dataList.indexOf(initialValue);
  //       if (index != -1) {
  //         setState(() {
  //           widget.dataList[index][0]['filter'] = selectedValue;
  //           _selectedValue = selectedValue;
  //         });
  //       }
  //     } else {
  //       // Handle the case when the new value is a duplicate
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Duplicate Value'),
  //             content: const Text('The entered value is already in the list.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

  @override
  void initState() {
    rowData = DataTableWebModel.getRowsDataGP();
    super.initState();
    _scrollController1 = ScrollController();
    scrollController2 = ScrollController();
    _scrollControllerTable = ScrollController();
    // final bosData = Provider.of<SheetProvider>(context, listen: false);
    // if (bosData.myString == 'Select..') {
    //   bosData.setInitialString("Hello");
    // }
    _selectedMonth = widget.selectedMonthList;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(
                    title:
                        'Focus Brand / ${widget.selectedIndex1 == 0 ? "Consolidated View By Site" : widget.selectedIndex1 == 1 ? "Consolidated View By Category" : widget.selectedIndex1 == 2 ? "FB %" : widget.selectedIndex1 == 3 ? "FB Absolute" : ""}',
                    subTitle: 'Focus Brand',
                    showHide: false,
                    onPressed: () {},
                    onNewMonth: () {},
                    showHideRetailing: false,
                    onTapDefaultGoe: () {},
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 0, right: 0, bottom: 20),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Scrollbar(
                              controller: _scrollController1,
                              child: SingleChildScrollView(
                                controller: _scrollController1,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    TabsSizedBoxTable(
                                      onTap: widget.onTap1,
                                      selectedIndex: widget.selectedIndex1,
                                      index: 0,
                                      arrayRetailing: arrayRetailing,
                                    ),
                                    TabsSizedBoxTable(
                                      onTap: widget.onTap2,
                                      selectedIndex: widget.selectedIndex1,
                                      index: 1,
                                      arrayRetailing: arrayRetailing,
                                    ),
                                    TabsSizedBoxTable(
                                      onTap: widget.onTap3,
                                      selectedIndex: widget.selectedIndex1,
                                      index: 2,
                                      arrayRetailing: arrayRetailing,
                                    ),
                                    TabsSizedBoxTable(
                                      onTap: widget.onTap4,
                                      selectedIndex: widget.selectedIndex1,
                                      index: 3,
                                      arrayRetailing: arrayRetailing,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              BackButtonTable(onTap: widget.onTap),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      )),
                  widget.selectedIndex1 == 0
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                                width: size.width,
                                height: size.height / 1.3,
                                decoration: BoxDecoration(
                                    color: MyColors.whiteColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Stack(
                                  children: [
                                    sheetProvider.fbErrorMsg.isNotEmpty
                                        ? Center(
                                            child: Column(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text('Something went wrong! Try Again'),
                                                const SizedBox(height: 20,),
                                                OutlinedButton(
                                                  onPressed:widget.tryAgain,
                                                  style: ButtonStyle(
                                                    side: MaterialStateProperty.all(
                                                        const BorderSide(
                                                            width: 1.0, color: MyColors.primary)),
                                                    shape: MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(5.0))),
                                                  ),
                                                  child: const Text(
                                                    "Try Again",
                                                    style: TextStyle(
                                                        fontFamily: fontFamily, color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ) : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: MyColors.dark400,
                                                height: 42,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      widget.dataList.length,
                                                  itemBuilder:
                                                      (context, outerIndex) {
                                                    sheetProvider
                                                        .selectedChannelSite = widget
                                                                .dataList[
                                                            selectedIndexLocation]
                                                        [0]['filter_key'];
                                                    sheetProvider
                                                            .selectedChannelDivision =
                                                        findDatasetName(widget
                                                                    .dataList[
                                                                selectedIndexLocation]
                                                            [0]['filter_key']);
                                                    sheetProvider
                                                            .selectedChannelMonthData =
                                                        widget.dataList[
                                                                outerIndex][0]
                                                            ['month'];
                                                    selectedMonth = widget
                                                                .dataList[
                                                            selectedIndexLocation]
                                                        [0]['month'];
                                                    sheetProvider
                                                            .myStringMonthFB =
                                                        selectedMonth;
                                                    _selectedMonth = widget
                                                                .dataList[
                                                            selectedIndexLocation]
                                                        [0]['month'];
                                                    sheetProvider
                                                            .selectedChannelIndexFB =
                                                        selectedIndexLocation;
                                                    return TabsBodyTable(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedIndexLocation =
                                                              outerIndex;
                                                          sheetProvider
                                                                  .selectedChannelIndexFB =
                                                              selectedIndexLocation;
                                                          sheetProvider
                                                                  .selectedChannelDivision =
                                                              findDatasetName(widget
                                                                          .dataList[
                                                                      outerIndex][0]
                                                                  [
                                                                  'filter_key']);
                                                          sheetProvider
                                                                  .selectedChannelMonthData =
                                                              widget.dataList[
                                                                      outerIndex]
                                                                  [0]['month'];
                                                          sheetProvider
                                                                  .selectedChannelCategory =
                                                              widget.dataList[
                                                                      outerIndex]
                                                                  [
                                                                  0]['channel'];
                                                          _selectedMonth =
                                                              widget.dataList[
                                                                      outerIndex]
                                                                  [0]['month'];
                                                          // widget.selectedItemValueChannel = widget.dataList[outerIndex][0]['channel'];
                                                        });

                                                        sheetProvider
                                                                .removeIndexFB =
                                                            selectedIndexLocation;
                                                      },
                                                      onTapGes: () {
                                                        setState(() {
                                                          selectedIndex =
                                                              selectedIndex ==
                                                                      outerIndex
                                                                  ? -1
                                                                  : outerIndex;
                                                          sheetProvider
                                                                  .isExpanded ==
                                                              true;
                                                        });
                                                      },
                                                      selectedIndexLocation:
                                                          selectedIndexLocation,
                                                      outerIndex: outerIndex,
                                                      title:
                                                          "${widget.dataList[outerIndex][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataList[outerIndex][0]['filter_key']} / ${widget.dataList[outerIndex][0]['month']}",
                                                      onClosedTap:
                                                          widget.onClosedTap,
                                                    );
                                                  },
                                                ),
                                              ),
                                              // Container B (conditionally shown)
                                              if (selectedIndexLocation != -1)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: widget.dataList.isEmpty
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : SingleChildScrollView(
                                                          child: Container(
                                                            width: size.width,
                                                            decoration: const BoxDecoration(
                                                                color: MyColors
                                                                    .whiteColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            child: Column(
                                                              children: [
                                                                TableHeaderWidget(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      addGeoBool =
                                                                          !addGeoBool;
                                                                    });
                                                                  },
                                                                  title:
                                                                      "${widget.dataList[selectedIndexLocation][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataList[selectedIndexLocation][0]['filter_key']} / ${widget.dataList[selectedIndexLocation][0]['month']}${widget.dataList[selectedIndexLocation][0]['channel'] == '' ? '' : "/ ${widget.dataList[selectedIndexLocation][0]['channel']}"}  ${widget.dataList[selectedIndexLocation][0]['filter_key2'] == '' ? '' : "/ ${widget.dataList[selectedIndexLocation][0]['filter_key2']}"} ",
                                                                ),
                                                                Scrollbar(
                                                                  controller:
                                                                      _scrollControllerTable,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    controller:
                                                                        _scrollControllerTable,
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          400,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height -
                                                                          410,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          CustomHeaderTitle(
                                                                            dataList:
                                                                                widget.dataList,
                                                                            selectedIndexLocation:
                                                                                selectedIndexLocation,
                                                                            per:
                                                                                'FB %',
                                                                            points:
                                                                                'FB Points Achieved',
                                                                            target:
                                                                                'FB Target',
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 15.0,
                                                                                right: 15.0,
                                                                                bottom: 8.0),
                                                                            child: widget.dataList[selectedIndexLocation][0]['filter_key'] == 'All India' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'allIndia'
                                                                                ? FBTableDataAll(
                                                                                    newDataList: widget.dataList[selectedIndexLocation],
                                                                                    keyName1: 'fb_per',
                                                                                    keyName2: 'fb_achieve_sum',
                                                                                    keyName3: 'fb_target_sum',
                                                                                  )
                                                                                : widget.dataList[selectedIndexLocation][0]['filter_key'] == 'N-E' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'S-W'
                                                                                    ? FBTableDivision(
                                                                                        newDataList: widget.dataList[selectedIndexLocation],
                                                                                        keyName1: 'fb_per',
                                                                                        keyName2: 'fb_achieve_sum',
                                                                                        keyName3: 'fb_target_sum',
                                                                                      )
                                                                                    : FBTableSite(newDataList: widget.dataList[selectedIndexLocation], keyName1: 'fb_per', keyName2: 'fb_achieve_sum', keyName3: 'fb_target_sum'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                            ],
                                          ),
                                    GeoPositionTable(
                                      addGeoBool: addGeoBool,
                                      onCoverageTap: () {
                                        setState(() {
                                          addGeoBool = !addGeoBool;
                                        });
                                      },
                                      divisionList: widget.divisionList,
                                      siteList: widget.siteList,
                                      branchList: widget.branchList,
                                      selectedGeo: widget.selectedGeo,
                                      clusterList: widget.clusterList,
                                      onApplyTap: () {
                                        setState(() {
                                          addGeoBool = !addGeoBool;
                                          sheetProvider.selectMonth = true;
                                        });
                                      },
                                    ),
                                    MonthPositionTable(
                                      visible: sheetProvider.selectMonth,
                                      onApplyPressedMonth:
                                          widget.onApplyPressedMonth,
                                      onTap: () {
                                        setState(() {
                                          sheetProvider.selectMonth = false;
                                        });
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        )
                      : widget.selectedIndex1 == 1
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                    width: size.width,
                                    height: size.height / 1.3,
                                    decoration: BoxDecoration(
                                        color: MyColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Stack(
                                      children: [
                                        sheetProvider.fb1ErrorMsg.isNotEmpty
                                            ? Center(
                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text('Something went wrong! Try Again'),
                                              const SizedBox(height: 20,),
                                              OutlinedButton(
                                                onPressed:widget.tryAgain1,
                                                style: ButtonStyle(
                                                  side: MaterialStateProperty.all(
                                                      const BorderSide(
                                                          width: 1.0, color: MyColors.primary)),
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(5.0))),
                                                ),
                                                child: const Text(
                                                  "Try Again",
                                                  style: TextStyle(
                                                      fontFamily: fontFamily, color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ) : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    color: MyColors.dark400,
                                                    height: 42,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: widget
                                                          .dataListCCTabs
                                                          .length,
                                                      itemBuilder: (context,
                                                          outerIndex1) {
                                                        sheetProvider
                                                            .selectedChannelSite = widget
                                                                    .dataListCCTabs[
                                                                selectedIndexLocation1]
                                                            [0]['filter_key'];
                                                        var monthForm =
                                                            widget.dataListCCTabs[
                                                                    outerIndex1]
                                                                [0]['month'];
                                                        String year = monthForm
                                                            .substring(2, 6);
                                                        String month = monthForm
                                                            .substring(7);
                                                        var finalMonth =
                                                            "$month-$year";
                                                        sheetProvider
                                                                .selectedChannelMonthData =
                                                            finalMonth;
                                                        selectedMonth = widget
                                                                    .dataListCCTabs[
                                                                selectedIndexLocation1]
                                                            [0]['month'];
                                                        _selectedMonth = widget
                                                                    .dataListCCTabs[
                                                                selectedIndexLocation1]
                                                            [0]['month'];
                                                        sheetProvider
                                                                .selectedChannelIndexFB =
                                                            selectedIndexLocation1;
                                                        return TabsBodyTable(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedIndexLocation1 =
                                                                  outerIndex1;
                                                              sheetProvider
                                                                      .selectedChannelIndexFB =
                                                                  selectedIndexLocation1;
                                                              sheetProvider
                                                                  .selectedChannelDivision = findDatasetName(widget
                                                                          .dataListCCTabs[
                                                                      outerIndex1][0]
                                                                  [
                                                                  'filter_key']);
                                                              var formattedMonth =
                                                                  widget.dataListCCTabs[
                                                                          outerIndex1]
                                                                      [
                                                                      0]['month'];
                                                              String year =
                                                                  formattedMonth
                                                                      .substring(
                                                                          2, 6);
                                                              String month =
                                                                  formattedMonth
                                                                      .substring(
                                                                          7);
                                                              var finalMonth =
                                                                  "$month-$year";
                                                              sheetProvider
                                                                      .selectedChannelMonthData =
                                                                  finalMonth;
                                                              sheetProvider
                                                                      .removeIndexFB =
                                                                  selectedIndexLocation1;
                                                              _selectedMonth =
                                                                  widget.dataListCCTabs[
                                                                          selectedIndexLocation1]
                                                                      [
                                                                      0]['month'];
                                                            });
                                                          },
                                                          onTapGes: () {
                                                            setState(() {
                                                              selectedIndex =
                                                                  selectedIndex ==
                                                                          outerIndex1
                                                                      ? -1
                                                                      : outerIndex1;
                                                              sheetProvider
                                                                      .isExpanded ==
                                                                  true;
                                                            });
                                                          },
                                                          selectedIndexLocation:
                                                              selectedIndexLocation1,
                                                          outerIndex:
                                                              outerIndex1,
                                                          title:
                                                              "${widget.dataListCCTabs[outerIndex1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListCCTabs[outerIndex1][0]['filter_key']} / ${widget.dataListCCTabs[outerIndex1][0]['month']}",
                                                          onClosedTap: widget
                                                              .onClosedTap,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Container B (conditionally shown)
                                                  if (selectedIndexLocation1 !=
                                                      -1)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: widget
                                                              .dataListCCTabs
                                                              .isEmpty
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : SingleChildScrollView(
                                                              child: Container(
                                                                width:
                                                                    size.width,
                                                                decoration: const BoxDecoration(
                                                                    color: MyColors
                                                                        .whiteColor,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                                child: Column(
                                                                  children: [
                                                                    TableHeaderWidget(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          addGeoBool =
                                                                              !addGeoBool;
                                                                        });
                                                                      },
                                                                      title:
                                                                          "${widget.dataListCCTabs[selectedIndexLocation1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListCCTabs[selectedIndexLocation1][0]['filter_key']} / ${widget.dataListCCTabs[selectedIndexLocation1][0]['month']}${widget.dataListCCTabs[selectedIndexLocation1][0]['channel'] == "" ? "" : " / ${widget.dataListCCTabs[selectedIndexLocation1][0]['channel']}"} ${widget.dataListCCTabs[selectedIndexLocation1][0]['filter_key2'] == '' ? '' : " / ${widget.dataListCCTabs[selectedIndexLocation1][0]['filter_key2']}"} ",
                                                                    ),
                                                                    Scrollbar(
                                                                      controller:
                                                                          _scrollControllerTable,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        controller:
                                                                            _scrollControllerTable,
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Container(
                                                                          decoration: const BoxDecoration(
                                                                              // color: MyColors.textColor,
                                                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                          width:
                                                                              MediaQuery.of(context).size.width - 400,
                                                                          height:
                                                                              MediaQuery.of(context).size.height - 410,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              CustomHeaderTitleCategory(
                                                                                dataList: widget.dataListCCTabs,
                                                                                selectedIndexLocation: selectedIndexLocation1,
                                                                                per: 'FB %',
                                                                                points: 'FB Points Achieved',
                                                                                target: 'FB Target',
                                                                              ),
                                                                              Padding(
                                                                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
                                                                                  child: FBTableDataAllCategory(
                                                                                    newDataList: widget.dataListCCTabs[selectedIndexLocation1],
                                                                                    keyName1: 'fb_per',
                                                                                    keyName2: 'fb_achieve_sum',
                                                                                    keyName3: 'fb_target_sum',
                                                                                  )
                                                                                  //     : widget
                                                                                  //     .dataListCCTabs[selectedIndexLocation1][0]['filter'] ==
                                                                                  //     'N-E' || widget
                                                                                  //     .dataListCCTabs[selectedIndexLocation1][0]['filter'] ==
                                                                                  //     'S-W'
                                                                                  //     ?
                                                                                  // CoverageTableTabDivision(
                                                                                  //   newDataList: widget
                                                                                  //       .dataListCCTabs[selectedIndexLocation1],
                                                                                  //   keyName1: 'cc_per1',
                                                                                  //   keyName2: 'cc_per2',
                                                                                  //   keyName3: 'cc_per3',
                                                                                  // )
                                                                                  //     : CoverageTableTabSite(
                                                                                  //     newDataList: widget
                                                                                  //         .dataListCCTabs[selectedIndexLocation1],
                                                                                  //     keyName1: 'cc_per1',
                                                                                  //     keyName2: 'cc_per2',
                                                                                  //     keyName3: 'cc_per3'
                                                                                  // ),
                                                                                  ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                ],
                                              ),
                                        GeoPositionTable(
                                          addGeoBool: addGeoBool,
                                          onCoverageTap: () {
                                            setState(() {
                                              addGeoBool = !addGeoBool;
                                            });
                                          },
                                          divisionList: widget.divisionList,
                                          siteList: widget.siteList,
                                          branchList: widget.branchList,
                                          selectedGeo: widget.selectedGeo,
                                          clusterList: widget.clusterList,
                                          onApplyTap: () {
                                            setState(() {
                                              addGeoBool = !addGeoBool;
                                              sheetProvider.selectMonth = true;
                                            });
                                          },
                                        ),
                                        MonthPositionTable(
                                          visible: sheetProvider.selectMonth,
                                          onApplyPressedMonth:
                                              widget.onApplyPressedMonth,
                                          onTap: () {
                                            setState(() {
                                              sheetProvider.selectMonth = false;
                                            });
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                            )
                          : widget.selectedIndex1 == 2
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                        width: size.width,
                                        height: size.height / 1.3,
                                        decoration: BoxDecoration(
                                            color: MyColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Stack(
                                          children: [
                                            sheetProvider.fb2ErrorMsg.isNotEmpty
                                                ? Center(
                                              child: Column(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text('Something went wrong! Try Again'),
                                                  const SizedBox(height: 20,),
                                                  OutlinedButton(
                                                    onPressed:widget.tryAgain2,
                                                    style: ButtonStyle(
                                                      side: MaterialStateProperty.all(
                                                          const BorderSide(
                                                              width: 1.0, color: MyColors.primary)),
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(5.0))),
                                                    ),
                                                    child: const Text(
                                                      "Try Again",
                                                      style: TextStyle(
                                                          fontFamily: fontFamily, color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        color: MyColors.dark400,
                                                        height: 42,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: widget
                                                              .dataListTabs
                                                              .length,
                                                          itemBuilder: (context,
                                                              outerIndex2) {
                                                            sheetProvider
                                                                .selectedChannelSite = widget
                                                                        .dataListTabs[
                                                                    selectedIndexLocation2]
                                                                [
                                                                0]['filter_key'];
                                                            sheetProvider
                                                                .selectedChannelMonthData = widget
                                                                        .dataListTabs[
                                                                    outerIndex2]
                                                                [0]['month1'];
                                                            selectedMonth = widget
                                                                        .dataListTabs[
                                                                    selectedIndexLocation2]
                                                                [0]['month1'];
                                                            _selectedMonth = widget
                                                                        .dataListTabs[
                                                                    selectedIndexLocation2]
                                                                [0]['month1'];
                                                            sheetProvider
                                                                    .selectedChannelIndexFB =
                                                                selectedIndexLocation2;
                                                            return TabsBodyTable(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedIndexLocation2 =
                                                                      outerIndex2;
                                                                  sheetProvider
                                                                          .selectedChannelIndexFB =
                                                                      selectedIndexLocation2;
                                                                  sheetProvider
                                                                      .selectedChannelDivision = findDatasetName(widget
                                                                              .dataListTabs[
                                                                          outerIndex2][0]
                                                                      [
                                                                      'filter_key']);
                                                                  var formattedMonth =
                                                                      widget.dataListTabs[outerIndex2]
                                                                              [
                                                                              0]
                                                                          [
                                                                          'month1'];
                                                                  String year =
                                                                      formattedMonth
                                                                          .substring(
                                                                              2,
                                                                              6);
                                                                  String month =
                                                                      formattedMonth
                                                                          .substring(
                                                                              7);
                                                                  var finalMonth =
                                                                      "$month-$year";
                                                                  sheetProvider
                                                                          .selectedChannelMonthData =
                                                                      finalMonth;
                                                                  sheetProvider
                                                                          .removeIndexFB =
                                                                      selectedIndexLocation2;
                                                                  _selectedMonth =
                                                                      widget.dataListTabs[selectedIndexLocation2]
                                                                              [
                                                                              0]
                                                                          [
                                                                          'month1'];
                                                                });
                                                              },
                                                              onTapGes: () {
                                                                setState(() {
                                                                  selectedIndex =
                                                                      selectedIndex ==
                                                                              outerIndex2
                                                                          ? -1
                                                                          : outerIndex2;
                                                                  sheetProvider
                                                                          .isExpanded ==
                                                                      true;
                                                                });
                                                              },
                                                              selectedIndexLocation:
                                                                  selectedIndexLocation2,
                                                              outerIndex:
                                                                  outerIndex2,
                                                              title:
                                                                  "${widget.dataListTabs[outerIndex2][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListTabs[outerIndex2][0]['filter_key']} / ${widget.dataListTabs[outerIndex2][0]['month1']}",
                                                              onClosedTap: widget
                                                                  .onClosedTap,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      // Container B (conditionally shown)
                                                      if (selectedIndexLocation2 !=
                                                          -1)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: widget
                                                                  .dataListTabs
                                                                  .isEmpty
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : SingleChildScrollView(
                                                                  child:
                                                                      Container(
                                                                    width: size
                                                                        .width,
                                                                    decoration: const BoxDecoration(
                                                                        color: MyColors
                                                                            .whiteColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20))),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        TableHeaderWidget(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                addGeoBool = !addGeoBool;
                                                                              });
                                                                            },
                                                                            title:
                                                                                "${widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListTabs[selectedIndexLocation2][0]['filter_key']} / ${widget.dataListTabs[selectedIndexLocation2][0]['month1']}  ${widget.dataListTabs[selectedIndexLocation2][0]['channel'].isEmpty ? '' : '/ ${widget.dataListTabs[selectedIndexLocation2][0]['channel']}'}"),
                                                                        Scrollbar(
                                                                          controller:
                                                                              _scrollControllerTable,
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            controller:
                                                                                _scrollControllerTable,
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            child:
                                                                                Container(
                                                                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              width: MediaQuery.of(context).size.width - 400,
                                                                              height: MediaQuery.of(context).size.height - 410,
                                                                              child: Column(
                                                                                children: [
                                                                                  CustomHeaderTitle(
                                                                                    dataList: widget.dataListTabs,
                                                                                    selectedIndexLocation: selectedIndexLocation2,
                                                                                    per: widget.dataListTabs[selectedIndexLocation2][0]['month1'],
                                                                                    points: widget.dataListTabs[selectedIndexLocation2][0]['month2'],
                                                                                    target: widget.dataListTabs[selectedIndexLocation2][0]['month3'],
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
                                                                                    child: widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'All India' || widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'allIndia'
                                                                                        ? FBTableDataAllMonthWise(
                                                                                            newDataList: widget.dataListTabs[selectedIndexLocation2],
                                                                                            keyName1: 'fb_per1',
                                                                                            keyName2: 'fb_per2',
                                                                                            keyName3: 'fb_per3',
                                                                                          )
                                                                                        : widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'N-E' || widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'S-W'
                                                                                            ? CoverageTableTabDivision(
                                                                                                newDataList: widget.dataListTabs[selectedIndexLocation2],
                                                                                                keyName1: 'fb_per1',
                                                                                                keyName2: 'fb_per2',
                                                                                                keyName3: 'fb_per3',
                                                                                              )
                                                                                            : CoverageTableTabSite(
                                                                                                newDataList: widget.dataListTabs[selectedIndexLocation2],
                                                                                                keyName1: 'fb_per1',
                                                                                                keyName2: 'fb_per2',
                                                                                                keyName3: 'fb_per3',
                                                                                              ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                        ),
                                                    ],
                                                  ),
                                            GeoPositionTable(
                                              addGeoBool: addGeoBool,
                                              onCoverageTap: () {
                                                setState(() {
                                                  addGeoBool = !addGeoBool;
                                                });
                                              },
                                              divisionList: widget.divisionList,
                                              siteList: widget.siteList,
                                              branchList: widget.branchList,
                                              selectedGeo: widget.selectedGeo,
                                              clusterList: widget.clusterList,
                                              onApplyTap: () {
                                                setState(() {
                                                  addGeoBool = !addGeoBool;
                                                  sheetProvider.selectMonth =
                                                      true;
                                                });
                                              },
                                            ),
                                            MonthPositionTable(
                                              visible:
                                                  sheetProvider.selectMonth,
                                              onApplyPressedMonth:
                                                  widget.onApplyPressedMonth,
                                              onTap: () {
                                                setState(() {
                                                  sheetProvider.selectMonth =
                                                      false;
                                                });
                                              },
                                            ),
                                          ],
                                        )),
                                  ),
                                )
                              : widget.selectedIndex1 == 3
                                  ? Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: size.width,
                                            height: size.height / 1.3,
                                            decoration: BoxDecoration(
                                                color: MyColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Stack(
                                              children: [
                                                sheetProvider.fb3ErrorMsg.isNotEmpty
                                                    ? Center(
                                                  child: Column(
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text('Something went wrong! Try Again'),
                                                      const SizedBox(height: 20,),
                                                      OutlinedButton(
                                                        onPressed:widget.tryAgain3,
                                                        style: ButtonStyle(
                                                          side: MaterialStateProperty.all(
                                                              const BorderSide(
                                                                  width: 1.0, color: MyColors.primary)),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(5.0))),
                                                        ),
                                                        child: const Text(
                                                          "Try Again",
                                                          style: TextStyle(
                                                              fontFamily: fontFamily, color: Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ) : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            color: MyColors
                                                                .dark400,
                                                            height: 42,
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount: widget
                                                                  .dataListBillingTabs
                                                                  .length,
                                                              itemBuilder: (context,
                                                                  outerIndex3) {
                                                                sheetProvider
                                                                    .selectedChannelSite = widget
                                                                            .dataListBillingTabs[
                                                                        selectedIndexLocation3][0]
                                                                    [
                                                                    'filter_key'];
                                                                sheetProvider
                                                                    .selectedChannelMonthData = widget
                                                                            .dataListBillingTabs[
                                                                        outerIndex3]
                                                                    [
                                                                    0]['month1'];
                                                                selectedMonth =
                                                                    widget.dataListBillingTabs[
                                                                            selectedIndexLocation3][0]
                                                                        [
                                                                        'month1'];
                                                                _selectedMonth =
                                                                    widget.dataListBillingTabs[
                                                                            selectedIndexLocation3][0]
                                                                        [
                                                                        'month1'];
                                                                sheetProvider
                                                                        .selectedChannelIndexFB =
                                                                    selectedIndexLocation3;
                                                                return TabsBodyTable(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedIndexLocation3 =
                                                                          outerIndex3;
                                                                      sheetProvider
                                                                              .selectedChannelIndexFB =
                                                                          selectedIndexLocation3;
                                                                      sheetProvider
                                                                          .selectedChannelDivision = findDatasetName(widget.dataListBillingTabs[selectedIndexLocation3]
                                                                              [
                                                                              0]
                                                                          [
                                                                          'filter_key']);
                                                                      var formattedMonth =
                                                                          widget.dataListBillingTabs[selectedIndexLocation3][0]
                                                                              [
                                                                              'month1'];
                                                                      String
                                                                          year =
                                                                          formattedMonth.substring(
                                                                              2,
                                                                              6);
                                                                      String
                                                                          month =
                                                                          formattedMonth
                                                                              .substring(7);
                                                                      var finalMonth =
                                                                          "$month-$year";
                                                                      sheetProvider
                                                                              .selectedChannelMonthData =
                                                                          finalMonth;
                                                                      sheetProvider
                                                                              .removeIndexFB =
                                                                          selectedIndexLocation3;
                                                                      _selectedMonth =
                                                                          widget.dataListBillingTabs[selectedIndexLocation3][0]
                                                                              [
                                                                              'month1'];
                                                                    });
                                                                  },
                                                                  onTapGes: () {
                                                                    setState(
                                                                        () {
                                                                      selectedIndex = selectedIndex ==
                                                                              outerIndex3
                                                                          ? -1
                                                                          : outerIndex3;
                                                                      sheetProvider
                                                                              .isExpanded ==
                                                                          true;
                                                                    });
                                                                  },
                                                                  selectedIndexLocation:
                                                                      selectedIndexLocation3,
                                                                  outerIndex:
                                                                      outerIndex3,
                                                                  title:
                                                                      "${widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key']} / ${widget.dataListBillingTabs[outerIndex3][0]['month1']}",
                                                                  onClosedTap:
                                                                      widget
                                                                          .onClosedTap,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          // Container B (conditionally shown)
                                                          if (selectedIndexLocation3 !=
                                                              -1)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0.0),
                                                              child: widget
                                                                      .dataListBillingTabs
                                                                      .isEmpty
                                                                  ? const Center(
                                                                      child:
                                                                          CircularProgressIndicator())
                                                                  : SingleChildScrollView(
                                                                      child:
                                                                          Container(
                                                                        width: size
                                                                            .width,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                MyColors.whiteColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            TableHeaderWidget(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    addGeoBool = !addGeoBool;
                                                                                  });
                                                                                },
                                                                                title: "${widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key']} / ${widget.dataListBillingTabs[selectedIndexLocation3][0]['month1']}  ${widget.dataListBillingTabs[selectedIndexLocation3][0]['channel'].isEmpty ? '' : '/ ${widget.dataListBillingTabs[selectedIndexLocation3][0]['channel']}'}"),
                                                                            Scrollbar(
                                                                              controller: _scrollControllerTable,
                                                                              child: SingleChildScrollView(
                                                                                controller: _scrollControllerTable,
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                      // color: MyColors.textColor,
                                                                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                                  width: MediaQuery.of(context).size.width - 400,
                                                                                  height: MediaQuery.of(context).size.height - 410,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      CustomHeaderTitle(
                                                                                        dataList: widget.dataListBillingTabs,
                                                                                        selectedIndexLocation: selectedIndexLocation3,
                                                                                        per: widget.dataListBillingTabs[selectedIndexLocation3][0]['month1'],
                                                                                        points: widget.dataListBillingTabs[selectedIndexLocation3][0]['month2'],
                                                                                        target: widget.dataListBillingTabs[selectedIndexLocation3][0]['month3'],
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
                                                                                        child: widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'All India' || widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'allIndia'
                                                                                            ? FBTableDataAllMonthWise(
                                                                                                newDataList: widget.dataListBillingTabs[selectedIndexLocation3],
                                                                                                keyName1: 'fb_abs_1',
                                                                                                keyName2: 'fb_abs_2',
                                                                                                keyName3: 'fb_abs_3',
                                                                                              )
                                                                                            : widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'N-E' || widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'S-W'
                                                                                                ? CoverageTableTabDivision(
                                                                                                    newDataList: widget.dataListBillingTabs[selectedIndexLocation3],
                                                                                                    keyName1: 'fb_abs_1',
                                                                                                    keyName2: 'fb_abs_2',
                                                                                                    keyName3: 'fb_abs_3',
                                                                                                  )
                                                                                                : CoverageTableTabSite(
                                                                                                    newDataList: widget.dataListBillingTabs[selectedIndexLocation3],
                                                                                                    keyName1: 'fb_abs_1',
                                                                                                    keyName2: 'fb_abs_2',
                                                                                                    keyName3: 'fb_abs_3',
                                                                                                  ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                        ],
                                                      ),
                                                GeoPositionTable(
                                                  addGeoBool: addGeoBool,
                                                  onCoverageTap: () {
                                                    setState(() {
                                                      addGeoBool = !addGeoBool;
                                                    });
                                                  },
                                                  divisionList:
                                                      widget.divisionList,
                                                  siteList: widget.siteList,
                                                  branchList: widget.branchList,
                                                  selectedGeo:
                                                      widget.selectedGeo,
                                                  clusterList:
                                                      widget.clusterList,
                                                  onApplyTap: () {
                                                    setState(() {
                                                      addGeoBool = !addGeoBool;
                                                      sheetProvider
                                                          .selectMonth = true;
                                                    });
                                                  },
                                                ),
                                                MonthPositionTable(
                                                  visible:
                                                      sheetProvider.selectMonth,
                                                  onApplyPressedMonth: widget
                                                      .onApplyPressedMonth,
                                                  onTap: () {
                                                    setState(() {
                                                      sheetProvider
                                                          .selectMonth = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                                  : Container(),
                  ExcelImportButton(onClickExcel: () async{

                    setState(() {});
                    await postRequest(context);
                  },),
                ],
              ),
            ),
            FiltersAllCategory(
              selectedMonthList: widget.selectedIndex1 == 0
                  ? (widget.dataList).isEmpty
                      ? 'Select..'
                      : widget.dataList[selectedIndexLocation][0]['month']
                  : widget.selectedIndex1 == 1
                      ? (widget.dataListCCTabs).isEmpty
                          ? 'Select..'
                          : widget.dataListCCTabs[selectedIndexLocation1][0]
                              ['month']
                      : widget.selectedIndex1 == 2
                          ? (widget.dataListTabs).isEmpty
                              ? 'Select..'
                              : widget.dataListTabs[selectedIndexLocation2][0]
                                  ['month1']
                          : widget.selectedIndex1 == 3
                              ? (widget.dataListBillingTabs).isEmpty
                                  ? 'Select..'
                                  : widget.dataListBillingTabs[
                                      selectedIndexLocation][0]['month1']
                              : "Select..",
              onTapMonthFilter: widget.onTapMonthFilter,
              selectedChannelList: widget.selectedIndex1 == 0
                  ? (widget.dataList).isEmpty
                      ? ['Select..']
                      : widget.dataList[selectedIndexLocation][0]['channel']
                  : widget.selectedIndex1 == 1
                      ? (widget.dataListCCTabs).isEmpty
                          ? ['Select..']
                          : widget.dataListCCTabs[selectedIndexLocation1][0]
                              ['channel']
                      : widget.selectedIndex1 == 2
                          ? (widget.dataListTabs).isEmpty
                              ? ['Select..']
                              : widget.dataListTabs[selectedIndexLocation2][0]
                                  ['channel']
                          : widget.selectedIndex1 == 3
                              ? (widget.dataListBillingTabs).isEmpty
                                  ? ['Select..']
                                  : widget.dataListBillingTabs[
                                      selectedIndexLocation][0]['channel']
                              : ["Select.."],
              onTapChannelFilter: widget.onTapChannelFilter,
              attributeName: 'FB',
              categoryApply: widget.categoryApply, onTapRemoveFilter: widget.onTapRemoveFilter,
            )
          ],
        ),
      ],
    );
  }

  findDatasetName(String selectedKey) {
    List<dynamic> cluster = widget.clusterList;
    List<dynamic> site = widget.siteList;
    List<dynamic> division = widget.divisionList;
    List<dynamic> divisionN = ['S-W', 'N-E'];

    if (site.contains(selectedKey)) {
      return "site";
    } else if (cluster.contains(selectedKey)) {
      return "cluster";
    } else if (divisionN.contains(selectedKey)) {
      return "division";
    } else if (division.contains(selectedKey)) {
      return "division";
    } else if (selectedKey == 'allIndia') {
      return "allIndia";
    } else {
      if (selectedKey == 'All India') {
        return "allIndia";
      }
    }
  }
}
