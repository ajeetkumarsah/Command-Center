import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:command_centre/mobile_dashboard/views/summary/summary_screen.dart';
import 'package:command_centre/mobile_dashboard/views/all_metrics/all_metrics_screen.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: ctlr.selectedNav,
            children: const [SummaryScreen(), AllMetricsScreen()],
          ),
          bottomNavigationBar:
              //  Hidable(
              //   controller: ctlr.selectedNav == 0
              //       ? ctlr.sScrollController
              //       : ctlr.mScrollController,
              //   preferredWidgetSize: const Size.fromHeight(100),
              //   // deltaFactor: 1,
              //   enableOpacityAnimation: true,
              //   child:
              Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 3,
                      offset: const Offset(3, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 3,
                      offset: const Offset(-3, -3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => ctlr.onChangeBottomNav(0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.track_changes_outlined,
                            color: ctlr.selectedNav == 0
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                          Text(
                            "Summary",
                            style: GoogleFonts.ptSans(
                              fontSize: 14,
                              color: ctlr.selectedNav == 0
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => ctlr.onChangeBottomNav(1),
                      child: Column(
                        children: [
                          Icon(
                            Icons.apps,
                            color: ctlr.selectedNav == 1
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                          Text(
                            "All Metrics",
                            style: GoogleFonts.ptSans(
                              fontSize: 14,
                              color: ctlr.selectedNav == 1
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ),
        );
      },
    );
  }
}

class ScrollListener extends ChangeNotifier {
  double bottom = 0;
  double _last = 0;

  ScrollListener.initialise(ScrollController controller, [double height = 56]) {
    controller.addListener(() {
      final current = controller.offset;
      bottom += _last - current;
      if (bottom <= -height) bottom = -height;
      if (bottom >= 0) bottom = 0;
      _last = current;
      if (bottom <= 0 && bottom >= -height) notifyListeners();
    });
  }
}
