import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';

class SelectMonthBottomsheet extends StatefulWidget {
  final bool isLoadRetailing;
  final String tabType;
  final bool isSummary;
  const SelectMonthBottomsheet(
      {super.key,
      this.isLoadRetailing = false,
      required this.tabType,
      this.isSummary = false});

  @override
  State<SelectMonthBottomsheet> createState() => _SelectMonthBottomsheetState();
}

class _SelectMonthBottomsheetState extends State<SelectMonthBottomsheet> {
  List<String> yearsList = ['Year', 'Month']; //Date
  bool isFirst = true;
  void initCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;
      ctlr.selectedMonthInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      // initState: (_) {},
      builder: (ctlr) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          initCall(ctlr);
        });
        return StatefulBuilder(builder: (context, setState) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Select Date',
                          textAlign: TextAlign.center,
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
                            ...yearsList
                                .map(
                                  (e) => Container(
                                    color: AppColors.bgLight,
                                    child: ListTile(
                                      // onTap: () => ctlr.onChangeYearFilter(e),
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
                        child: SizedBox(
                          height: 300,
                          child: ctlr.isFilterLoading
                              ? const CustomLoader()
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.lightGrey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: DropdownButton<String>(
                                          value: ctlr.selectedTempYear,
                                          underline: const SizedBox(),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.arrow_drop_down_rounded,
                                            size: 24,
                                          ),
                                          items: ctlr.yearFilter
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (v) =>
                                              ctlr.onChangeTempYear(v ?? ''),
                                        ),
                                      ),
                                      ctlr.isMonthLoading
                                          ? CustomShimmer(
                                              height: 40,
                                              width: double.infinity,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            )
                                          : Container(
                                              height: 40,
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              padding: const EdgeInsets.only(
                                                  left: 12, right: 6),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.lightGrey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: DropdownButton<String>(
                                                value: ctlr.selectedTempMonth,
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                icon: const Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  size: 24,
                                                ),
                                                items: ctlr.monthFilters
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (v) => ctlr
                                                    .onChangeTempMonth(v ?? ''),
                                              ),
                                            ),
                                      // ...ctlr.monthFilters
                                      //     .map(
                                      //       (month) => InkWell(
                                      //         onTap: () {
                                      //           ctlr.onChangeMonthFilter(
                                      //             month,
                                      //             isLoadRetailing:
                                      //                 isLoadRetailing,
                                      //             priority: tabType,
                                      //             isSummary: isSummary,
                                      //           );
                                      //           Get.back();
                                      //         },
                                      //         child: Row(
                                      //           children: [
                                      //             Transform.scale(
                                      //               scale: .9,
                                      //               child: Checkbox(
                                      //                 value: ctlr
                                      //                         .selectedTempMonth
                                      //                         ?.toLowerCase() ==
                                      //                     month.toLowerCase(),
                                      //                 onChanged: (v) {
                                      //                   ctlr.onChangeMonthFilter(
                                      //                     month,
                                      //                     isLoadRetailing:
                                      //                         isLoadRetailing,
                                      //                     priority: tabType,
                                      //                     isSummary: isSummary,
                                      //                   );
                                      //                   Get.back();
                                      //                 },
                                      //               ),
                                      //             ),
                                      //             Flexible(
                                      //               child: Text(
                                      //                 month,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     )
                                      //     .toList(),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // LoggerUtils.firebaseAnalytics(
                          //     AnalyticsEvent.selected_month,
                          //     "Selected Month ${ctlr.getUserName()}");
                          // if (ctlr.selectedTempMonth != null) {
                          //   ctlr.onChangeDate(
                          //     isLoadRetailing: isLoadRetailing,
                          //     tabType: 'All',
                          //     isSummary: isSummary,
                          //   );
                          ctlr.onChangeMonthFilter(
                            ctlr.selectedTempMonth ?? '',
                            ctlr.selectedTempYear ?? '',
                            isLoadRetailing: widget.isLoadRetailing,
                            priority: widget.tabType,
                            isSummary: widget.isSummary,
                          );
                          Navigator.pop(context);
                          // } else {
                          //   showCustomSnackBar('Please select the month.',
                          //       isError: false, isBlack: true);
                          // }
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
        });
      },
    );
  }
}
