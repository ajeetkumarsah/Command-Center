import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';

class SelectMonthBottomsheet extends StatelessWidget {
  final bool isLoadRetailing;
  final String tabType;
  final bool isSummary;
  const SelectMonthBottomsheet(
      {super.key,
      this.isLoadRetailing = false,
      required this.tabType,
      this.isSummary = false});

  @override
  Widget build(BuildContext context) {
    List<String> yearsList = ['Date'];

    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      // initState: (_) {},
      builder: (ctlr) {
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
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Select Date',
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
                                .map((e) => Container(
                                      color: e == ctlr.selectedTempYear
                                          ? AppColors.white
                                          : null,
                                      child: ListTile(
                                        onTap: () => ctlr.onChangeYearFilter(e),
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
                        child: SizedBox(
                          height: 300,
                          child: ctlr.isFilterLoading
                              ? const CustomLoader()
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...ctlr.monthFilters
                                          .map(
                                            (month) => InkWell(
                                              onTap: () => ctlr
                                                  .onChangeMonthFilter(month),
                                              child: Row(
                                                children: [
                                                  Transform.scale(
                                                    scale: .9,
                                                    child: Checkbox(
                                                      value: ctlr
                                                              .selectedTempMonth
                                                              ?.toLowerCase() ==
                                                          month.toLowerCase(),
                                                      onChanged: (v) => ctlr
                                                          .onChangeMonthFilter(
                                                              month),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      month,
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
                          if (ctlr.selectedTempMonth != null) {
                            ctlr.onChangeDate(
                              isLoadRetailing: isLoadRetailing,
                              tabType: 'All',
                            );
                            Navigator.pop(context);
                          } else {
                            showCustomSnackBar('Please select the month.',
                                isError: false, isBlack: true);
                          }
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
