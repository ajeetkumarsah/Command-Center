import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_deepdive_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_epanded_Widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geography_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geo_multi_select_bottom.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/trends_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/channel_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/category_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_expanded_chart_widget.dart';

class RetailingScreen extends StatelessWidget {
  const RetailingScreen({super.key});
  // final HomeController controller =
  //     Get.put(HomeController(homeRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // controller.getRetailingData();
        // controller.getRetailingData(type: 'category', name: 'category');
        // controller.getRetailingData(type: 'channel', name: 'geo');
        // controller.getRetailingData(type: 'geo', name: 'trends');
      },
      builder: (ctlr) {
        return RefreshIndicator(
          onRefresh: () async {
            ctlr.getRetailingData();
            ctlr.getRetailingData(type: 'category', name: 'category');
            ctlr.getRetailingData(type: 'channel', name: 'geo');
            ctlr.getRetailingData(type: 'geo', name: 'trends');
            return;
          },
          child: Scaffold(
            backgroundColor: AppColors.bgLight,
            appBar: CustomDeepDiveAppBar(
              title: 'Retailing',
              onDivisionTap: () => Get.bottomSheet(
                GeographyBottomsheet(
                  isLoadRetailing: true,
                  tabType: SummaryTypes.retailing.type,
                ),
                isScrollControlled: true,
              ),
              onMonthTap: () => Get.bottomSheet(
                SelectMonthBottomsheet(
                  isLoadRetailing: true,
                  tabType: SummaryTypes.retailing.type,
                ),
                isScrollControlled: true,
              ),
              geo: ctlr.selectedGeo,
              geoValue: ctlr.selectedGeoValue,
              date: ctlr.selectedMonth != null
                  ? '${ctlr.selectedMonth!.substring(0, 3)} - ${ctlr.selectedYear}'
                  : '',
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
                            : ctlr.retailingList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Retailing by Geography',
                                    isSummary: true,
                                    onTap: () => ctlr.onExpandSummary(
                                        !ctlr.isSummaryExpanded),
                                    isExpanded: ctlr.isSummaryExpanded,
                                    dataList: ctlr.retailingList,
                                    onFilterTap: () => Get.bottomSheet(
                                      GeographyMultiSelectBottomsheet(
                                          tabType: SummaryTypes.retailing.type),
                                      isScrollControlled: true,
                                    ),
                                  )
                                : const SizedBox(),
                        SizedBox(
                            height: ctlr.retailingList.isNotEmpty ? 16 : 0),
                        ctlr.isCategoryLoading
                            ? loadingWidget(context)
                            : ctlr.categoryList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Retailing by Category',
                                    firstWidget: InkWell(
                                      onTap: () => Get.bottomSheet(
                                        CategoryFilterBottomsheet(
                                            tabType:
                                                SummaryTypes.retailing.type),
                                        isScrollControlled: true,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          children: [
                                            Expanded(
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
                                    dataList: ctlr.categoryList.isNotEmpty
                                        ? ctlr.categoryList
                                        : null,
                                    onTap: () => ctlr.onExpandCategory(
                                        !ctlr.isExpandedCategory),
                                    isExpanded: ctlr.isExpandedCategory,
                                  )
                                : const SizedBox(),
                        SizedBox(height: ctlr.categoryList.isNotEmpty ? 16 : 0),
                        ctlr.isChannelLoading
                            ? loadingWidget(context)
                            : ctlr.channelList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Retailing by Channel',
                                    firstWidget: InkWell(
                                      onTap: () => Get.bottomSheet(
                                        ChannelFilterBottomsheet(
                                            tabType:
                                                SummaryTypes.retailing.type),
                                        isScrollControlled: true,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Channels',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
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
                                    onTap: () => ctlr.onExpandChannel(
                                        !ctlr.isExpandedChannel),
                                    dataList: ctlr.channelList.isNotEmpty
                                        ? ctlr.channelList
                                        : null,
                                    isExpanded: ctlr.isExpandedChannel,
                                  )
                                : const SizedBox(),
                        SizedBox(height: ctlr.channelList.isNotEmpty ? 16 : 0),
                        ctlr.isRetailingTrendsLoading
                            ? loadingWidget(context)
                            : ctlr.trendsList.isNotEmpty
                                ? CustomExpandedChartWidget(
                                    summaryType: SummaryTypes.retailing.type,
                                    title: 'Retailing Trends',
                                    onTap: () => ctlr
                                        .onExpandTrends(!ctlr.isExpandedTrends),
                                    isExpanded: ctlr.isExpandedTrends,
                                    trendsList: ctlr.trendsList,
                                    onFilterTap: () => Get.bottomSheet(
                                      TrendsFilterBottomsheet(
                                        onTap: (v) =>
                                            ctlr.onTrendsFilterSelect(v),
                                        tabType: SummaryTypes.retailing.type,
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
