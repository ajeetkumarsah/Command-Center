import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/web_dashboard/cards_container/retailing_container.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/table_utils/position_month_table.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/popup_sheet.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/popup_summary.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/retailing_header.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/coverage_addgeo_sheet.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/header_card_web.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../../activities/retailing_screen.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../../utils/style/text_style.dart';
import 'retailing_summary.dart';

class RetailingContainer extends StatefulWidget {
  final bool menuBool;
  final bool divisionBool;
  final bool removeBool;
  final Function() onGeoChanged;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final Function() onTap4;
  final Function() onMonthChangedDefault;
  final Function() onApplySummaryDefaultMonth;
  final int selectedIndex1;
  final List<dynamic> dataList;
  final List<dynamic> dataListByGeo;
  final List<dynamic> listRetailingDataListCoverage;
  final Function() onClosedTap;
  final List divisionList;
  final List siteList;
  final List branchList;
  final int selectedGeo;
  final List clusterList;
  final Function() onApplyPressedMonth;
  final Function() onApplyRetailingSummary;
  final Function() onRemoveGeoPressed;
  final Function() onTapMonthFilter;
  final List<String> selectedItemValueChannel;
  final Function(String?) onChangedFilter;
  final Function() onRemoveFilter;
  final List<String> selectedItemValueCategory;
  final Function() categoryApply;
  final Function() onRemoveFilterCategory;
  final Function() onTapChannelFilter;
  final Function() onTapRemoveFilter;
  final Function() tryAgain;
  final Function() tryAgain1;
  final Function() tryAgain2;
  final Function() tryAgain3;
  final List<String> selectedItemValueBrand;
  final List<String> selectedItemValueBrandForm;
  final List<String> selectedItemValueBrandFromGroup;
  final String selectedMonthList;
  final Function() onTapSiteFilter;
  final Function() onTapBranchFilter;
  final Function() onTapContainer;

  const RetailingContainer(
      {Key? key,
      required this.onGeoChanged,
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
      required this.listRetailingDataListCoverage,
      required this.onTapContainer,
      required this.onApplyRetailingSummary,
      required this.onRemoveGeoPressed,
      required this.menuBool,
      required this.divisionBool,
      required this.removeBool, required this.onMonthChangedDefault, required this.onApplySummaryDefaultMonth, required this.tryAgain, required this.tryAgain1, required this.tryAgain2, required this.tryAgain3})
      : super(key: key);

  @override
  State<RetailingContainer> createState() => _RetailingContainerState();
}

class _RetailingContainerState extends State<RetailingContainer> {
  int selectedIndex = 1;
  int selectedCardIndex = 0;
  int selectedArrayItemRe = -1;
  late double xAlign;

  int iya = 0;
  late Color loginColor;
  late Color signInColor;
  // bool menuBool = false;
  // bool divisionBool = false;
  // bool removeBool = false;
  List<String> popupmenuList = ['Add Another Geo', 'Remove Geo'];

  List<String> widgetList = [
    'Goa',
    'Bangalore',
    'All India',
    '',
  ];

  List<String> retailingDeep = [
    'Daily Sellout Report',
    'Retailing by Geo',
    'Retailing by Category',
    'Retailing by Channel',
  ];

  bool dailyReport = false;
  int selectedIndex1 = 0;
  late ScrollController _scrollController;

  List<bool> itemVisibilityList = List.generate(5, (index) => false);

