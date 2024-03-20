import 'package:command_centre/mobile_dashboard/services/analytics_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class CategoryTrendsFilterBottomsheet extends StatefulWidget {
  final String tabType;
  final String type;
  const CategoryTrendsFilterBottomsheet(
      {super.key, required this.tabType, required this.type});

  @override
  State<CategoryTrendsFilterBottomsheet> createState() =>
      _CategoryTrendsFilterBottomsheetState();
}

class _CategoryTrendsFilterBottomsheetState
    extends State<CategoryTrendsFilterBottomsheet> {
  String _selectedTrendsCategory = 'Category',
      _selectedTrendsCategoryValue = '';
  String get selectedTrendsCategory => _selectedTrendsCategory;
  String get selectedTrendsCategoryValue => _selectedTrendsCategoryValue;
  void onFilterChange(String value) {
    _selectedTrendsCategory = value;
    setState(() {});
  }

  void onFilterChangeValue(String value) {
    _selectedTrendsCategoryValue = value;
    setState(() {});
  }

  bool isFirst = true;
  intCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.tabType == SummaryTypes.retailing.type) {
          //
        }

        onFilterChange(ctlr.selectedTrendsCategory);

        onFilterChangeValue(ctlr.selectedTrendsCategoryValue);
        FirebaseAnalytics.instance.logEvent(name: 'data_refreash', parameters: {"message": 'Selected Trends Category ${ctlr.selectedTrendsCategoryValue} ${ctlr.getUserName()}'});
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = ['Category', 'Brand', 'Brand form'];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        intCall(ctlr);
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: AppColors.bgLight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Select Category ',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width * .4,
                      color: AppColors.blueLight.withOpacity(.25),
                      child: Column(
                        children: [
                          ...categoryList
                              .map(
                                (e) => Container(
                                  color: e == selectedTrendsCategory
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () {
                                      onFilterChange(e);
                                      ctlr.onChangeTrendsCategory(e);
                                    },
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -3),
                                    title: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 300,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...ctlr.categoryTrendsFilters
                                        .map(
                                          (cat) => GestureDetector(
                                            onTap: () =>
                                                onFilterChangeValue(cat),
                                            child: Row(
                                              children: [
                                                Transform.scale(
                                                  scale: .9,
                                                  child: Checkbox(
                                                    value:
                                                        _selectedTrendsCategoryValue ==
                                                            cat,
                                                    onChanged: (v) =>
                                                        onFilterChangeValue(
                                                            cat),
                                                  ),
                                                ),
                                                Flexible(child: Text(cat)),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Clear',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAnalytics.instance.logEvent(name: 'deep_dive_selected_category', parameters: {"message": 'Added Selected Category ${ctlr.getUserName()}'});
                        ctlr.onTrendsFilterSelect(widget.type, widget.tabType);
                        ctlr.onChangeTrendsChannelValue(
                            _selectedTrendsCategoryValue, widget.tabType,
                            isChannel: false);
                        ctlr.onChangeTrendsCategoryValue(
                            _selectedTrendsCategory);
                        ctlr.onApplyMultiFilter(
                          'trends',
                          widget.tabType == SummaryTypes.coverage.type
                              ? 'trends'
                              : 'geo',
                          tabType: widget.tabType,
                          subType: 'trends',
                        );

                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Apply Changes',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
