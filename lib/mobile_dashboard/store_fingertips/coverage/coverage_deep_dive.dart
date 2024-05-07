import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';

class CoverageDeepDiveScreen extends StatelessWidget {
  const CoverageDeepDiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return DefaultTabController(
          length: 5,
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      // height: 140,
                      width: MediaQuery.of(context).size.width,
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
                        children: [
                          ListTile(
                            title: Text(
                              'Shashi Medical and General Store',
                              style: GoogleFonts.inter(
                                fontSize: 26,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.menu_rounded,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, top: 12, bottom: 6),
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
                                Image.asset(
                                  PngFiles.calendar,
                                  height: 24,
                                  width: 24,
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
                    ),
                    TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.white.withOpacity(0.3),
                      indicatorColor: Colors.black,
                      tabs: const [
                        Tab(
                          child: Text('Dashboard'),
                        ),
                        Tab(
                          child: Text('Sales Value'),
                        ),
                        Tab(
                          child: Text('Coverage'),
                        ),
                        Tab(
                          child: Text('GP'),
                        ),
                        Tab(
                          child: Text('FB'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
