import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';

class GeographyTrendsBottomsheet extends StatefulWidget {
  final String tabType;
  final String type;
  const GeographyTrendsBottomsheet(
      {super.key, required this.tabType, required this.type});

  @override
  State<GeographyTrendsBottomsheet> createState() =>
      _GeographyTrendsBottomsheetState();
}

class _GeographyTrendsBottomsheetState
    extends State<GeographyTrendsBottomsheet> {
  List<String> geoList = ['All India', 'Division', 'Cluster', 'Site', 'Branch'];
  String _selectedGeo = 'All India', _selectedGeoValue = '';
  String get selectedGeo => _selectedGeo;
  String get selectedGeoValue => _selectedGeoValue;
  void onChangeFilter(String value) {
    _selectedGeo = value;

    setState(() {});
  }

  bool _isFirst = true;
  void catInit(HomeController ctlr, {required String tabType}) {
    if (_isFirst) {
      _isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        String _selectedGeo = ctlr.selectedTrendsGeo.isNotEmpty
            ? ctlr.selectedTrendsGeo
            : ctlr.selectedGeo;
        String _selectedGeoValue1 = ctlr.selectedTrendsGeo.isNotEmpty
            ? ctlr.selectedTrendsGeoValue
            : ctlr.selectedGeoValue;
        _selectedGeoValue = _selectedGeoValue1;
        ctlr.onTrendsGeoChange(_selectedGeo);
        onChangeFilter(_selectedGeo);
        // if (tabType == SummaryTypes.retailing.type) {
        //   onChangeFilter(_selectedGeo);
        // } else if (tabType == SummaryTypes.gp.type) {
        //   onChangeFilter(_selectedGeo);
        // } else if (tabType == SummaryTypes.fb.type) {
        //   onChangeFilter(_selectedGeo);
        // }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void onChangeFilterValue(String value) {
    _selectedGeoValue = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {},
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
                                    color: e == selectedGeo
                                        ? AppColors.white
                                        : null,
                                    child: ListTile(
                                      onTap: () {
                                        onChangeFilter(e);
                                        ctlr.onTrendsGeoChange(e);
                                      },
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
                            _selectedGeo.trim().toLowerCase() ==
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
                              height: _selectedGeo.trim().toLowerCase() ==
                                      "Branch".toLowerCase()
                                  ? 250
                                  : 300,
                              child: _selectedGeo.trim().toLowerCase() ==
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
                                                          onTap: () =>
                                                              onChangeFilterValue(
                                                                  e),
                                                          child: Row(
                                                            children: [
                                                              Transform.scale(
                                                                scale: .9,
                                                                child: Checkbox(
                                                                  value: _selectedGeoValue
                                                                          .trim()
                                                                          .toLowerCase() ==
                                                                      e
                                                                          .trim()
                                                                          .toLowerCase(),
                                                                  onChanged: (v) =>
                                                                      onChangeFilterValue(
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
                                              ...ctlr.trendsFilter
                                                  .map(
                                                    (e) => InkWell(
                                                      onTap: () =>
                                                          onChangeFilterValue(
                                                              e),
                                                      child: Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: .9,
                                                            child: Checkbox(
                                                              value: _selectedGeoValue
                                                                      .trim()
                                                                      .toLowerCase() ==
                                                                  e
                                                                      .trim()
                                                                      .toLowerCase(),
                                                              onChanged: (v) =>
                                                                  onChangeFilterValue(
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
                        ctlr.onTrendsFilterSelect(widget.type, widget.tabType);
                        ctlr.onChangeGeoTrends(_selectedGeo);
                        ctlr.onChangeTrendsFilters(
                            _selectedGeoValue, widget.tabType);
                        ctlr.onApplyMultiFilter(
                          'trends',
                          widget.tabType == SummaryTypes.coverage.type
                              ? 'trends'
                              : 'geo',
                          tabType: widget.tabType,
                          isTrendsFilter: true,
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
