import 'dart:convert';

import 'package:command_centre/helper/http_call.dart';
import 'package:command_centre/model/all_metrics.dart';
import 'package:command_centre/utils/comman/new_cards.dart';
import 'package:http/http.dart' as http;
import 'package:command_centre/utils/comman/title_widget.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/web_dashboard/cards_container/cc_container.dart';
import 'package:command_centre/web_dashboard/cards_container/coverage_container.dart';
import 'package:command_centre/web_dashboard/cards_container/distribution_container.dart';
import 'package:command_centre/web_dashboard/cards_container/fb_container.dart';
import 'package:command_centre/web_dashboard/cards_container/gp_container.dart';
import 'package:command_centre/web_dashboard/cards_container/inventory_container.dart';
import 'package:command_centre/web_dashboard/cards_container/productivity_container.dart';
import 'package:command_centre/web_dashboard/cards_container/retailing_container.dart';
import 'package:command_centre/web_dashboard/cards_container/shipment_container.dart';
import 'package:command_centre/web_dashboard/model/summary_model.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/popup_sheet.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/add_geo.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/month_web_sheet.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/header_card_web.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/pop_up_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:provider/provider.dart';

import '../../../../../../activities/retailing_screen.dart';
import '../../../../../../provider/sheet_provider.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../../utils/style/text_style.dart';

class SummaryContainer extends StatefulWidget {
  final List<AllMetrics> widgetList;
  final Function() onTapContainer;
  final Function() onRemoveGeoPressed;
  final Function() onNewMonth;
  final List<AllMetrics> includedData;
  final List<AllMetrics> metricData;
  final List<AllMetrics> allMetrics;
  final List list;
  final List divisionList;
  final List siteList;
  final List branchList;
  final int selectedGeo;
  final List clusterList;
  final Function() onApplyPressed;
  final Function() onApplyPressedMonth;
  final Function() onApplyPressedMonthDefault;
  final Function() onGestureTap;
  final Function() onPressed;
  final Function() onPressedGeo;
  final List<bool> menuBool;
  final List<bool> divisionBool;
  final List<bool> removeBool;
  final List<bool> addDateBool;
  final List<bool> firstIsHovering;
  final List<dynamic> dataList;
  final List<dynamic> allSummary;
  final List<dynamic> coverageDataList;
  final List<dynamic> gpDataList;
  final List<dynamic> fbDataList;
  final List<dynamic> prodDataList;
  final List<dynamic> ccDataList;
  final bool updateDefault;
  final bool updateMonth;

  // final Function(bool) toggleChanged;

  const SummaryContainer({
    Key? key,
    required this.widgetList,
    required this.onTapContainer,
    required this.includedData,
    required this.metricData,
    required this.allMetrics,
    required this.list,
    required this.divisionList,
    required this.siteList,
    required this.branchList,
    required this.selectedGeo,
    required this.clusterList,
    required this.onApplyPressed,
    required this.menuBool,
    required this.divisionBool,
    required this.removeBool,
    required this.firstIsHovering,
    required this.onGestureTap,
    required this.addDateBool,
    required this.dataList,
    required this.onApplyPressedMonth,
    required this.coverageDataList,
    required this.gpDataList,
    required this.fbDataList,
    required this.prodDataList,
    required this.ccDataList,
    required this.updateDefault,
    required this.onPressed,
    required this.onPressedGeo,
    required this.onRemoveGeoPressed,
    required this.onNewMonth,
    required this.updateMonth,
    required this.onApplyPressedMonthDefault, required this.allSummary,
  }) : super(key: key);

  @override
  State<SummaryContainer> createState() => _SummaryContainerState();
}

