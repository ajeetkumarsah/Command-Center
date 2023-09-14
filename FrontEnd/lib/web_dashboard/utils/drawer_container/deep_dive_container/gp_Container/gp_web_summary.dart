import 'package:command_centre/web_dashboard/utils/comman_utils/excel_button.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/back_button_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/custom_header_title_category.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/custome_header_title.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_geo_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_month_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/table_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_body_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_sizedbox_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/text_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_all_category.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_channel.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filters_retailing.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/allIndia_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/category_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/division_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/month_wise_table.dart';
import 'package:command_centre/web_dashboard/utils/table/fb_tables/site_table.dart';
import 'package:command_centre/web_dashboard/utils/table/table_tabs/division_table_tab.dart';
import 'package:command_centre/web_dashboard/utils/table/table_tabs/site_table_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../activities/coverage_screen.dart';
import '../../../../../../model/data_table_model.dart';
import '../../../../../../provider/sheet_provider.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../../utils/style/text_style.dart';
// import 'dart:html' as html;

class GPWebSummary extends StatefulWidget {
  final Function() onTap;
  final Function() onApplyPressedMonth;
  final Function() onApplyPressedMonthCHRTab;
  final Function() onClosedTap;
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
  final String selectedMonthList;
  final Function() onTapMonthFilter;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final Function() onTap4;
  final int selectedIndex1;
  final Function() onRemoveFilterTap;
  final Function() onRemoveFilterCategory;
  final Function() onTapChannelFilter;
  final List<String> selectedItemValueCategory;
  final List<String> selectedItemValueBrand;
  final List<String> selectedItemValueBrandForm;
  final List<String> selectedItemValueBrandFromGroup;

  const GPWebSummary(
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
      required this.categoryApply, required this.onClosedTap, required this.selectedMonthList, required this.onTapMonthFilter, required this.onTap1, required this.onTap2, required this.onTap3, required this.onTap4, required this.selectedIndex1, required this.onRemoveFilterTap, required this.onRemoveFilterCategory, required this.selectedItemValueCategory, required this.selectedItemValueBrand, required this.selectedItemValueBrandForm, required this.selectedItemValueBrandFromGroup, required this.onTapChannelFilter})
      : super(key: key);

  @override
  State<GPWebSummary> createState() => _GPWebSummaryState();
}

