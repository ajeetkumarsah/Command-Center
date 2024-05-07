import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_fb_controller.dart';

class FBDeepDiveScreen extends StatefulWidget {
  const FBDeepDiveScreen({super.key});

  @override
  State<FBDeepDiveScreen> createState() => _FBDeepDiveScreenState();
}

class _FBDeepDiveScreenState extends State<FBDeepDiveScreen> {
  final StoreFBController fbCtlr =
      Get.put(StoreFBController(storeFBRepo: Get.find()));
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  @override
  void initState() {
    super.initState();
    fbCtlr.getFBData(distributor: '', branch: '', channel: '', store: '');
    fbCtlr.getFBData(
        type: 'trends', distributor: '', branch: '', channel: '', store: '');
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);
    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    List<StaticBrand> brandList = [
      StaticBrand(title: 'Ambi Pure', status: false),
      StaticBrand(title: 'Gurad', status: true),
      StaticBrand(title: 'Pampers', status: false),
      StaticBrand(title: 'Pantene', status: false),
      StaticBrand(title: 'Vicks', status: true),
      StaticBrand(title: 'Whisper', status: true),
    ];

    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return SingleChildScrollView(
          child: fbCtlr.isLoading
              ? const Center(child: CustomLoader())
              : Column(
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
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: GoogleFonts.inter(
                    //           color: const Color(0xff0B4983),
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5.0),
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         offset: const Offset(0, 4),
                    //         blurRadius: 15,
                    //         color: AppColors.black.withOpacity(.25),
                    //       ),
                    //     ],
                    //   ),
                    //   child: GridView.builder(
                    //     itemCount: 2,
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemBuilder: (context, index) => Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           index == 0 ? 'FB Target' : 'FB Achieved',
                    //           style: GoogleFonts.inter(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500,
                    //             color: AppColors.storeTextColor,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 8),
                    //         InnerShadow(
                    //           blur: 4,
                    //           offset: const Offset(4, 4),
                    //           color: AppColors.black.withOpacity(.25),
                    //           child: Container(
                    //             height: 30,
                    //             width: 160,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(100),
                    //               color: const Color(0xff7CA0DF),
                    //               // boxShadow: [
                    //               //   BoxShadow(
                    //               //     offset: const Offset(4, 4),
                    //               //     blurRadius: 4,
                    //               //     spreadRadius: -4,
                    //               //     color: AppColors.black.withOpacity(.25),
                    //               //   ),
                    //               // ],
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 index == 0
                    //                     ? '${ctlr.getFBTarget()}%'
                    //                     : '${ctlr.getFBAchieved()}%',
                    //                 style: GoogleFonts.inter(
                    //                   color: AppColors.white,
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w600,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 2,
                    //       childAspectRatio: 1.8,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                '6',
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                'FB Target',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.greyTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 1,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  '10',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                subtitle: Text(
                                  'FB Achieved',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.greyTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 4),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Monthly Trend',
                                  style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Text(
                                'in thousands',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 12),
                            child: Row(
                              children: [
                                const SizedBox(width: 12),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: AppColors.borderColor),
                                  height: 10,
                                  width: 10,
                                  margin: const EdgeInsets.only(right: 8),
                                ),
                                Flexible(
                                  child: Text(
                                    'Target',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: AppColors.sfPrimary),
                                  height: 10,
                                  width: 10,
                                  margin: const EdgeInsets.only(
                                    right: 8,
                                    left: 16,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Achieved',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: BarChart(
                              BarChartData(
                                maxY: 20,
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.grey,
                                    getTooltipItem: (a, b, c, d) => null,
                                  ),
                                  touchCallback:
                                      (FlTouchEvent event, response) {
                                    if (response == null ||
                                        response.spot == null) {
                                      // setState(() {
                                      touchedGroupIndex = -1;
                                      showingBarGroups = List.of(rawBarGroups);
                                      // });
                                      return;
                                    }

                                    touchedGroupIndex =
                                        response.spot!.touchedBarGroupIndex;

                                    // setState(() {
                                    //   if (!event.isInterestedForInteractions) {
                                    //     touchedGroupIndex = -1;
                                    //     showingBarGroups = List.of(rawBarGroups);
                                    //     return;
                                    //   }
                                    //   showingBarGroups = List.of(rawBarGroups);
                                    //   if (touchedGroupIndex != -1) {
                                    //     var sum = 0.0;
                                    //     for (final rod
                                    //         in showingBarGroups[touchedGroupIndex]
                                    //             .barRods) {
                                    //       sum += rod.toY;
                                    //     }
                                    //     final avg = sum /
                                    //         showingBarGroups[touchedGroupIndex]
                                    //             .barRods
                                    //             .length;

                                    //     showingBarGroups[touchedGroupIndex] =
                                    //         showingBarGroups[touchedGroupIndex]
                                    //             .copyWith(
                                    //       barRods: showingBarGroups[touchedGroupIndex]
                                    //           .barRods
                                    //           .map((rod) {
                                    //         return rod.copyWith(
                                    //           toY: avg,
                                    //           color: AppColors.borderColor,
                                    //         );
                                    //       }).toList(),
                                    //     );
                                    //   }
                                    // });
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: bottomTitles,
                                      reservedSize: 42,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 28,
                                      interval: 1,
                                      getTitlesWidget: leftTitles,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: showingBarGroups,
                                gridData: const FlGridData(show: false),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      // padding: ,
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                              color: Color(0xffF2F6FD),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Brand Name',
                                      style: GoogleFonts.inter(
                                        color: AppColors.storeTextLightColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'FB Ach',
                                      style: GoogleFonts.inter(
                                        color: AppColors.storeTextLightColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...brandList
                              .asMap()
                              .map(
                                (i, e) => MapEntry(
                                  i,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: i == brandList.length - 1
                                          ? const BorderRadius.only(
                                              bottomLeft: Radius.circular(5.0),
                                              bottomRight: Radius.circular(5.0),
                                            )
                                          : null,
                                      color: i % 2 == 0
                                          ? Colors.white
                                          : const Color(0xffF2F6FD),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              e.title,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Icon(
                                              e.status
                                                  ? Icons.check
                                                  : Icons.close,
                                              color: e.status
                                                  ? AppColors.green
                                                  : AppColors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
        );
      },
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: AppColors.bgLight,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: AppColors.primary,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}

class StaticGraph {
  final double xValue;
  final double yValue;

  StaticGraph({required this.xValue, required this.yValue});
}

class StaticBrand {
  final String title;
  final bool status;

  StaticBrand({
    required this.title,
    required this.status,
  });
}
