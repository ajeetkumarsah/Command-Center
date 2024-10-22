import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';

class GeographyBottomsheet extends StatefulWidget {
  final Function(Map<String, dynamic>)? onApplyFilter;
  final bool isLoadRetailing;
  final String tabType;
  final bool isSummary;
  const GeographyBottomsheet(
      {super.key,
      this.onApplyFilter,
      this.isLoadRetailing = false,
      required this.isSummary,
      required this.tabType});

  @override
  State<GeographyBottomsheet> createState() => _GeographyBottomsheetState();
}

class _GeographyBottomsheetState extends State<GeographyBottomsheet> {
  List<String> geoList = [
    'All India',
    'Division',
    'Cluster',
    'Focus Area',
    'Branch'
  ];

  @override
  void initState() {
    super.initState();
  }

  bool _isFirst = true;
  void geoInit(HomeController ctlr) {
    if (_isFirst) {
      _isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctlr.geoFilterInit();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {},
      builder: (ctlr) {
        geoInit(ctlr);
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
                                      title: Text(
                                        e,
                                        style: GoogleFonts.ptSans(),
                                      ),
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
                                                                e,
                                                                isLoadRetailing:
                                                                    widget
                                                                        .isLoadRetailing,
                                                                tabType: 'All',
                                                                isSummary: widget
                                                                    .isSummary,
                                                              )
                                                              .then((value) =>
                                                                  Get.back()),
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
                                                                  onChanged: (v) => ctlr
                                                                      .onChangeFilters(
                                                                        e,
                                                                        isLoadRetailing:
                                                                            widget.isLoadRetailing,
                                                                        tabType:
                                                                            'All',
                                                                        isSummary:
                                                                            widget.isSummary,
                                                                      )
                                                                      .then((value) => Get.back()),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  e,
                                                                  style: GoogleFonts
                                                                      .ptSans(),
                                                                ),
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
                                                          .onChangeFilters(
                                                            e,
                                                            isLoadRetailing: widget
                                                                .isLoadRetailing,
                                                            tabType: 'All',
                                                            isSummary: widget
                                                                .isSummary,
                                                          )
                                                          .then((value) =>
                                                              Get.back()),
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
                                                                  ctlr
                                                                      .onChangeFilters(
                                                                        e,
                                                                        isLoadRetailing:
                                                                            widget.isLoadRetailing,
                                                                        tabType:
                                                                            'All',
                                                                        isSummary:
                                                                            widget.isSummary,
                                                                      )
                                                                      .then((value) =>
                                                                          Get.back()),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              e,
                                                              style: GoogleFonts
                                                                  .ptSans(),
                                                            ),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     // TextButton(
                //     //   onPressed: () => Get.back(),
                //     //   style: ButtonStyle(
                //     //     overlayColor:
                //     //         MaterialStateProperty.all(Colors.transparent),
                //     //   ),
                //     //   child: Text(
                //     //     'Clear',
                //     //     style: GoogleFonts.ptSans(
                //     //       fontSize: 16,
                //     //       fontWeight: FontWeight.w400,
                //     //       color: Colors.grey,
                //     //     ),
                //     //   ),
                //     // ),
                //     // TextButton(
                //     //   onPressed: () {
                //     //     LoggerUtils.firebaseAnalytics(
                //     //         AnalyticsEvent.deep_dive_selected_geo, "Added Selected Geo ${ctlr.getUserName()}");
                //     //     if (ctlr.selectedTempGeoValue.isNotEmpty) {
                //     //       ctlr.onApplyFilter(
                //     //         isLoadRetailing: isLoadRetailing,
                //     //         tabType: 'All',
                //     //         isSummary: isSummary,
                //     //       );
                //     //       Navigator.pop(context);
                //     //     } else {
                //     //       showCustomSnackBar('Please select a geo!');
                //     //     }
                //     //   },
                //     //   style: ButtonStyle(
                //     //     overlayColor:
                //     //         MaterialStateProperty.all(Colors.transparent),
                //     //   ),
                //     //   child: Text(
                //     //     'Apply Changes',
                //     //     style: GoogleFonts.ptSans(
                //     //       fontSize: 16,
                //     //       fontWeight: FontWeight.w700,
                //     //       color: ctlr.selectedTempGeoValue.isNotEmpty
                //     //           ? AppColors.primary
                //     //           : Colors.grey,
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
