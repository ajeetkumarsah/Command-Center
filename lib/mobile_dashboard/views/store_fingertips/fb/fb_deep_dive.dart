import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_fb_controller.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_fb_trends_model.dart';

class FBDeepDiveScreen extends StatefulWidget {
  const FBDeepDiveScreen({super.key});

  @override
  State<FBDeepDiveScreen> createState() => _FBDeepDiveScreenState();
}

class _FBDeepDiveScreenState extends State<FBDeepDiveScreen> {
  final double width = 7;

  int touchedIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreFBController>(
      init: StoreFBController(storeFBRepo: Get.find()),
      builder: (ctlr) {
        return SingleChildScrollView(
          child: !ctlr.isLoading && ctlr.storeFBTrendsModel != null
              ? Column(
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
                                ctlr.storeFBCategoryModel.first.fbTarget ?? '',
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
                                  ctlr.storeFBCategoryModel.first
                                          .fbPointsAchieved ??
                                      '',
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
                          const SizedBox(height: 20),
                          Expanded(
                            child: BarChart(
                              BarChartData(
                                maxY:
                                    ctlr.storeFBTrendsModel?.yMax?.toDouble() ??
                                        0.0,
                                // barTouchData: BarTouchData(
                                //   touchTooltipData: BarTouchTooltipData(
                                //     tooltipBgColor: Colors.grey,
                                //     getTooltipItem: (a, b, c, d) => null,
                                //   ),
                                //   touchCallback:
                                //       (FlTouchEvent event, response) {
                                //     if (response == null ||
                                //         response.spot == null) {
                                //       touchedGroupIndex = -1;
                                //       return;
                                //     }
                                //     touchedGroupIndex =
                                //         response.spot!.touchedBarGroupIndex;
                                //   },
                                // ),
                                minY: 0,
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: _bottomTitles(
                                        ctlr.storeFBTrendsModel!.data),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 45,
                                      interval:
                                          ctlr.storeFBTrendsModel?.yInterval ??
                                              1,
                                      getTitlesWidget: (value, meta) =>
                                          getLeftLineTitles(
                                              value,
                                              meta,
                                              ctlr.storeFBTrendsModel!
                                                  .yAxisData),
                                    ),
                                  ),
                                ),
                                barTouchData: BarTouchData(
                                  enabled: false,
                                  // handleBuiltInTouches: true,
                                  longPressDuration:
                                      const Duration(milliseconds: 100),
                                  handleBuiltInTouches: true,
                                  // allowTouchBarBackDraw: false,
                                  // touchExtraThreshold: EdgeInsets.only(right: 30),
                                  touchCallback:
                                      (FlTouchEvent event, barTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          barTouchResponse == null ||
                                          barTouchResponse.spot == null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = barTouchResponse
                                          .spot!.touchedBarGroupIndex;
                                    });
                                  },
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipHorizontalAlignment:
                                        FLHorizontalAlignment.center,
                                    tooltipMargin: 30,
                                    tooltipBgColor: AppColors.primary,
                                    tooltipRoundedRadius: 100,
                                    getTooltipItem:
                                        (group, groupIndex, rod, rodIndex) {
                                      return touchedIndex == groupIndex
                                          ? BarTooltipItem(
                                              getDataTitles(
                                                  group.x.toDouble(),
                                                  ctlr.storeFBTrendsModel!.data,
                                                  true),
                                              const TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            )
                                          : null;
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: [
                                  ...ctlr.storeFBTrendsModel!.data
                                      .asMap()
                                      .map(
                                        (key, value) => MapEntry(
                                          key,
                                          makeGroupData(
                                              value.index ?? 0,
                                              double.tryParse(
                                                      value.fbTarget ?? '') ??
                                                  0.0,
                                              double.tryParse(
                                                      value.fbPointsAchieved ??
                                                          '') ??
                                                  0.0),
                                        ),
                                      )
                                      .values
                                      .toList()
                                ],
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
                          ...ctlr.storeFBCategoryModel
                              .asMap()
                              .map(
                                (i, e) => MapEntry(
                                  i,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: i ==
                                              ctlr.storeFBCategoryModel.length -
                                                  1
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
                                              e.brandName ?? '',
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Icon(
                                              e.targetAchieved ?? false
                                                  ? Icons.check
                                                  : Icons.close,
                                              color: e.targetAchieved ?? false
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
                )
              : const Center(child: CustomLoader()),
        );
      },
    );
  }

  String getDataTitles(
      double value, List<FBTrendsModel> trendsModel, bool fbAchieved) {
    String text = '';
    for (var v in trendsModel) {
      if (value.toInt() == v.index) {
        text =
            '${v.monthYear}\n${fbAchieved ? v.fbPointsAchieved : v.fbTarget ?? ''}';
      }
    }
    return text;
  }

  Widget getLeftLineTitles(
      double value, TitleMeta meta, List<YAxisDataModel> yAxisData) {
    final style = GoogleFonts.ptSans(
      color: AppColors.primary,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );
    String text = '';
    for (var v in yAxisData) {
      if (value == double.tryParse(v.yAbs ?? '0.0')) {
        text = v.yAbs ?? '';
      }
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  SideTitles _bottomTitles(List<FBTrendsModel> trendsList) => SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          for (var v in trendsList) {
            if (value.toInt() == v.index) {
              text = v.monthYear ?? '';
            }
          }
          final style = GoogleFonts.ptSans(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          );
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 4,
            angle: 35,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  text,
                  style: style,
                ),
              ),
            ),
          );
        },
      );
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
}

class StaticGraph {
  final double xValue;
  final double yValue;

  StaticGraph({required this.xValue, required this.yValue});
}
