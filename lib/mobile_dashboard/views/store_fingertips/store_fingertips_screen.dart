import 'new_appbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/widgets/tab_item_widget.dart';


class StoreFingertipsScreen extends StatelessWidget {
  const StoreFingertipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgLight,
      body: StoreDashboardUI(),
    );
  }
}

class StoreDashboardUI extends StatelessWidget {
  const StoreDashboardUI({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: GetBuilder<StoreController>(
          init: StoreController(storeRepo: Get.find()),
          builder: (ctlr) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   padding: const EdgeInsets.all(10.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(30.0),
                  //       bottomRight: Radius.circular(30.0),
                  //     ),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         offset: const Offset(0, 4),
                  //         blurRadius: 15,
                  //         color: AppColors.black.withOpacity(.25),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Image.asset("assets/png/Group 35.png", height: 31),
                  //       const SizedBox(height: 15),
                  //       Image.asset("assets/png/Rectangle 426.png"),
                  //       const SizedBox(height: 15),
                  //       Text(
                  //         ctlr.getStore(),
                  //         style: GoogleFonts.inter(
                  //           color: const Color(0xff0B4983),
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const NewAppBar(),
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: const Color(0xff747474),
                    indicatorColor: Colors.black,
                    indicator: const BoxDecoration(),
                    labelStyle: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    labelColor: Colors.black,
                    tabs: const [
                      TabItemWidget(title: 'Dashboard'),
                      TabItemWidget(title: 'Sales Value'),
                      TabItemWidget(title: 'Coverage'),
                      TabItemWidget(title: 'GP'),
                      TabItemWidget(title: 'FB', isLast: true),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppPages.SALES_DEEP_DIVE),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Sales Values",
                                  style: TextStyle(
                                      color: AppColors.primary, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 60) *
                                          .8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("0.00K"),
                                      Text("87.71K"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 8.0,
                                    barRadius: const Radius.circular(10),
                                    // leading: const Text("0.00K"),
                                    // trailing: const Text("73.48K"),
                                    percent: 0.7,
                                    linearGradient: LinearGradient(
                                      colors: [
                                        const Color(0xff5B5B5B)
                                            .withOpacity(.44),
                                        const Color(0xff5B5B5B)
                                      ],
                                    ),
                                    linearStrokeCap: LinearStrokeCap.butt,

                                    backgroundColor: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 8.0,
                                    barRadius: const Radius.circular(10),
                                    linearGradient: const LinearGradient(
                                      colors: [
                                        Color(0xff6ECCDA),
                                        Color(0xff475DEF)
                                      ],
                                    ),
                                    percent: 0.9,
                                    linearStrokeCap: LinearStrokeCap.butt,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 60) *
                                          .9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("0.00K"),
                                      Text("87.71K"),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   padding: EdgeInsets.all(20.0),
                  //   child: Table(
                  //     border: TableBorder.all(color: Colors.black),
                  //     children: [
                  //       TableRow(children: [
                  //         Text('Cell 1'),
                  //         Text('Cell 2'),
                  //         Text('Cell 3'),
                  //       ]),
                  //       TableRow(children: [
                  //         Text('Cell 4'),
                  //         Text('Cell 5'),
                  //         Text('Cell 6'),
                  //       ])
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        // padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [
                            TableData(),
                            TableData(),
                            TableData(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppPages.COVERAGE_DEEP_DIVE),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Colors.white,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 12, bottom: 12),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Coverage/Visit",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        color: AppColors.primary,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: LinearPercentIndicator(
                                        width: 170.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 8.0,
                                        barRadius: const Radius.circular(10),
                                        leading: const Text("Target Calls"),
                                        trailing: const Text("8"),
                                        percent: 0.8,
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xff6ECCDA),
                                            Color(0xff475DEF)
                                          ],
                                        ),
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: LinearPercentIndicator(
                                        width: 170.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 8.0,
                                        barRadius: const Radius.circular(10),
                                        leading: const Text("Call Made"),
                                        trailing: const Text("9"),
                                        percent: 0.9,
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xff6ECCDA),
                                            Color(0xff475DEF)
                                          ],
                                        ),
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: LinearPercentIndicator(
                                        width: 170.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 8.0,
                                        barRadius: const Radius.circular(10),
                                        leading: const Text("CCR Calls"),
                                        trailing: const Text("6"),
                                        percent: 0.7,
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xff6ECCDA),
                                            Color(0xff475DEF)
                                          ],
                                        ),
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: LinearPercentIndicator(
                                        width: 170.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 8.0,
                                        barRadius: const Radius.circular(10),
                                        leading: const Text("Billed Calls"),
                                        trailing: const Text("8"),
                                        percent: 0.8,
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xff6ECCDA),
                                            Color(0xff475DEF)
                                          ],
                                        ),
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: LinearPercentIndicator(
                                        width: 170.0,
                                        animation: true,

                                        animationDuration: 1000,
                                        lineHeight: 8.0,
                                        barRadius: const Radius.circular(10),
                                        // backgroundColor:
                                        //     const Color.fromARGB(255, 2, 74, 133),
                                        leading: const Text("Pro Calls"),
                                        trailing: const Text("8"),
                                        percent: 0.8,
                                        // ignore: deprecated_member_use
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        linearGradient: const LinearGradient(
                                          colors: [
                                            Color(0xff6ECCDA),
                                            Color(0xff475DEF)
                                          ],
                                        ),
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(100),
                                            bottomLeft: Radius.circular(100),
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xff475DEF),
                                              Color(0xff6ECCDA),
                                            ],
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 12),
                                            Flexible(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: '33.07',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 20,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'min',
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Avg in-Store Time',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 10.00,
                            child: GestureDetector(
                              onTap: () =>
                                  Get.toNamed(AppPages.GP_DEEP_DIVE_SCREEN),
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Golden Point",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 2, 151),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    LinearPercentIndicator(
                                      width: 160,
                                      animation: true,
                                      animationDuration: 1000,
                                      lineHeight: 8.0,
                                      barRadius: const Radius.circular(10),
                                      backgroundColor: AppColors.white,
                                      linearGradient: LinearGradient(
                                        colors: [
                                          const Color(0xff5B5B5B)
                                              .withOpacity(.44),
                                          const Color(0xff5B5B5B),
                                        ],
                                      ),
                                      trailing: const Text("8"),
                                      percent: 1.0,
                                      // ignore: deprecated_member_use
                                      linearStrokeCap: LinearStrokeCap.butt,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    LinearPercentIndicator(
                                      width: 160.0,
                                      animation: true,
                                      animationDuration: 1000,
                                      lineHeight: 8.0,
                                      barRadius: const Radius.circular(10),
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Color(0xff6ECCDA),
                                          Color(0xff475DEF)
                                        ],
                                      ),
                                      backgroundColor: AppColors.white,
                                      trailing: const Text("8"),
                                      percent: 0.4,
                                      // ignore: deprecated_member_use
                                      linearStrokeCap: LinearStrokeCap.butt,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    LinearPercentIndicator(
                                      width: 160.0,
                                      animation: true,
                                      animationDuration: 1000,
                                      lineHeight: 8.0,
                                      barRadius: const Radius.circular(10),
                                      linearGradient: const LinearGradient(
                                        colors: [
                                          Color(0xff6ECCDA),
                                          Color(0xff475DEF)
                                        ],
                                      ),
                                      backgroundColor: AppColors.white,
                                      trailing: const Text("8"),
                                      percent: 1.0,
                                      // ignore: deprecated_member_use
                                      linearStrokeCap: LinearStrokeCap.butt,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 10.00,
                            child: GestureDetector(
                              onTap: () =>
                                  Get.toNamed(AppPages.FB_DEEP_DIVE_SCREEN),
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Focus Brand",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 2, 151),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 8.0,
                                      percent: 0.75,
                                      linearGradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xff475DEF),
                                          Color(0xff6ECCDA),
                                          Color(0xff6ECCDA),
                                          Color(0xff475DEF),
                                        ],
                                      ),
                                      backgroundColor: AppColors.white,
                                      center: CircularPercentIndicator(
                                        radius: 50.0,
                                        lineWidth: 8.0,
                                        percent: 1.0,
                                        center: const Text(
                                          "6/5",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        linearGradient: LinearGradient(
                                          colors: [
                                            const Color(0xff5B5B5B),
                                            const Color(0xff5B5B5B)
                                                .withOpacity(.44),
                                          ],
                                        ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                    const SizedBox(height: 20),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "FB Target / ",
                                            style: GoogleFonts.ptSans(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            // recognizer: TapGestureRecognizer()
                                            //   ..onTap = () => Get.toNamed(
                                            //       AppPages.FB_DEEP_DIVE_SCREEN),
                                            text: "FB Achieved",
                                            style: GoogleFonts.ptSans(
                                              color: AppColors.primary,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TableData extends StatefulWidget {
  const TableData({super.key});

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  final TableRow _tableRow = const TableRow(children: <Widget>[
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Channel Name",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Seller Type",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "DSE Code",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Last Visited",
        style: TextStyle(color: AppColors.primary),
      ),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        border: TableBorder.all(
          width: .5,
          color: Colors.grey[300]!,
          // borderRadius: BorderRadius.circular(8),
        ),
        defaultColumnWidth: const FlexColumnWidth(10.0),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: <TableRow>[_tableRow],
      ),
    );
  }
}
