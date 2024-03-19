import 'package:command_centre/mobile_dashboard/controllers/store_selection_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/menu_bottomsheet.dart';

class NewAppBar extends StatelessWidget {
  const NewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreSelectionController>(
        init: StoreSelectionController(storeRepo: Get.find()),
        builder: (ctlr) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        // height: 140,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              PngFiles.newAppBar,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                ctlr.selectedStore ?? ctlr.title ?? '',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
              trailing: GetBuilder<HomeController>(
                init: HomeController(homeRepo: Get.find()),
                initState: (_) {},
                builder: (ctlr) {
                  return IconButton(
                    onPressed: () =>
                        Get.bottomSheet(
                          MenuBottomsheet(
                              version: ctlr.appVersion, isBusiness: false),
                          isScrollControlled: true,
                        ),
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.white,
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin:
              const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.white,
                    AppColors.white.withOpacity(.0),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 6),
              child: Row(
                children: [

                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset(
                      PngFiles.calendar,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'CY 2022, November',
                      style: GoogleFonts.inter(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
