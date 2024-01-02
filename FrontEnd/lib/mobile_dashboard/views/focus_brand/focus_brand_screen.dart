import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_deepdive_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/focus_brand/widget/fb_chart_widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_epanded_Widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geography_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geo_multi_select_bottom.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/trends_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/channel_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/category_filter_bottomsheet.dart';

class FocusBrandScreen extends StatelessWidget {
  const FocusBrandScreen({super.key});
  // final HomeController controller =
  //     Get.put(HomeController(homeRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // controller.getFocusBrandData();
        // controller.getFocusBrandData(type: 'category', name: 'category');
        // controller.getFocusBrandData(type: 'channel', name: 'geo');
        // controller.getFocusBrandData(type: 'geo', name: 'trends');
      },
      builder: (ctlr) {
        return RefreshIndicator(
          onRefresh: () async {
            ctlr.getFocusBrandData();
            ctlr.getFocusBrandData(type: 'category', name: 'category');
            ctlr.getFocusBrandData(type: 'channel', name: 'geo');
            ctlr.getFocusBrandData(type: 'geo', name: 'trends');
            return;
          },
          child: Scaffold(
            backgroundColor: AppColors.bgLight,
            appBar: CustomDeepDiveAppBar(
              title: 'Focus Brand',
              onDivisionTap: () => Get.bottomSheet(
                GeographyBottomsheet(
                  isLoadRetailing: true,
                  tabType: SummaryTypes.fb.type,
                ),
                isScrollControlled: true,
              ),
              onMonthTap: () => Get.bottomSheet(
                SelectMonthBottomsheet(
                  isLoadRetailing: true,
                  tabType: SummaryTypes.fb.type,
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
                        ctlr.isSummaryLoading
                            ? loadingWidget(context)
                            : ctlr.fbList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Focus Brand by Geography',
                                    isSummary: true,
                                    onTap: () => ctlr.onExpandSummary(
                                        !ctlr.isSummaryExpanded),
                                    isExpanded: ctlr.isSummaryExpanded,
                                    dataList: ctlr.fbList,
                                    onFilterTap: () => Get.bottomSheet(
                                      GeographyMultiSelectBottomsheet(
                                          tabType: SummaryTypes.fb.type),
                                      isScrollControlled: true,
                                    ),
                                  )
                                : const SizedBox(),
                        SizedBox(height: ctlr.fbList.isNotEmpty ? 16 : 0),
                        ctlr.isCategoryLoading
                            ? loadingWidget(context)
                            : ctlr.categoryFBList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Focus Brand by Category',
                                    firstWidget: InkWell(
                                      onTap: () => Get.bottomSheet(
                                        CategoryFilterBottomsheet(
                                          tabType: SummaryTypes.fb.type,
                                        ),
                                        isScrollControlled: true,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                ctlr.selectedCategory,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  color: AppColors.primary,
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
                                    dataList: ctlr.categoryFBList.isNotEmpty
                                        ? ctlr.categoryFBList
                                        : null,
                                    onTap: () => ctlr.onExpandCategory(
                                        !ctlr.isExpandedCategory),
                                    isExpanded: ctlr.isExpandedCategory,
                                  )
                                : const SizedBox(),
                        SizedBox(
                            height: ctlr.categoryFBList.isNotEmpty ? 16 : 0),
                        ctlr.isChannelLoading
                            ? loadingWidget(context)
                            : ctlr.channelFBList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Focus Brand by Channel',
                                    firstWidget: InkWell(
                                      onTap: () => Get.bottomSheet(
                                        ChannelFilterBottomsheet(
                                          tabType: SummaryTypes.fb.type,
                                        ),
                                        isScrollControlled: true,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Channels',
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                color: AppColors.primary,
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
                                    dataList: ctlr.channelFBList.isNotEmpty
                                        ? ctlr.channelFBList
                                        : null,
                                    isExpanded: ctlr.isExpandedChannel,
                                  )
                                : const SizedBox(),
                        SizedBox(
                            height: ctlr.channelFBList.isNotEmpty ? 16 : 0),
                        ctlr.isFBTrendsLoading
                            ? loadingWidget(context)
                            : ctlr.trendsFBList.isNotEmpty
                                ? FBTrendsChartWidget(
                                    summaryType: SummaryTypes.fb.type,
                                    title: 'Focus Brand Trends',
                                    onTap: () => ctlr
                                        .onExpandTrends(!ctlr.isExpandedTrends),
                                    isExpanded: ctlr.isExpandedTrends,
                                    trendsList: ctlr.trendsFBList,
                                    onFilterTap: () => Get.bottomSheet(
                                      TrendsFilterBottomsheet(
                                        onTap: (v) => ctlr.onTrendsFilterSelect(
                                            v, SummaryTypes.fb.type),
                                        tabType: SummaryTypes.fb.type,
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
