import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/retailing_header.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/coverage_addgeo_sheet.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../activities/retailing_screen.dart';
import '../../../../../../provider/sheet_provider.dart';
import '../../../../../../utils/colors/colors.dart';
import 'coverage_web_summary.dart';

class DistributionContainer extends StatefulWidget {
  final String title;
  final List divisionList;
  final List siteList;
  final List branchList;
  final int selectedGeo;
  final List clusterList;
  final List coverageAPIList;
  final Function() onApplyPressedMonth;
  final bool addMonthBool;
  final List<dynamic> dataList;
  final List<dynamic> dataListTabs;
  final List<dynamic> dataListBillingTabs;
  final List<dynamic> dataListCCTabs;
  final Function(String?) onChangedFilter;
  final Function(String?) onChangedFilterMonth;
  final List<String> selectedItemValueChannel;
  final List<String> selectedItemValueChannelMonth;
  final Function() onApplyPressedMonthCHRTab;
  final Function() onClosedTap;
  final String selectedMonthList;
  final Function() onTapMonthFilter;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final Function() onTap4;
  final int selectedIndex1;
  final String selectedChannelList;
  final Function() onTapChannelFilter;
  final Function() onTapRemoveFilter;
  final int selectedIndexLocation;

  const DistributionContainer(
      {Key? key,
      required this.title,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo,
      required this.clusterList,
      required this.onApplyPressedMonth,
      required this.addMonthBool,
      required this.dataList,
      required this.coverageAPIList,
      required this.onChangedFilter,
      required this.selectedItemValueChannel,
      required this.onChangedFilterMonth,
      required this.selectedItemValueChannelMonth,
      required this.onApplyPressedMonthCHRTab,
      required this.dataListTabs,
      required this.dataListBillingTabs,
      required this.dataListCCTabs, required this.onClosedTap, required this.selectedMonthList, required this.onTapMonthFilter, required this.onTap1, required this.onTap2, required this.onTap3, required this.onTap4, required this.selectedIndex1, required this.selectedChannelList, required this.onTapChannelFilter, required this.onTapRemoveFilter, required this.selectedIndexLocation})
      : super(key: key);

  @override
  State<DistributionContainer> createState() => _DistributionContainerState();
}

class _DistributionContainerState extends State<DistributionContainer> {
  int selectedIndex = 1;
  int selectedCardIndex = 0;
  List<double> xAlign = [];
  List<bool> menuBool = [false, false, false, false, false];
  List<bool> divisionBool = [false, false, false, false, false];

  List<double> loginAlign = [-1, -1, -1, -1, -1];
  List<double> signInAlign = [1, 1, 1, 1, 1];

  late Color loginColor;
  late Color signInColor;
  List<String> popupmenuList = [
    'Switch Geo',
    'Delete Card',
  ];

  List<String> widgetList = [
    'Goa',
    '',
  ];

  List<String> retailingDeep = [
    'Consolidated View',
    'Call Hit Rate',
    'Productivity',
    'PxM Billing',
  ];

  bool dailyReport = false;
  int selectedIndex1 = 0;

  List<bool> itemVisibilityList = List.generate(5, (index) => false);