  void toggleItemVisibility(int index) {
    setState(() {
      itemVisibilityList[index] = !itemVisibilityList[index];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    _scrollController = ScrollController();
    // menuBool = widget.menuBool;
    // divisionBool = widget.divisionBool;
    // removeBool = widget.removeBool;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    return dailyReport == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: "Retailing",
                subTitle: "Retailing",
                showHide: false,
                onPressed: () {},
                onNewMonth: widget.onGeoChanged,
                showHideRetailing: true,
                onTapDefaultGoe: () {},
              ),
              Stack(children: [
                Positioned(
                  right: 20,
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: widget.onMonthChangedDefault,
                      //     (){
                      //   String selectedmonth = 'Jul';

                      //   fetchRetailingWeb(context,selectedmonth);
                      //   setState(() {
                      //
                      //   });
                      // },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(
                                width: 1.0, color: MyColors.whiteColor)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5.0))),
                      ),
                      child: const Text(
                        "Change Default Month",
                        style: TextStyle(
                            fontFamily: fontFamily, color: MyColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                      ),
                      child: SizedBox(
                          height: size.height - 130,
                          width: size.width - 350,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                            elevation: 3,
                                            child: Column(
                                              children: [
                                                HeaderWebCard(
                                                  dateTitle: "Jan'2023",
                                                  subLabel: '',
                                                  onPressed: () {
                                                    setState(() {
                                                      sheetProvider
                                                              .selectedIcon =
                                                          'Retailing';
                                                      SharedPreferencesUtils
                                                          .setString("keyName",
                                                              'Retailing');
                                                      sheetProvider.isMenuActive = !sheetProvider.isMenuActive;
                                                    });
                                                  },
                                                  title: 'Retailing',
                                                  subTitle: "CM",
                                                  xAlign: xAlign,
                                                  onTap: () {
                                                    setState(() {
                                                      iya = 0;
                                                      xAlign = loginAlign;
                                                      loginColor =
                                                          selectedColor;
                                                      signInColor = normalColor;
                                                    });
                                                  },
                                                  loginColor: loginColor,
                                                  signInColor: signInColor,
                                                  onTapSign: () {
                                                    setState(() {
                                                      iya = 1;
                                                      xAlign = signInAlign;
                                                      signInColor =
                                                          selectedColor;
                                                      loginColor = normalColor;
                                                    });
                                                  },
                                                  index: 'Retailing',
                                                  onEnter:
                                                      (PointerEnterEvent) {},
                                                  isHovering: false,
                                                  onExit:
                                                      (PointerEnterEvent) {},
                                                  onTapTitle:
                                                      widget.onTapContainer,
                                                  onTitle: () {
                                                    sheetProvider.selectedEl =
                                                        'Retailing';
                                                  },
                                                  onDateSelected: () {},
                                                  elName: 'Retailing',
                                                ),
                                                RetailingSummaryContainer(
                                                  iya: iya,
                                                  elName: 'Name',
                                                  dataList: widget
                                                      .listRetailingDataListCoverage,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: size.height / 2.5,
                                    child: ListView.builder(itemCount: retailingDeep.length, itemBuilder: (context, index){
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 20,
                                            right: 280),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              dailyReport = !dailyReport;
                                              selectedIndex1 = index;
                                            });
                                          },
                                          child: SizedBox(
                                            width: size.width,
                                            height: 65,
                                            // decoration: BoxDecoration(
                                            //   color: Colors.white,
                                            //   border: Border.all(
                                            //       width: 0.4,
                                            //       color: MyColors.deselectColor),
                                            //   borderRadius: BorderRadius.circular(20.0),
                                            // ),
                                            child: Card(
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0),
                                              ),
                                              elevation: 3,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      retailingDeep[
                                                      index],
                                                      style: ThemeText
                                                          .titleText,
                                                    ),
                                                    const Spacer(),
                                                    const Icon(
                                                      Icons
                                                          .arrow_outward_outlined,
                                                      color: MyColors
                                                          .toggletextColor,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Positioned(
                  right: 20,
                  top: 30,
                  child: Visibility(
                    visible: sheetProvider.isMenuActive,
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
                                    ? sheetProvider.isDivisionActive = !sheetProvider.isDivisionActive
                                    : index == 1
                                        ? sheetProvider.isRemoveActive = !sheetProvider.isRemoveActive
                                        : null;
                              });
                            },
                            child: Container(
                              height: 36,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 0.6, color: MyColors.sheetDivider),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                    visible: sheetProvider.isDivisionActive,
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
                        child: DivisionWebRetailingSheet(
                          onTap: () {
                            setState(() {
                              sheetProvider.isDivisionActive = !sheetProvider.isDivisionActive;
                            });
                          },
                          list: [],
                          divisionList: widget.divisionList,
                          siteList: widget.siteList,
                          branchList: widget.branchList,
                          selectedGeo: widget.selectedGeo,
                          clusterList: widget.clusterList,
                          onApplyPressed: widget.onApplyRetailingSummary,
                          elName: 'includedData[el].name',
                        )),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 30,
                  child: Visibility(
                    // visible: true,
                    visible: sheetProvider.isRemoveActive,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color:
                                                    MyColors.textHeaderColor),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                sheetProvider.isRemoveActive = !sheetProvider.isRemoveActive;
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
                                    padding: EdgeInsets.only(left: 20, top: 15),
                                    child: Text(
                                      'Show in Summary',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: MyColors.textHeaderColor),
                                    ),
                                  ),
                                  widget.listRetailingDataListCoverage.isEmpty
                                      ? Container()
                                      : Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30.0),
                                            child: ListView.builder(
                                                itemCount: widget
                                                    .listRetailingDataListCoverage[
                                                        0]['data']
                                                    .length,
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
                                                                if (selectedArrayItemRe ==
                                                                    index) {
                                                                  selectedArrayItemRe =
                                                                      -1;
                                                                  sheetProvider
                                                                          .removeIndexRetailingSummary =
                                                                      index;
                                                                } else {
                                                                  selectedArrayItemRe =
                                                                      index;
                                                                  sheetProvider
                                                                          .removeIndexRetailingSummary =
                                                                      index;
                                                                }
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20,
                                                                      top: 5,
                                                                      bottom:
                                                                          4),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    height: 15,
                                                                    width: 15,
                                                                    decoration: BoxDecoration(
                                                                        color: selectedArrayItemRe ==
                                                                                index
                                                                            ? Colors
                                                                                .blue
                                                                            : MyColors
                                                                                .transparent,
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius.circular(
                                                                                2)),
                                                                        border: Border.all(
                                                                            color: selectedArrayItemRe == index
                                                                                ? Colors.blue
                                                                                : MyColors.grey,
                                                                            width: 1)),
                                                                    child: selectedArrayItemRe ==
                                                                            index
                                                                        ? const Icon(
                                                                            Icons.check,
                                                                            color:
                                                                                MyColors.whiteColor,
                                                                            size:
                                                                                13,
                                                                          )
                                                                        : null,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "${widget.listRetailingDataListCoverage[0]['data'][index]['filter']} / ${widget.listRetailingDataListCoverage[0]['data'][index]['month']}",
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
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff778898),
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
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MyColors.showMoreColor,
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
                MonthPositionTable(
                  visible: sheetProvider.selectMonth,
                  onApplyPressedMonth:
                  widget.onApplySummaryDefaultMonth,
                  onTap: () {
                    setState(() {
                      sheetProvider.selectMonth = false;
                    });
                  },
                ),
              ])
            ],
          )
        : Expanded(
            child: RetailingWebSummary(
            onTap: () {
              setState(() {
                dailyReport = !dailyReport;
              });
            },
            selectedIndex: selectedIndex1 + 1,
            highlighted: true,
            onTap1: widget.onTap1,
            onTap2: widget.onTap2,
            onTap3: widget.onTap3,
            onTap4: widget.onTap4,
            selectedIndex1: widget.selectedIndex1,
            dataList: widget.dataList,
            onClosedTap: widget.onClosedTap,
            divisionList: widget.divisionList,
            siteList: widget.siteList,
            branchList: widget.branchList,
            selectedGeo: widget.selectedGeo,
            clusterList: widget.clusterList,
            onApplyPressedMonth: widget.onApplyPressedMonth,
            onTapMonthFilter: widget.onTapMonthFilter,
            selectedItemValueChannel: widget.selectedItemValueChannel,
            onChangedFilter: widget.onChangedFilter,
            onRemoveFilter: widget.onRemoveFilter,
            selectedItemValueCategory: widget.selectedItemValueCategory,
            categoryApply: widget.categoryApply,
            onRemoveFilterCategory: widget.onRemoveFilterCategory,
            selectedItemValueBrand: widget.selectedItemValueBrand,
            selectedItemValueBrandForm: widget.selectedItemValueBrandForm,
            selectedItemValueBrandFromGroup:
                widget.selectedItemValueBrandFromGroup,
            selectedMonthList: widget.selectedMonthList,
            onTapChannelFilter: widget.onTapChannelFilter,
            dataListByGeo: widget.dataListByGeo,
            onTapRemoveFilter: widget.onTapRemoveFilter,
            onTapSiteFilter: widget.onTapSiteFilter,
            onTapBranchFilter: widget.onTapBranchFilter,
              tryAgain: widget.tryAgain,
              tryAgain1: widget.tryAgain1,
              tryAgain2: widget.tryAgain2,
              tryAgain3: widget.tryAgain3,
          ));
  }
}
