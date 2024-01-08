import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';

class CategoryFilterBottomsheet extends StatelessWidget {
  final bool isTrends;
  final String tabType;
  const CategoryFilterBottomsheet(
      {super.key, this.isTrends = false, required this.tabType});

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = [
      'Category',
      'Brand',
      'Brand form',
      'Sub-brand form'
    ];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
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
                                  color: e == ctlr.selectedCategory
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () => ctlr.onChangeCategory(e),
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
                            ctlr.selectedCategory.trim().toLowerCase() ==
                                    'Sub-brand form'.trim().toLowerCase()
                                ? TextFormField(
                                    onChanged: (v) => ctlr.getCategorySearch(
                                        tabType == SummaryTypes.gp.type
                                            ? 'subBrandGroup'
                                            : 'subBrandForm',
                                        query: v),
                                    decoration: const InputDecoration(
                                      hintText: 'Search ',
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: .5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: .5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: .5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height:
                                  ctlr.selectedCategory.trim().toLowerCase() ==
                                          "Sub-brand form".toLowerCase()
                                      ? 250
                                      : 300,
                              child: ctlr.selectedCategory
                                          .trim()
                                          .toLowerCase() ==
                                      "Sub-brand form".toLowerCase()
                                  ? ctlr.isFilterLoading
                                      ? const CustomLoader()
                                      : ctlr.subBrandForm.isNotEmpty
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ...ctlr.subBrandForm
                                                      .map(
                                                        (e) => InkWell(
                                                          onTap: () => ctlr
                                                              .onChangeCategoryValue(
                                                                  e),
                                                          child: Row(
                                                            children: [
                                                              Transform.scale(
                                                                scale: .9,
                                                                child: Checkbox(
                                                                  value: ctlr
                                                                      .selectedCategoryFilters
                                                                      .contains(
                                                                          e),
                                                                  onChanged:
                                                                      (v) => ctlr
                                                                          .onChangeCategoryValue(
                                                                              e),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(e),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                'Search for Sub brand form',
                                                style:
                                                    GoogleFonts.ptSansCaption(),
                                              ),
                                            )
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ctlr.selectedCategory
                                                          .trim()
                                                          .toLowerCase() ==
                                                      "Category"
                                                          .toLowerCase() ||
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
                                                          type: 'category'),
                                                  child: Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: .9,
                                                        child: Checkbox(
                                                          value: listEquals(
                                                              ctlr.selectedCategoryFilters,
                                                              ctlr.categoryFilters),
                                                          onChanged: (v) => ctlr
                                                              .onChangeFiltersAll(
                                                                  type:
                                                                      'category'),
                                                        ),
                                                      ),
                                                      const Flexible(
                                                        child:
                                                            Text('Select all'),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(),
                                          ...ctlr.categoryFilters
                                              .map(
                                                (cat) => GestureDetector(
                                                  onTap: () => ctlr
                                                      .onChangeCategoryValue(
                                                          cat),
                                                  child: Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: .9,
                                                        child: Checkbox(
                                                          value: ctlr
                                                              .selectedCategoryFilters
                                                              .contains(cat),
                                                          onChanged: (v) => ctlr
                                                              .onChangeCategoryValue(
                                                                  cat),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          child: Text(cat)),
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
                        if (isTrends) {
                          ctlr.onApplyMultiFilter('trends', 'geo',
                              tabType: tabType);
                        } else {
                          ctlr.onApplyMultiFilter('category', 'category',
                              tabType: tabType);
                        }

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