  void toggleItemVisibility(int index) {
    setState(() {
      itemVisibilityList[index] = !itemVisibilityList[index];
    });
  }

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    return dailyReport == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: widget.title,
                subTitle: widget.title,
                showHide: false,
                onPressed: () {},
                onNewMonth: () {}, showHideRetailing: false,
              ),
              SingleChildScrollView(
                child: Stack(children: [
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
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          controller: _scrollController,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  controller: _scrollController,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  itemCount: widget
                                                      .coverageAPIList[0]
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 20,
                                                              right: 20),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            // dailyReport = !dailyReport;
                                                            // selectedIndex1 = index;
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          width:
                                                              size.height / 2.5,
                                                          height:
                                                              size.height / 1.7,
                                                          child: Card(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                              elevation: 3,
                                                              child: Column(
                                                                children: [
                                                                  RetailingHeader(
                                                                    onPressed:
                                                                        () {},
                                                                    title: widget.coverageAPIList[0][index]
                                                                            [
                                                                            'mtdRetailing']
                                                                        [
                                                                        'filter'],
                                                                    subTitle:
                                                                        '',
                                                                    dateTitle:
                                                                        '',
                                                                    subLabel:
                                                                        '',
                                                                    index: '',
                                                                    xAlign: 0.1,
                                                                    onTap:
                                                                        () {},
                                                                    onTapSign:
                                                                        () {},
                                                                    loginColor:
                                                                        MyColors
                                                                            .textColor,
                                                                    signInColor:
                                                                        MyColors
                                                                            .textColor,
                                                                    itemVisibilityList:
                                                                        true,
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                  width: size.height / 2.5,
                                                  height: size.height / 1.7,
                                                  child: InkWell(
                                                    onTap: () {
                                                      print(widget
                                                          .coverageAPIList[0]
                                                          .length);
                                                      print(widget
                                                          .coverageAPIList);
                                                      sheetProvider
                                                              .isCoverageGeoAdd =
                                                          !sheetProvider
                                                              .isCoverageGeoAdd;
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              top: 20,
                                                              right: 20),
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        elevation: 3,
                                                        child: const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          // mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              'Add Geography',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16,
                                                                color: MyColors
                                                                    .textColor,
                                                                fontFamily:
                                                                    fontFamily,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .add_circle_outline_sharp,
                                                              color:
                                                                  MyColors.grey,
                                                              size: 60,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: ListView.builder(
                                          itemCount: retailingDeep.length,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, index) {
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
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: Visibility(
                      // visible: true,
                      visible: sheetProvider.isCoverageGeoAdd,
                      child: Container(
                          height: 310,
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
                          child: CoverageGeoDivisionWebSheet(
                            onTap: () {
                              setState(() {
                                sheetProvider.isCoverageGeoAdd =
                                    !sheetProvider.isCoverageGeoAdd;
                              });
                            },
                            list: [],
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
                            elName: '',
                          )),
                    ),
                  ),
                ]),
              )
            ],
          )
        : Expanded(
            child: CoverageWebSummary(
            onTap: () {
              setState(() {
                dailyReport = !dailyReport;
              });
            },
            selectedIndex: selectedIndex1 + 1,
            highlighted: true,
            divisionList: widget.divisionList,
            siteList: widget.siteList,
            branchList: widget.branchList,
            selectedGeo: widget.selectedGeo,
            clusterList: widget.clusterList,
            onApplyPressedMonth: widget.onApplyPressedMonth,
            addMonthBool: widget.addMonthBool,
            dataList: widget.dataList,
            onChangedFilter: widget.onChangedFilter,
            selectedItemValueChannel: widget.selectedItemValueChannel,
            onChangedFilterMonth: widget.onChangedFilterMonth,
            selectedItemValueChannelMonth: widget.selectedItemValueChannelMonth,
            onApplyPressedMonthCHRTab: widget.onApplyPressedMonthCHRTab,
            dataListTabs: widget.dataListTabs,
            dataListBillingTabs: widget.dataListBillingTabs,
            dataListCCTabs: widget.dataListCCTabs, onClosedTap: widget.onClosedTap, selectedMonthList: widget.selectedMonthList, onTapMonthFilter: widget.onTapMonthFilter, onTap1: widget.onTap1, onTap2: widget.onTap2, onTap3: widget.onTap3, onTap4: widget.onTap4, selectedIndex1: widget.selectedIndex1, selectedChannelList: widget.selectedChannelList, onTapChannelFilter: widget.onTapChannelFilter, onTapRemoveFilter:  widget.onTapRemoveFilter, selectedIndexLocation: widget.selectedIndexLocation,
          ));
  }
}
