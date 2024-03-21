import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';

class GeographyMultiSelectBottomsheet extends StatefulWidget {
  final bool isTrends;
  final String tabType;
  const GeographyMultiSelectBottomsheet(
      {super.key, this.isTrends = false, required this.tabType});

  @override
  State<GeographyMultiSelectBottomsheet> createState() =>
      _GeographyMultiSelectBottomsheetState();
}

class _GeographyMultiSelectBottomsheetState
    extends State<GeographyMultiSelectBottomsheet> {
  String _selectedFilter = '';
  String get selectedFilter => _selectedFilter;

  void onChangeFilter(String value) {
    _selectedFilter = value;
    setState(() {});
  }

  // void onChangeFilterValue(String value) {
  //   if (selectedFilterValue.contains(value)) {
  //     selectedFilterValue.remove(value);
  //   } else {
  //     selectedFilterValue.add(value);
  //   }
  //   setState(() {});
  // }
  bool isFirst = true;
  void initCall(String value) {
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChangeFilter(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> geoList = [
      'All India',
      'Division',
      'Cluster',
      'Focus Area',
      'Branch'
    ];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {},
      builder: (ctlr) {
        initCall(ctlr.selectedMultiGeo);
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
                        'Select Geography ',
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
                              .map(
                                (e) => Container(
                                  color: e == selectedFilter
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () {
                                      onChangeFilter(e);
                                      ctlr.onGeoChange(_selectedFilter,
                                          isMultiSelect: true);
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
                            _selectedFilter.trim().toLowerCase() ==
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
                              height: _selectedFilter.trim().toLowerCase() ==
                                      "Branch".toLowerCase()
                                  ? 250
                                  : 300,
                              child: _selectedFilter.trim().toLowerCase() ==
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
                                                          onTap: () {
                                                            ctlr.onChangeMultiFilters(
                                                                e,
                                                                tabType: widget
                                                                    .tabType,
                                                                selectedMultiGeoFilter:
                                                                    _selectedFilter);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Transform.scale(
                                                                scale: .9,
                                                                child: Checkbox(
                                                                  value: selectedFilter
                                                                              .toLowerCase() ==
                                                                          'Branch'
                                                                              .toLowerCase()
                                                                      ? widget.tabType ==
                                                                              SummaryTypes
                                                                                  .retailing.type
                                                                          ? ctlr
                                                                              .selectedRetailingMultiBranches
                                                                              .contains(e)
                                                                          : widget.tabType == SummaryTypes.coverage.type
                                                                              ? ctlr.selectedCoverageMultiBranches.contains(e)
                                                                              : widget.tabType == SummaryTypes.gp.type
                                                                                  ? ctlr.selectedGPMultiBranches.contains(e)
                                                                                  : widget.tabType == SummaryTypes.fb.type
                                                                                      ? ctlr.selectedFBMultiBranches.contains(e)
                                                                                      : false
                                                                      : ctlr.selectedMultiFilters.contains(e),
                                                                  onChanged:
                                                                      (v) {
                                                                    ctlr.onChangeMultiFilters(
                                                                        e,
                                                                        tabType:
                                                                            widget
                                                                                .tabType,
                                                                        selectedMultiGeoFilter:
                                                                            _selectedFilter);
                                                                  },
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
                                              ...ctlr.multiFilters
                                                  .map(
                                                    (e) => InkWell(
                                                      onTap: () {
                                                        ctlr.onChangeMultiFilters(
                                                            e,
                                                            tabType:
                                                                widget.tabType,
                                                            selectedMultiGeoFilter:
                                                                _selectedFilter);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: .9,
                                                            child: Checkbox(
                                                              value: widget
                                                                          .tabType ==
                                                                      SummaryTypes
                                                                          .retailing
                                                                          .type
                                                                  ? selectedFilter ==
                                                                          'All India'
                                                                      ? ctlr
                                                                          .selectedRetailingMultiAllIndia
                                                                          .contains(
                                                                              e)
                                                                      : selectedFilter.trim().toLowerCase() ==
                                                                              'Division'.trim().toLowerCase()
                                                                          ? ctlr.selectedRetailingMultiDivisions.contains(e)
                                                                          : selectedFilter.toLowerCase() == 'Cluster'.toLowerCase()
                                                                              ? ctlr.selectedRetailingMultiClusters.contains(e)
                                                                              : selectedFilter.toLowerCase() == 'Focus Area'.toLowerCase()
                                                                                  ? ctlr.selectedRetailingMultiSites.contains(e)
                                                                                  : selectedFilter.toLowerCase() == 'Branch'.toLowerCase()
                                                                                      ? ctlr.selectedRetailingMultiBranches.contains(e)
                                                                                      : ctlr.selectedMultiFilters.contains(e)
                                                                  : widget.tabType == SummaryTypes.coverage.type
                                                                      ? selectedFilter == 'All India'
                                                                          ? ctlr.selectedCoverageMultiAllIndia.contains(e)
                                                                          : selectedFilter.trim().toLowerCase() == 'Division'.trim().toLowerCase()
                                                                              ? ctlr.selectedCoverageMultiDivisions.contains(e)
                                                                              : selectedFilter.toLowerCase() == 'Cluster'.toLowerCase()
                                                                                  ? ctlr.selectedCoverageMultiClusters.contains(e)
                                                                                  : selectedFilter.toLowerCase() == 'Focus Area'.toLowerCase()
                                                                                      ? ctlr.selectedCoverageMultiSites.contains(e)
                                                                                      : selectedFilter.toLowerCase() == 'Branch'.toLowerCase()
                                                                                          ? ctlr.selectedCoverageMultiBranches.contains(e)
                                                                                          : ctlr.selectedMultiFilters.contains(e)
                                                                      : widget.tabType == SummaryTypes.gp.type
                                                                          ? selectedFilter == 'All India'
                                                                              ? ctlr.selectedGPMultiAllIndia.contains(e)
                                                                              : selectedFilter.trim().toLowerCase() == 'Division'.trim().toLowerCase()
                                                                                  ? ctlr.selectedGPMultiDivisions.contains(e)
                                                                                  : selectedFilter.toLowerCase() == 'Cluster'.toLowerCase()
                                                                                      ? ctlr.selectedGPMultiClusters.contains(e)
                                                                                      : selectedFilter.toLowerCase() == 'Focus Area'.toLowerCase()
                                                                                          ? ctlr.selectedGPMultiSites.contains(e)
                                                                                          : selectedFilter.toLowerCase() == 'Branch'.toLowerCase()
                                                                                              ? ctlr.selectedGPMultiBranches.contains(e)
                                                                                              : ctlr.selectedMultiFilters.contains(e)
                                                                          : widget.tabType == SummaryTypes.fb.type
                                                                              ? selectedFilter == 'All India'
                                                                                  ? ctlr.selectedFBMultiAllIndia.contains(e)
                                                                                  : selectedFilter.trim().toLowerCase() == 'Division'.trim().toLowerCase()
                                                                                      ? ctlr.selectedFBMultiDivisions.contains(e)
                                                                                      : selectedFilter.toLowerCase() == 'Cluster'.toLowerCase()
                                                                                          ? ctlr.selectedFBMultiClusters.contains(e)
                                                                                          : selectedFilter.toLowerCase() == 'Focus Area'.toLowerCase()
                                                                                              ? ctlr.selectedFBMultiSites.contains(e)
                                                                                              : selectedFilter.toLowerCase() == 'Branch'.toLowerCase()
                                                                                                  ? ctlr.selectedFBMultiBranches.contains(e)
                                                                                                  : ctlr.selectedMultiFilters.contains(e)
                                                                              : false,
                                                              // ctlr.selectedMultiFilters
                                                              //     .contains(
                                                              //         e),
                                                              onChanged: (v) {
                                                                ctlr.onChangeMultiFilters(
                                                                    e,
                                                                    tabType: widget
                                                                        .tabType,
                                                                    selectedMultiGeoFilter:
                                                                        _selectedFilter);
                                                              },
                                                            ),
                                                          ),
                                                          Flexible(
                                                              child: Text(e)),
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
                      onPressed: () {
                        Get.back();
                        // ctlr.clearMultiFilter();
                        if (widget.isTrends) {
                          ctlr.clearMultiFilter('trends', 'geo',
                              tabType: widget.tabType);
                        } else {
                          ctlr.clearMultiFilter('geo', 'geo',
                              tabType: widget.tabType);
                        }
                      },
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
                          ? ctlr.selectedRetailingMultiAllIndia.isNotEmpty ||
                                  ctlr.selectedRetailingMultiDivisions
                                      .isNotEmpty ||
                                  ctlr.selectedRetailingMultiClusters
                                      .isNotEmpty ||
                                  ctlr.selectedRetailingMultiSites.isNotEmpty ||
                                  ctlr.selectedRetailingMultiBranches.isNotEmpty
                              ? () => onApplyFilter(ctlr)
                              : null
                          : widget.tabType == SummaryTypes.coverage.type
                              ? ctlr.selectedCoverageMultiAllIndia.isNotEmpty ||
                                      ctlr.selectedCoverageMultiDivisions
                                          .isNotEmpty ||
                                      ctlr.selectedCoverageMultiClusters
                                          .isNotEmpty ||
                                      ctlr.selectedCoverageMultiSites
                                          .isNotEmpty ||
                                      ctlr.selectedCoverageMultiBranches
                                          .isNotEmpty
                                  ? () => onApplyFilter(ctlr)
                                  : null
                              : widget.tabType == SummaryTypes.gp.type
                                  ? ctlr.selectedGPMultiAllIndia.isNotEmpty ||
                                          ctlr.selectedGPMultiDivisions
                                              .isNotEmpty ||
                                          ctlr.selectedGPMultiClusters
                                              .isNotEmpty ||
                                          ctlr.selectedGPMultiSites
                                              .isNotEmpty ||
                                          ctlr.selectedGPMultiBranches
                                              .isNotEmpty
                                      ? () => onApplyFilter(ctlr)
                                      : null
                                  : widget.tabType == SummaryTypes.fb.type
                                      ? ctlr.selectedFBMultiAllIndia.isNotEmpty ||
                                              ctlr.selectedFBMultiDivisions
                                                  .isNotEmpty ||
                                              ctlr.selectedFBMultiClusters
                                                  .isNotEmpty ||
                                              ctlr.selectedFBMultiSites
                                                  .isNotEmpty ||
                                              ctlr.selectedFBMultiBranches
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
                              ? ctlr.selectedRetailingMultiAllIndia.isNotEmpty ||
                                      ctlr.selectedRetailingMultiDivisions
                                          .isNotEmpty ||
                                      ctlr.selectedRetailingMultiClusters
                                          .isNotEmpty ||
                                      ctlr.selectedRetailingMultiSites
                                          .isNotEmpty ||
                                      ctlr.selectedRetailingMultiBranches
                                          .isNotEmpty
                                  ? AppColors.primary
                                  : Colors.grey
                              : widget.tabType == SummaryTypes.coverage.type
                                  ? ctlr.selectedCoverageMultiAllIndia.isNotEmpty ||
                                          ctlr.selectedCoverageMultiDivisions
                                              .isNotEmpty ||
                                          ctlr.selectedCoverageMultiClusters
                                              .isNotEmpty ||
                                          ctlr.selectedCoverageMultiSites
                                              .isNotEmpty ||
                                          ctlr.selectedCoverageMultiBranches
                                              .isNotEmpty
                                      ? AppColors.primary
                                      : Colors.grey
                                  : widget.tabType == SummaryTypes.gp.type
                                      ? ctlr.selectedGPMultiAllIndia.isNotEmpty ||
                                              ctlr.selectedGPMultiDivisions
                                                  .isNotEmpty ||
                                              ctlr.selectedGPMultiClusters
                                                  .isNotEmpty ||
                                              ctlr.selectedGPMultiSites
                                                  .isNotEmpty ||
                                              ctlr.selectedGPMultiBranches
                                                  .isNotEmpty
                                          ? AppColors.primary
                                          : Colors.grey
                                      : widget.tabType == SummaryTypes.fb.type
                                          ? ctlr.selectedFBMultiAllIndia.isNotEmpty ||
                                                  ctlr.selectedFBMultiDivisions
                                                      .isNotEmpty ||
                                                  ctlr.selectedFBMultiClusters
                                                      .isNotEmpty ||
                                                  ctlr.selectedFBMultiSites
                                                      .isNotEmpty ||
                                                  ctlr.selectedFBMultiBranches
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
    FirebaseAnalytics.instance.logEvent(
        name: 'deep_dive_selected_geo',
        parameters: {"message": 'Added Selected Geo ${ctlr.getUserName()}'});
    ctlr.onMultiGeoChange(_selectedFilter);

    if (widget.isTrends) {
      ctlr.onApplyMultiFilter('trends', 'geo',
          tabType: widget.tabType, isTrendsFilter: true, subType: 'geo');
    } else {
      ctlr.onApplyMultiFilter('geo', 'geo',
          tabType: widget.tabType, subType: 'geo');
    }
    Navigator.pop(context, true);
  }
}
