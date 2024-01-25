import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../retailing/widgets/geography_bottomsheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/menu_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_card.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/retailing_graph_widget.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/retailing_table_widget.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_bottomsheet.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isFirst = true;
  void initCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctlr.getInitValues();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>>? dataList = [
      ['Channel', 'Retailing', 'Apr-23 IYA'],
      ['Core DO', '', ''],
      ['MR', '', ''],
      ['DCOM', '', ''],
      ['EC', '', ''],
    ];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // initCall();
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   controller.getInitValues();
        // });
      },
      builder: (ctlr) {
        initCall(ctlr);
        return RefreshIndicator(
          onRefresh: () => ctlr.getSummaryData(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PngFiles.homeBg),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: ctlr.sScrollController,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hello,',
                                      style: GoogleFonts.ptSans(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${ctlr.getUserName()}',
                                      style: GoogleFonts.ptSans(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Here\'s your MTD summary',
                                style: GoogleFonts.ptSans(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row( mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Version:  ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                  FutureBuilder(
                                    future: getVersionNumber(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) =>
                                        Text(
                                          snapshot.hasData
                                              ? "${snapshot.data}"
                                              : "Loading ...",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.bottomSheet(
                            const MenuBottomsheet(),
                            isScrollControlled: true,
                          ),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.filterColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () => Get.bottomSheet(
                                      const GeographyBottomsheet(
                                        tabType: 'All',
                                        isLoadRetailing: true,
                                        isSummary: true,
                                      ),
                                      isScrollControlled: true,
                                    ),
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              ctlr.selectedGeo,
                                              style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          const Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 56, width: 1, color: Colors.grey),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            ctlr.selectedGeoValue,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => Get.bottomSheet(
                              const SelectMonthBottomsheet(
                                tabType: 'All',
                                isLoadRetailing: true,
                                isSummary: true,
                              ),
                              isScrollControlled: true,
                            ),
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.filterColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      ctlr.selectedMonth != null
                                          ? '${ctlr.selectedMonth}'
                                          : '',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.ptSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (ctlr.activeMetrics.contains('Retailing'))
                    ctlr.isSummaryPageLoading || ctlr.isDirectIndirectLoading
                        ? CustomShimmer(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 24, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Retailing',
                                isDataFound: ctlr.isSummaryDirect
                                    ? ctlr.summaryData.first.mtdRetailing?.ind
                                            ?.dataFound ??
                                        false
                                    : ctlr.summaryData.first.mtdRetailing
                                            ?.indDir?.dataFound ??
                                        false,
                                secondTitle: '',
                                secondWidget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Retailing',
                                        style: GoogleFonts.ptSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 0, left: 12, right: 4),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.lightGrey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                ctlr.onChangeSummaryDI(true),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ctlr.isSummaryDirect
                                                    ? AppColors.primary
                                                    : AppColors.white,
                                                border: Border.all(
                                                  width: 1,
                                                  color: ctlr.isSummaryDirect
                                                      ? AppColors.primary
                                                      : AppColors.white,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                              child: Text(
                                                'Indirect',
                                                style:
                                                    GoogleFonts.ptSansCaption(
                                                  color: ctlr.isSummaryDirect
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (ctlr.selectedGeo == 'All India')
                                            GestureDetector(
                                              onTap: () =>
                                                  ctlr.onChangeSummaryDI(false),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ctlr.isSummaryDirect
                                                      ? AppColors.white
                                                      : AppColors.primary,
                                                  border: ctlr.isSummaryDirect
                                                      ? null
                                                      : Border.all(
                                                          width: 1,
                                                          color: !ctlr
                                                                  .isSummaryDirect
                                                              ? AppColors
                                                                  .primary
                                                              : AppColors.white,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                child: Text(
                                                  'Indirect + Direct',
                                                  style:
                                                      GoogleFonts.ptSansCaption(
                                                    color: !ctlr.isSummaryDirect
                                                        ? Colors.white
                                                        : Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.RETAILING_SCREEN),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      ctlr.isSummaryDirect
                                                          ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout}'
                                                          : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${ctlr.selectedMonth?.substring(0, 3)}${ctlr.selectedMonth?.substring(6, 8)} IYA',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      ctlr.isSummaryDirect
                                                          ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmIya}'
                                                          : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmIya}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      ctlr.isSummaryDirect
                                                          ? '${ctlr.summaryData.first.mtdRetailing?.ind?.fyIya}'
                                                          : '${ctlr.summaryData.first.mtdRetailing?.indDir?.fyIya}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.channel !=
                                          null)
                                    Container(
                                      height: .5,
                                      width: double.infinity,
                                      color: AppColors.borderColor,
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.channel !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Flexible(
                                            child: Text(
                                              'Channel-Wise',
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.channel !=
                                          null)
                                    RetailingTableWidget(
                                      dataList: ctlr.isSummaryDirect
                                          ? ctlr.summaryData.first.mtdRetailing
                                                  ?.ind?.channel ??
                                              []
                                          : ctlr.summaryData.first.mtdRetailing
                                                  ?.indDir?.channel ??
                                              [],
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    Container(
                                      height: .5,
                                      width: double.infinity,
                                      color: AppColors.borderColor,
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Flexible(
                                            child: Text(
                                              'Trends Analysis',
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 12),
                                      child: Row(
                                        children: [
                                          Container(
                                            // height: 26,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.lightGrey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      ctlr.onChannelSalesChange(
                                                          true),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ctlr.channelSales
                                                          ? AppColors.primary
                                                          : AppColors.white,
                                                      border: Border.all(
                                                        width: 1,
                                                        color: ctlr.channelSales
                                                            ? AppColors.primary
                                                            : AppColors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    child: Text(
                                                      'Sales Value',
                                                      style: GoogleFonts
                                                          .ptSansCaption(
                                                        color: ctlr.channelSales
                                                            ? Colors.white
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      ctlr.onChannelSalesChange(
                                                          false),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ctlr.channelSales
                                                          ? AppColors.white
                                                          : AppColors.primary,
                                                      border: ctlr.channelSales
                                                          ? null
                                                          : Border.all(
                                                              width: 1,
                                                              color: !ctlr
                                                                      .channelSales
                                                                  ? AppColors
                                                                      .primary
                                                                  : AppColors
                                                                      .white,
                                                            ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    child: Text(
                                                      '  IYA  ',
                                                      style: GoogleFonts
                                                          .ptSansCaption(
                                                        color:
                                                            !ctlr.channelSales
                                                                ? Colors.white
                                                                : Colors.grey,
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
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    const SizedBox(height: 12),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    RetailingGraphWidget(
                                      yAxisData: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
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
                                                      ?.ind
                                                      ?.yAxisDataPer ??
                                                  []
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yAxisData ??
                                                  []
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yAxisDataPer ??
                                                  [],
                                      minValue: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
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
                                                      ?.ind
                                                      ?.yPerMin ??
                                                  0.0
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yMin ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yPerMin ??
                                                  0.0,
                                      maxValue: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
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
                                                      ?.ind
                                                      ?.yPerMax ??
                                                  0.0
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yMax ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yPerMax ??
                                                  0.0,
                                      interval: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
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
                                                      ?.ind
                                                      ?.yPerInterval ??
                                                  0.0
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yInterval ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yPerInterval ??
                                                  0.0,
                                      trendsData: ctlr.isSummaryDirect
                                          ? ctlr.summaryData.first.mtdRetailing
                                                  ?.ind?.trends ??
                                              []
                                          : ctlr.summaryData.first.mtdRetailing
                                                  ?.indDir?.trends ??
                                              [],
                                      salesValue: ctlr.channelSales,
                                    ),
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
                                top: 16, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Coverage ',
                                top: 12,
                                isDataFound:
                                    ctlr.summaryData.first.coverage?.dataFound,
                                secondTitle: '',
                                bottomInside: 8,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.COVERAGE_SCREEN),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Coverage (in ${ctlr.summaryData.first.coverage?.cmCoverage?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.coverage?.cmCoverage?.contains('M') ?? false ? 'M' : 'M'})',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.coverage?.cmCoverage?.contains('MM') ?? false ? ctlr.summaryData.first.coverage?.cmCoverage?.replaceAll('MM', '') : ctlr.summaryData.first.coverage?.cmCoverage?.contains('M') ?? false ? ctlr.summaryData.first.coverage?.cmCoverage?.replaceAll('M', '') : ctlr.summaryData.first.coverage?.cmCoverage}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                '${ctlr.selectedMonth?.substring(0, 3)}${ctlr.selectedMonth?.substring(6, 8)} Billing %',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.coverage?.billing?.contains('') ?? false ? ctlr.summaryData.first.coverage?.billing?.replaceAll('%', '') : ctlr.summaryData.first.coverage?.billing}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Call Hit Rate %',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.coverage?.ccCurrentMonth}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.productivity?.productivityCurrentMonth}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                  if (ctlr.activeMetrics
                      .contains('Golden Points')) //ctlr.showGoldenPoints)
                    ctlr.isSummaryPageLoading
                        ? CustomShimmer(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 16, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Golden Points',
                                secondTitle: '', //P3M
                                top: 12,
                                isDataFound: ctlr
                                    .summaryData.first.dgpCompliance?.dataFound,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.GOLDEN_POINT_SCREEN),
                                bottomInside: 8,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'P3M GP (in ${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? 'M' : 'M'})',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? ctlr.summaryData.first.dgpCompliance?.gpAbs?.replaceAll('MM', '') : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? ctlr.summaryData.first.dgpCompliance?.gpAbs?.replaceAll('M', '') : ctlr.summaryData.first.dgpCompliance?.gpAbs}',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Column(
                                              children: [
                                                Text(
                                                  'GP IYA',
                                                  style:
                                                      GoogleFonts.ptSansCaption(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '${ctlr.summaryData.first.dgpCompliance?.gpIya}',
                                                  style:
                                                      GoogleFonts.ptSansCaption(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w500,
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
                                          header: const Text('GP Ach %'),
                                          center: Text(
                                              "${ctlr.summaryData.first.dgpCompliance?.gpAchievememt}%"),
                                          backgroundColor:
                                              const Color(0xffD9D9D9),
                                          animation: true,
                                          curve: Curves.easeInBack,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          linearGradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color(0xff2CBBCE),
                                              Color(0xff83d1c8),
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
                                top: 16, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Focus Brand',
                                secondTitle: '',
                                isDataFound: ctlr
                                    .summaryData.first.focusBrand?.dataFound,
                                top: 12,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.FOCUS_BRAND_SCREEN),
                                bottomInside: 8,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'FB Actual (in ${(ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false) ? 'MM' : (ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false) ? 'M' : 'M'})',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${(ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false) ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('MM', '') : (ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false) ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('M', '') : ctlr.summaryData.first.focusBrand?.fbActual}',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w400,
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
                                          header: const Text('FB Achiev.'),
                                          center: Text(
                                              "${ctlr.summaryData.first.focusBrand?.fbAchievement}%"),
                                          backgroundColor:
                                              const Color(0xffD9D9D9),
                                          animation: true,
                                          curve: Curves.easeInBack,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          linearGradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color(0xff2CBBCE),
                                              Color(0xff83d1c8),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            const PersonalizeBottomsheet(),
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.settings,
                                color: AppColors.primary,
                              ),
                              Text(
                                '  Personalize',
                                style: GoogleFonts.ptSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 90),
                  // ...ctlr.summaryData
                  //     .map(
                  //       (e) => const ListTile(
                  //         title: Text('Title'),
                  //       ),
                  //     )
                  //     .toList(),
                ],
              ),
            ),
          ),
          // : Center(
          //     child: Text(
          //       'Something went wrong!',
          //       style: GoogleFonts.ptSans(),
          //     ),
          //   ),
        );
      },
    );
  }
  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    print(version);
    return version;
  }
}
