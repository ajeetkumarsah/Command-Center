import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/onboarding_screen.dart';
// import 'package:command_centre/mobile_dashboard/utils/global.dart' as globals;

class MenuBottomsheet extends StatelessWidget {
  final String version;
  final bool isBusiness;
  const MenuBottomsheet({
    super.key,
    required this.version,
    this.isBusiness = true,
  });

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
            const SizedBox(height: 20),
            // ListTile(
            //   title: Text(
            //     '  Account',
            //     style: GoogleFonts.ptSans(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            //   trailing: TextButton(
            //     onPressed: () {},
            //     child: const Icon(
            //       Icons.arrow_outward_rounded,
            //       color: AppColors.primary,
            //       size: 18,
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 1,
            //   width: double.infinity,
            //   color: AppColors.borderColor,
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     const SizedBox(width: 16),
            //     Flexible(
            //       child: Text(
            //         'Switch Mode',
            //         style: GoogleFonts.ptSans(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    'To organize the data for you according to your purpose today',
                    style: GoogleFonts.ptSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 26),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: isBusiness
                          ? () => Get.back()
                          : () => Get.offAndToNamed(AppPages.INITIAL),
                      child: Container(
                        height: 56,
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.primary,
                          ),
                          color: isBusiness ? AppColors.primary : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Business Overview',
                            style: GoogleFonts.ptSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  isBusiness ? AppColors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: !isBusiness
                          ? () => Get.back()
                          : () => Get.to(const OnboardingScreen()),
                      child: Container(
                        height: 56,
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppColors.primary,
                          ),
                          color:
                              !isBusiness ? AppColors.primary : AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Market Visit',
                            style: GoogleFonts.ptSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: !isBusiness ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.borderColor,
            ),
            // ListTile(
            //   title: Text(
            //     '  View Abbreviations',
            //     style: GoogleFonts.ptSans(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            //   trailing: TextButton(
            //     onPressed: () {},
            //     child: const Icon(
            //       Icons.arrow_outward_rounded,
            //       color: AppColors.primary,
            //       size: 18,
            //     ),
            //   ),
            // ),
            // SelectableText(globals.FCMToken),
            ListTile(
              onTap: () {
                Get.back();
                Get.toNamed(AppPages.HELP_SUPPORT);
              },
              title: Text(
                '  Help & Support',
                style: GoogleFonts.ptSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_outward_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.borderColor,
            ),
            ListTile(
              title: Text(
                ' App Version',
                style: GoogleFonts.ptSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(
                version,
                style: GoogleFonts.ptSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
