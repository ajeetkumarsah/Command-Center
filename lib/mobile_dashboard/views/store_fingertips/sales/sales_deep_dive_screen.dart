import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';

class SalesDeepDiveScreen extends StatelessWidget {
  const SalesDeepDiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 78,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withOpacity(.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0.71%',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'SRN%',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    color: AppColors.tableBorder,
                    height: 60,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '8.91%',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          'Scheme Earning',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(bottom: 8),
              margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withOpacity(.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // padding: const EdgeInsets.symmetric(vertical: 4.0),

                    color: ctlr.salesTableShowMore
                        ? AppColors.white
                        : AppColors.storeTableRowColor,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .27,
                          child: Center(
                            child: Text(
                              'DSE Code',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyTextColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: .5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xffCCCCCC).withOpacity(0),
                                const Color(0xffC8C8C8),
                                const Color(0xffC8C8C8),
                                const Color(0xffCCCCCC).withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .27,
                          child: Center(
                            child: Text(
                              'P3M Retailing Avg',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyTextColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: .5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xffCCCCCC).withOpacity(0),
                                const Color(0xffC8C8C8),
                                const Color(0xffC8C8C8),
                                const Color(0xffCCCCCC).withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .27,
                          child: Center(
                            child: Text(
                              'Retailing AHC',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyTextColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: .5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xffCCCCCC).withOpacity(0),
                                const Color(0xffC8C8C8),
                                const Color(0xffC8C8C8),
                                const Color(0xffCCCCCC).withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: const Icon(
                              Icons.swap_vert_rounded,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (ctlr.salesTableShowMore)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.storeTableRowColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          tableRow(context),
                        ],
                      ),
                    ),
                  GestureDetector(
                    onTap: () => ctlr.onSalesTableShowMore(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          ctlr.salesTableShowMore
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 418,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 8),
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff000000).withOpacity(.1),
                      blurRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      onTap: (v) {},
                      indicatorWeight: 3,
                      indicatorColor: AppColors.black,
                      tabs: [
                        Tab(
                          icon: Text(
                            'Retailing Trends',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Tab(
                          icon: Text(
                            'Product Level',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const TabBarView(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   children: [
                    //     Icon(Icons.flight, size: 50),
                    //     Icon(Icons.directions_transit, size: 50),
                    //   ],
                    // ),
                    ListTile(
                        title: Text(
                          'Sales Value Trends',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(5),
                            border: Border(
                              top: BorderSide(
                                width: .5,
                                color: AppColors.lightGrey,
                              ),
                              bottom: BorderSide(
                                width: .5,
                                color: AppColors.lightGrey,
                              ),
                              left: BorderSide(
                                width: .5,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.filter_alt_outlined,
                                color: AppColors.primary,
                              ),
                              Text(
                                'Category',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                      height: .5,
                      color: AppColors.tableBorder,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget tableRow(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 4.0),
      color: AppColors.storeTableRowColor,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Center(
              child: Text(
                'CGADH_MS104',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffCCCCCC).withOpacity(0),
                  const Color(0xffC8C8C8),
                  const Color(0xffC8C8C8),
                  const Color(0xffCCCCCC).withOpacity(0),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Center(
              child: Text(
                '38,889',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffCCCCCC).withOpacity(0),
                  const Color(0xffC8C8C8),
                  const Color(0xffC8C8C8),
                  const Color(0xffCCCCCC).withOpacity(0),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Center(
              child: Text(
                '₹ 66,186',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            width: .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xffCCCCCC).withOpacity(0),
                  const Color(0xffC8C8C8),
                  const Color(0xffC8C8C8),
                  const Color(0xffCCCCCC).withOpacity(0),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 4),
              Text(
                '20%',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
              Icon(Icons.arrow_upward_sharp, color: AppColors.green, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 1),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 10,
        maxY: 5,
        minY: 0,
      );
  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (v, w) {
              return const SizedBox(width: 8);
            },
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );
  Widget chartItem({required Color color, required String title}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 12,
          width: 5,
          color: color,
          margin: const EdgeInsets.only(right: 8),
        ),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1';
        break;
      case 2:
        text = '2';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '4';
        break;
      case 5:
        text = '5';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 30,
      );
  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jun', style: style);
        break;
      case 7:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Aug', style: style);
        break;
      case 9:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Oct', style: style);
        break;
      case 11:
        text = const Text('Nov', style: style);
        break;
      case 12:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: RotatedBox(quarterTurns: 3, child: text),
    );
  }

  FlGridData get gridData => FlGridData(
        show: true,
        drawHorizontalLine: false,
      );
  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );
  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
        lineChartBarData1_4,
        lineChartBarData1_5,
      ];
  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorGreen,
        barWidth: 4,
        isStrokeCapRound: false,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 1.5,
              strokeColor: AppColors.white,
              color: Colors.white,
              strokeWidth: 0,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1.2),
          FlSpot(2, 1.2),
          FlSpot(3, 1.8),
          FlSpot(4, 1.2),
          FlSpot(5, 1.2),
          FlSpot(6, 1.2),
          FlSpot(7, 1.2),
          FlSpot(8, 1.2),
          FlSpot(9, 1.2),
          FlSpot(10, 1.2),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorPink,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 1.5,
              strokeColor: AppColors.white,
              color: Colors.white,
              strokeWidth: 0,
            );
          },
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(2, 1),
          FlSpot(3, 1),
          FlSpot(4, 1),
          FlSpot(5, 1),
          FlSpot(6, 1),
          FlSpot(7, 1),
          FlSpot(8, 1),
          FlSpot(9, 1),
          FlSpot(10, 1),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: false,
        color: Colors.blue,
        barWidth: 4,
        isStrokeCapRound: false,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 1.5,
              strokeColor: AppColors.white,
              color: Colors.white,
              strokeWidth: 0,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2),
          FlSpot(2, 2),
          FlSpot(3, 2),
          FlSpot(4, 2),
          FlSpot(5, 2),
          FlSpot(6, 2),
          FlSpot(7, 2),
          FlSpot(8, 2),
          FlSpot(9, 2),
          FlSpot(10, 2),
        ],
      );

  LineChartBarData get lineChartBarData1_4 => LineChartBarData(
        isCurved: false,
        curveSmoothness: 0,
        color: Colors.red,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 1.5,
              strokeColor: AppColors.white,
              color: Colors.white,
              strokeWidth: 0,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3),
          FlSpot(2, 3),
          FlSpot(3, 3),
          FlSpot(4, 3),
          FlSpot(5, 3),
          FlSpot(6, 3),
          FlSpot(7, 3),
          FlSpot(8, 3),
          FlSpot(9, 3),
          FlSpot(10, 3),
        ],
      );

  LineChartBarData get lineChartBarData1_5 => LineChartBarData(
        isCurved: false,
        color: Colors.grey,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 1.5,
              strokeColor: AppColors.white,
              color: Colors.white,
              strokeWidth: 0,
            );
          },
        ),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 4),
          FlSpot(2, 4),
          FlSpot(3, 4),
          FlSpot(4, 4),
          FlSpot(5, 4),
          FlSpot(6, 4),
          FlSpot(7, 4),
          FlSpot(8, 4),
          FlSpot(9, 4),
          FlSpot(10, 4),
        ],
      );
}
