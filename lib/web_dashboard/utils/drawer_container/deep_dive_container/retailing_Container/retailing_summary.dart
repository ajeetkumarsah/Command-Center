import 'dart:math';
import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/excel_button.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/back_button_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/custome_header_title.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_geo_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_month_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/retailing_custom_header.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/table_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_body_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/tabs_sizedbox_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/text_header_widget.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_all_category.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_channel.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filter_retailing_summary.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/filters_retailing.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:command_centre/web_dashboard/utils/table/retailing_table/retailing_allIndia_table.dart';
import 'package:command_centre/web_dashboard/utils/table/tables_retailing.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../../model/data_table_model.dart';
import '../../../../../../provider/sheet_provider.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../../utils/comman/retailing_table/retailing_table.dart';
import '../../../../../../utils/style/text_style.dart';
import '../../../../../activities/pglogin/model.dart';

class RetailingWebSummary extends StatefulWidget {
  final Function() onTap;
  final int selectedIndex;
  final bool highlighted;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final Function() onTap4;
  final int selectedIndex1;
  final List<dynamic> dataList;
  final List<dynamic> dataListByGeo;
  final Function() onClosedTap;
  final List divisionList;
  final List siteList;
  final List branchList;
  final int selectedGeo;
  final List clusterList;
  final Function() onApplyPressedMonth;
  final Function() onTapMonthFilter;
  final List<String> selectedItemValueChannel;
  final Function(String?) onChangedFilter;
  final Function() onRemoveFilter;
  final Function() categoryApply;
  final Function() onRemoveFilterCategory;
  final Function() onTapChannelFilter;
  final Function() onTapRemoveFilter;
  final Function() tryAgain;
  final Function() tryAgain1;
  final Function() tryAgain2;
  final Function() tryAgain3;
  final List<String> selectedItemValueCategory;
  final List<String> selectedItemValueBrand;
  final List<String> selectedItemValueBrandForm;
  final List<String> selectedItemValueBrandFromGroup;
  final String selectedMonthList;
  final Function() onTapSiteFilter;
  final Function() onTapBranchFilter;

  const RetailingWebSummary(
      {Key? key,
      required this.onTap,
      required this.selectedIndex,
      required this.highlighted,
      required this.onTap1,
      required this.onTap2,
      required this.onTap3,
      required this.onTap4,
      required this.selectedIndex1,
      required this.dataList,
      required this.onClosedTap,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo,
      required this.clusterList,
      required this.onApplyPressedMonth,
      required this.onTapMonthFilter,
      required this.selectedItemValueChannel,
      required this.onChangedFilter,
      required this.onRemoveFilter,
      required this.selectedItemValueCategory,
      required this.categoryApply,
      required this.onRemoveFilterCategory,
      required this.selectedItemValueBrand,
      required this.selectedItemValueBrandForm,
      required this.selectedItemValueBrandFromGroup,
      required this.selectedMonthList,
      required this.onTapChannelFilter,
      required this.dataListByGeo,
      required this.onTapRemoveFilter,
      required this.onTapSiteFilter,
      required this.onTapBranchFilter,
      required this.tryAgain,
      required this.tryAgain1,
      required this.tryAgain2,
      required this.tryAgain3})
      : super(key: key);

  @override
  State<RetailingWebSummary> createState() => _RetailingWebSummaryState();
}

class _RetailingWebSummaryState extends State<RetailingWebSummary> {
  List arrayDrawer = [
    'Summary',
    'Retailing',
    'Coverage & Distribution',
    'Golden Points',
    'Focus Brand',
    'Call Compliance',
    'Productivity',
    'Inventory',
    'Shipment',
    'Trends',
    'Templates',
    'View Abbreviations',
    'View Definitions'
  ];

  List arrayTitle = ['Month', 'Distribution Period', 'Month', 'Distribution Period', 'Month', 'Distribution Period', 'Month', 'Distribution Period'];

  List arrayRetailing = [
    'Daily Retailing Report',
    'Retailing by Geo',
    'Retailing by Category',
    'Retailing by Channel',
  ];
  List arrayLocation = [
    'Goa',
    'Cochin',
    'Bangalore',
    'Goa WS',
    '',
  ];

  List arrayDist = ['P1M', 'P3M', '', 'P6M', 'P12M', 'FYTD'];
  List arrayMonth = ['January', 'February', 'March', 'April', 'May'];
  List arrayYear = ['2023', '', '2022', '2021', '2020', '2019'];

  bool visible = false;
  bool addSite = false;
  bool monthBool = false;
  bool distBool = false;
  var isExpanded = false;

