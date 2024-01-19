import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/geo_trends_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/channel_trends_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/retailing/widgets/category_trends_bottomsheet.dart';

class TrendsFilterBottomsheet extends StatelessWidget {
  final bool isCoverage;
  final String tabType;
  const TrendsFilterBottomsheet(
      {super.key, this.isCoverage = false, required this.tabType});

  @override
  Widget build(BuildContext context) {
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
                    'Select Type',
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
            // const SizedBox(height: 12),
            ...['Geography', 'Category', 'Channel']
                .map(
                  (e) => e == 'Category' && isCoverage
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.back();
                              // if (onTap != null) {
                              //   onTap!(e);
                              // }
                              if (e == 'Category') {
                                Get.bottomSheet(CategoryTrendsFilterBottomsheet(
                                    tabType: tabType, type: e));
                              } else if (e == 'Geography') {
                                Get.bottomSheet(GeographyTrendsBottomsheet(
                                    tabType: tabType, type: e));
                              } else if (e == 'Channel') {
                                Get.bottomSheet(ChannelTrendsFilterBottomsheet(
                                    tabType: tabType, type: e));
                              }
                            },
                            title: Text(
                              e,
                              style: GoogleFonts.ptSans(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.grey),
                          ),
                        ),
                )
                .toList(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
