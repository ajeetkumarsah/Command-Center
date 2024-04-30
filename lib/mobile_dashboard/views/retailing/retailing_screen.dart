import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_deepdive_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_epanded_Widget.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geography_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geo_multi_select_bottom.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/select_month_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/trends_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/channel_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/category_filter_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/custom_expanded_chart_widget.dart';

class RetailingScreen extends StatefulWidget {
  const RetailingScreen({super.key});

  @override
  State<RetailingScreen> createState() => _RetailingScreenState();
}

class _RetailingScreenState extends State<RetailingScreen> {
  bool isFirst = true;

  void initCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;
      debugPrint('===> calling');
      ctlr.getReatilingInit();
    }
  }

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
        initCall(ctlr);
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
              trailing: Container(
                // height: 26,
                margin: const EdgeInsets.only(bottom: 0, left: 12, right: 12),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.lightGrey,
                    ),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => ctlr.onChangeDeepDiveIndirect(true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ctlr.isRetailingDeepDiveInd
                              ? AppColors.white
                              : Colors.grey,
                          border: Border.all(
                            width: 1,
                            color: ctlr.isRetailingDeepDiveInd
                                ? AppColors.white
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          'Distributor',
                          style: GoogleFonts.ptSansCaption(
                            color: ctlr.isRetailingDeepDiveInd
                                ? AppColors.primary
                                : AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    if (ctlr.selectedGeo == 'All India')
                      GestureDetector(
                        onTap: () => ctlr.onChangeDeepDiveIndirect(false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !ctlr.isRetailingDeepDiveInd
                                ? AppColors.white
                                : Colors.grey,
                            border: ctlr.isRetailingDeepDiveInd
                                ? null
                                : Border.all(
                                    width: 1,
                                    color: !ctlr.isRetailingDeepDiveInd
                                        ? AppColors.white
                                        : Colors.grey,
                                  ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: Text(
                            'Total Retailing',
                            style: GoogleFonts.ptSansCaption(
                              color: ctlr.isRetailingDeepDiveInd
                                  ? AppColors.white
                                  : AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              onDivisionTap: ctlr.isRetailingTrendsLoading ||
                      ctlr.isRetailingGeoLoading ||
                      ctlr.isRetailingChannelLoading ||
                      ctlr.isRetailingCategoryLoading
                  ? () {
                      showCustomSnackBar('Please wait data is loading! ',
                          isError: false, isBlack: true);
                    }
                  : () => Get.bottomSheet(
                        GeographyBottomsheet(
                          isLoadRetailing: true,
                          tabType: SummaryTypes.retailing.type,
                          isSummary: false,
                        ),
                        isScrollControlled: true,
                      ),
              onMonthTap: ctlr.isRetailingTrendsLoading ||
                      ctlr.isRetailingGeoLoading ||
                      ctlr.isRetailingChannelLoading ||
                      ctlr.isRetailingCategoryLoading
                  ? () {
                      showCustomSnackBar('Please wait data is loading! ',
                          isError: false, isBlack: true);
                    }
                  : () => Get.bottomSheet(
                        SelectMonthBottomsheet(
                          isLoadRetailing: true,
                          tabType: SummaryTypes.retailing.type,
                        ),
                        isScrollControlled: true,
                      ),
              geo: ctlr.selectedGeo,
              geoValue: ctlr.selectedGeoValue,
              date: ctlr.selectedMonth.isNotEmpty
                  ? '${ctlr.selectedMonth}-${ctlr.selectedYear}'
                  : '',
            ),
            body: ctlr.isLoading
                ? const CustomLoader()
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ctlr.isRetailingGeoLoading
                            ? loadingWidget(context)
                            : ctlr.retailingGeoModel != null
                                ? CustomExpandedWidget(
                                    title: 'Retailing by Geography',
                                    isSummary: true,
                                    selectedFilterValue: '',
                                    onTap: () => ctlr.onExpandSummary(
                                        !ctlr.isSummaryExpanded),
                                    isExpanded: ctlr.isSummaryExpanded,
                                    dataList: ctlr.isRetailingDeepDiveInd
                                        ? ctlr.retailingGeoModel?.ind ?? []
                                        : ctlr.retailingGeoModel?.indDir ?? [],
                                    onFilterTap: () {},
                                    onAddGeoTap: () => Get.bottomSheet(
                                      GeographyMultiSelectBottomsheet(
                                          tabType: SummaryTypes.retailing.type),
                                      isScrollControlled: true,
                                    ).then((value) {
                                      if (value == null) {
                                        ctlr.clearRetailingGeo();
                                      }
                                    }),
                                    tabType: SummaryTypes.retailing.type,
                                  )
                                : const SizedBox(),
                        const SizedBox(height: 16),
                        ctlr.isRetailingCategoryLoading
                            ? loadingWidget(context)
                            : CustomExpandedWidget(
                                title: 'Retailing by Category',
                                firstColumnWidth: true,
                                onFilterTap: () => Get.bottomSheet(
                                  CategoryFilterBottomsheet(
                                      tabType: SummaryTypes.retailing.type),
                                  isScrollControlled: true,
                                ),
                                selectedFilterValue: ctlr.selectedCategory,
                                dataList: ctlr.isRetailingDeepDiveInd
                                    ? ctlr.categoryRetailingModel?.ind ?? []
                                    : ctlr.categoryRetailingModel?.indDir ?? [],
                                onTap: () => ctlr
                                    .onExpandCategory(!ctlr.isExpandedCategory),
                                isExpanded: ctlr.isExpandedCategory,
                                tabType: '',
                              ),
                        const SizedBox(height: 16),
                        ctlr.isRetailingChannelLoading
                            ? loadingWidget(context)
                            : CustomExpandedWidget(
                                title: 'Retailing by Channel',
                                onFilterTap: () => Get.bottomSheet(
                                  ChannelFilterBottomsheet(
                                      tabType: SummaryTypes.retailing.type),
                                  isScrollControlled: true,
                                ),
                                selectedFilterValue: 'Channel',
                                onTap: () => ctlr
                                    .onExpandChannel(!ctlr.isExpandedChannel),
                                dataList: ctlr.isRetailingDeepDiveInd
                                    ? ctlr.channelRetailingModel?.ind ?? []
                                    : ctlr.channelRetailingModel?.indDir ?? [],
                                isExpanded: ctlr.isExpandedChannel,
                                tabType: '',
                              ),
                        const SizedBox(height: 16),
                        ctlr.isRetailingTrendsLoading
                            ? loadingWidget(context)
                            : CustomExpandedChartWidget(
                                summaryType: SummaryTypes.retailing.type,
                                title: 'Retailing Trends',
                                onTap: () =>
                                    ctlr.onExpandTrends(!ctlr.isExpandedTrends),
                                isExpanded: ctlr.isExpandedTrends,
                                trendsList: ctlr.isRetailingDeepDiveInd
                                    ? ctlr.trendsRetailingModel!.ind
                                    : ctlr.trendsRetailingModel!.indDir,
                                onFilterTap: () => Get.bottomSheet(
                                  TrendsFilterBottomsheet(
                                      tabType: SummaryTypes.retailing.type),
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