class _SummaryContainerState extends State<SummaryContainer> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  List<bool> menuBool = [];
  List<bool> divisionBool = [];
  List<bool> removeBool = [];
  late List<AllMetrics> includedData;
  late List<AllMetrics> metricData;
  List<SummaryModel> summaryData = [];
  int selectedArrayItemRe = -1;
  int selectedArrayItemCo = -1;
  int selectedArrayItemGP = -1;
  int selectedArrayItemFB = -1;
  int selectedArrayItemPr = -1;
  int selectedArrayItemCC = -1;
  int selectedArrayItem = -1;

  bool addMatrix = false;
  bool addDate = false;

  // bool updateDefault = false;
  int iya = 0;
  var dateTime = DateTime.now();
  List<String> items = [
    'Select Site Name',
    'Select Division Name',
    'All India'
  ];

  Future<SummaryModel> fetchSummaryData(BuildContext context) async {

    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/d2007bee-dbcd-446d-8b86-cf5ca19a20ee'));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      // print("Summary Screen $jsonBody");

      return SummaryModel.fromJson(jsonBody[0]);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;

    includedData = allMetricsFromJson(
        SharedPreferencesUtils.getString('includedData') ??
            jsonEncode(widget.includedData));
    metricData = allMetricsFromJson(
        SharedPreferencesUtils.getString('metricData') ??
            jsonEncode(widget.metricData));
    // print("Include $includedData");
    // fetchSummaryData(context);
    // print("Summary Screen 2 ${widget.allSummary}");
  }

  List<String> popupmenuList = [
    'Add Another Geo',
    'Remove Geo',
    'Delete Metric Card',
  ];



  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);

    final size = MediaQuery.of(context).size;
    print(widget.allSummary.length);

    List<DraggableGridItem> draggableCardList = List.generate(
      includedData.length,
      (el) => DraggableGridItem(
        isDraggable: true,
        child: includedData[el].name == ''
            ? InkWell(
                onTap: () {
                  setState(() {
                    addMatrix = !addMatrix;
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 3,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Metrics',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: MyColors.textColor,
                          fontFamily: fontFamily,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.add_circle_outline_sharp,
                        color: MyColors.grey,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 3,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        HeaderWebCard(
                          dateTitle: "Jan'2023",
                          subLabel: includedData[el].subtitle,
                          onPressed: () {
                            setState(() {
                              sheetProvider.selectedIcon =
                                  includedData[el].name;
                              SharedPreferencesUtils.setString("keyName", includedData[el].name);
                              // print(includedData[el].name);
                              widget.menuBool[el] = !widget.menuBool[el];
                            });
                          },
                          title: includedData[el].name,
                          subTitle: "CM",
                          xAlign: xAlign,
                          onTap: () {
                            setState(() {
                              iya = 0;
                              xAlign = loginAlign;
                              loginColor = selectedColor;
                              signInColor = normalColor;
                            });
                          },
                          loginColor: loginColor,
                          signInColor: signInColor,
                          onTapSign: () {
                            setState(() {
                              iya = 1;
                              xAlign = signInAlign;
                              signInColor = selectedColor;
                              loginColor = normalColor;
                            });
                          },
                          index: includedData[el].name,
                          onEnter: (PointerEnterEvent) {
                            setState(() {
                              widget.firstIsHovering[el] = true;
                              sheetProvider.selectedCard =
                                  includedData[el].name;
                              // print(
                              //     "Selected Card - ${sheetProvider.selectedCard}");
                            });
                          },
                          isHovering: widget.firstIsHovering[el],
                          onExit: (PointerEnterEvent) {
                            setState(() {
                              widget.firstIsHovering[el] = false;
                              sheetProvider.selectedCard = '';
                              // print(
                              //     "Selected Card - ${sheetProvider.selectedCard}");
                            });
                          },
                          onTapTitle: widget.onTapContainer,
                          onTitle: () {
                            sheetProvider.selectedEl = includedData[el].name;
                          },
                          onDateSelected: () {
                            setState(() {
                              widget.addDateBool[el] = !widget.addDateBool[el];
                            });
                          },
                          elName: includedData[el].name,
                        ),
                        includedData[el].name == "Golden Points"
                            ? GPWebContainer(
                                elName: includedData[el].name,
                                gpDataList: widget.allSummary,
                              )
                            : includedData[el].name == "Focus Brand"
                                ? FBWebContainer(
                                    elName: includedData[el].name,
                                    fbDataList: widget.allSummary,
                                  )
                                : includedData[el].name == "Call Compliance"
                                    ? CCWebContainer(
                                        elName: includedData[el].name,
                                        ccDataList: widget.allSummary,
                                      )
                                    : includedData[el].name == "Productivity"
                                        ? ProductivityWebContainer(
                                            elName: includedData[el].name,
                                            prodDataList: widget.allSummary,
                                          )
                                        : includedData[el].name == "PXM billing"
                                            ? CoverageWebContainer(
                                                elName: includedData[el].name,
                                                coverageDataList:
                                                    widget.allSummary,
                                              )
                                            : includedData[el].name ==
                                                    "Retailing"
                                                ? RetailingSummaryContainer(
                                                    iya: iya,
                                                    elName:
                                                        includedData[el].name,
                                                    dataList: widget.allSummary,
                                                  )
                                                : includedData[el].name ==
                                                        "Shipment"
                                                    ? ShipmentWebContainer(
                                                        elName: includedData[el]
                                                            .name,
                                                      )
                                                    : includedData[el].name ==
                                                            "Inventory"
                                                        ? InventoryWebContainer(
                                                            elName:
                                                                includedData[el]
                                                                    .name,
                                                          )
                                                        : includedData[el]
                                                                    .name ==
                                                                "Distribution"
                                                            ? DistributionWebContainer(
                                                                elName:
                                                                    includedData[
                                                                            el]
                                                                        .name,
                                                              )
                                                            : includedData[el]
                                                                        .name ==
                                                                    "Cost/MSU"
                                                                ? const TitleWidgetCard(
                                                                    title: '0.0',
                                                                  )
                                                                : includedData[el]
                                                                            .name ==
                                                                        "Shortages/Damages (Rs.)"
                                                                    ? const TitleWidgetCard(
                                                                        title:
                                                                            '0.0',
                                                                      )
                                                                    : includedData[el].name ==
                                                                            "VFR"
                                                                        ? const TitleWidgetCard(
                                                                            title:
                                                                                '0.0',
                                                                          )
                                                                        : includedData[el].name ==
                                                                                "MSU/Truck"
                                                                            ? const TitleWidgetCard(
                                                                                title: '0.0',
                                                                              )
                                                                            : includedData[el].name == "Debits (Rs.)"
                                                                                ? const TitleWidgetCard(
                                                                                    title: '0.0',
                                                                                  )
                                                                                : includedData[el].name == "CFR"
                                                                                    ? const TitleWidgetCard(
                                                                                        title: '0.0',
                                                                                      )
                                                                                    : includedData[el].name == "SRN"
                                                                                        ? const TitleWidgetCard(
                                                                                            title: '0.0',
                                                                                          )
                                                                                        : includedData[el].name == "BT%"
                                                                                            ? const TitleWidgetCard(
                                                                                                title: '12.8',
                                                                                              )
                                                                                            : includedData[el].name == "NOS (MM)"
                                                                                                ? const TitleWidgetCard(
                                                                                                    title: '1654',
                                                                                                  )
                                                                                                : includedData[el].name == "MSE%"
                                                                                                    ? const TitleWidgetCard(
                                                                                                        title: '13.1',
                                                                                                      )
                                                                                                    : includedData[el].name == "CTS%"
                                                                                                        ? const TitleWidgetCard(
                                                                                                            title: '7.2',
                                                                                                          )
                                                                                                        : includedData[el].name == "SD%"
                                                                                                            ? const TitleWidgetCard(
                                                                                                                title: '12.3',
                                                                                                              )
                                                                                                            : includedData[el].name == "SRA%"
                                                                                                                ? const TitleWidgetCard(
                                                                                                                    title: '12.2',
                                                                                                                  )
                                                                                                                : includedData[el].name == "TDC%"
                                                                                                                    ? const TitleWidgetCard(
                                                                                                                        title: '7.6',
                                                                                                                      )
                                                                                                                    : includedData[el].name == "GOS%"
                                                                                                                        ? const TitleWidgetCard(
                                                                                                                            title: '15.5',
                                                                                                                          )
                                                                                                                        : includedData[el].name == "GM%"
                                                                                                                            ? const TitleWidgetCard(
                                                                                                                                title: '38.6',
                                                                                                                              )
                                                                                                                            : Container()
                      ],
                    ),
                    Positioned(
                      right: 20,
                      top: 30,
                      child: Visibility(
                        visible: widget.menuBool[el],
                        child: Container(
                          height: 108,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 12,
                                color: Color.fromRGBO(0, 0, 0, 0.16),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                            itemCount: popupmenuList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    index == 0
                                        ? widget.divisionBool[el] =
                                            !widget.divisionBool[el]
                                        : index == 1
                                            ? widget.removeBool[el] =
                                                !widget.removeBool[el]
                                            : index == 2
                                                ? addMatrix = !addMatrix
                                                : null;
                                  });
                                },
                                child: Container(
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.6,
                                          color: MyColors.sheetDivider),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            popupmenuList[index],
                                            style: TextStyle(
                                                fontFamily: fontFamily,
                                                fontSize: 16,
                                                color: index == 2
                                                    ? Colors.red
                                                    : MyColors.textHeaderColor),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.arrow_outward_outlined,
                                            color: MyColors.showMoreColor,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 30,
                      child: Visibility(
                        // visible: true,
                        visible: widget.divisionBool[el],
                        child: Container(
                            height: 210,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.16),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: DivisionWebSheet(
                              onTap: () {
                                setState(() {
                                  widget.divisionBool[el] =
                                      !widget.divisionBool[el];
                                });
                              },
                              list: widget.list,
                              divisionList: widget.divisionList,
                              siteList: widget.siteList,
                              branchList: widget.branchList,
                              selectedGeo: widget.selectedGeo,
                              clusterList: widget.clusterList,
                              onApplyPressed: widget.onApplyPressedMonth,
                              //     () {
                              //   setState(() {
                              //     widget.addDateBool[el] = true;
                              //   });
                              // },
                              elName: includedData[el].name,
                            )),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 30,
                      child: Visibility(
                        // visible: true,
                        visible: widget.removeBool[el],
                        child: Container(
                            height: 220,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.16),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 36,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: MyColors.sheetDivider),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Remove Geo',
                                                style: TextStyle(
                                                    fontFamily: fontFamily,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors
                                                        .textHeaderColor),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    widget.removeBool[el] =
                                                        !widget.removeBool[el];
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 15),
                                        child: Text(
                                          'Show in Summary',
                                          style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: MyColors.textHeaderColor),
                                        ),
                                      ),
                                      widget.allSummary.isEmpty?Container():
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 30.0),
                                          child: ListView.builder(
                                              itemCount: includedData[el]
                                                          .name ==
                                                      'Retailing'
                                                  ? widget.allSummary[0]['data'].length
                                                  : includedData[el].name ==
                                                          'PXM billing'
                                                      ? widget.allSummary[4]['data'].length
                                                      : includedData[el].name ==
                                                              'Focus Brand'
                                                          ? widget.allSummary[2]['data'].length
                                                          : includedData[el]
                                                                      .name ==
                                                                  'Golden Points'
                                                              ? widget.allSummary[1]['data'].length
                                                              : includedData[el]
                                                                          .name ==
                                                                      'Productivity'
                                                                  ? widget.allSummary[5]['data'].length
                                                                  : includedData[el]
                                                                              .name ==
                                                                          'Call Compliance'
                                                                      ? widget.allSummary[3]['data'].length
                                                                      : 0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {

                                                return SizedBox(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              if (includedData[
                                                                          el]
                                                                      .name ==
                                                                  "Retailing") {
                                                                if (selectedArrayItemRe ==
                                                                    index) {
                                                                  selectedArrayItemRe =
                                                                      -1;
                                                                  sheetProvider
                                                                      .removeIndexRetailing =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemRe =
                                                                      index;
                                                                  sheetProvider
                                                                      .removeIndexRetailing =
                                                                      index;
                                                                }
                                                              } else if (includedData[
                                                                          el]
                                                                      .name ==
                                                                  "PXM billing") {
                                                                if (selectedArrayItemCo ==
                                                                    index) {
                                                                  selectedArrayItemCo =
                                                                      -1;
                                                                  sheetProvider
                                                                      .removeIndexCoverage =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemCo =
                                                                      index;
                                                                  sheetProvider
                                                                      .removeIndexCoverage =
                                                                      index;
                                                                }
                                                              } else if (includedData[
                                                                          el]
                                                                      .name ==
                                                                  "Golden Points") {
                                                                if (selectedArrayItemGP ==
                                                                    index) {
                                                                  selectedArrayItemGP =
                                                                      -1;
                                                                  sheetProvider
                                                                      .removeIndexGoldenPoint =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemGP =
                                                                      index;
                                                                  sheetProvider
                                                                      .removeIndexGoldenPoint =
                                                                      index;
                                                                }
                                                              } else if (includedData[
                                                                          el]
                                                                      .name ==
                                                                  "Focus Brand") {
                                                                if (selectedArrayItemFB ==
                                                                    index) {
                                                                  selectedArrayItemFB =
                                                                      -1;
                                                                  sheetProvider
                                                                      .removeIndexFocusBrand =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemFB =
                                                                      index;
                                                                  sheetProvider
                                                                      .removeIndexFocusBrand =
                                                                      index;
                                                                }
                                                              } else if (includedData[
                                                                          el]
                                                                      .name ==
                                                                  "Productivity") {
                                                                if (selectedArrayItemPr ==
                                                                    index) {
                                                                  selectedArrayItemPr =
                                                                      -1;
                                                                  sheetProvider
                                                                      .removeIndexProductivity =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemPr =
                                                                      index;
                                                                  sheetProvider
                                                                      .removeIndexProductivity =
                                                                      index;
                                                                }
                                                              } else if (includedData[
                                                                          el]
                                                                      .name ==
                                                                  "Call Compliance") {
                                                                if (selectedArrayItemCC ==
                                                                    index) {
                                                                  selectedArrayItemCC =
                                                                      -1;
                                                                  sheetProvider
                                                                      .removeIndexCallC =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemCC =
                                                                      index;
                                                                  sheetProvider
                                                                      .removeIndexCallC =
                                                                      index;
                                                                }
                                                              } else {}

                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20,
                                                                    top: 5,
                                                                    bottom: 4),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  decoration: BoxDecoration(
                                                                      color: includedData[el].name == "Retailing"
                                                                          ? selectedArrayItemRe == index
                                                                              ? Colors.blue
                                                                              : MyColors.transparent
                                                                          : includedData[el].name == "PXM billing"
                                                                              ? selectedArrayItemCo == index
                                                                                  ? Colors.blue
                                                                                  : MyColors.transparent
                                                                              : includedData[el].name == "Golden Points"
                                                                                  ? selectedArrayItemGP == index
                                                                                      ? Colors.blue
                                                                                      : MyColors.transparent
                                                                                  : includedData[el].name == "Focus Brand"
                                                                                      ? selectedArrayItemFB == index
                                                                                          ? Colors.blue
                                                                                          : MyColors.transparent
                                                                                      : includedData[el].name == "Productivity"
                                                                                          ? selectedArrayItemPr == index
                                                                                              ? Colors.blue
                                                                                              : MyColors.transparent
                                                                                          : includedData[el].name == "Call Compliance"
                                                                                              ? selectedArrayItemCC == index
                                                                                                  ? Colors.blue
                                                                                                  : MyColors.transparent
                                                                                              : MyColors.whiteColor,
                                                                      // selectedArrayItem == index
                                                                      //     ? Colors.blue
                                                                      //     : MyColors
                                                                      //     .transparent,
                                                                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                                      border: Border.all(
                                                                          color: includedData[el].name == "Retailing"
                                                                              ? selectedArrayItemRe == index
                                                                                  ? Colors.blue
                                                                                  : MyColors.grey
                                                                              : includedData[el].name == "PXM billing"
                                                                                  ? selectedArrayItemCo == index
                                                                                      ? Colors.blue
                                                                                      : MyColors.grey
                                                                                  : includedData[el].name == "Golden Points"
                                                                                      ? selectedArrayItemGP == index
                                                                                          ? Colors.blue
                                                                                          : MyColors.grey
                                                                                      : includedData[el].name == "Focus Brand"
                                                                                          ? selectedArrayItemFB == index
                                                                                              ? Colors.blue
                                                                                              : MyColors.grey
                                                                                          : includedData[el].name == "Productivity"
                                                                                              ? selectedArrayItemPr == index
                                                                                                  ? Colors.blue
                                                                                                  : MyColors.grey
                                                                                              : includedData[el].name == "Call Compliance"
                                                                                                  ? selectedArrayItemCC == index
                                                                                                      ? Colors.blue
                                                                                                      : MyColors.grey
                                                                                                  : MyColors.grey,
                                                                          width: 1)),
                                                                  child: includedData[el]
                                                                              .name ==
                                                                          "Retailing"
                                                                      ? selectedArrayItemRe ==
                                                                              index
                                                                          ? const Icon(
                                                                              Icons.check,
                                                                              color: MyColors.whiteColor,
                                                                              size: 13,
                                                                            )
                                                                          : null
                                                                      : includedData[el].name ==
                                                                              "PXM billing"
                                                                          ? selectedArrayItemCo == index
                                                                              ? const Icon(
                                                                                  Icons.check,
                                                                                  color: MyColors.whiteColor,
                                                                                  size: 13,
                                                                                )
                                                                              : null
                                                                          : includedData[el].name == "Golden Points"
                                                                              ? selectedArrayItemGP == index
                                                                                  ? const Icon(
                                                                                      Icons.check,
                                                                                      color: MyColors.whiteColor,
                                                                                      size: 13,
                                                                                    )
                                                                                  : null
                                                                              : includedData[el].name == "Focus Brand"
                                                                                  ? selectedArrayItemFB == index
                                                                                      ? const Icon(
                                                                                          Icons.check,
                                                                                          color: MyColors.whiteColor,
                                                                                          size: 13,
                                                                                        )
                                                                                      : null
                                                                                  : includedData[el].name == "Productivity"
                                                                                      ? selectedArrayItemPr == index
                                                                                          ? const Icon(
                                                                                              Icons.check,
                                                                                              color: MyColors.whiteColor,
                                                                                              size: 13,
                                                                                            )
                                                                                          : null
                                                                                      : includedData[el].name == "Call Compliance"
                                                                                          ? selectedArrayItemCC == index
                                                                                              ? const Icon(
                                                                                                  Icons.check,
                                                                                                  color: MyColors.whiteColor,
                                                                                                  size: 13,
                                                                                                )
                                                                                              : null
                                                                                          : null,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  includedData[el]
                                                                              .name ==
                                                                          'Retailing'
                                                                      ? "${widget.allSummary[0]['data'][index]['filter']} / ${widget.allSummary[0]['data'][index]['month']}"
                                                                      : includedData[el].name ==
                                                                              'PXM billing'
                                                                          ? "${widget.allSummary[4]['data'][index]['filter']} / ${widget.allSummary[4]['data'][index]['month']}"
                                                                          : includedData[el].name == 'Focus Brand'
                                                                              ? "${widget.allSummary[2]['data'][index]['filter']} / ${widget.allSummary[2]['data'][index]['month']}"
                                                                              : includedData[el].name == 'Golden Points'
                                                                                  ? "${widget.allSummary[1]['data'][index]['filter']} / ${widget.allSummary[1]['data'][index]['month']}"
                                                                                  : includedData[el].name == 'Productivity'
                                                                                      ? "${widget.allSummary[5]['data'][index]['filter']} / ${widget.allSummary[5]['data'][index]['month']}"
                                                                                      : includedData[el].name == 'Call Compliance'
                                                                                          ? "${widget.allSummary[3]['data'][index]['filter']} / ${widget.allSummary[3]['data'][index]['month']}"
                                                                                          : "",
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          fontFamily,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xff344C65)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          const Expanded(
                                              child: TextButton(
                                                  onPressed: null,
                                                  child: Text(
                                                    "Clear",
                                                    style: TextStyle(
                                                        fontFamily: fontFamily,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff778898),
                                                        fontSize: 14),
                                                  ))),
                                          Expanded(
                                              child: TextButton(
                                                  onPressed:
                                                      widget.onRemoveGeoPressed,
                                                  child: const Text(
                                                    "Apply",
                                                    style: TextStyle(
                                                        fontFamily: fontFamily,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: MyColors
                                                            .showMoreColor,
                                                        fontSize: 14),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );

    return GestureDetector(
      onTap: widget.onGestureTap,
      child: Stack(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: 'Summary',
                subTitle: 'Summary',
                showHide: true,
                onPressed: widget.onPressed,
                onNewMonth: widget.onNewMonth,
                showHideRetailing: false,
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                      ),
                      child: SizedBox(
                        height: size.height - 124,
                        width: size.width - 350,
                        child: DraggableGridViewBuilder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            crossAxisSpacing: 25.0,
                            mainAxisSpacing: 25.0,
                            childAspectRatio:
                                ((size.height / 1.7) / (size.height / 2)),
                            maxCrossAxisExtent: size.height / 1.7,
                          ),
                          isOnlyLongPress: true,
                          dragCompletion: (List<DraggableGridItem> list,
                              int beforeIndex, int afterIndex) {
                            // print('onDragAccept: $beforeIndex -> $afterIndex');
                            var item = includedData[beforeIndex];
                            includedData.removeAt(beforeIndex);
                            includedData.insert(afterIndex, item);
                            SharedPreferencesUtils.setString(
                                'includedData', jsonEncode(includedData));
                          },
                          children: draggableCardList,
                          dragPlaceHolder:
                              (List<DraggableGridItem> list, int index) {
                            return PlaceHolderWidget(
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          },
                          dragFeedback:
                              (List<DraggableGridItem> list, int index) {
                            return SizedBox(
                              width: 300,
                              child: list[index].child,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            right: 65,
            top: 90,
            child: Visibility(
              visible: widget.updateMonth,
              child: Container(
                  height: 220,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1, color: MyColors.sheetDivider),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Select Month',
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: MyColors.textHeaderColor),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  sheetProvider.isDefaultMonth =
                                      !sheetProvider.isDefaultMonth;
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: MonthWebSheet(
                            elName: '',
                            onApplyPressed: widget.onApplyPressedMonthDefault,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Positioned(
              right: 0,
              top: 100,
              child: Visibility(
                visible: addMatrix,
                child: Container(
                  height: 700,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PersonalizeWeb(
                      onTap: () {
                        setState(() {
                          addMatrix = !addMatrix;
                        });
                      },
                      includedData: includedData,
                      metricData: metricData,
                      allMetrics: widget.allMetrics,
                      onTapApply: () {
                        setState(() {
                          addMatrix = !addMatrix;
                        });
                      },
                    ),
                  ),
                ),
              )),
          Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: widget.updateDefault,
                  child: Container(
                    height: size.width / 2.3,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectDivisionPopUp(
                        onPressedGeo: widget.onPressedGeo,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
