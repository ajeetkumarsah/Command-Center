import 'dart:math';
import 'package:get/get.dart';
import 'package:text_3d/text_3d.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_card.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/retailing_graph_widget.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/retailing_table_widget.dart';

class AllMetricsScreen extends StatelessWidget {
  const AllMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return RefreshIndicator(
            onRefresh: () => ctlr.getSummaryData(),
            child: ctlr.summaryData.isNotEmpty
                ? Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(PngFiles.homeBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 40),
                    child: SingleChildScrollView(
                      controller: ctlr.mScrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'All Metrics',
                            style: GoogleFonts.ptSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          if (ctlr.activeMetrics
                              .contains('Retailing')) //ctlr.showRetailing)
                            ctlr.isSummaryPageLoading ||
                                    ctlr.isDirectIndirectLoading
                                ? CustomShimmer(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    borderRadius: BorderRadius.circular(22),
                                    margin: const EdgeInsets.only(
                                        top: 24,
                                        left: 12,
                                        right: 12,
                                        bottom: 8),
                                  )
                                : ctlr.summaryData.isNotEmpty
                                    ? PersonalizeCard(
                                        title: 'Retailing',
                                        onPressedShowMore: () => Get.toNamed(
                                            AppPages.RETAILING_SCREEN),
                                        secondWidget: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: ThreeDText(
                                                text: 'Retailing',
                                                textStyle: GoogleFonts.ptSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.white,
                                                ),
                                                depth: 2,
                                                style: ThreeDStyle.inset,
                                                angle: pi / 6,
                                                perspectiveDepth: 10,
                                              ),
                                              // Text(
                                              //   'Retailing',
                                              //   style: GoogleFonts.ptSans(
                                              //     fontSize: 18,
                                              //     fontWeight: FontWeight.w700,
                                              //     color: AppColors.white,
                                              //   ),
                                              // ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 0,
                                                  left: 12,
                                                  right: 4),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.white,
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      AppColors
                                                          .contentColorCyan,
                                                      AppColors
                                                          .contentColorBlue,
                                                    ],
                                                  ),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.lightGrey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                        ctlr.onChangeSummaryDI(
                                                            true),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: ctlr
                                                                .isSummaryDirect
                                                            ? AppColors.white
                                                            : Colors
                                                                .transparent,
                                                        gradient: !ctlr
                                                                .isSummaryDirect
                                                            ? const LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                                  AppColors
                                                                      .contentColorCyan,
                                                                  AppColors
                                                                      .contentColorBlue,
                                                                ],
                                                              )
                                                            : null,
                                                        boxShadow:
                                                            ctlr.isSummaryDirect
                                                                ? [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .5),
                                                                      blurRadius:
                                                                          2.0,
                                                                      spreadRadius:
                                                                          0.0,
                                                                      offset: const Offset(
                                                                          2.0,
                                                                          2.0),
                                                                    ),
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .2),
                                                                      blurRadius:
                                                                          2.0,
                                                                      spreadRadius:
                                                                          0.0,
                                                                      offset: const Offset(
                                                                          -2.0,
                                                                          -2.0),
                                                                    ),
                                                                  ]
                                                                : null,
                                                        border: Border.all(
                                                          width: 1,
                                                          color: ctlr
                                                                  .isSummaryDirect
                                                              ? AppColors.white
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                      child: Text(
                                                        'Distributor',
                                                        style: GoogleFonts
                                                            .ptSansCaption(
                                                          color: ctlr
                                                                  .isSummaryDirect
                                                              ? AppColors
                                                                  .primary
                                                              : Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (ctlr.selectedGeo ==
                                                      'All India')
                                                    GestureDetector(
                                                      onTap: () => ctlr
                                                          .onChangeSummaryDI(
                                                              false),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ctlr
                                                                  .isSummaryDirect
                                                              ? Colors
                                                                  .transparent
                                                              : AppColors.white,
                                                          gradient: ctlr
                                                                  .isSummaryDirect
                                                              ? const LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    AppColors
                                                                        .contentColorCyan,
                                                                    AppColors
                                                                        .contentColorBlue,
                                                                  ],
                                                                )
                                                              : null,
                                                          boxShadow: !ctlr
                                                                  .isSummaryDirect
                                                              ? [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .5),
                                                                    blurRadius:
                                                                        2.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        const Offset(
                                                                            2.0,
                                                                            2.0),
                                                                  ),
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .2),
                                                                    blurRadius:
                                                                        2.0,
                                                                    spreadRadius:
                                                                        0.0,
                                                                    offset:
                                                                        const Offset(
                                                                            -2.0,
                                                                            -2.0),
                                                                  ),
                                                                ]
                                                              : null,
                                                          border:
                                                              ctlr.isSummaryDirect
                                                                  ? null
                                                                  : Border.all(
                                                                      width: 1,
                                                                      color: !ctlr.isSummaryDirect
                                                                          ? AppColors
                                                                              .white
                                                                          : Colors
                                                                              .transparent,
                                                                    ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 4),
                                                        child: Text(
                                                          'Total Retailing',
                                                          style: GoogleFonts
                                                              .ptSansCaption(
                                                            color: !ctlr
                                                                    .isSummaryDirect
                                                                ? AppColors
                                                                    .primary
                                                                : Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        ctlr.isSummaryDirect
                                                            ? 'Sellout (in ${ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Lk') ?? false ? 'Lk' : ''})'
                                                            : 'Sellout (in ${ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Lk') ?? false ? 'Lk' : ''})',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              ctlr.isSummaryDirect
                                                                  ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout}'
                                                                  : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout}',
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${ctlr.selectedMonth.substring(0, 3)}${ctlr.selectedMonth.substring(6, 8)} IYA',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              ctlr.isSummaryDirect
                                                                  ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmIya}'
                                                                  : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmIya}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'FYTD IYA',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              ctlr.isSummaryDirect
                                                                  ? '${ctlr.summaryData.first.mtdRetailing?.ind?.fyIya}'
                                                                  : '${ctlr.summaryData.first.mtdRetailing?.indDir?.fyIya}',
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //

                                          if (ctlr.getPersona() &&
                                              ctlr.channelRetailingModel !=
                                                  null)
                                            Container(
                                              height: .5,
                                              width: double.infinity,
                                              color: AppColors.borderColor,
                                            ),
                                          if (ctlr.getPersona() &&
                                              ctlr.channelRetailingModel !=
                                                  null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 16),
                                                  Flexible(
                                                    child: Text(
                                                      'Channel-Wise',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (ctlr.getPersona() &&
                                              ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.channel !=
                                                  null)
                                            RetailingTableWidget(
                                              dataList: ctlr.isSummaryDirect
                                                  ? ctlr
                                                          .summaryData
                                                          .first
                                                          .mtdRetailing
                                                          ?.ind
                                                          ?.channel ??
                                                      []
                                                  : ctlr
                                                          .summaryData
                                                          .first
                                                          .mtdRetailing
                                                          ?.indDir
                                                          ?.channel ??
                                                      [],
                                            ),
                                          if (ctlr.getPersona() &&
                                              ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.trends !=
                                                  null)
                                            Container(
                                              height: .5,
                                              width: double.infinity,
                                              color: AppColors.borderColor,
                                            ),
                                          if (ctlr.getPersona() &&
                                              ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.trends !=
                                                  null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 16),
                                                  Flexible(
                                                    child: Text(
                                                      'Trends Analysis',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          if (ctlr.getPersona() &&
                                              ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.trends !=
                                                  null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 12),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    // height: 26,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .lightGrey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () => ctlr
                                                              .onChannelSalesChange(
                                                                  true),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ctlr.channelSales
                                                                  ? AppColors
                                                                      .white
                                                                  : AppColors
                                                                      .white,
                                                              gradient: ctlr
                                                                      .channelSales
                                                                  ? const LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      colors: [
                                                                        AppColors
                                                                            .contentColorCyan,
                                                                        AppColors
                                                                            .contentColorBlue,
                                                                        // AppColors.contentColorCyan.withOpacity(.6),
                                                                      ],
                                                                    )
                                                                  : null,
                                                              boxShadow:
                                                                  ctlr.channelSales
                                                                      ? [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.black.withOpacity(.5),
                                                                            blurRadius:
                                                                                2.0,
                                                                            spreadRadius:
                                                                                0.0,
                                                                            offset:
                                                                                const Offset(2.0, 2.0),
                                                                          ),
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.black.withOpacity(.2),
                                                                            blurRadius:
                                                                                2.0,
                                                                            spreadRadius:
                                                                                0.0,
                                                                            offset:
                                                                                const Offset(-2.0, -2.0),
                                                                          ),
                                                                        ]
                                                                      : null,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 4),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        4),
                                                            child: Text(
                                                              'Sales Value',
                                                              style: GoogleFonts
                                                                  .ptSansCaption(
                                                                color: ctlr
                                                                        .channelSales
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () => ctlr
                                                              .onChannelSalesChange(
                                                                  false),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ctlr.channelSales
                                                                  ? AppColors
                                                                      .white
                                                                  : AppColors
                                                                      .primary,
                                                              gradient: !ctlr
                                                                      .channelSales
                                                                  ? const LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
                                                                      end: Alignment
                                                                          .bottomCenter,
                                                                      colors: [
                                                                        AppColors
                                                                            .contentColorCyan,
                                                                        AppColors
                                                                            .contentColorBlue,
                                                                        // AppColors.contentColorCyan.withOpacity(.6),
                                                                      ],
                                                                    )
                                                                  : null,
                                                              boxShadow: !ctlr
                                                                      .channelSales
                                                                  ? [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(.5),
                                                                        blurRadius:
                                                                            2.0,
                                                                        spreadRadius:
                                                                            0.0,
                                                                        offset: const Offset(
                                                                            2.0,
                                                                            2.0),
                                                                      ),
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(.2),
                                                                        blurRadius:
                                                                            2.0,
                                                                        spreadRadius:
                                                                            0.0,
                                                                        offset: const Offset(
                                                                            -2.0,
                                                                            -2.0),
                                                                      ),
                                                                    ]
                                                                  : null,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        4),
                                                            child: Text(
                                                              '  IYA  ',
                                                              style: GoogleFonts
                                                                  .ptSansCaption(
                                                                color: !ctlr
                                                                        .channelSales
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (ctlr.getPersona() &&
                                              ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.trends !=
                                                  null)
                                            const SizedBox(height: 12),
                                          if (ctlr.getPersona() &&
                                              ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.trends !=
                                                  null)
                                            ctlr.summaryData.first.mtdRetailing
                                                        ?.ind?.trends !=
                                                    null
                                                ? RetailingGraphWidget(
                                                    yAxisData: ctlr.isSummaryDirect
                                                        ? ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.ind
                                                                ?.yAxisData ??
                                                            []
                                                        : ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.indDir
                                                                ?.yAxisData ??
                                                            [],
                                                    minValue: ctlr
                                                            .isSummaryDirect
                                                        ? ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.ind
                                                                ?.yMin ??
                                                            0.0
                                                        : ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.indDir
                                                                ?.yMin ??
                                                            0.0,
                                                    maxValue: ctlr
                                                            .isSummaryDirect
                                                        ? ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.ind
                                                                ?.yMax ??
                                                            0.0
                                                        : ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.indDir
                                                                ?.yMax ??
                                                            0.0,
                                                    interval: ctlr
                                                            .isSummaryDirect
                                                        ? ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.ind
                                                                ?.yInterval ??
                                                            0.0
                                                        : ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.indDir
                                                                ?.yInterval ??
                                                            0.0,
                                                    trendsData: ctlr
                                                            .isSummaryDirect
                                                        ? ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.ind
                                                                ?.trends ??
                                                            []
                                                        : ctlr
                                                                .summaryData
                                                                .first
                                                                .mtdRetailing
                                                                ?.indDir
                                                                ?.trends ??
                                                            [],
                                                    salesValue:
                                                        ctlr.channelSales,
                                                  )
                                                : const SizedBox(),
                                        ],
                                      )
                                    : const SizedBox(),
                          if (ctlr.activeMetrics
                              .contains('Coverage')) //ctlr.showCoverage)
                            ctlr.isSummaryPageLoading
                                ? CustomShimmer(
                                    height: 260,
                                    width: MediaQuery.of(context).size.width,
                                    borderRadius: BorderRadius.circular(22),
                                    margin: const EdgeInsets.only(
                                        top: 16,
                                        left: 12,
                                        right: 12,
                                        bottom: 8),
                                  )
                                : ctlr.summaryData.isNotEmpty
                                    ? PersonalizeCard(
                                        title: 'Coverage',
                                        secondTitle: '',
                                        top: 12,
                                        bottomInside: 8,
                                        onPressedShowMore: () => Get.toNamed(
                                            AppPages.COVERAGE_SCREEN),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Coverage (in ${ctlr.summaryData.first.coverage?.cmCoverage?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.coverage?.cmCoverage?.contains('M') ?? false ? 'M' : 'M'})',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${ctlr.summaryData.first.coverage?.cmCoverage?.contains('MM') ?? false ? ctlr.summaryData.first.coverage?.cmCoverage?.replaceAll('MM', '') : ctlr.summaryData.first.coverage?.cmCoverage?.contains('M') ?? false ? ctlr.summaryData.first.coverage?.cmCoverage?.replaceAll('M', '') : ctlr.summaryData.first.coverage?.cmCoverage}',
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${ctlr.selectedMonth.substring(0, 3)}${ctlr.selectedMonth.substring(6, 8)} Billing %',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${ctlr.summaryData.first.coverage?.billing?.contains('') ?? false ? ctlr.summaryData.first.coverage?.billing?.replaceAll('%', '') : ctlr.summaryData.first.coverage?.billing}',
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Call Hit Rate %',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${ctlr.summaryData.first.coverage?.ccCurrentMonth}',
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Productivity %',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              '${ctlr.summaryData.first.productivity?.productivityCurrentMonth}',
                                                              style: GoogleFonts
                                                                  .ptSans(
                                                                fontSize: 40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                          if (ctlr.activeMetrics.contains(
                              'Golden Points')) //ctlr.showGoldenPoints)
                            ctlr.isSummaryPageLoading
                                ? CustomShimmer(
                                    height: 240,
                                    width: MediaQuery.of(context).size.width,
                                    borderRadius: BorderRadius.circular(22),
                                    margin: const EdgeInsets.only(
                                        top: 16,
                                        left: 12,
                                        right: 12,
                                        bottom: 8),
                                  )
                                : ctlr.summaryData.isNotEmpty
                                    ? PersonalizeCard(
                                        title: 'Golden Points',
                                        secondTitle: 'P3M',
                                        top: 12,
                                        onPressedShowMore: () => Get.toNamed(
                                            AppPages.GOLDEN_POINT_SCREEN),
                                        bottomInside: 8,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'GP P3M (in ${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? 'M' : 'M'})',
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? ctlr.summaryData.first.dgpCompliance?.gpAbs?.replaceAll('MM', '') : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? ctlr.summaryData.first.dgpCompliance?.gpAbs?.replaceAll('M', '') : ctlr.summaryData.first.dgpCompliance?.gpAbs}',
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'GP P3M IYA',
                                                          style: GoogleFonts
                                                              .ptSansCaption(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${ctlr.summaryData.first.dgpCompliance?.gpIya}',
                                                          style: GoogleFonts
                                                              .ptSansCaption(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 50.0,
                                                  lineWidth: 12.0,
                                                  percent: double.tryParse(ctlr
                                                              .summaryData
                                                              .first
                                                              .dgpCompliance
                                                              ?.progressBarGpAchieved ??
                                                          '0.0') ??
                                                      0.0,
                                                  header:
                                                      const Text('DGP Comp.'),
                                                  center: Text(
                                                      "${ctlr.summaryData.first.dgpCompliance?.gpAchievememt}%"),
                                                  backgroundColor:
                                                      const Color(0xffD9D9D9),
                                                  animation: true,
                                                  curve: Curves.easeInBack,
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  linearGradient:
                                                      LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      AppColors.contentColorCyan
                                                          .withOpacity(.6),
                                                      AppColors.contentColorBlue
                                                          .withOpacity(.6),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                          if (ctlr.activeMetrics
                              .contains('Focus Brand')) //ctlr.showFocusBrand)
                            ctlr.isSummaryPageLoading
                                ? CustomShimmer(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    borderRadius: BorderRadius.circular(22),
                                    margin: const EdgeInsets.only(
                                        top: 16,
                                        left: 12,
                                        right: 12,
                                        bottom: 8),
                                  )
                                : ctlr.summaryData.isNotEmpty
                                    ? PersonalizeCard(
                                        title: 'Focus Brand',
                                        top: 12,
                                        onPressedShowMore: () => Get.toNamed(
                                            AppPages.FOCUS_BRAND_SCREEN),
                                        bottomInside: 8,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'FB Actual (in ${ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false ? 'M' : 'M'})',
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('MM', '') : ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('M', '') : ctlr.summaryData.first.focusBrand?.fbActual}',
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            fontSize: 40,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                  ],
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 50.0,
                                                  lineWidth: 12.0,
                                                  percent: double.tryParse(ctlr
                                                              .summaryData
                                                              .first
                                                              .focusBrand
                                                              ?.progressBarFbAchievement ??
                                                          '0.0') ??
                                                      0.0,
                                                  header:
                                                      const Text('FB Achiev.'),
                                                  center: Text(
                                                      "${ctlr.summaryData.first.focusBrand?.fbAchievement}%"),
                                                  backgroundColor:
                                                      const Color(0xffD9D9D9),
                                                  animation: true,
                                                  curve: Curves.easeInBack,
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  linearGradient:
                                                      LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      AppColors.contentColorCyan
                                                          .withOpacity(.6),
                                                      AppColors.contentColorBlue
                                                          .withOpacity(.6),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                          ///
                          const SizedBox(height: 110),
                        ],
                      ),
                    ),
                  )
                : const CustomLoader());
      },
    );
  }
}
