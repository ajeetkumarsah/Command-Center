import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_deepdive_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/coverage/widget/trends_chart_widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_epanded_Widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geography_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geo_multi_select_bottom.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/trends_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/channel_filter_bottomsheet.dart';

class CoverageScreen extends StatefulWidget {
  const CoverageScreen({super.key});

  @override
  State<CoverageScreen> createState() => _CoverageScreenState();
}

class _CoverageScreenState extends State<CoverageScreen> {
  bool isFirst = true;
  void initCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;
      ctlr.getCoverageInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> coverageFilter = ['Billing %', 'Prod %', 'CCR %'];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // controller.getCoverageData();
        // // controller.getCoverageData(type: 'category', name: 'category');
        // controller.getCoverageData(type: 'channel', name: 'geo');
        // controller.getCoverageData(type: 'trends', name: 'trends');
      },
      builder: (ctlr) {
        initCall(ctlr);
        return RefreshIndicator(
          onRefresh: () async {
            ctlr.getCoverageData();
            ctlr.getCoverageData(type: 'channel', name: 'geo');
            ctlr.getCoverageData(type: 'trends', name: 'trends');
          },
          child: Scaffold(
            backgroundColor: AppColors.bgLight,
            appBar: CustomDeepDiveAppBar(
              title: 'Coverage',
              onDivisionTap: () => Get.bottomSheet(
                GeographyBottomsheet(
                  isSummary: false,
                  isLoadRetailing: true,
                  tabType: SummaryTypes.coverage.type,
                ),
                isScrollControlled: true,
              ),
              onMonthTap: () => Get.bottomSheet(
                SelectMonthBottomsheet(
                  isLoadRetailing: true,
                  tabType: SummaryTypes.coverage.type,
                ),
                isScrollControlled: true,
              ),
              geo: ctlr.selectedGeo,
              geoValue: ctlr.selectedGeoValue,
              date: ctlr.selectedMonth != null ? '${ctlr.selectedMonth}' : '',
            ),
            body: ctlr.isLoading
                ? const CustomLoader()
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ctlr.isCoverageGeoLoading
                            ? loadingWidget(context)
                            : ctlr.coverageList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Coverage by Geography',
                                    isSummary: true,
                                    onTap: () => ctlr.onExpandSummary(
                                        !ctlr.isSummaryExpanded),
                                    isExpanded: ctlr.isSummaryExpanded,
                                    dataList: ctlr.coverageList,
                                    onFilterTap: () => Get.bottomSheet(
                                      GeographyMultiSelectBottomsheet(
                                          tabType: SummaryTypes.coverage.type),
                                      isScrollControlled: true,
                                    ),
                                  )
                                : const SizedBox(),
                        SizedBox(height: ctlr.coverageList.isNotEmpty ? 16 : 0),
                        // ctlr.isCategoryLoading
                        //     ? loadingWidget(context)
                        //     : ctlr.categoryCoverageList.isNotEmpty
                        //         ? CustomExpandedWidget(
                        //             title: 'Coverage by Category',
                        //             firstWidget: InkWell(
                        //               onTap: () => Get.bottomSheet(
                        //                 const CategoryFilterBottomsheet(),
                        //                 isScrollControlled: true,
                        //               ),
                        //               child: Container(
                        //                 padding: const EdgeInsets.all(6),
                        //                 child: Row(
                        //                   children: [
                        //                     Flexible(
                        //                       child: Text(
                        //                         ctlr.selectedCategory,
                        //                         maxLines: 2,
                        //                         overflow: TextOverflow.ellipsis,
                        //                         style: GoogleFonts.ptSans(
                        //                           fontSize: 16,
                        //                           color: AppColors.primary,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     const Icon(
                        //                       Icons.edit,
                        //                       size: 16,
                        //                       color: AppColors.primary,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             dataList: ctlr.categoryCoverageList.isNotEmpty
                        //                 ? ctlr.categoryCoverageList
                        //                 : null,
                        //             onTap: () => ctlr.onExpandCategory(
                        //                 !ctlr.isExpandedCategory),
                        //             isExpanded: ctlr.isExpandedCategory,
                        //           )
                        //         : const SizedBox(),
                        SizedBox(
                            height:
                                ctlr.categoryCoverageList.isNotEmpty ? 16 : 0),
                        ctlr.isCoverageChannelLoading
                            ? loadingWidget(context)
                            : ctlr.channelCoverageList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Coverage by Channel',
                                    firstWidget: InkWell(
                                      onTap: () => Get.bottomSheet(
                                        ChannelFilterBottomsheet(
                                            tabType:
                                                SummaryTypes.coverage.type),
                                        isScrollControlled: true,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: FittedBox(
                                                child: Text(
                                                  'Channels',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.edit,
                                              size: 16,
                                              color: AppColors.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () => ctlr.onExpandChannel(
                                        !ctlr.isExpandedChannel),
                                    dataList: ctlr.channelCoverageList,
                                    isExpanded: ctlr.isExpandedChannel,
                                  )
                                : const SizedBox(),
                        SizedBox(
                            height:
                                ctlr.channelCoverageList.isNotEmpty ? 16 : 0),
                        ctlr.isCoverageTrendsLoading
                            ? loadingWidget(context)
                            : ctlr.trendsCoverageList.isNotEmpty
                                ? CoverageTrendsChartWidget(
                                    title: 'Coverage Trends',
                                    onTap: () => ctlr
                                        .onExpandTrends(!ctlr.isExpandedTrends),
                                    isExpanded: ctlr.isExpandedTrends,
                                    trendsList: ctlr.trendsCoverageList,
                                    summaryType: SummaryTypes.coverage.type,
                                    coverageWidget: Container(
                                      height: 26,
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.lightGrey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: DropdownButton<String>(
                                        value:
                                            ctlr.selectedCoverageTrendsFilter,
                                        underline: const SizedBox(),
                                        icon: const Icon(
                                          Icons.arrow_drop_down_rounded,
                                          size: 24,
                                        ),
                                        items:
                                            coverageFilter.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (v) =>
                                            ctlr.onChangeCoverageTrends(v!),
                                      ),
                                    ),
                                    onFilterTap: () => Get.bottomSheet(
                                      TrendsFilterBottomsheet(
                                        tabType: SummaryTypes.coverage.type,
                                        isCoverage: true,
                                      ),
                                      isScrollControlled: true,
                                    ),
                                  )
                                : const SizedBox(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget loadingWidget(BuildContext context) {
    return CustomShimmer(
      height: 70,
      width: MediaQuery.of(context).size.width,
      borderRadius: BorderRadius.circular(20),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
