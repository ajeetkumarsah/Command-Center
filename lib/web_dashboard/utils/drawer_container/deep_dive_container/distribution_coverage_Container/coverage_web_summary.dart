import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/coverage_division.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/coverage_month.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/excel_button.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/back_button_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/custome_header_title.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_geo_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_month_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/table_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_body_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_sizedbox_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/text_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_channel.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filters_retailing.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:command_centre/web_dashboard/utils/table/table%20productivity/table_billing.dart';
import 'package:command_centre/web_dashboard/utils/table/table%20productivity/table_cc.dart';
import 'package:command_centre/web_dashboard/utils/table/table%20productivity/table_productivity.dart';
import 'package:command_centre/web_dashboard/utils/table/table_division.dart';
import 'package:command_centre/web_dashboard/utils/table/table_site.dart';
import 'package:command_centre/web_dashboard/utils/table/table_tabs/division_table_tab.dart';
import 'package:command_centre/web_dashboard/utils/table/table_tabs/site_table_tab.dart';
import 'package:command_centre/web_dashboard/utils/table/tables_retailing.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../activities/coverage_screen.dart';
import '../../../../../../model/data_table_model.dart';
import '../../../../../../provider/sheet_provider.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../../utils/style/text_style.dart';

class CoverageWebSummary extends StatefulWidget {
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
  final List<String> selectedItemValueChannel;
  final List<String> selectedItemValueChannelMonth;
  final String selectedMonthList;
  final Function() onTapMonthFilter;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final Function() onTap4;
  final Function() tryAgain;
  final Function() tryAgain1;
  final Function() tryAgain2;
  final Function() tryAgain3;
  final int selectedIndex1;
  final String selectedChannelList;
  final Function() onTapChannelFilter;
  final Function() onTapRemoveFilter;
  final int selectedIndexLocation;

  const CoverageWebSummary({Key? key,
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
    required this.dataList, required this.onChangedFilter, required this.selectedItemValueChannel, required this.onChangedFilterMonth, required this.selectedItemValueChannelMonth, required this.onApplyPressedMonthCHRTab, required this.dataListTabs, required this.dataListBillingTabs, required this.dataListCCTabs, required this.onClosedTap, required this.selectedMonthList, required this.onTapMonthFilter, required this.onTap1, required this.onTap2, required this.onTap3, required this.onTap4, required this.selectedIndex1, required this.selectedChannelList, required this.onTapChannelFilter, required this.onTapRemoveFilter, required this.selectedIndexLocation, required this.tryAgain, required this.tryAgain1, required this.tryAgain2, required this.tryAgain3})
      : super(key: key);

  @override
  State<CoverageWebSummary> createState() => _CoverageWebSummaryState();
}

class _CoverageWebSummaryState extends State<CoverageWebSummary> {

  List arrayRetailing = [
    'Consolidated View',
    'Call Hit Rate',
    'Productivity',
    'PxM Billing',
  ];

  late ScrollController _scrollController;
  late ScrollController _scrollController1;
  late ScrollController scrollController2;

  bool visible = false;
  bool addSite = false;
  bool monthBool = false;
  bool distBool = false;
  var isExpanded = false;

  bool addGeoBool = false;
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  bool highlighted = false;
  int selectedAddIndex = -1;
  int selectedIndexRetailing = 1;
  int selectedIndexLocation = 0;
  int selectedIndexLocation1 = 0;
  int selectedIndexLocation2 = 0;
  int selectedIndexLocation3 = 0;
  int select = 0;
  late List<DataTableWebModel> rowData;

  List clusterCount = [];
  late ScrollController _scrollControllerTable;

  String selectedValueCategory = '';
  String selectedValueCategory1 = '';
  String selectedValueCategory2 = '';
  String selectedValueCategory3 = '';
  String selectedMonth = '';
  List selectedChannel = [];

  postRequest(context) async {
    if (true) {
      setState(() {

        final List<String> headers = [
          'Month',
          'Division',
          'Site',
          'Branch',
          'Channel',
          'SubChannel',
          'filter_key',
          'billed_sum',
          'Coverage',
          'pc_sum',
          'tc_sum',
          'billing_per',
          'productivity_per',
        ];

        final excel = Excel.createExcel();
        final sheet = excel['Sheet1'];

        // Write headers to the sheet
        sheet.appendRow(headers);

        // Iterate through the JSON data and populate the Excel sheet
        for (var monthData in widget.dataList) {
          if (monthData is List<dynamic>) {
            for (var data in monthData) {
              if (data is Map<String, dynamic>) {
                _processData(data, sheet, [''], headers);
              }
            }
          }
        }

        // Save the Excel file
        excel.save();
      });
    } else {
    }
  }

