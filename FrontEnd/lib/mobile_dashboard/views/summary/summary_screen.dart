import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../retailing/widgets/geography_bottomsheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_card.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/menu_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_bottomsheet.dart';


class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final HomeController controller =
      Get.put(HomeController(homeRepo: Get.find()));
  bool isFirst = true;
  void initCall() {
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getInitValues();
      });
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // initCall();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.getInitValues();
        });
      },
      builder: (ctlr) {
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
                              child:
                                  // Text.rich(
                                  //   maxLines: 1,
                                  //   TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text: ctlr.selectedMonth !=
                                  //                 null
                                  //             ? '${ctlr.selectedMonth!.substring(0, 3)} - ${ctlr.selectedYear}'
                                  //             : '',
                                  //         style: GoogleFonts.ptSans(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.w400,
                                  //         ),
                                  //       ),
                                  //       const WidgetSpan(
                                  //         child: Icon(
                                  //             Icons.arrow_drop_down),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  Row(
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
                  if (ctlr.activeMetrics
                      .contains('Retailing')) //ctlr.showRetailing)
                    ctlr.isSummaryPageLoading
                        ? CustomShimmer(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 24, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isEmpty
                            ? const SizedBox()
                            : PersonalizeCard(
                                title: 'Retailing',
                                secondTitle: '',
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
                                                      '${ctlr.summaryData.first.mtdRetailing?.cmIya}',
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
                                                      '${ctlr.summaryData.first.mtdRetailing?.fyIya}',
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
                                                'Sellout (in ${ctlr.summaryData.first.mtdRetailing?.cmSellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.cmSellout?.contains('Lk') ?? false ? 'Lk' : ''})',
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
                                                      '${ctlr.summaryData.first.mtdRetailing?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.cmSellout}',
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
                                  // Padding(
                                  //   padding: const EdgeInsets.all(12.0),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             'FY IYA',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             '${ctlr.summaryData.first.mtdRetailing?.fyIya}',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 40,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),

                                  //     ],
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 12.0),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             'Tgt IYA',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             '${ctlr.summaryData.first.mtdRetailing?.tgtIya}',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //       Column(
                                  //         children: [
                                  //           Text(
                                  //             'Tgt Sal %',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             '${ctlr.summaryData.first.mtdRetailing?.tgtSaliance}',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //       Column(
                                  //         children: [
                                  //           Text(
                                  //             'Tgt Sellout',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 16,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             '${ctlr.summaryData.first.mtdRetailing?.tgtSellout}',
                                  //             style: GoogleFonts.ptSans(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
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
                        : ctlr.summaryData.isEmpty
                            ? const SizedBox()
                            : PersonalizeCard(
                                title: 'Coverage ',
                                top: 12,
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
                              ),
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
                        : ctlr.summaryData.isEmpty
                            ? const SizedBox()
                            : PersonalizeCard(
                                title: 'Golden Points',
                                secondTitle: '', //P3M
                                top: 12,
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
                                                  'GP Abs (in ${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? 'M' : 'M'})',
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
                                          header: const Text('DGP Comp.'),
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
                              ),
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
                        : ctlr.summaryData.isEmpty
                            ? const SizedBox()
                            : PersonalizeCard(
                                title: 'Focus Brand',
                                secondTitle: '',
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
                                                  'FB Actual (in ${ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false ? 'M' : 'M'})',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('MM', '') : ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('M', '') : ctlr.summaryData.first.focusBrand?.fbActual}',
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
                              ),
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
}
