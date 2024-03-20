import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_deepdive_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/golden_point/widget/gp_chart_widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_epanded_Widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geography_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geo_multi_select_bottom.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/trends_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/channel_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/category_filter_bottomsheet.dart';

class GoldenPointScreen extends StatefulWidget {
  const GoldenPointScreen({super.key});

  @override
  State<GoldenPointScreen> createState() => _GoldenPointScreenState();
}

class _GoldenPointScreenState extends State<GoldenPointScreen> {
  bool isFirst = true;
  void initCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;
      ctlr.getGPInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // controller.getGPData();
        // controller.getGPData(type: 'category', name: 'category');
        // controller.getGPData(type: 'channel', name: 'geo');
        // controller.getGPData(type: 'geo', name: 'trends');
      },
      builder: (ctlr) {
        initCall(ctlr);
        return RefreshIndicator(
          onRefresh: () async {
            ctlr.getGPData();
            ctlr.getGPData(type: 'category', name: 'category');
            ctlr.getGPData(type: 'channel', name: 'geo');
            ctlr.getGPData(type: 'geo', name: 'trends');
          },
          child: Scaffold(
            backgroundColor: AppColors.bgLight,
            appBar: CustomDeepDiveAppBar(
              title: 'Golden Points',
              onDivisionTap: () => Get.bottomSheet(
                GeographyBottomsheet(
                  isLoadRetailing: true,
                  isSummary: false,
                  tabType: SummaryTypes.gp.type,
                ),
                isScrollControlled: true,
              ),
              onMonthTap: () => Get.bottomSheet(
                SelectMonthBottomsheet(
                  isLoadRetailing: true,
                  tabType: SummaryTypes.gp.type,
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
                        ctlr.isGPGeoLoading
                            ? loadingWidget(context)
                            : ctlr.gpList.isNotEmpty
                                ? CustomExpandedWidget(
                                    title: 'Golden Points by Geography',
                                    selectedFilterValue: '',
                                    isSummary: true,
                                    onTap: () => ctlr.onExpandSummary(
                                        !ctlr.isSummaryExpanded),
                                    isExpanded: ctlr.isSummaryExpanded,
                                    dataList: ctlr.gpList,
                                    onFilterTap: () {},
                                    onAddGeoTap: () => Get.bottomSheet(
                                      GeographyMultiSelectBottomsheet(
                                          tabType: SummaryTypes.gp.type),
                                      isScrollControlled: true,
                                    ),
                                    tabType: '',
                                  )
                                : const SizedBox(),
                        const SizedBox(height: 16),
                        ctlr.isGPCategoryLoading
                            ? loadingWidget(context)
                            : CustomExpandedWidget(
                                title: 'Golden Points by Category',
                                firstColumnWidth: true,
                                onFilterTap: () => Get.bottomSheet(
                                  CategoryFilterBottomsheet(
                                      tabType: SummaryTypes.gp.type),
                                  isScrollControlled: true,
                                ),
                                selectedFilterValue: ctlr.selectedGPCategory,
                                dataList: ctlr.categoryGPList.isNotEmpty
                                    ? ctlr.categoryGPList
                                    : [],
                                onTap: () => ctlr
                                    .onExpandCategory(!ctlr.isExpandedCategory),
                                isExpanded: ctlr.isExpandedCategory,
                                tabType: '',
                              ),
                        const SizedBox(height: 16),
                        ctlr.isGPChannelLoading
                            ? loadingWidget(context)
                            : CustomExpandedWidget(
                                title: 'Golden Points by Channel',
                                onFilterTap: () => Get.bottomSheet(
                                  ChannelFilterBottomsheet(
                                    tabType: SummaryTypes.gp.type,
                                  ),
                                  isScrollControlled: true,
                                ),
                                selectedFilterValue: 'Channel',
                                onTap: () => ctlr
                                    .onExpandChannel(!ctlr.isExpandedChannel),
                                dataList: ctlr.channelGPList,
                                isExpanded: ctlr.isExpandedChannel,
                                tabType: '',
                              ),
                        const SizedBox(height: 16),
                        ctlr.isGPTrendsLoading
                            ? loadingWidget(context)
                            : GPTrendsChartWidget(
                                summaryType: SummaryTypes.gp.type,
                                title: 'Golden Points Trends',
                                onTap: () =>
                                    ctlr.onExpandTrends(!ctlr.isExpandedTrends),
                                isExpanded: ctlr.isExpandedTrends,
                                trendsList: ctlr.trendsGPList,
                                onFilterTap: () => Get.bottomSheet(
                                  TrendsFilterBottomsheet(
                                      tabType: SummaryTypes.gp.type),
                                  isScrollControlled: true,
                                ),
                              ),
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