  void _processData(
      Map<String, dynamic> data,
      Sheet sheet,
      List<String> path,
      List<String> headers,
      ) {
    for (var entry in data.entries) {
      var newPath = List<String>.from(path)..add(entry.key);

      if (entry.value is Map<String, dynamic>) {
        _processData(entry.value, sheet, newPath, headers);
      } else if (entry.value is List<dynamic>) {
        for (var nestedData in entry.value) {
          if (nestedData is Map<String, dynamic>) {
            _processData(nestedData, sheet, newPath, headers);
          }
        }
      } else {
        _writeRow(data, sheet, newPath, headers);
      }
    }
  }

  void _writeRow(
      Map<String, dynamic> data,
      Sheet sheet,
      List<String> path,
      List<String> headers,
      ) {
    // Initialize the row with empty values
    List<String> row = List.filled(headers.length, '');

    // Update the row with the actual data
    for (int i = 0; i < path.length; i++) {
      if (headers.contains(path[i])) {
        row[headers.indexOf(path[i])] = data[path[i]].toString();
      }
    }

    // Write the row to the sheet
    sheet.appendRow(row);
  }

  @override
  void initState() {
    rowData = DataTableWebModel.getRowsDataGP();
    super.initState();
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    scrollController2 = ScrollController();
    _scrollControllerTable = ScrollController();

    // selectedIndexLocation = widget.selectedIndexLocation;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
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
                    title: 'Coverage & Distribution / ${widget.selectedIndex1 ==
                        0 ? "Consolidated View" : widget.selectedIndex1 == 1
                        ? "Call Hit Rate"
                        : widget.selectedIndex1 == 2 ? "Productivity" : widget
                        .selectedIndex1 == 3 ? "PxM Billing" : ""}',
                    subTitle: 'Coverage & Distribution',
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
                  widget.selectedIndex1 == 0 ? Expanded(
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
                              sheetProvider.coverageErrorMsg.isNotEmpty
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
                              )
                                  :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: MyColors.dark400,
                                    height: 42,
                                    width: size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.dataList.length,
                                      itemBuilder: (context, outerIndex) {
                                        selectedChannel = widget
                                            .dataList[selectedIndexLocation][0]['channel'];

                                        sheetProvider.selectedChannelSite =
                                        widget
                                            .dataList[selectedIndexLocation][0]['filter_key'];
                                        sheetProvider.selectedChannelDivision =
                                            findDatasetName(widget
                                                .dataList[selectedIndexLocation][0]['filter_key']);
                                        SharedPreferencesUtils.setString(
                                            'divisionChannelSelected',
                                            findDatasetName(widget
                                                .dataList[selectedIndexLocation][0]['filter_key']));
                                        SharedPreferencesUtils.setString(
                                            'siteChannelSelected', widget
                                            .dataList[selectedIndexLocation][0]['filter_key']);
                                        selectedMonth = widget
                                            .dataList[selectedIndexLocation][0]['month'];
                                        sheetProvider.myStringMonth =
                                            selectedMonth;
                                        sheetProvider.selectedChannelIndex =
                                            selectedIndexLocation;


                                        return TabsBodyTable(
                                          onTap: () {
                                            setState(() {
                                              selectedIndexLocation =
                                                  outerIndex;
                                              sheetProvider
                                                  .selectedChannelIndex =
                                                  selectedIndexLocation;
                                              sheetProvider
                                                  .selectedChannelDivision =
                                                  findDatasetName(widget
                                                      .dataList[outerIndex][0]['filter_key']);
                                              sheetProvider
                                                  .selectedChannelMonth =
                                              widget
                                                  .dataList[outerIndex][0]['month'];
                                              // var channels = widget
                                              //     .dataList[outerIndex][0]['division'][0]['Site'][0]['Branch'][0]['Channel']
                                              //     .length;
                                              // if (channels > 1) {
                                              //   selectedValueCategory =
                                              //   '';
                                              // } else {
                                              //   selectedValueCategory =
                                              //   widget
                                              //       .dataList[outerIndex][0]['division'][0]['Site'][0]['Branch'][0]['Channel'][0]['filter_key'];
                                              // }
                                              sheetProvider.removeIndexCC =
                                                  selectedIndexLocation;
                                              selectedMonth = widget
                                                  .dataList[selectedIndexLocation][0]['month'];
                                              selectedChannel = widget
                                                  .dataList[selectedIndexLocation][0]['channel'];
                                              sheetProvider.isExpandedDivision = false;
                                              sheetProvider.isExpanded = false;
                                              sheetProvider.isExpandedBranch = false;
                                              sheetProvider.isExpandedChannel = false;
                                              sheetProvider.isExpandedSubChannel = false;
                                            });
                                          },
                                          onTapGes: () {
                                            setState(() {
                                              selectedIndex =
                                              selectedIndex == outerIndex
                                                  ? -1
                                                  : outerIndex;
                                              sheetProvider.isExpanded ==
                                                  true;
                                            });
                                          },
                                          selectedIndexLocation:
                                          selectedIndexLocation,
                                          outerIndex: outerIndex,
                                          title:
                                          "${widget
                                              .dataList[outerIndex][0]['filter_key']} / ${widget
                                              .dataList[outerIndex][0]['month']}",
                                          onClosedTap: widget.onClosedTap,);
                                      },
                                    ),
                                  ),
                                  // Container B (conditionally shown)
                                  if (selectedIndexLocation != -1)
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child:
                                      widget.dataList.isEmpty
                                          ? const Center(
                                          child:
                                          CircularProgressIndicator())
                                          :
                                      SingleChildScrollView(
                                        child: Container(
                                          width: size.width,

                                          decoration: const BoxDecoration(
                                              color: MyColors.whiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))
                                          ),
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
                                                  "${widget
                                                      .dataList[selectedIndexLocation][0]['filter_key']} / ${widget
                                                      .dataList[selectedIndexLocation][0]['month']}  ${widget
                                                      .dataList[selectedIndexLocation][0]['channel']
                                                      .isEmpty
                                                      ? ''
                                                      : '/ ${widget
                                                      .dataList[selectedIndexLocation][0]['channel']}'}"),
                                              Scrollbar(
                                                controller: _scrollControllerTable,
                                                child: SingleChildScrollView(
                                                  controller: _scrollControllerTable,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(20))
                                                    ),
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 400,
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height - 410,
                                                    child: Column(children: [
                                                      CustomHeaderTitle(
                                                        dataList:
                                                        widget.dataList,
                                                        selectedIndexLocation:
                                                        selectedIndexLocation,
                                                        per:
                                                        'Coverage',
                                                        points:
                                                        'Billing %',
                                                        target:
                                                        'Productivity %',
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            bottom: 8.0),
                                                        child:
                                                        widget
                                                            .dataList[selectedIndexLocation][0]['filter_key'] ==
                                                            'All India' ||
                                                            widget
                                                                .dataList[selectedIndexLocation][0]['filter_key'] ==
                                                                'allIndia' ?
                                                        CoverageTableData(
                                                          newDataList: widget
                                                              .dataList[selectedIndexLocation], key1: 'Coverage', key2: 'billing_per', key3: 'productivity_per',
                                                        )
                                                            : widget
                                                            .dataList[selectedIndexLocation][0]['filter_key'] ==
                                                            'N-E' || widget
                                                            .dataList[selectedIndexLocation][0]['filter_key'] ==
                                                            'S-W' ?
                                                        CoverageTableDivision(
                                                          newDataList: widget
                                                              .dataList[selectedIndexLocation], key1: 'Coverage', key2: 'billing_per', key3: 'productivity_per',
                                                        ) : CoverageTableSite(
                                                          newDataList: widget
                                                              .dataList[selectedIndexLocation], key1: 'Coverage', key2: 'billing_per', key3: 'productivity_per',
                                                        ),
                                                      ),
                                                    ],),
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
                  ) :
                  widget.selectedIndex1 == 1 ? Expanded(
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
                              sheetProvider.coverage1ErrorMsg.isNotEmpty
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
                              )
                                  :Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: MyColors.dark400,
                                    height: 42,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.dataListCCTabs.length,
                                      itemBuilder: (context, outerIndex1) {
                                        sheetProvider.selectedChannelSite =
                                        widget
                                            .dataListCCTabs[selectedIndexLocation1][0]['filter_key'];
                                        // var x
                                        selectedMonth = widget
                                            .dataListCCTabs[selectedIndexLocation1][0]['month1'];
                                        selectedChannel = widget
                                            .dataListCCTabs[selectedIndexLocation1][0]['channel'];
                                        sheetProvider.selectedChannelFromAPI =
                                        widget
                                            .dataListCCTabs[selectedIndexLocation1][0]['channel'];
                                        SharedPreferencesUtils.setString(
                                            'divisionChannelSelected1',
                                            findDatasetName(widget
                                                .dataListCCTabs[selectedIndexLocation1][0]['filter_key']));
                                        SharedPreferencesUtils.setString(
                                            'siteChannelSelected1', widget
                                            .dataListCCTabs[selectedIndexLocation1][0]['filter_key']);
                                        sheetProvider.selectedChannelIndex =
                                            selectedIndexLocation1;
                                        return TabsBodyTable(
                                          onTap: () {
                                            setState(() {
                                              selectedIndexLocation1 =
                                                  outerIndex1;
                                              sheetProvider
                                                  .selectedChannelIndex =
                                                  selectedIndexLocation1;
                                              sheetProvider
                                                  .selectedChannelDivision =
                                                  findDatasetName(widget
                                                      .dataListCCTabs[outerIndex1][0]['filter_key']);
                                              var formattedMonth = widget
                                                  .dataListCCTabs[outerIndex1][0]['month1'];
                                              String year = formattedMonth
                                                  .substring(2, 6);
                                              String month = formattedMonth
                                                  .substring(7);
                                              var finalMonth = "$month-$year";
                                              sheetProvider
                                                  .selectedChannelMonth =
                                                  finalMonth;
                                              sheetProvider.removeIndexCC =
                                                  selectedIndexLocation1;
                                              selectedMonth = widget
                                                  .dataListCCTabs[selectedIndexLocation1][0]['month1'];
                                              selectedChannel = widget
                                                  .dataListCCTabs[selectedIndexLocation1][0]['channel'];
                                              sheetProvider.isExpandedDivision = false;
                                              sheetProvider.isExpanded = false;
                                              sheetProvider.isExpandedBranch = false;
                                              sheetProvider.isExpandedChannel = false;
                                              sheetProvider.isExpandedSubChannel = false;
                                            });
                                          },
                                          onTapGes: () {
                                            setState(() {
                                              selectedIndex =
                                              selectedIndex == outerIndex1
                                                  ? -1
                                                  : outerIndex1;
                                              sheetProvider.isExpanded ==
                                                  true;
                                            });
                                          },
                                          selectedIndexLocation:
                                          selectedIndexLocation1,
                                          outerIndex: outerIndex1,
                                          title:
                                          "${widget
                                              .dataListCCTabs[outerIndex1][0]['filter_key']} / ${widget
                                              .dataListCCTabs[outerIndex1][0]['month1']}",
                                          onClosedTap: widget.onClosedTap,);
                                      },
                                    ),
                                  ),
                                  // Container B (conditionally shown)
                                  if (selectedIndexLocation1 != -1)
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: widget.dataListCCTabs.isEmpty
                                          ? const Center(
                                          child:
                                          CircularProgressIndicator())
                                          : SingleChildScrollView(
                                        child: Container(
                                          width: size.width,

                                          decoration: const BoxDecoration(
                                              color: MyColors.whiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))
                                          ),
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

                                                  title: "${widget
                                                      .dataListCCTabs[selectedIndexLocation1][0]['filter_key']} / ${widget
                                                      .dataListCCTabs[selectedIndexLocation1][0]['month1']}  ${widget
                                                      .dataListCCTabs[selectedIndexLocation1][0]['channel']
                                                      .isEmpty
                                                      ? ''
                                                      : '/ ${widget
                                                      .dataListCCTabs[selectedIndexLocation1][0]['channel']}'}"),
                                              // "${widget
                                              //     .dataListCCTabs[selectedIndexLocation1][0]['filter_key']} / ${widget
                                              //     .dataListCCTabs[selectedIndexLocation1][0]['month1']} / $selectedValueCategory1",
                                              // ),
                                              Scrollbar(
                                                controller: _scrollControllerTable,
                                                child: SingleChildScrollView(
                                                  controller: _scrollControllerTable,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      // color: MyColors.textColor,
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(20))
                                                    ),
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 400,
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height - 410,
                                                    child: Column(children: [
                                                      CustomHeaderTitle(
                                                        dataList:
                                                        widget.dataListCCTabs,
                                                        selectedIndexLocation:
                                                        selectedIndexLocation1,
                                                        per:
                                                        widget
                                                            .dataListCCTabs[selectedIndexLocation1][0]['month1'],
                                                        points:
                                                        widget
                                                            .dataListCCTabs[selectedIndexLocation1][0]['month2'],
                                                        target:
                                                        widget
                                                            .dataListCCTabs[selectedIndexLocation1][0]['month3'],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            bottom: 8.0),
                                                        child:
                                                        // CoverageTableDataCC(newDataList: widget.dataListCCTabs[selectedIndexLocation],)
                                                        widget
                                                            .dataListCCTabs[selectedIndexLocation1][0]['filter_key'] ==
                                                            'All India' ||
                                                            widget
                                                                .dataListCCTabs[selectedIndexLocation1][0]['filter_key'] ==
                                                                'allIndia' ?
                                                        CoverageTableDataCC(
                                                          newDataList: widget
                                                              .dataListCCTabs[selectedIndexLocation1],
                                                        )
                                                            : widget
                                                            .dataListCCTabs[selectedIndexLocation1][0]['filter_key'] ==
                                                            'N-E' || widget
                                                            .dataListCCTabs[selectedIndexLocation1][0]['filter_key'] ==
                                                            'S-W'
                                                            ?
                                                        CoverageTableTabDivision(
                                                          newDataList: widget
                                                              .dataListCCTabs[selectedIndexLocation1],
                                                          keyName1: 'cc_per1',
                                                          keyName2: 'cc_per2',
                                                          keyName3: 'cc_per3',
                                                        )
                                                            : CoverageTableTabSite(
                                                            newDataList: widget
                                                                .dataListCCTabs[selectedIndexLocation1],
                                                            keyName1: 'cc_per1',
                                                            keyName2: 'cc_per2',
                                                            keyName3: 'cc_per3'
                                                        ),
                                                      ),
                                                    ],),
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
                  ) :
                  widget.selectedIndex1 == 2 ? Expanded(
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
                              sheetProvider.coverage2ErrorMsg.isNotEmpty
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
                              )
                                  :Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: MyColors.dark400,
                                    height: 42,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.dataListTabs.length,
                                      itemBuilder: (context, outerIndex2) {
                                        sheetProvider.selectedChannelSite =
                                        widget
                                            .dataListTabs[selectedIndexLocation2][0]['filter_key'];
                                        selectedMonth = widget
                                            .dataListTabs[selectedIndexLocation2][0]['month1'];
                                        selectedChannel = widget
                                            .dataListTabs[selectedIndexLocation2][0]['channel'];
                                        sheetProvider.selectedChannelFromAPI =
                                        widget
                                            .dataListTabs[selectedIndexLocation2][0]['channel'];
                                        SharedPreferencesUtils.setString(
                                            'divisionChannelSelected2',
                                            findDatasetName(widget
                                                .dataListTabs[selectedIndexLocation2][0]['filter_key']));
                                        SharedPreferencesUtils.setString(
                                            'siteChannelSelected2', widget
                                            .dataListTabs[selectedIndexLocation2][0]['filter_key']);
                                        sheetProvider.selectedChannelIndex =
                                            selectedIndexLocation2;
                                        return TabsBodyTable(
                                          onTap: () {
                                            setState(() {
                                              selectedIndexLocation2 =
                                                  outerIndex2;
                                              sheetProvider
                                                  .selectedChannelIndex =
                                                  selectedIndexLocation2;
                                              sheetProvider
                                                  .selectedChannelDivision =
                                                  findDatasetName(widget
                                                      .dataListTabs[outerIndex2][0]['filter_key']);
                                              var formattedMonth = widget
                                                  .dataListTabs[outerIndex2][0]['month1'];
                                              String year = formattedMonth
                                                  .substring(2, 6);
                                              String month = formattedMonth
                                                  .substring(7);
                                              var finalMonth = "$month-$year";
                                              sheetProvider
                                                  .selectedChannelMonth =
                                                  finalMonth;
                                              sheetProvider.removeIndexCC =
                                                  selectedIndexLocation2;
                                              selectedMonth = widget
                                                  .dataListTabs[selectedIndexLocation2][0]['month1'];
                                              selectedChannel = widget
                                                  .dataListTabs[selectedIndexLocation2][0]['channel'];
                                              sheetProvider.isExpandedDivision = false;
                                              sheetProvider.isExpanded = false;
                                              sheetProvider.isExpandedBranch = false;
                                              sheetProvider.isExpandedChannel = false;
                                              sheetProvider.isExpandedSubChannel = false;
                                            });
                                          },
                                          onTapGes: () {
                                            setState(() {
                                              selectedIndex =
                                              selectedIndex == outerIndex2
                                                  ? -1
                                                  : outerIndex2;
                                              sheetProvider.isExpanded ==
                                                  true;
                                            });
                                          },
                                          selectedIndexLocation:
                                          selectedIndexLocation2,
                                          outerIndex: outerIndex2,
                                          title:
                                          "${widget
                                              .dataListTabs[outerIndex2][0]['filter_key']} / ${widget
                                              .dataListTabs[outerIndex2][0]['month1']}",
                                          onClosedTap: widget.onClosedTap,);
                                      },
                                    ),
                                  ),
                                  // Container B (conditionally shown)
                                  if (selectedIndexLocation2 != -1)
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: widget.dataListTabs.isEmpty
                                          ? const Center(
                                          child:
                                          CircularProgressIndicator())
                                          : SingleChildScrollView(
                                        child: Container(
                                          width: size.width,

                                          decoration: const BoxDecoration(
                                              color: MyColors.whiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))
                                          ),
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
                                                  title: "${widget
                                                      .dataListTabs[selectedIndexLocation2][0]['filter_key']} / ${widget
                                                      .dataListTabs[selectedIndexLocation2][0]['month1']}  ${widget
                                                      .dataListTabs[selectedIndexLocation2][0]['channel']
                                                      .isEmpty
                                                      ? ''
                                                      : '/ ${widget
                                                      .dataListTabs[selectedIndexLocation2][0]['channel']}'}"
                                                // title:
                                                // widget
                                                //     .dataListTabs[selectedIndexLocation2][0]['filter_key'],
                                              ),
                                              Scrollbar(
                                                controller: _scrollControllerTable,
                                                child: SingleChildScrollView(
                                                  controller: _scrollControllerTable,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      // color: MyColors.textColor,
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(20))
                                                    ),
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 400,
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height - 410,
                                                    child: Column(children: [
                                                      CustomHeaderTitle(
                                                        dataList:
                                                        widget.dataListTabs,
                                                        selectedIndexLocation:
                                                        selectedIndexLocation2,
                                                        per:
                                                        widget
                                                            .dataListTabs[selectedIndexLocation2][0]['month1'],
                                                        points:
                                                        widget
                                                            .dataListTabs[selectedIndexLocation2][0]['month2'],
                                                        target:
                                                        widget
                                                            .dataListTabs[selectedIndexLocation2][0]['month3'],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            bottom: 8.0),
                                                        child:
                                                        // CoverageTableDataProductivity(newDataList: widget.dataListTabs[selectedIndexLocation],)
                                                        widget
                                                            .dataListTabs[selectedIndexLocation2][0]['filter_key'] ==
                                                            'All India' ||
                                                            widget
                                                                .dataListTabs[selectedIndexLocation2][0]['filter_key'] ==
                                                                'allIndia' ?
                                                        CoverageTableDataProductivity(
                                                          newDataList: widget
                                                              .dataListTabs[selectedIndexLocation2],
                                                          key1: 'productivity_per1',
                                                          key2: 'productivity_per2',
                                                          key3: 'productivity_per3',
                                                        ) : widget
                                                            .dataListTabs[selectedIndexLocation2][0]['filter_key'] ==
                                                            'N-E' || widget
                                                            .dataListTabs[selectedIndexLocation2][0]['filter_key'] ==
                                                            'S-W'
                                                            ?
                                                        CoverageTableTabDivision(
                                                          newDataList: widget
                                                              .dataListTabs[selectedIndexLocation2],
                                                          keyName1: 'productivity_per1',
                                                          keyName2: 'productivity_per2',
                                                          keyName3: 'productivity_per3',
                                                        )
                                                            : CoverageTableTabSite(
                                                            newDataList: widget
                                                                .dataListTabs[selectedIndexLocation2],
                                                            keyName1: 'productivity_per1',
                                                            keyName2: 'productivity_per2',
                                                            keyName3: 'productivity_per3'
                                                        ),
                                                      ),
                                                    ],),
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
                  ) :
                  widget.selectedIndex1 == 3 ? Expanded(
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
                              sheetProvider.coverage3ErrorMsg.isNotEmpty
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
                              )
                                  :Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: MyColors.dark400,
                                    height: 42,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.dataListBillingTabs
                                          .length,
                                      itemBuilder: (context, outerIndex3) {
                                        sheetProvider.selectedChannelSite =
                                        widget
                                            .dataListBillingTabs[selectedIndexLocation3][0]['filter_key'];
                                        selectedMonth = widget
                                            .dataListBillingTabs[selectedIndexLocation3][0]['month1'];
                                        selectedChannel = widget
                                            .dataListBillingTabs[selectedIndexLocation3][0]['channel'];
                                        sheetProvider.selectedChannelFromAPI =
                                        widget
                                            .dataListBillingTabs[selectedIndexLocation3][0]['channel'];
                                        SharedPreferencesUtils.setString(
                                            'divisionChannelSelected3',
                                            findDatasetName(widget
                                                .dataListBillingTabs[selectedIndexLocation3][0]['filter_key']));
                                        SharedPreferencesUtils.setString(
                                            'siteChannelSelected3', widget
                                            .dataListBillingTabs[selectedIndexLocation3][0]['filter_key']);
                                        sheetProvider.selectedChannelIndex =
                                            selectedIndexLocation3;
                                        return TabsBodyTable(
                                          onTap: () {
                                            setState(() {
                                              selectedIndexLocation3 =
                                                  outerIndex3;

                                              sheetProvider
                                                  .selectedChannelIndex =
                                                  selectedIndexLocation3;
                                              sheetProvider
                                                  .selectedChannelDivision =
                                                  findDatasetName(widget
                                                      .dataListBillingTabs[selectedIndexLocation3][0]['filter_key']);
                                              var formattedMonth = widget
                                                  .dataListBillingTabs[selectedIndexLocation3][0]['month1'];
                                              String year = formattedMonth
                                                  .substring(2, 6);
                                              String month = formattedMonth
                                                  .substring(7);
                                              var finalMonth = "$month-$year";
                                              sheetProvider
                                                  .selectedChannelMonth =
                                                  finalMonth;
                                              sheetProvider.removeIndexCC =
                                                  selectedIndexLocation3;
                                              selectedMonth = widget
                                                  .dataListBillingTabs[selectedIndexLocation3][0]['month1'];
                                              selectedChannel = widget
                                                  .dataListBillingTabs[selectedIndexLocation3][0]['channel'];
                                              sheetProvider.isExpandedDivision = false;
                                              sheetProvider.isExpanded = false;
                                              sheetProvider.isExpandedBranch = false;
                                              sheetProvider.isExpandedChannel = false;
                                              sheetProvider.isExpandedSubChannel = false;
                                            });
                                          },
                                          onTapGes: () {
                                            setState(() {
                                              selectedIndex =
                                              selectedIndex == outerIndex3
                                                  ? -1
                                                  : outerIndex3;
                                              sheetProvider.isExpanded ==
                                                  true;
                                            });
                                          },
                                          selectedIndexLocation:
                                          selectedIndexLocation3,
                                          outerIndex: outerIndex3,
                                          title:
                                          "${widget
                                              .dataListBillingTabs[outerIndex3][0]['filter_key']} / ${widget
                                              .dataListBillingTabs[outerIndex3][0]['month1']}",
                                          onClosedTap: widget.onClosedTap,);
                                      },
                                    ),
                                  ),
                                  // Container B (conditionally shown)
                                  if (selectedIndexLocation3 != -1)
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: widget.dataListBillingTabs.isEmpty
                                          ? const Center(
                                          child:
                                          CircularProgressIndicator())
                                          : SingleChildScrollView(
                                        child: Container(
                                          width: size.width,

                                          decoration: const BoxDecoration(
                                              color: MyColors.whiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))
                                          ),
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
                                                  title: "${widget
                                                      .dataListBillingTabs[selectedIndexLocation3][0]['filter_key']} / ${widget
                                                      .dataListBillingTabs[selectedIndexLocation3][0]['month1']}  ${widget
                                                      .dataListBillingTabs[selectedIndexLocation3][0]['channel']
                                                      .isEmpty
                                                      ? ''
                                                      : '/ ${widget
                                                      .dataListBillingTabs[selectedIndexLocation3][0]['channel']}'}"
                                                // title:
                                                // widget
                                                //     .dataListBillingTabs[selectedIndexLocation3][0]['filter_key'],
                                              ),
                                              Scrollbar(
                                                controller: _scrollControllerTable,
                                                child: SingleChildScrollView(
                                                  controller: _scrollControllerTable,
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      // color: MyColors.textColor,
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(20))
                                                    ),
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width - 400,
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height - 410,
                                                    child: Column(children: [
                                                      CustomHeaderTitle(
                                                        dataList:
                                                        widget
                                                            .dataListBillingTabs,
                                                        selectedIndexLocation:
                                                        selectedIndexLocation3,
                                                        per:
                                                        widget
                                                            .dataListBillingTabs[selectedIndexLocation3][0]['month1'],
                                                        points:
                                                        widget
                                                            .dataListBillingTabs[selectedIndexLocation3][0]['month2'],
                                                        target:
                                                        widget
                                                            .dataListBillingTabs[selectedIndexLocation3][0]['month3'],
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            bottom: 8.0),
                                                        child:
                                                        // CoverageTableDataBilling(newDataList: widget.dataListBillingTabs[selectedIndexLocation],)
                                                        widget
                                                            .dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] ==
                                                            'All India' ||
                                                            widget
                                                                .dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] ==
                                                                'allIndia' ?
                                                        CoverageTableDataBilling(
                                                          newDataList: widget
                                                              .dataListBillingTabs[selectedIndexLocation3],
                                                        ) : widget
                                                            .dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] ==
                                                            'N-E' || widget
                                                            .dataListBillingTabs[selectedIndexLocation3][0]['filter_key'] ==
                                                            'S-W'
                                                            ?
                                                        CoverageTableTabDivision(
                                                          newDataList: widget
                                                              .dataListBillingTabs[selectedIndexLocation3],
                                                          keyName1: 'billing_per1',
                                                          keyName2: 'billing_per2',
                                                          keyName3: 'billing_per3',
                                                        )
                                                            : CoverageTableTabSite(
                                                          newDataList: widget
                                                              .dataListBillingTabs[selectedIndexLocation3],
                                                          keyName1: 'billing_per1',
                                                          keyName2: 'billing_per2',
                                                          keyName3: 'billing_per3',
                                                        ),
                                                      ),
                                                    ],),
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
                  ) :
                  Container(),
                  ExcelImportButton(onClickExcel: () async{

                    setState(() {});
                    await postRequest(context);
                  },),
                ],
              ),
            ),
            // FiltersChannel(
            //   selectedMonthList: (widget.dataList).isEmpty?'Select..':selectedMonth,
            //   onTapMonthFilter: widget.onTapMonthFilter,
            //   selectedChannelList:
            //   (widget.dataList).isEmpty?'Select..':
            //   selectedChannel,
            //   onTapChannelFilter:  widget.onTapChannelFilter, onTapRemoveFilter:  widget.onTapRemoveFilter,
            // )
            FiltersChannel(
              selectedMonthList: widget.selectedIndex1 == 0
                  ? (widget.dataList).isEmpty
                  ? 'Select..'
                  : widget.dataList[selectedIndexLocation][0]['month']
                  : widget.selectedIndex1 == 1
                  ? (widget.dataListCCTabs).isEmpty
                  ? 'Select..'
                  : widget.dataListCCTabs[selectedIndexLocation1][0]
              ['month1']
                  : widget.selectedIndex1 == 2
                  ? (widget.dataListTabs).isEmpty
                  ? 'Select..'
                  : widget.dataListTabs[selectedIndexLocation2][0]
              ['month1']
                  : widget.selectedIndex1 == 3
                  ? (widget.dataListBillingTabs).isEmpty
                  ? 'Select..'
                  : widget.dataListBillingTabs[selectedIndexLocation3]
              [0]['month1']
                  : "Select..",
              onTapMonthFilter: widget.onTapMonthFilter,
              selectedChannelList:
              widget.selectedIndex1 == 0
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
                  : widget.dataListBillingTabs[selectedIndexLocation3]
              [0]['channel']
                  : ['Select..'],
              onTapChannelFilter: widget.onTapChannelFilter, onTapRemoveFilter: widget.onTapRemoveFilter,
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
