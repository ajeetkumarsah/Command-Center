import 'package:command_centre/mobile_dashboard/services/analytics_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class CategoryFilterBottomsheet extends StatefulWidget {
  final bool isTrends;
  final String tabType;
  const CategoryFilterBottomsheet(
      {super.key, this.isTrends = false, required this.tabType});

  @override
  State<CategoryFilterBottomsheet> createState() =>
      _CategoryFilterBottomsheetState();
}

class _CategoryFilterBottomsheetState extends State<CategoryFilterBottomsheet> {
  Function eq = const ListEquality().equals;
  String _selectedCategory = 'Category';
  String get selectedCategory => _selectedCategory;
  void onFilterChange(String value) {
    _selectedCategory = value;
    setState(() {});
  }

  bool _isFirst = true;
  void catInit(HomeController ctlr, {required String tabType}) {
    if (_isFirst) {
      _isFirst = false;
      if (tabType == SummaryTypes.retailing.type) {
        _selectedCategory = ctlr.selectedCategory;
      } else if (tabType == SummaryTypes.gp.type) {
        _selectedCategory = ctlr.selectedGPCategory;
      } else if (tabType == SummaryTypes.fb.type) {
        _selectedCategory = ctlr.selectedFBCategory;
      }
      ctlr.onChangeCategory(_selectedCategory, _selectedCategory, isInit: true);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = ['Category', 'Brand', 'Brand form'];
    if (widget.tabType == SummaryTypes.fb.type) {
      categoryList = ['Category', 'Brand'];
    }

    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        catInit(ctlr, tabType: widget.tabType);
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
                        'Select Category',
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
                                  color: e == selectedCategory
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () {
                                      onFilterChange(e);
                                      ctlr.onChangeCategory(
                                          e, _selectedCategory);
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
                                    ctlr.selectedCategory
                                                    .trim()
                                                    .toLowerCase() ==
                                                "Category".toLowerCase() ||
                                            ctlr.selectedCategory
                                                    .trim()
                                                    .toLowerCase() ==
                                                "Brand".toLowerCase() ||
                                            ctlr.selectedCategory
                                                    .trim()
                                                    .toLowerCase() ==
                                                "Brand form".toLowerCase()
                                        ? InkWell(
                                            onTap: () =>
                                                ctlr.onChangeFiltersAll(
                                                    type: 'category',
                                                    tabType: widget.tabType),
                                            child: Row(
                                              children: [
                                                Transform.scale(
                                                  scale: .9,
                                                  child: Checkbox(
                                                    value: widget.tabType ==
                                                            SummaryTypes
                                                                .retailing.type
                                                        ? eq(
                                                            ctlr
                                                                .selectedRetailingCategoryFilters,
                                                            ctlr
                                                                .categoryFilters)
                                                        : widget.tabType ==
                                                                SummaryTypes
                                                                    .coverage
                                                                    .type
                                                            ? eq(
                                                                ctlr
                                                                    .selectedCoverageCategoryFilters,
                                                                ctlr
                                                                    .categoryFilters)
                                                            : widget.tabType ==
                                                                    SummaryTypes
                                                                        .gp.type
                                                                ? eq(
                                                                    ctlr
                                                                        .selectedGPCategoryFilters,
                                                                    ctlr
                                                                        .categoryFilters)
                                                                : widget.tabType ==
                                                                        SummaryTypes
                                                                            .fb
                                                                            .type
                                                                    ? eq(
                                                                        ctlr.selectedFBCategoryFilters,
                                                                        ctlr.categoryFilters)
                                                                    : false,
                                                    onChanged: (v) =>
                                                        ctlr.onChangeFiltersAll(
                                                            type: 'category',
                                                            tabType:
                                                                widget.tabType),
                                                  ),
                                                ),
                                                const Flexible(
                                                  child: Text('Select all'),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                    ...ctlr.categoryFilters
                                        .map(
                                          (cat) => GestureDetector(
                                            onTap: () =>
                                                ctlr.onChangeCategoryValue(
                                                    cat,
                                                    _selectedCategory,
                                                    widget.tabType),
                                            child: Row(
                                              children: [
                                                Transform.scale(
                                                  scale: .9,
                                                  child: Checkbox(
                                                    value: widget.tabType ==
                                                            SummaryTypes
                                                                .retailing.type
                                                        ? ctlr
                                                            .selectedRetailingCategoryFilters
                                                            .contains(cat)
                                                        : widget.tabType ==
                                                                SummaryTypes
                                                                    .coverage
                                                                    .type
                                                            ? ctlr
                                                                .selectedCoverageCategoryFilters
                                                                .contains(cat)
                                                            : widget.tabType ==
                                                                    SummaryTypes
                                                                        .gp.type
                                                                ? ctlr
                                                                    .selectedGPCategoryFilters
                                                                    .contains(
                                                                        cat)
                                                                : widget.tabType ==
                                                                        SummaryTypes
                                                                            .fb
                                                                            .type
                                                                    ? ctlr
                                                                        .selectedFBCategoryFilters
                                                                        .contains(
                                                                            cat)
                                                                    : false,
                                                    onChanged: (v) => ctlr
                                                        .onChangeCategoryValue(
                                                            cat,
                                                            _selectedCategory,
                                                            widget.tabType),
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
                      onPressed: widget.tabType == SummaryTypes.retailing.type
                          ? ctlr.selectedRetailingCategoryFilters.isNotEmpty
                              ? () => onApplyFilter(ctlr)
                              : null
                          : widget.tabType == SummaryTypes.coverage.type
                              ? ctlr.selectedCoverageCategoryFilters.isNotEmpty
                                  ? () => onApplyFilter(ctlr)
                                  : null
                              : widget.tabType == SummaryTypes.gp.type
                                  ? ctlr.selectedGPCategoryFilters.isNotEmpty
                                      ? () => onApplyFilter(ctlr)
                                      : null
                                  : widget.tabType == SummaryTypes.fb.type
                                      ? ctlr.selectedFBCategoryFilters
                                              .isNotEmpty
                                          ? () => onApplyFilter(ctlr)
                                          : null
                                      : () => onApplyFilter(ctlr),
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Apply Changes',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: widget.tabType == SummaryTypes.retailing.type
                              ? ctlr.selectedRetailingCategoryFilters.isNotEmpty
                                  ? AppColors.primary
                                  : Colors.grey
                              : widget.tabType == SummaryTypes.gp.type
                                  ? ctlr.selectedGPCategoryFilters.isNotEmpty
                                      ? AppColors.primary
                                      : Colors.grey
                                  : widget.tabType == SummaryTypes.fb.type
                                      ? ctlr.selectedFBCategoryFilters
                                              .isNotEmpty
                                          ? AppColors.primary
                                          : Colors.grey
                                      : Colors.grey,
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

  void onApplyFilter(HomeController ctlr) {
    LoggerUtils.firebaseAnalytics(
        AnalyticsEvent.deep_dive_selected_channel, "Added Selected Category ${ctlr.getUserName()}");
    ctlr.onChangeCategory1(_selectedCategory, tabType: widget.tabType);
    if (widget.isTrends) {
      ctlr.onApplyMultiFilter('trends', 'geo',
          tabType: widget.tabType, subType: 'category');
    } else {
      ctlr.onApplyMultiFilter('category', 'category',
          tabType: widget.tabType, subType: 'category');
    }

    Navigator.pop(context);
  }
}
