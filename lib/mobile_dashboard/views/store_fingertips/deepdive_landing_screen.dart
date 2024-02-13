import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/coverage/coverage_deep_dive.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/fb/fb_deep_dive.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/gp/gp_deep_dive_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/new_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/sales/sales_deep_dive_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/store_fingertips_screen.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/widgets/tab_item_widget.dart';

class DeepDiveLandingScreen extends StatelessWidget {
  const DeepDiveLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return DefaultTabController(
          length: 4,
          initialIndex: ctlr.selectedTab,
          child: Scaffold(
            backgroundColor: AppColors.bgLight,
            body: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const NewAppBar(),
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: const Color(0xff747474),
                    indicatorColor: Colors.black,
                    indicator: const BoxDecoration(),
                    onTap: (v) => ctlr.onTabChange(v),
                    labelStyle: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    labelColor: Colors.black,
                    tabs: const [
                      TabItemWidget(title: 'Sales Value'),
                      TabItemWidget(title: 'Coverage'),
                      TabItemWidget(title: 'GP'),
                      TabItemWidget(title: 'FB', isLast: true),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        SalesDeepDiveScreen(),
                        CoverageDeepDiveScreen(),
                        GPDeepDiveScreen(),
                        FBDeepDiveScreen(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