class _GPWebSummaryState extends State<GPWebSummary> {
  List arrayRetailing = [
    'Consolidated View By Site',
    'GP %',
    'GP Absolute',
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
    selectedMonth = widget.selectedMonthList;
    print(selectedMonth);
    print(widget.selectedMonthList);
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
                    title: 'Golden Points / ${widget.selectedIndex1 == 0?"Consolidated View By Site":widget.selectedIndex1 == 1?"GP %":widget.selectedIndex1 == 2?"GP Absolute":""}',
                    // title: 'Golden Points / ',
                    subTitle: 'Golden Points',
                    showHide: false,
                    onPressed: () {},
                    onNewMonth: () {}, showHideRetailing: false,
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
                                    // TabsSizedBoxTable(
                                    //   onTap: widget.onTap4,
                                    //   selectedIndex: widget.selectedIndex1,
                                    //   index: 3,
                                    //   arrayRetailing: arrayRetailing,
                                    // ),
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
                                    sheetProvider.isLoaderActive == true
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : Column(
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
                                                    // sheetProvider
                                                    //     .selectedChannelMonth =
                                                    // widget.dataList[
                                                    // outerIndex]
                                                    // [
                                                    // 0]['month'];
                                                    selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                    sheetProvider.myStringMonthGP = selectedMonth;
                                                    sheetProvider
                                                        .selectedChannelIndex =
                                                        selectedIndexLocation;
                                                    return TabsBodyTable(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedIndexLocation =
                                                                outerIndex;
                                                            sheetProvider
                                                                    .selectedChannelIndex =
                                                                outerIndex;
                                                            sheetProvider
                                                                    .selectedChannelDivision =
                                                                findDatasetName(
                                                                    widget.dataList[
                                                                            outerIndex][0]
                                                                        [
                                                                        'filter_key']);
                                                            sheetProvider
                                                                    .selectedChannelMonth =
                                                                widget.dataList[
                                                                        outerIndex]
                                                                    [
                                                                    0]['month'];
                                                            sheetProvider
                                                                .selectedChannelCategory = widget
                                                                        .dataList[
                                                                    outerIndex]
                                                                [0]['channel'];
                                                            sheetProvider.removeIndexGP = selectedIndexLocation;
                                                          });
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
                                                            "${widget.dataList[outerIndex][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataList[outerIndex][0]['filter_key']} / ${widget.dataList[outerIndex][0]['month']}", onClosedTap: widget.onClosedTap,);
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
                                                                                'GP %',
                                                                            points:
                                                                                'GP Points Achieved',
                                                                            target:
                                                                                'GP Target',
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 15.0,
                                                                                right: 15.0,
                                                                                bottom: 8.0),
                                                                            child: widget.dataList[selectedIndexLocation][0]['filter_key'] == 'All India' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'allIndia'
                                                                                ? FBTableDataAll(
                                                                                    newDataList: widget.dataList[selectedIndexLocation],
                                                                                    keyName1: 'gp_per',
                                                                                    keyName2: 'gp_gf_p3m_sum',
                                                                                    keyName3: 'gp_target_sum',
                                                                                  )
                                                                                : widget.dataList[selectedIndexLocation][0]['filter_key'] == 'N-E' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'S-W'
                                                                                    ? FBTableDivision(
                                                                                        newDataList: widget.dataList[selectedIndexLocation],
                                                                                        keyName1: 'gp_per',
                                                                                        keyName2: 'gp_gf_p3m_sum',
                                                                                        keyName3: 'gp_target_sum',
                                                                                      )
                                                                                    : FBTableSite(newDataList: widget.dataList[selectedIndexLocation], keyName1: 'gp_per', keyName2: 'gp_gf_p3m_sum', keyName3: 'gp_target_sum'),
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
                                            sheetProvider.isLoaderActive == true
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : Column(
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
                                                            selectedMonth = widget.dataListTabs[selectedIndexLocation2][0]['month1'];
                                                            // selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                            sheetProvider.myStringMonthGP = selectedMonth;
                                                            return TabsBodyTable(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedIndexLocation2 =
                                                                      outerIndex2;
                                                                  sheetProvider
                                                                          .selectedChannelIndex =
                                                                      outerIndex2;
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
                                                                          .selectedChannelMonth =
                                                                      finalMonth;
                                                                  sheetProvider.removeIndexGP = selectedIndexLocation2;
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
                                                                  "${widget.dataListTabs[outerIndex2][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListTabs[outerIndex2][0]['filter_key']} / ${widget.dataListTabs[outerIndex2][0]['month1']}", onClosedTap: widget.onClosedTap,
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
                                                                              "${widget.dataListTabs[selectedIndexLocation2][0]['filter_key']} / ${widget.dataListTabs[selectedIndexLocation2][0]['month1']} ${widget.dataListTabs[selectedIndexLocation2][0]['channel'].isEmpty?'': '/ ${widget.dataListTabs[selectedIndexLocation2][0]['channel']}'}",
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
                                                                                            keyName1: 'gp_per1',
                                                                                            keyName2: 'gp_per2',
                                                                                            keyName3: 'gp_per3',
                                                                                          )
                                                                                        : widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'N-E' || widget.dataListTabs[selectedIndexLocation2][0]['filter_key'] == 'S-W'
                                                                                            ? CoverageTableTabDivision(
                                                                                                newDataList: widget.dataListTabs[selectedIndexLocation2],
                                                                                                keyName1: 'gp_per1',
                                                                                                keyName2: 'gp_per2',
                                                                                                keyName3: 'gp_per3',
                                                                                              )
                                                                                            : CoverageTableTabSite(
                                                                                                newDataList: widget.dataListTabs[selectedIndexLocation2],
                                                                                                keyName1: 'gp_per1',
                                                                                                keyName2: 'gp_per2',
                                                                                                keyName3: 'gp_per3',
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
                              : widget.selectedIndex1 == 2
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
                                                sheetProvider.isLoaderActive ==
                                                        true
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : Column(
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
                                                                selectedMonth = widget.dataListBillingTabs[selectedIndexLocation3][0]['month1'];
                                                                // selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                                sheetProvider.myStringMonthGP = selectedMonth;
                                                                return TabsBodyTable(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedIndexLocation3 =
                                                                          outerIndex3;
                                                                      sheetProvider
                                                                              .selectedChannelIndex =
                                                                          outerIndex3;
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
                                                                              .selectedChannelMonth =
                                                                          finalMonth;
                                                                      sheetProvider.removeIndexGP = selectedIndexLocation3;
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
                                                                      "${widget.dataListBillingTabs[outerIndex3][0]['filter_key']} / ${widget.dataListBillingTabs[outerIndex3][0]['month1']}", onClosedTap: widget.onClosedTap,
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
                                                                              title: "${widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key']} / ${widget.dataListBillingTabs[selectedIndexLocation3][0]['month1']}${widget.dataListBillingTabs[selectedIndexLocation3][0]['channel'].isEmpty?'': '/ ${widget.dataListBillingTabs[selectedIndexLocation3][0]['channel']}'} ",
                                                                            ),
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
                                                                                                keyName1: 'gp_abs1',
                                                                                                keyName2: 'gp_abs2',
                                                                                                keyName3: 'gp_abs3',
                                                                                              )
                                                                                            : widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'N-E' || widget.dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] == 'S-W'
                                                                                                ? CoverageTableTabDivision(
                                                                                                    newDataList: widget.dataListBillingTabs[selectedIndexLocation3],
                                                                                                    keyName1: 'gp_abs1',
                                                                                                    keyName2: 'gp_abs2',
                                                                                                    keyName3: 'gp_abs3',
                                                                                                  )
                                                                                                : CoverageTableTabSite(
                                                                                                    newDataList: widget.dataListBillingTabs[selectedIndexLocation3],
                                                                                                    keyName1: 'gp_abs1',
                                                                                                    keyName2: 'gp_abs2',
                                                                                                    keyName3: 'gp_abs3',
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
                  const ExcelImportButton(),
                ],
              ),
            ),
            FiltersAllCategory(
              // FiltersChannel(
              selectedMonthList:widget.selectedIndex1 == 0?
              (widget.dataList).isEmpty?'Select..':
              widget.dataList[0][0]['month']:
              widget.selectedIndex1 == 1?(widget.dataListCCTabs).isEmpty?'Loading..':
              widget.dataListCCTabs[0][0]['month']:
              widget.selectedIndex1 == 2?(widget.dataListTabs).isEmpty?'Loading..':
              widget.dataListTabs[0][0]['month1']:
              widget.selectedIndex1 == 3?(widget.dataListBillingTabs).isEmpty?'Loading..':
              widget.dataListBillingTabs[0][0]['month1']:"" ,
              // (widget.dataList).isEmpty?'Loading..':selectedMonth,
              // widget.dataList[selectedIndexLocation][0]['month'],
              onTapMonthFilter: widget.onTapMonthFilter,
              selectedChannelList:
              widget.selectedIndex1 == 0?
              (widget.dataList).isEmpty?'Select..':
              widget.dataList[0][0]['channel']:
              widget.selectedIndex1 == 1?(widget.dataListCCTabs).isEmpty?'Loading..':
              widget.dataListCCTabs[0][0]['channel']:
              widget.selectedIndex1 == 2?(widget.dataListTabs).isEmpty?'Loading..':
              widget.dataListTabs[0][0]['channel']:
              widget.selectedIndex1 == 3?(widget.dataListBillingTabs).isEmpty?'Loading..':
              widget.dataListBillingTabs[0][0]['channel']:"" ,
              onTapChannelFilter:  widget.onTapChannelFilter, attributeName: 'FB', categoryApply: widget.categoryApply,
            )
            // FiltersRetailing(
            //   clusterCount: clusterCount,
            //   onChangedFilter: widget.onChangedFilter,
            //   selectedItemValueChannel: widget.selectedItemValueChannel,
            //   onChangedFilterMonth: widget.onChangedFilterMonth,
            //   selectedItemValueChannelMonth:
            //       widget.selectedItemValueChannelMonth,
            //   onChangedFilterBrand: widget.onChangedFilterBrand,
            //   selectedItemValueChannelBrand:
            //       widget.selectedItemValueChannelBrand,
            //   categoryApply: widget.categoryApply,
            //   fbFilter: 'FB',selectedMonth: selectedMonth.isEmpty ?"Select..": selectedMonth,
            //   onRemoveFilter: widget.onRemoveFilterTap, selectedMonthList: selectedMonth.isEmpty ?"Select..": selectedMonth, onTapMonthFilter: widget.onTapMonthFilter,
            //   onRemoveFilterCategory: widget.onRemoveFilterCategory, selectedCategoryList: '',
            //   selectedItemValueCategory: widget.selectedItemValueCategory,
            //   selectedItemValueBrand: widget.selectedItemValueBrand,
            //   selectedItemValueBrandForm: widget.selectedItemValueBrandForm,
            //   selectedItemValueBrandFromGroup: widget.selectedItemValueBrandFromGroup,
            // )
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
