import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/utils/retailing_header.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/coverage_addgeo_sheet.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../../activities/retailing_screen.dart';
import '../../../../../../utils/colors/colors.dart';
import '../../../../../../utils/style/text_style.dart';
import 'retailing_summary.dart';

class RetailingContainer extends StatefulWidget {
  final Function() onGeoChanged;
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
  final List<String> selectedItemValueCategory;
  final Function() categoryApply;
  final Function() onRemoveFilterCategory;
  final Function() onTapChannelFilter;
  final List<String> selectedItemValueBrand;
  final List<String> selectedItemValueBrandForm;
  final List<String> selectedItemValueBrandFromGroup;
  final String selectedMonthList;
  const RetailingContainer({Key? key, required this.onGeoChanged, required this.onTap1, required this.onTap2, required this.onTap3, required this.onTap4, required this.selectedIndex1, required this.dataList, required this.onClosedTap, required this.divisionList, required this.siteList, required this.branchList, required this.selectedGeo, required this.clusterList, required this.onApplyPressedMonth, required this.onTapMonthFilter, required this.selectedItemValueChannel, required this.onChangedFilter, required this.onRemoveFilter, required this.selectedItemValueCategory, required this.categoryApply, required this.onRemoveFilterCategory, required this.selectedItemValueBrand, required this.selectedItemValueBrandForm, required this.selectedItemValueBrandFromGroup, required this.selectedMonthList, required this.onTapChannelFilter, required this.dataListByGeo}) : super(key: key);

  @override
  State<RetailingContainer> createState() => _RetailingContainerState();
}

class _RetailingContainerState extends State<RetailingContainer> {
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
    'Bangalore',
    'All India',
    '',
  ];

  List<String> retailingDeep = [
    'Daily Sellout Report',
    'Retailing by Channel',
    'Retailing by Category',
    'Retailing Trends',
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
                title: "Retailing",
                subTitle: "Retailing",
                showHide: false,
                onPressed: () {},
                onNewMonth: widget.onGeoChanged, showHideRetailing: true,
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
                                                  itemCount: 4,
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
                                                              size.height / 3.2,
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
                                                                    title: '$index',
                                                                    // title: widget.coverageAPIList[0][index]
                                                                    //         [
                                                                    //         'mtdRetailing']
                                                                    //     [
                                                                    //     'filter'],
                                                                    subTitle:
                                                                        'hhh',
                                                                    dateTitle:
                                                                        'dsgs',
                                                                    subLabel:
                                                                        'alshdjk',
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
                                                                  SizedBox(height: 20,),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      CircularPercentIndicator(
                                                                        radius: 50.0,
                                                                        lineWidth: 10.0,
                                                                        animation: true,
                                                                        percent: 0.45,
                                                                        center: const Text(
                                                                          "112",
                                                                          style: ThemeText
                                                                              .achText,
                                                                        ),
                                                                        circularStrokeCap:
                                                                        CircularStrokeCap
                                                                            .round,
                                                                        backgroundColor:
                                                                        MyColors
                                                                            .progressBack,
                                                                        linearGradient:
                                                                        const LinearGradient(
                                                                            colors: [
                                                                              MyColors
                                                                                  .progressStart,
                                                                              MyColors
                                                                                  .progressEnd,
                                                                            ]),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      const Text(
                                                                        'Target: 113',
                                                                        style: ThemeText
                                                                            .coverageText,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

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
                              // setState(() {
                              //   sheetProvider.isCoverageGeoAdd =
                              //       !sheetProvider.isCoverageGeoAdd;
                              // });
                            },
                            list: [],
                            divisionList: [],
                            siteList:[],
                            branchList: [],
                            selectedGeo: 0,
                            clusterList: [],
                            onApplyPressed: (){},
                            // divisionList: widget.divisionList,
                            // siteList: widget.siteList,
                            // branchList: widget.branchList,
                            // selectedGeo: widget.selectedGeo,
                            // clusterList: widget.clusterList,
                            // onApplyPressed: widget.onApplyPressedMonth,
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
            child: RetailingWebSummary(
            onTap: () {
              setState(() {
                dailyReport = !dailyReport;
              });
            },
            selectedIndex: selectedIndex1 + 1,
            highlighted: true, onTap1:  widget.onTap1, onTap2: widget.onTap2, onTap3: widget.onTap3, onTap4: widget.onTap4, selectedIndex1: widget.selectedIndex1,
              dataList: widget.dataList, onClosedTap: widget.onClosedTap, divisionList: widget.divisionList, siteList: widget.siteList,
              branchList: widget.branchList, selectedGeo: widget.selectedGeo, clusterList: widget.clusterList, onApplyPressedMonth: widget.onApplyPressedMonth,
              onTapMonthFilter: widget.onTapMonthFilter, selectedItemValueChannel: widget.selectedItemValueChannel, onChangedFilter: widget.onChangedFilter,
              onRemoveFilter: widget.onRemoveFilter, selectedItemValueCategory: widget.selectedItemValueCategory, categoryApply: widget.categoryApply,
              onRemoveFilterCategory: widget.onRemoveFilterCategory,
              selectedItemValueBrand: widget.selectedItemValueBrand,
              selectedItemValueBrandForm: widget.selectedItemValueBrandForm,
              selectedItemValueBrandFromGroup: widget.selectedItemValueBrandFromGroup, selectedMonthList: widget.selectedMonthList, onTapChannelFilter: widget.onTapChannelFilter, dataListByGeo: widget.dataListByGeo,
          ));
  }
}