  int selectedIndex = 0;
  int selectedIndex2 = 0;
  bool highlighted = false;
  int selectedAddIndex = -1;
  int selectedIndexRetailing = 1;
  int selectedIndexLocation = 0;
  int selectedIndexLocation1 = 0;
  int selectedIndexLocation2 = 0;
  late List<DataTableWebModel> rowData;
  String selectedMonth = '';
  String _selectedMonth = '';

  late ScrollController _scrollController1;
  late ScrollController scrollController2;
  late ScrollController _scrollControllerTable;
  late ScrollController _scrollControllerTable1;
  bool addGeoBool = false;
  late ScrollController _scrollController3;
  ScrollController _controller = ScrollController();
  ScrollController _controller1 = ScrollController();
  ScrollController _controller2 = ScrollController();
  ScrollController _controller3 = ScrollController();

  Color getColor(Set<MaterialState> states) {
    return const Color(0x397992D2);
  }

  Color getColorGray(Set<MaterialState> states) {
    return const Color(0x157992D2);
  }

  List clusterCount = [];

  Future<void> clusterFilterAPI() async {
    // var url = 'https://run.mocky.io/v3/64496a8b-11ff-414b-b0ca-d7d861653287';
    var url = '$BASE_URL/api/appData/clusterFilter';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      setState(() {
        clusterCount = jsonResponse["data"];
        // print(clusterCount);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

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
        print('Excel file saved successfully.');
      });
    } else {}
  }

  late ScrollController _scrollController;

  @override
  void initState() {
    rowData = DataTableWebModel.getRowsDataGP();
    super.initState();
    _scrollController = ScrollController();
    _scrollController1 = ScrollController();
    scrollController2 = ScrollController();
    _scrollControllerTable = ScrollController();
    _scrollControllerTable1 = ScrollController();
    _scrollController3 = ScrollController();
    selectedMonth = widget.selectedMonthList;
    clusterFilterAPI();
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
                    // title: 'Retailing / Daily Retailing Report',
                    title:
                        "Retailing / ${widget.selectedIndex1 == 0 ? 'Daily Retailing Report' : widget.selectedIndex1 == 1 ? 'Retailing By Geo' : widget.selectedIndex1 == 2 ? 'Retailing By Category' : widget.selectedIndex1 == 3 ? 'Retailing By Channel' : ''}",
                    subTitle: 'Retailing',
                    showHide: false,
                    onPressed: () {},
                    onNewMonth: () {},
                    showHideRetailing: false,
                    onTapDefaultGoe: () {},
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 0, right: 0, bottom: 20),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Scrollbar(
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                controller: _scrollController,
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
                                decoration: BoxDecoration(color: MyColors.whiteColor, borderRadius: BorderRadius.circular(15)),
                                child: Stack(
                                  children: [
                                    sheetProvider.retailingErrorMsg.isNotEmpty
                                        ? Center(
                                            child: Column(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text('Something went wrong! Try Again'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                OutlinedButton(
                                                  onPressed: widget.tryAgain,
                                                  style: ButtonStyle(
                                                    side: MaterialStateProperty.all(const BorderSide(width: 1.0, color: MyColors.primary)),
                                                    shape:
                                                        MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                                                  ),
                                                  child: const Text(
                                                    "Try Again",
                                                    style: TextStyle(fontFamily: fontFamily, color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: MyColors.dark400,
                                                height: 42,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: widget.dataList.length,
                                                  itemBuilder: (context, outerIndex) {
                                                    sheetProvider.selectedChannelSite = widget.dataList[selectedIndexLocation][0]['filter_key1'];
                                                    sheetProvider.selectedChannelDivision =
                                                        findDatasetName(widget.dataList[selectedIndexLocation][0]['filter_key1']);
                                                    sheetProvider.selectedChannelMonthData = widget.dataList[outerIndex][0]['month'];
                                                    selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                    sheetProvider.myStringMonthFB = selectedMonth;
                                                    _selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                    selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                    sheetProvider.selectedChannelIndex = selectedIndexLocation;
                                                    return TabsBodyTable(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedIndexLocation = outerIndex;
                                                          sheetProvider.selectedChannelIndex = outerIndex;
                                                          sheetProvider.selectedChannelDivision =
                                                              findDatasetName(widget.dataList[outerIndex][0]['filter_key1']);
                                                          sheetProvider.selectedChannelMonthData = widget.dataList[outerIndex][0]['month'];
                                                          sheetProvider.selectedChannelCategory = widget.dataList[outerIndex][0]['channel'];
                                                          _selectedMonth = widget.dataList[outerIndex][0]['month'];
                                                          selectedMonth = widget.dataList[selectedIndexLocation][0]['month'];
                                                          // widget.selectedItemValueChannel = widget.dataList[outerIndex][0]['channel'];
                                                        });

                                                        sheetProvider.removeIndexRe = selectedIndexLocation;
                                                      },
                                                      onTapGes: () {
                                                        setState(() {
                                                          selectedIndex = selectedIndex == outerIndex ? -1 : outerIndex;
                                                          sheetProvider.isExpanded == true;
                                                        });
                                                      },
                                                      selectedIndexLocation: selectedIndexLocation,
                                                      outerIndex: outerIndex,
                                                      title:
                                                          "${widget.dataList[outerIndex][0]['filter_key1'] == 'allIndia' ? 'All India' : widget.dataList[outerIndex][0]['filter_key1']} / ${widget.dataList[outerIndex][0]['month']}",
                                                      onClosedTap: widget.onClosedTap,
                                                    );
                                                  },
                                                ),
                                              ),
                                              // Container B (conditionally shown)
                                              if (selectedIndexLocation != -1)
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: widget.dataList.isEmpty
                                                      ? const Center(child: CircularProgressIndicator())
                                                      : SingleChildScrollView(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                            child: Container(
                                                              width: size.width,
                                                              decoration: const BoxDecoration(
                                                                  color: MyColors.whiteColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                                                              child: Column(
                                                                children: [
                                                                  TableHeaderWidget(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        addGeoBool = !addGeoBool;
                                                                      });
                                                                    },
                                                                    title:
                                                                        "${widget.dataList[selectedIndexLocation][0]['filter_key1'] == 'allIndia' ? 'All India' : widget.dataList[selectedIndexLocation][0]['filter_key1']} / ${widget.dataList[selectedIndexLocation][0]['month']}${(widget.dataList[selectedIndexLocation][0]['channel']).isEmpty ? '' : "/ ${widget.dataList[selectedIndexLocation][0]['channel']}"} ",
                                                                  ),
                                                                  Scrollbar(
                                                                    controller: _scrollControllerTable,
                                                                    child: SingleChildScrollView(
                                                                      controller: _scrollControllerTable,
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: Container(
                                                                        decoration:
                                                                            const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                        width: MediaQuery.of(context).size.width - 400,
                                                                        height: MediaQuery.of(context).size.height - 410,
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              height: 30,
                                                                              decoration: const BoxDecoration(
                                                                                  // border: Border(
                                                                                  //   bottom: BorderSide(width: 0.5, color: MyColors.textColor),
                                                                                  //   top: BorderSide(width: 0.5, color: MyColors.textColor),
                                                                                  // ),
                                                                                  ),
                                                                              child: Row(
                                                                                children: [
                                                                                  const Padding(
                                                                                    padding: EdgeInsets.only(left: 15.0),
                                                                                    child: SizedBox(
                                                                                      width: 130,
                                                                                      child: Text(
                                                                                        "Day Number",
                                                                                        style: ThemeText.sheetText,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      itemCount: widget.dataList[selectedIndexLocation].length,
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      itemBuilder: (context, index) {
                                                                                        return Row(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                                width: 140,
                                                                                                child: Text(
                                                                                                  widget.dataList[selectedIndexLocation][index]
                                                                                                      ['month'],
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: const TextStyle(
                                                                                                      fontSize: 16, fontFamily: fontFamily),
                                                                                                ))
                                                                                          ],
                                                                                        );
                                                                                      }),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height - 440,
                                                                              width: size.width - 540,
                                                                              child: Scrollbar(
                                                                                controller: _scrollControllerTable1,
                                                                                child: ListView.builder(
                                                                                    controller: _scrollControllerTable1,
                                                                                    // itemCount: [widget.dataList[selectedIndexLocation][0]['data'].length, widget.dataList[selectedIndexLocation][1]['data'].length].reduce((current, next) => current > next ? current : next),
                                                                                    itemCount: 31,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemBuilder: (context, index1) {
                                                                                      // print("${[widget.dataList[selectedIndexLocation][0]['data'].length, widget.dataList[selectedIndexLocation][1]['data'].length].reduce((current, next) => current > next ? current : next)}");
                                                                                      return Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              //For indexing
                                                                                              SizedBox(
                                                                                                child: Container(
                                                                                                  height: 40,
                                                                                                  width: 140,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: index1 % 2 == 0
                                                                                                        ? MyColors.dark500
                                                                                                        : MyColors.dark600,
                                                                                                    // border: const Border(
                                                                                                    //   bottom: BorderSide(width: 0.2, color: MyColors.whiteColor),
                                                                                                    //   top: BorderSide(width: 0.2, color: MyColors.whiteColor),
                                                                                                    // ),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: Text(
                                                                                                      '${index1 + 1}',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: const TextStyle(
                                                                                                          fontSize: 16,
                                                                                                          fontFamily: fontFamily),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Container(
                                                                                                height: 40,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: index1 % 2 == 0
                                                                                                      ? MyColors.dark500
                                                                                                      : MyColors.dark600,
                                                                                                ),
                                                                                                child: ListView.builder(
                                                                                                    controller: _controller,
                                                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                                                    shrinkWrap: true,
                                                                                                    scrollDirection: Axis.horizontal,
                                                                                                    itemCount: widget.dataList[selectedIndexLocation].length,
                                                                                                    itemBuilder: (context, index) {
                                                                                                      return SizedBox(
                                                                                                        height: 40,
                                                                                                        width: 140,
                                                                                                        child: Row(
                                                                                                          crossAxisAlignment:
                                                                                                              CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Expanded(
                                                                                                              child: ListView.builder(
                                                                                                                  shrinkWrap: true,
                                                                                                                  controller: _controller2,
                                                                                                                  physics:
                                                                                                                      const NeverScrollableScrollPhysics(),
                                                                                                                  itemCount: widget.dataList[selectedIndexLocation][index]['data'].length,
                                                                                                                  scrollDirection: Axis.vertical,
                                                                                                                  itemBuilder: (context, indx) {
                                                                                                                    return Row(
                                                                                                                      children: [
                                                                                                                        Container(
                                                                                                                          width: 140,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            color: index1 % 2 == 0
                                                                                                                                ? MyColors.dark500
                                                                                                                                : MyColors.dark600,
                                                                                                                          ),
                                                                                                                          child: Padding(
                                                                                                                            padding:
                                                                                                                                const EdgeInsets.all(
                                                                                                                                    8.0),
                                                                                                                            child: Text(
                                                                                                                              "${widget.dataList[selectedIndexLocation][index]['data'][index1]['retailing']}",
                                                                                                                              textAlign:
                                                                                                                                  TextAlign.center,
                                                                                                                              style: const TextStyle(
                                                                                                                                  fontSize: 16,
                                                                                                                                  fontFamily:
                                                                                                                                      fontFamily),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ],
                                                                                                                    );
                                                                                                                  }),
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      );
                                                                                                    }),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    }),
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
                                      onApplyPressedMonth: widget.onApplyPressedMonth,
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
                                    decoration: BoxDecoration(color: MyColors.whiteColor, borderRadius: BorderRadius.circular(15)),
                                    child: Stack(
                                      children: [
                                        sheetProvider.retailing1ErrorMsg.isNotEmpty
                                            ? Center(
                                                child: Column(
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Something went wrong! Try Again'),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: widget.tryAgain1,
                                                      style: ButtonStyle(
                                                        side: MaterialStateProperty.all(const BorderSide(width: 1.0, color: MyColors.primary)),
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                                                      ),
                                                      child: const Text(
                                                        "Try Again",
                                                        style: TextStyle(fontFamily: fontFamily, color: Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    color: MyColors.dark400,
                                                    height: 42,
                                                    child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: widget.dataListByGeo.length,
                                                      itemBuilder: (context, outerIndex1) {
                                                        SharedPreferencesUtils.setString('divisionChannelSelected1',
                                                            findDatasetName(widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']));
                                                        SharedPreferencesUtils.setString(
                                                            'siteChannelSelected1', widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']);
                                                        SharedPreferencesUtils.setString(
                                                            'monthChannelSelected1', widget.dataListByGeo[selectedIndexLocation1][0]['date']);
                                                        sheetProvider.selectedChannelIndex = selectedIndexLocation1;
                                                        return TabsBodyTable(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedIndexLocation1 = outerIndex1;

                                                              SharedPreferencesUtils.setString('divisionChannelSelected1',
                                                                  findDatasetName(widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']));
                                                              SharedPreferencesUtils.setString('siteChannelSelected1',
                                                                  widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']);
                                                              SharedPreferencesUtils.setString(
                                                                  'monthChannelSelected1', widget.dataListByGeo[selectedIndexLocation1][0]['date']);
                                                              sheetProvider.selectedChannelIndex = selectedIndexLocation1;
                                                            });

                                                            // sheetProvider
                                                            //     .removeIndexRe =
                                                            //     selectedIndexLocation;
                                                          },
                                                          onTapGes: () {
                                                            setState(() {
                                                              selectedIndex = selectedIndex == outerIndex1 ? -1 : outerIndex1;
                                                              sheetProvider.isExpanded == true;
                                                            });
                                                          },
                                                          selectedIndexLocation: selectedIndexLocation1,
                                                          outerIndex: outerIndex1,
                                                          title:
                                                              "${widget.dataListByGeo[outerIndex1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListByGeo[outerIndex1][0]['filter_key']} / ${widget.dataListByGeo[outerIndex1][0]['date']}",
                                                          onClosedTap: widget.onClosedTap,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Container B (conditionally shown)
                                                  if (selectedIndexLocation != -1)
                                                    Padding(
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: widget.dataListByGeo.isEmpty
                                                          ? const Center(child: CircularProgressIndicator())
                                                          : SingleChildScrollView(
                                                              child: Container(
                                                                width: size.width,
                                                                decoration: const BoxDecoration(
                                                                    color: MyColors.whiteColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                child: Column(
                                                                  children: [
                                                                    TableHeaderWidget(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          addGeoBool = !addGeoBool;
                                                                        });
                                                                      },
                                                                      title:
                                                                          "${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']} / ${widget.dataListByGeo[selectedIndexLocation1][0]['date']} ${(widget.dataListByGeo[selectedIndexLocation1][0]['channel']).isEmpty ? "" : "/ ${widget.dataListByGeo[selectedIndexLocation1][0]['channel']}"} ${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key2'] == "" ? "" : "/ ${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key2']}"}",
                                                                    ),
                                                                    Scrollbar(
                                                                      controller: _scrollControllerTable,
                                                                      child: SingleChildScrollView(
                                                                        controller: _scrollControllerTable,
                                                                        scrollDirection: Axis.horizontal,
                                                                        child: Container(
                                                                          decoration: const BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                          width: MediaQuery.of(context).size.width - 200,
                                                                          height: MediaQuery.of(context).size.height - 410,
                                                                          child: Column(
                                                                            children: [
                                                                              RetailingCustomHeaderTitle(
                                                                                dataList: widget.dataListByGeo,
                                                                                selectedIndexLocation: selectedIndexLocation1,
                                                                                cm: 'CM',
                                                                                cmIYA: 'CMIYA',
                                                                                p1m: 'P1M',
                                                                                p3m: 'P3M',
                                                                                p6m: 'P6M',
                                                                                p12m: 'P12M',
                                                                                fy: 'FY',
                                                                                fyIYA: 'FYIYA',
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
                                                                                child:
                                                                                    // widget.dataList[selectedIndexLocation][0]['filter_key'] == 'All India' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'allIndia'
                                                                                    //     ?c
                                                                                    RetailingAllIndiaTableData(
                                                                                        newDataList: widget.dataListByGeo[selectedIndexLocation1],
                                                                                        selectedIndex: selectedIndexLocation,
                                                                                        division: findDatasetName(widget
                                                                                            .dataListByGeo[selectedIndexLocation1][0]['filter_key']),
                                                                                        divisionName: widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                            ['filter_key'],
                                                                                        month: widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                            ['date']),
                                                                              )
                                                                              //     : widget.dataList[selectedIndexLocation][0]['filter_key'] == 'N-E' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'S-W'
                                                                              //     ? FBTableDivision(
                                                                              //   newDataList: widget.dataList[selectedIndexLocation],
                                                                              //   keyName1: 'fb_per',
                                                                              //   keyName2: 'fb_achieve_sum',
                                                                              //   keyName3: 'fb_target_sum',
                                                                              // )
                                                                              //     : FBTableSite(newDataList: widget.dataList[selectedIndexLocation], keyName1: 'fb_per', keyName2: 'fb_achieve_sum', keyName3: 'fb_target_sum'),
                                                                              // ),
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
                                          onApplyPressedMonth: widget.onApplyPressedMonth,
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
                                        decoration: BoxDecoration(color: MyColors.whiteColor, borderRadius: BorderRadius.circular(15)),
                                        child: Stack(
                                          children: [
                                            sheetProvider.retailing2ErrorMsg.isNotEmpty
                                                ? Center(
                                                    child: Column(
                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Text('Something went wrong! Try Again'),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        OutlinedButton(
                                                          onPressed: widget.tryAgain2,
                                                          style: ButtonStyle(
                                                            side: MaterialStateProperty.all(const BorderSide(width: 1.0, color: MyColors.primary)),
                                                            shape: MaterialStateProperty.all(
                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                                                          ),
                                                          child: const Text(
                                                            "Try Again",
                                                            style: TextStyle(fontFamily: fontFamily, color: Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        color: MyColors.dark400,
                                                        height: 42,
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: widget.dataListByGeo.length,
                                                          itemBuilder: (context, outerIndex1) {
                                                            SharedPreferencesUtils.setString('divisionChannelSelected1',
                                                                findDatasetName(widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']));
                                                            SharedPreferencesUtils.setString('siteChannelSelected1',
                                                                widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']);
                                                            SharedPreferencesUtils.setString(
                                                                'monthChannelSelected1', widget.dataListByGeo[selectedIndexLocation1][0]['date']);
                                                            sheetProvider.selectedChannelIndex = selectedIndexLocation1;
                                                            return TabsBodyTable(
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedIndexLocation1 = outerIndex1;

                                                                  SharedPreferencesUtils.setString('divisionChannelSelected1',
                                                                      findDatasetName(widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']));
                                                                  SharedPreferencesUtils.setString('siteChannelSelected1',
                                                                      widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']);
                                                                  SharedPreferencesUtils.setString('monthChannelSelected1',
                                                                      widget.dataListByGeo[selectedIndexLocation1][0]['date']);
                                                                  sheetProvider.selectedChannelIndex = selectedIndexLocation1;
                                                                });

                                                                // sheetProvider
                                                                //     .removeIndexRe =
                                                                //     selectedIndexLocation;
                                                              },
                                                              onTapGes: () {
                                                                setState(() {
                                                                  selectedIndex = selectedIndex == outerIndex1 ? -1 : outerIndex1;
                                                                  sheetProvider.isExpanded == true;
                                                                });
                                                              },
                                                              selectedIndexLocation: selectedIndexLocation1,
                                                              outerIndex: outerIndex1,
                                                              title:
                                                                  "${widget.dataListByGeo[outerIndex1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListByGeo[outerIndex1][0]['filter_key']} / ${widget.dataListByGeo[outerIndex1][0]['date']}",
                                                              onClosedTap: widget.onClosedTap,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      // Container B (conditionally shown)
                                                      if (selectedIndexLocation != -1)
                                                        Padding(
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: widget.dataListByGeo.isEmpty
                                                              ? const Center(child: CircularProgressIndicator())
                                                              : SingleChildScrollView(
                                                                  child: Container(
                                                                    width: size.width,
                                                                    decoration: const BoxDecoration(
                                                                        color: MyColors.whiteColor,
                                                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                    child: Column(
                                                                      children: [
                                                                        TableHeaderWidget(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              addGeoBool = !addGeoBool;
                                                                            });
                                                                          },
                                                                          title:
                                                                              "${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']} / ${widget.dataListByGeo[selectedIndexLocation1][0]['date']} ${(widget.dataListByGeo[selectedIndexLocation1][0]['channel']).isEmpty ? "" : "/ ${widget.dataListByGeo[selectedIndexLocation1][0]['channel']}"} ${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key2'] == "" ? "" : "/ ${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key2']}"}",
                                                                        ),
                                                                        Scrollbar(
                                                                          controller: _scrollControllerTable,
                                                                          child: SingleChildScrollView(
                                                                            controller: _scrollControllerTable,
                                                                            scrollDirection: Axis.horizontal,
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                              width: MediaQuery.of(context).size.width - 200,
                                                                              height: MediaQuery.of(context).size.height - 410,
                                                                              child: Column(
                                                                                children: [
                                                                                  RetailingCustomHeaderTitle(
                                                                                    dataList: widget.dataListByGeo,
                                                                                    selectedIndexLocation: selectedIndexLocation1,
                                                                                    cm: 'CM',
                                                                                    cmIYA: 'CMIYA',
                                                                                    p1m: 'P1M',
                                                                                    p3m: 'P3M',
                                                                                    p6m: 'P6M',
                                                                                    p12m: 'P12M',
                                                                                    fy: 'FY',
                                                                                    fyIYA: 'FYIYA',
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                        const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
                                                                                    child:
                                                                                        // widget.dataList[selectedIndexLocation][0]['filter_key'] == 'All India' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'allIndia'
                                                                                        //     ?c
                                                                                        RetailingAllIndiaTableData(
                                                                                            newDataList: widget.dataListByGeo[selectedIndexLocation1],
                                                                                            selectedIndex: selectedIndexLocation,
                                                                                            division: findDatasetName(
                                                                                                widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                                    ['filter_key']),
                                                                                            divisionName: widget.dataListByGeo[selectedIndexLocation1]
                                                                                                [0]['filter_key'],
                                                                                            month: widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                                ['date']),
                                                                                  )
                                                                                  //     : widget.dataList[selectedIndexLocation][0]['filter_key'] == 'N-E' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'S-W'
                                                                                  //     ? FBTableDivision(
                                                                                  //   newDataList: widget.dataList[selectedIndexLocation],
                                                                                  //   keyName1: 'fb_per',
                                                                                  //   keyName2: 'fb_achieve_sum',
                                                                                  //   keyName3: 'fb_target_sum',
                                                                                  // )
                                                                                  //     : FBTableSite(newDataList: widget.dataList[selectedIndexLocation], keyName1: 'fb_per', keyName2: 'fb_achieve_sum', keyName3: 'fb_target_sum'),
                                                                                  // ),
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
                                              onApplyPressedMonth: widget.onApplyPressedMonth,
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
                              : widget.selectedIndex1 == 3
                                  ? Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: size.width,
                                            height: size.height / 1.3,
                                            decoration: BoxDecoration(color: MyColors.whiteColor, borderRadius: BorderRadius.circular(15)),
                                            child: Stack(
                                              children: [
                                                sheetProvider.retailing3ErrorMsg.isNotEmpty
                                                    ? Center(
                                                        child: Column(
                                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const Text('Something went wrong! Try Again'),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            OutlinedButton(
                                                              onPressed: widget.tryAgain3,
                                                              style: ButtonStyle(
                                                                side:
                                                                    MaterialStateProperty.all(const BorderSide(width: 1.0, color: MyColors.primary)),
                                                                shape: MaterialStateProperty.all(
                                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                                                              ),
                                                              child: const Text(
                                                                "Try Again",
                                                                style: TextStyle(fontFamily: fontFamily, color: Colors.black),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            color: MyColors.dark400,
                                                            height: 42,
                                                            child: ListView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: widget.dataListByGeo.length,
                                                              itemBuilder: (context, outerIndex1) {
                                                                SharedPreferencesUtils.setString('divisionChannelSelected1',
                                                                    findDatasetName(widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']));
                                                                SharedPreferencesUtils.setString('siteChannelSelected1',
                                                                    widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']);
                                                                SharedPreferencesUtils.setString(
                                                                    'monthChannelSelected1', widget.dataListByGeo[selectedIndexLocation1][0]['date']);
                                                                sheetProvider.selectedChannelIndex = selectedIndexLocation1;
                                                                return TabsBodyTable(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      selectedIndexLocation1 = outerIndex1;

                                                                      SharedPreferencesUtils.setString(
                                                                          'divisionChannelSelected1',
                                                                          findDatasetName(
                                                                              widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']));
                                                                      SharedPreferencesUtils.setString('siteChannelSelected1',
                                                                          widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']);
                                                                      SharedPreferencesUtils.setString('monthChannelSelected1',
                                                                          widget.dataListByGeo[selectedIndexLocation1][0]['date']);
                                                                      sheetProvider.selectedChannelIndex = selectedIndexLocation1;
                                                                    });

                                                                    // sheetProvider
                                                                    //     .removeIndexRe =
                                                                    //     selectedIndexLocation;
                                                                  },
                                                                  onTapGes: () {
                                                                    setState(() {
                                                                      selectedIndex = selectedIndex == outerIndex1 ? -1 : outerIndex1;
                                                                      sheetProvider.isExpanded == true;
                                                                    });
                                                                  },
                                                                  selectedIndexLocation: selectedIndexLocation1,
                                                                  outerIndex: outerIndex1,
                                                                  title:
                                                                      "${widget.dataListByGeo[outerIndex1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListByGeo[outerIndex1][0]['filter_key']} / ${widget.dataListByGeo[outerIndex1][0]['date']}",
                                                                  onClosedTap: widget.onClosedTap,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          // Container B (conditionally shown)
                                                          if (selectedIndexLocation != -1)
                                                            Padding(
                                                              padding: const EdgeInsets.all(0.0),
                                                              child: widget.dataListByGeo.isEmpty
                                                                  ? const Center(child: CircularProgressIndicator())
                                                                  : SingleChildScrollView(
                                                                      child: Container(
                                                                        width: size.width,
                                                                        decoration: const BoxDecoration(
                                                                            color: MyColors.whiteColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                        child: Column(
                                                                          children: [
                                                                            TableHeaderWidget(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  addGeoBool = !addGeoBool;
                                                                                });
                                                                              },
                                                                              title:
                                                                                  "${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key'] == 'allIndia' ? 'All India' : widget.dataListByGeo[selectedIndexLocation1][0]['filter_key']} / ${widget.dataListByGeo[selectedIndexLocation1][0]['date']} ${(widget.dataListByGeo[selectedIndexLocation1][0]['channel']).isEmpty ? "" : "/ ${widget.dataListByGeo[selectedIndexLocation1][0]['channel']}"} ${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key2'] == "" ? "" : "/ ${widget.dataListByGeo[selectedIndexLocation1][0]['filter_key2']}"}",
                                                                            ),
                                                                            Scrollbar(
                                                                              controller: _scrollControllerTable,
                                                                              child: SingleChildScrollView(
                                                                                controller: _scrollControllerTable,
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                                  width: MediaQuery.of(context).size.width - 200,
                                                                                  height: MediaQuery.of(context).size.height - 410,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      RetailingCustomHeaderTitle(
                                                                                        dataList: widget.dataListByGeo,
                                                                                        selectedIndexLocation: selectedIndexLocation1,
                                                                                        cm: 'CM',
                                                                                        cmIYA: 'CMIYA',
                                                                                        p1m: 'P1M',
                                                                                        p3m: 'P3M',
                                                                                        p6m: 'P6M',
                                                                                        p12m: 'P12M',
                                                                                        fy: 'FY',
                                                                                        fyIYA: 'FYIYA',
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(
                                                                                            left: 15.0, right: 15.0, bottom: 8.0),
                                                                                        child:
                                                                                            // widget.dataList[selectedIndexLocation][0]['filter_key'] == 'All India' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'allIndia'
                                                                                            //     ?c
                                                                                            RetailingAllIndiaTableData(
                                                                                                newDataList:
                                                                                                    widget.dataListByGeo[selectedIndexLocation1],
                                                                                                selectedIndex: selectedIndexLocation,
                                                                                                division: findDatasetName(
                                                                                                    widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                                        ['filter_key']),
                                                                                                divisionName:
                                                                                                    widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                                        ['filter_key'],
                                                                                                month: widget.dataListByGeo[selectedIndexLocation1][0]
                                                                                                    ['date']),
                                                                                      )
                                                                                      //     : widget.dataList[selectedIndexLocation][0]['filter_key'] == 'N-E' || widget.dataList[selectedIndexLocation][0]['filter_key'] == 'S-W'
                                                                                      //     ? FBTableDivision(
                                                                                      //   newDataList: widget.dataList[selectedIndexLocation],
                                                                                      //   keyName1: 'fb_per',
                                                                                      //   keyName2: 'fb_achieve_sum',
                                                                                      //   keyName3: 'fb_target_sum',
                                                                                      // )
                                                                                      //     : FBTableSite(newDataList: widget.dataList[selectedIndexLocation], keyName1: 'fb_per', keyName2: 'fb_achieve_sum', keyName3: 'fb_target_sum'),
                                                                                      // ),
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
                                                  onApplyPressedMonth: widget.onApplyPressedMonth,
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
                                  : Container(),
                  ExcelImportButton(
                    onClickExcel: () async {
                      print('hello');
                      setState(() {});
                      await postRequest(context);
                    },
                  ),
                ],
              ),
            ),
            FiltersAllRetailingSummary(
              selectedMonthList: widget.selectedIndex1 == 0
                  ? (widget.dataList).isEmpty
                      ? 'Select..'
                      : widget.dataList[selectedIndexLocation][0]['month']
                  : widget.selectedIndex1 == 1
                      ? (widget.dataListByGeo).isEmpty
                          ? 'Select..'
                          : widget.dataListByGeo[selectedIndexLocation1][0]['date']
                      : widget.selectedIndex1 == 2
                          ? (widget.dataListByGeo).isEmpty
                              ? 'Select..'
                              : widget.dataListByGeo[selectedIndexLocation2][0]['date']
                          : widget.selectedIndex1 == 3
                              ? (widget.dataListByGeo).isEmpty
                                  ? 'Select..'
                                  : widget.dataListByGeo[selectedIndexLocation][0]['date']
                              : "Select..",
              onTapMonthFilter: widget.onTapMonthFilter,
              selectedChannelList: widget.selectedIndex1 == 0
                  ? (widget.dataList).isEmpty
                      ? ['Select..']
                      : widget.dataList[selectedIndexLocation][0]['channel']
                  : widget.selectedIndex1 == 1
                      ? (widget.dataListByGeo).isEmpty
                          ? ['Select..']
                          : widget.dataListByGeo[selectedIndexLocation1][0]['channel']
                      : widget.selectedIndex1 == 2
                          ? (widget.dataListByGeo).isEmpty
                              ? ['Select..']
                              : widget.dataListByGeo[selectedIndexLocation2][0]['channel']
                          : widget.selectedIndex1 == 3
                              ? (widget.dataListByGeo).isEmpty
                                  ? ['Select..']
                                  : widget.dataListByGeo[selectedIndexLocation][0]['channel']
                              : ['Select..'],
              onTapChannelFilter: widget.onTapChannelFilter,
              attributeName: 'FB',
              categoryApply: widget.categoryApply,
              onTapRemoveFilter: widget.onTapRemoveFilter,
              selectedCategoryList: "Select..",
              onTapSiteFilter: widget.onTapSiteFilter,
              onTapBranchFilter: widget.onTapBranchFilter,
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
