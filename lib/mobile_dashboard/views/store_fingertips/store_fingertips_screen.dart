import 'package:get/get.dart';
import 'widgets/new_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/widgets/table_widget.dart';

class StoreFingertipsScreen extends StatefulWidget {
  final String selectedDistributor;
  final String selectedBranch;
  final String selectedChannel;
  final String selectedStore;
  const StoreFingertipsScreen(
      {super.key,
      required this.selectedDistributor,
      required this.selectedBranch,
      required this.selectedChannel,
      required this.selectedStore});

  @override
  State<StoreFingertipsScreen> createState() => _StoreFingertipsScreenState();
}

class _StoreFingertipsScreenState extends State<StoreFingertipsScreen> {
  bool isFirst = true;
  void initCall(StoreController ctlr) {
    if (isFirst) {
      isFirst = false;
      ctlr.getHomeData(
          distributor: widget.selectedDistributor,
          branch: widget.selectedBranch,
          channel: widget.selectedChannel,
          store: widget.selectedStore);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<StoreController>(
          init: StoreController(storeRepo: Get.find()),
          builder: (ctlr) {
            initCall(ctlr);
            return !ctlr.isLoading
                ? ctlr.storeHomeModel != null
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Container(
                            //   padding: const EdgeInsets.all(10.0),
                            //   decoration: BoxDecoration(
                            //     borderRadius: const BorderRadius.only(
                            //       bottomLeft: Radius.circular(30.0),
                            //       bottomRight: Radius.circular(30.0),
                            //     ),
                            //     color: Colors.white,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         offset: const Offset(0, 4),
                            //         blurRadius: 15,
                            //         color: AppColors.black.withOpacity(.25),
                            //       ),
                            //     ],
                            //   ),
                            //   child: Column(
                            //     children: [
                            //       Image.asset("assets/png/Group 35.png", height: 31),
                            //       const SizedBox(height: 15),
                            //       Image.asset("assets/png/Rectangle 426.png"),
                            //       const SizedBox(height: 15),
                            //       Text(
                            //         ctlr.getStore(),
                            //         style: GoogleFonts.inter(
                            //           color: const Color(0xff0B4983),
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            NewAppBar(title: ctlr.selectedStore ?? ''),
                            // TabBar(
                            //   isScrollable: true,
                            //   unselectedLabelColor: const Color(0xff747474),
                            //   indicatorColor: Colors.black,
                            //   indicator: const BoxDecoration(),
                            //   labelStyle: GoogleFonts.inter(
                            //     color: Colors.grey,
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            //   labelColor: Colors.black,
                            //   tabs: const [
                            //     TabItemWidget(title: 'Dashboard'),
                            //     TabItemWidget(title: 'Sales Value'),
                            //     TabItemWidget(title: 'Coverage'),
                            //     TabItemWidget(title: 'GP'),
                            //     TabItemWidget(title: 'FB', isLast: true),
                            //   ],
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'KPI Homepage',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 8),
                                      GestureDetector(
                                        onTap: () {
                                          ctlr.onTabChange(0);
                                          Get.toNamed(
                                              AppPages.sroreFingertipsLanding);
                                        },
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Sales Values",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: AppColors
                                                          .greyTextColor,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        60) *
                                                    .9,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "0.00K",
                                                      style:
                                                          GoogleFonts.ptSans(),
                                                    ),
                                                    Text(
                                                      "${ctlr.storeHomeModel?.mtdRetailing?.retailing}",
                                                      style:
                                                          GoogleFonts.ptSans(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6.0),
                                                child: LinearPercentIndicator(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      60,
                                                  animation: true,
                                                  animationDuration: 1000,
                                                  lineHeight: 8.0,
                                                  barRadius:
                                                      const Radius.circular(10),
                                                  // leading: const Text("0.00K"),
                                                  // trailing: const Text("73.48K"),
                                                  percent: double.tryParse(
                                                          '${ctlr.storeHomeModel?.mtdRetailing?.retailingPer}') ??
                                                      0.0,
                                                  progressColor:
                                                      AppColors.sfPrimary,
                                                  backgroundColor:
                                                      AppColors.bgLight,
                                                  linearStrokeCap:
                                                      LinearStrokeCap.butt,
                                                ),
                                              ),
                                              // const SizedBox(height: 4),
                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           horizontal: 6.0),
                                              //   child: LinearPercentIndicator(
                                              //     width: MediaQuery.of(context)
                                              //             .size
                                              //             .width -
                                              //         60,
                                              //     animation: true,
                                              //     animationDuration: 1000,
                                              //     lineHeight: 8.0,
                                              //     barRadius:
                                              //         const Radius.circular(10),
                                              //     progressColor:
                                              //         AppColors.sfPrimary,
                                              //     backgroundColor:
                                              //         AppColors.bgLight,
                                              //     percent: 0.9,
                                              //     linearStrokeCap:
                                              //         LinearStrokeCap.butt,
                                              //   ),
                                              // ),
                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           horizontal: 8.0),
                                              //   child: SizedBox(
                                              //     width: (MediaQuery.of(context)
                                              //                 .size
                                              //                 .width -
                                              //             60) *
                                              //         .9,
                                              //     child: const Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceBetween,
                                              //       children: [
                                              //         Text("0.00K"),
                                              //         Text("87.71K"),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              const SizedBox(height: 12),
                                            ],
                                          ),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        // height: 60,
                                        width: double.infinity,
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        // margin: const EdgeInsets.only(
                                        //     top: 12, left: 12, right: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff000000)
                                                  .withOpacity(.08),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (!ctlr.dashboeardShowmore)
                                              StoreTableWidget(
                                                dataList: [
                                                  ctlr
                                                          .storeHomeModel
                                                          ?.mtdRetailing
                                                          ?.channel?[0] ??
                                                      []
                                                ],
                                                isFirst: true,
                                                color: ctlr.dashboeardShowmore
                                                    ? AppColors.white
                                                    : AppColors
                                                        .storeTableRowColor,
                                              ),
                                            // Container(
                                            //   color: ctlr.dashboeardShowmore
                                            //       ? AppColors.white
                                            //       : AppColors
                                            //           .storeTableRowColor,
                                            //   child: Row(
                                            //     children: [
                                            //       Expanded(
                                            //         child: Center(
                                            //           child: Text(
                                            //             'Channel Name',
                                            //             style:
                                            //                 GoogleFonts.inter(
                                            //               fontSize: 11,
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               color: AppColors
                                            //                   .greyTextColor,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Container(
                                            //         height: 30,
                                            //         width: .5,
                                            //         decoration: BoxDecoration(
                                            //           gradient: LinearGradient(
                                            //             colors: [
                                            //               const Color(
                                            //                       0xffCCCCCC)
                                            //                   .withOpacity(0),
                                            //               const Color(
                                            //                   0xffC8C8C8),
                                            //               const Color(
                                            //                   0xffC8C8C8),
                                            //               const Color(
                                            //                       0xffCCCCCC)
                                            //                   .withOpacity(0),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Expanded(
                                            //         child: Center(
                                            //           child: Text(
                                            //             'Seller Type',
                                            //             style:
                                            //                 GoogleFonts.inter(
                                            //               fontSize: 11,
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               color: AppColors
                                            //                   .greyTextColor,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Container(
                                            //         height: 30,
                                            //         width: .5,
                                            //         decoration: BoxDecoration(
                                            //           gradient: LinearGradient(
                                            //             colors: [
                                            //               const Color(
                                            //                       0xffCCCCCC)
                                            //                   .withOpacity(0),
                                            //               const Color(
                                            //                   0xffC8C8C8),
                                            //               const Color(
                                            //                   0xffC8C8C8),
                                            //               const Color(
                                            //                       0xffCCCCCC)
                                            //                   .withOpacity(0),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Expanded(
                                            //         child: Center(
                                            //           child: Text(
                                            //             'DSE Code',
                                            //             style:
                                            //                 GoogleFonts.inter(
                                            //               fontSize: 11,
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               color: AppColors
                                            //                   .greyTextColor,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Container(
                                            //         height: 30,
                                            //         width: .5,
                                            //         decoration: BoxDecoration(
                                            //           gradient: LinearGradient(
                                            //             colors: [
                                            //               const Color(
                                            //                       0xffCCCCCC)
                                            //                   .withOpacity(0),
                                            //               const Color(
                                            //                   0xffC8C8C8),
                                            //               const Color(
                                            //                   0xffC8C8C8),
                                            //               const Color(
                                            //                       0xffCCCCCC)
                                            //                   .withOpacity(0),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Expanded(
                                            //         child: Center(
                                            //           child: Text(
                                            //             'Last visited',
                                            //             style:
                                            //                 GoogleFonts.inter(
                                            //               fontSize: 11,
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               color: AppColors
                                            //                   .greyTextColor,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            if (ctlr.dashboeardShowmore)
                                              StoreTableWidget(
                                                dataList: ctlr
                                                        .storeHomeModel
                                                        ?.mtdRetailing
                                                        ?.channel ??
                                                    [],
                                                color: !ctlr.dashboeardShowmore
                                                    ? AppColors.white
                                                    : AppColors
                                                        .storeTableRowColor,
                                              ),
                                            // AnimatedContainer(
                                            //   duration: const Duration(
                                            //       milliseconds: 300),
                                            //   // height: 110,
                                            //   width: MediaQuery.of(context)
                                            //       .size
                                            //       .width,
                                            //   color: AppColors
                                            //       .storeTableRowColor,
                                            //   // padding: EdgeInsets.only(left: 6),
                                            //   child: Column(
                                            //     mainAxisSize:
                                            //         MainAxisSize.min,
                                            //     children: [
                                            //       Table(
                                            //         border: TableBorder.all(
                                            //             color: Colors
                                            //                 .transparent),
                                            //         children: [
                                            //           ...widget.dataList
                                            //               .asMap()
                                            //               .map(
                                            //                 (index, tableData) =>
                                            //                     MapEntry(
                                            //                   index,
                                            //                   TableRow(
                                            //                     decoration:
                                            //                         BoxDecoration(
                                            //                       color: index ==
                                            //                               0
                                            //                           ? AppColors
                                            //                               .white
                                            //                           : index % 2 ==
                                            //                                   0
                                            //                               ? AppColors.primary.withOpacity(.12)
                                            //                               : AppColors.primary.withOpacity(.25),
                                            //                       borderRadius: index ==
                                            //                               0
                                            //                           ? const BorderRadius
                                            //                               .only(
                                            //                               topLeft:
                                            //                                   Radius.circular(20),
                                            //                               topRight:
                                            //                                   Radius.circular(20),
                                            //                             )
                                            //                           : ((widget.dataList.length > 6)
                                            //                                   ? index == 6
                                            //                                   : index == (widget.dataList.length - 1))
                                            //                               ? const BorderRadius.only(
                                            //                                   bottomLeft: Radius.circular(20),
                                            //                                   bottomRight: Radius.circular(20),
                                            //                                 )
                                            //                               : null,
                                            //                     ),
                                            //                     children: [
                                            //                       ...tableData
                                            //                           .asMap()
                                            //                           .map(
                                            //                             (key, value) =>
                                            //                                 MapEntry(
                                            //                               key,
                                            //                               Container(
                                            //                                 decoration: BoxDecoration(
                                            //                                   borderRadius: BorderRadius.only(
                                            //                                     topLeft: key == 0 && index == 0 ? const Radius.circular(20) : Radius.zero,
                                            //                                     topRight: index == 0 && key == (widget.dataList[0].length - 1) ? const Radius.circular(20) : Radius.zero,
                                            //                                     bottomRight: index == (widget.dataList.length - 1) && key == (widget.dataList[0].length - 1) ? const Radius.circular(20) : Radius.zero,
                                            //                                     bottomLeft: index == (widget.dataList.length - 1) && key == 0 ? const Radius.circular(20) : Radius.zero,
                                            //                                   ),
                                            //                                 ),
                                            //                                 padding: const EdgeInsets.all(8.0),
                                            //                                 child: Text(
                                            //                                   value,
                                            //                                   style: GoogleFonts.ptSansCaption(
                                            //                                     fontSize: 12,
                                            //                                     fontWeight: index == 0 ? FontWeight.w600 : null,
                                            //                                   ),
                                            //                                 ),
                                            //                               ),
                                            //                             ),
                                            //                           )
                                            //                           .values
                                            //                           .toList(),
                                            //                     ],
                                            //                   ),
                                            //                 ),
                                            //               )
                                            //               .values
                                            //               .toList(),
                                            //         ],
                                            //       ),
                                            //       // tableRow(context),
                                            //       // tableRow(context),
                                            //       // tableRow(context),
                                            //       // tableRow(context),
                                            //       // tableRow(context),
                                            //       // tableRow(context),
                                            //     ],
                                            //   ),
                                            // ),
                                            GestureDetector(
                                              onTap: () => ctlr
                                                  .onDashboardTableShowMore(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    ctlr.dashboeardShowmore
                                                        ? Icons
                                                            .arrow_drop_up_outlined
                                                        : Icons
                                                            .arrow_drop_down_outlined,
                                                    color: AppColors.primary,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   color: Colors.white,
                            //   padding: EdgeInsets.all(20.0),
                            //   child: Table(
                            //     border: TableBorder.all(color: Colors.black),
                            //     children: [
                            //       TableRow(children: [
                            //         Text('Cell 1'),
                            //         Text('Cell 2'),
                            //         Text('Cell 3'),
                            //       ]),
                            //       TableRow(children: [
                            //         Text('Cell 4'),
                            //         Text('Cell 5'),
                            //         Text('Cell 6'),
                            //       ])
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10, right: 10),
                            //   child: Card(
                            //     elevation: 10,
                            //     color: Colors.white,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         color: Colors.white,
                            //       ),
                            //       // padding: const EdgeInsets.all(10),
                            //       child: Column(
                            //         children: const [
                            //           TableData(),
                            //           TableData(),
                            //           TableData(),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  ctlr.onTabChange(1);
                                  Get.toNamed(AppPages.sroreFingertipsLanding);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 12, bottom: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Coverage/Visit",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.inter(
                                                  color: AppColors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors.greyTextColor,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 12),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child:
                                                        LinearPercentIndicator(
                                                      width: 130.0,
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      lineHeight: 8.0,
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      leading: const Text(
                                                          "Target Calls"),
                                                      trailing: Text(
                                                          "${ctlr.storeHomeModel?.coverage?.targetCalls}"
                                                              .replaceAll(
                                                                  ".00", "")),
                                                      percent: double.tryParse(
                                                              '${ctlr.storeHomeModel?.coverage?.targetCallsPer}') ??
                                                          0.0,
                                                      linearStrokeCap:
                                                          LinearStrokeCap.butt,
                                                      progressColor:
                                                          AppColors.sfPrimary,
                                                      backgroundColor:
                                                          AppColors.bgLight,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child:
                                                        LinearPercentIndicator(
                                                      width: 130.0,
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      lineHeight: 8.0,
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      leading: const Text(
                                                          "Call Made   "),
                                                      trailing: Text(
                                                          "${ctlr.storeHomeModel?.coverage?.coverage}"
                                                              .replaceAll(
                                                                  ".00", "")),
                                                      percent: double.tryParse(
                                                              '${ctlr.storeHomeModel?.coverage?.coveragePer}') ??
                                                          0.0,
                                                      linearStrokeCap:
                                                          LinearStrokeCap.butt,
                                                      progressColor:
                                                          AppColors.sfPrimary,
                                                      backgroundColor:
                                                          AppColors.bgLight,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child:
                                                        LinearPercentIndicator(
                                                      width: 130.0,
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      lineHeight: 8.0,
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      leading: const Text(
                                                          "CCR Calls   "),
                                                      trailing: Text(
                                                          "${ctlr.storeHomeModel?.coverage?.callCompliance}"
                                                              .replaceAll(
                                                                  ".00", "")),
                                                      percent: double.tryParse(
                                                              '${ctlr.storeHomeModel?.coverage?.callCompliancePer}') ??
                                                          0.0,
                                                      linearStrokeCap:
                                                          LinearStrokeCap.butt,
                                                      progressColor:
                                                          AppColors.sfPrimary,
                                                      backgroundColor:
                                                          AppColors.bgLight,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child:
                                                        LinearPercentIndicator(
                                                      width: 130.0,
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      lineHeight: 8.0,
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      leading: const Text(
                                                          "Billed Calls "),
                                                      trailing: Text(
                                                        "${ctlr.storeHomeModel?.coverage?.billing}"
                                                            .replaceAll(
                                                                ".00", ""),
                                                        style: GoogleFonts
                                                            .ptSans(),
                                                      ),
                                                      percent: double.tryParse(
                                                              '${ctlr.storeHomeModel?.coverage?.billingPer}') ??
                                                          0.0,
                                                      linearStrokeCap:
                                                          LinearStrokeCap.butt,
                                                      progressColor:
                                                          AppColors.sfPrimary,
                                                      backgroundColor:
                                                          AppColors.bgLight,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child:
                                                        LinearPercentIndicator(
                                                      width: 130.0,
                                                      animation: true,

                                                      animationDuration: 1000,
                                                      lineHeight: 8.0,
                                                      barRadius:
                                                          const Radius.circular(
                                                              10),
                                                      // backgroundColor:
                                                      //     const Color.fromARGB(255, 2, 74, 133),
                                                      leading: const Text(
                                                          "Pro Calls    "),
                                                      trailing: Text(
                                                        "${ctlr.storeHomeModel?.coverage?.productivity}"
                                                            .replaceAll(
                                                                ".00", ""),
                                                        style: GoogleFonts
                                                            .ptSans(),
                                                      ),
                                                      percent: double.tryParse(
                                                              '${ctlr.storeHomeModel?.coverage?.productivityPer}') ??
                                                          0.0,
                                                      // ignore: deprecated_member_use
                                                      linearStrokeCap:
                                                          LinearStrokeCap.butt,
                                                      progressColor:
                                                          AppColors.sfPrimary,
                                                      backgroundColor:
                                                          AppColors.bgLight,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                100),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        const SizedBox(
                                                            width: 12),
                                                        Flexible(
                                                          child: Text.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: '37',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontSize:
                                                                        18,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: 'min',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontSize:
                                                                        10,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          'Avg in-Store Time',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.inter(
                                                            // fontStyle: FontStyle.italic,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .greyTextColor,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          ctlr.onTabChange(2);
                                          Get.toNamed(
                                              AppPages.sroreFingertipsLanding);
                                        },
                                        child: Container(
                                          height: 285,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Golden Point",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: AppColors
                                                          .greyTextColor,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  'Target',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              LinearPercentIndicator(
                                                width: 140,

                                                animation: true,
                                                animationDuration: 1000,
                                                lineHeight: 8.0,
                                                barRadius:
                                                    const Radius.circular(10),
                                                progressColor:
                                                    AppColors.sfPrimary,
                                                backgroundColor:
                                                    AppColors.bgLight,

                                                trailing: Text(
                                                    "${ctlr.storeHomeModel?.dgpCompliance?.gpTarget}"
                                                        .replaceAll(".00", "")),
                                                percent: double.tryParse(
                                                        '${ctlr.storeHomeModel?.dgpCompliance?.gpTargetPer}') ??
                                                    0.0,
                                                // ignore: deprecated_member_use
                                                linearStrokeCap:
                                                    LinearStrokeCap.butt,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6),
                                              ),
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  'P3M',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              LinearPercentIndicator(
                                                width: 140.0,
                                                animation: true,
                                                animationDuration: 1000,
                                                lineHeight: 8.0,
                                                barRadius:
                                                    const Radius.circular(10),
                                                progressColor:
                                                    AppColors.sfPrimary,
                                                backgroundColor:
                                                    AppColors.bgLight,
                                                trailing: Text(
                                                    "${ctlr.storeHomeModel?.dgpCompliance?.gpP3M}"
                                                        .replaceAll(".00", "")),
                                                percent: double.tryParse(
                                                        '${ctlr.storeHomeModel?.dgpCompliance?.gpP3MPer}') ??
                                                    0.0,
                                                // ignore: deprecated_member_use
                                                linearStrokeCap:
                                                    LinearStrokeCap.butt,
                                              ),
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  'P1M',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              LinearPercentIndicator(
                                                width: 140.0,
                                                animation: true,
                                                animationDuration: 1000,
                                                lineHeight: 8.0,
                                                barRadius:
                                                    const Radius.circular(10),
                                                progressColor:
                                                    AppColors.sfPrimary,
                                                backgroundColor:
                                                    AppColors.bgLight,
                                                trailing: Text(
                                                    "${ctlr.storeHomeModel?.dgpCompliance?.gpP1M}"
                                                        .replaceAll(".00", "")),
                                                percent: double.tryParse(
                                                        '${ctlr.storeHomeModel?.dgpCompliance?.gpP1MPer}') ??
                                                    0.0,
                                                // ignore: deprecated_member_use
                                                linearStrokeCap:
                                                    LinearStrokeCap.butt,
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          ctlr.onTabChange(3);
                                          Get.toNamed(
                                              AppPages.sroreFingertipsLanding);
                                        },
                                        child: Container(
                                          height: 285,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Focus Brand",
                                                        style:
                                                            GoogleFonts.inter(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: AppColors
                                                          .greyTextColor,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 35),
                                              CircularPercentIndicator(
                                                radius: 50.0,
                                                lineWidth: 8.0,
                                                percent: double.tryParse(
                                                        '${ctlr.storeHomeModel?.focusBrand?.fbPer}') ??
                                                    0.0,
                                                progressColor:
                                                    AppColors.sfPrimary,
                                                backgroundColor:
                                                    AppColors.bgLight,
                                                center: Text(
                                                  "${ctlr.storeHomeModel?.focusBrand?.fbTarget.toString().replaceAll(".00", "")}/${ctlr.storeHomeModel?.focusBrand?.fbAchieved.toString().replaceAll(".00", "")}",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 20),
                                                ),
                                                // center: CircularPercentIndicator(
                                                //   radius: 50.0,
                                                //   lineWidth: 8.0,
                                                //   percent: 1.0,
                                                //   center: const Text(
                                                //     "6/5",
                                                //     style: TextStyle(fontSize: 20),
                                                //   ),
                                                //   linearGradient: LinearGradient(
                                                //     colors: [
                                                //       const Color(0xff5B5B5B),
                                                //       const Color(0xff5B5B5B)
                                                //           .withOpacity(.44),
                                                //     ],
                                                //   ),
                                                // ),
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                              ),
                                              const SizedBox(height: 20),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "FB Target / ",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          color: AppColors
                                                              .greyTextColor,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "FB Achieved",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NewAppBar(title: ctlr.selectedStore ?? ''),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/json/nothing.json',
                                width: MediaQuery.of(context).size.width * .7,
                                fit: BoxFit.fill,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'No Data Found!',
                                      style: GoogleFonts.ptSansCaption(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                        ],
                      )
                : const Center(child: CustomLoader());
          },
        ),
      ),
    );
  }

  Widget tableRow(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.storeTableRowColor,
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: AppColors.lightGrey,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  'Large A Pharmacy',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyTextColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffCCCCCC).withOpacity(0),
                  const Color(0xffC8C8C8),
                  const Color(0xffC8C8C8),
                  const Color(0xffCCCCCC).withOpacity(0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Field Seller',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffCCCCCC).withOpacity(0),
                  const Color(0xffC8C8C8),
                  const Color(0xffC8C8C8),
                  const Color(0xffCCCCCC).withOpacity(0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'CGADH_MS104',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffCCCCCC).withOpacity(0),
                  const Color(0xffC8C8C8),
                  const Color(0xffC8C8C8),
                  const Color(0xffCCCCCC).withOpacity(0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '31-12-2023',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableData extends StatefulWidget {
  const TableData({super.key});

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  final TableRow _tableRow = const TableRow(children: <Widget>[
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Channel Name",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Seller Type",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "DSE Code",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Last Visited",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        border: TableBorder.all(
          width: .5,
          color: Colors.grey[300]!,
          // borderRadius: BorderRadius.circular(8),
        ),
        defaultColumnWidth: const FlexColumnWidth(10.0),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: <TableRow>[_tableRow],
      ),
    );
  }
}
