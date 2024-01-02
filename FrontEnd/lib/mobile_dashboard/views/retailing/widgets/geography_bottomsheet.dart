import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class GeographyBottomsheet extends StatelessWidget {
  final Function(Map<String, dynamic>)? onApplyFilter;
  final bool isLoadRetailing;
  final String tabType;
  const GeographyBottomsheet(
      {super.key,
      this.onApplyFilter,
      this.isLoadRetailing = false,
      required this.tabType});

  @override
  Widget build(BuildContext context) {
    List<String> geoList = [
      'All India',
      'Division',
      'Cluster',
      'Site',
      'Branch'
    ];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {},
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
                        'Select Geography',
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
                          ...geoList
                              .map((e) => Container(
                                    color: e == ctlr.selectedTempGeo
                                        ? AppColors.white
                                        : null,
                                    child: ListTile(
                                      onTap: () => ctlr.onGeoChange(e),
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -3),
                                      title: Text(e),
                                    ),
                                  ))
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
                            ctlr.selectedTempGeo.trim().toLowerCase() ==
                                    "Branch".toLowerCase()
                                ? TextFormField(
                                    onChanged: (v) => ctlr
                                        .getCategorySearch('branch', query: v),
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
                                  ctlr.selectedTempGeo.trim().toLowerCase() ==
                                          "Branch".toLowerCase()
                                      ? 250
                                      : 300,
                              child: ctlr.selectedTempGeo
                                          .trim()
                                          .toLowerCase() ==
                                      "Branch".toLowerCase()
                                  ? ctlr.isFilterLoading
                                      ? const CustomLoader()
                                      : ctlr.branchFilter.isNotEmpty
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ...ctlr.branchFilter
                                                      .map(
                                                        (e) => InkWell(
                                                          onTap: () => ctlr
                                                              .onChangeFilters(
                                                                  e),
                                                          child: Row(
                                                            children: [
                                                              Transform.scale(
                                                                scale: .9,
                                                                child: Checkbox(
                                                                  value: ctlr
                                                                          .selectedTempGeoValue
                                                                          .trim()
                                                                          .toLowerCase() ==
                                                                      e
                                                                          .trim()
                                                                          .toLowerCase(),
                                                                  onChanged:
                                                                      (v) => ctlr
                                                                          .onChangeFilters(
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
                                                'Search for branch',
                                                style:
                                                    GoogleFonts.ptSansCaption(),
                                              ),
                                            )
                                  : ctlr.isFilterLoading
                                      ? const CustomLoader()
                                      : SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ...ctlr.filters
                                                  .map(
                                                    (e) => InkWell(
                                                      onTap: () => ctlr
                                                          .onChangeFilters(e),
                                                      child: Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: .9,
                                                            child: Checkbox(
                                                              value: ctlr
                                                                      .selectedTempGeoValue
                                                                      .trim()
                                                                      .toLowerCase() ==
                                                                  e
                                                                      .trim()
                                                                      .toLowerCase(),
                                                              onChanged: (v) =>
                                                                  ctlr.onChangeFilters(
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
                      onPressed: () async {
                        ctlr.onApplyFilter(
                            isLoadRetailing: isLoadRetailing, tabType: tabType);
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
