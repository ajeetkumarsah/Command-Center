import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/new_appbar.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/widgets/tab_item_widget.dart';

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
            backgroundColor: AppColors.bgLight,
            body: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 308,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                        children: [
                          ListTile(
                            title: Text(
                              'Monthly Trend - Calls',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                chartItem(
                                    color: Colors.grey, title: 'Targeted'),
                                chartItem(color: Colors.red, title: 'Billed'),
                                chartItem(color: Colors.blue, title: 'Placed'),
                                chartItem(color: Colors.green, title: 'Prod.'),
                                chartItem(
                                    color: AppColors.contentColorPink,
                                    title: 'CCR'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: LineChart(
                              sampleData1,
                              // swapAnimationDuration:
                              //     const Duration(milliseconds: 500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 318,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 8),
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                        children: [
                          ListTile(
                            title: Text(
                              'Monthly Trend - Calls',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                            ),
                          ),
                          Container(
                            height: .5,
                            color: AppColors.tableBorder,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Seller Type',
                                  style: GoogleFonts.inter(
                                    color: AppColors.primaryDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                width: .5,
                                color: AppColors.tableBorder,
                                height: 60,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .12,
                                child: Center(
                                  child: Text(
                                    'On Route',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: .5,
                                color: AppColors.tableBorder,
                                height: 60,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .32,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              'Calls',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryDark,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: AppColors.tableBorder,
                                      height: .5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    'Placed',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.primaryDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: .5,
                                                color: AppColors.tableBorder,
                                                height: 30,
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    'CCR',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.primaryDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: .5,
                                                color: AppColors.tableBorder,
                                                height: 30,
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    'Prod',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.primaryDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: .5,
                                color: AppColors.tableBorder,
                                height: 60,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .15,
                                child: Center(
                                  child: Text(
                                    'In-Store Time (min)',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: .5,
                            color: AppColors.tableBorder,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Expanded(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(secondary: Colors.white)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    tableRow(context,
                                        color: AppColors.storeTableRowColor),
                                    tableRow(context),
                                    tableRow(context,
                                        color: AppColors.storeTableRowColor),
                                    tableRow(context),
                                    tableRow(context,
                                        color: AppColors.storeTableRowColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tableRow(BuildContext context, {Color color = AppColors.white}) {
    return Container(
      color: color,
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Field Seller CDADH_M5104',
              style: GoogleFonts.inter(
                color: AppColors.primaryDark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: .5,
            color: AppColors.tableBorder,
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .12,
            child: Center(
              child: Text(
                '9',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ),
          Container(
            width: .5,
            color: AppColors.tableBorder,
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .32,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '9',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: .5,
                  color: AppColors.tableBorder,
                  height: 40,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '9',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: .5,
                  color: AppColors.tableBorder,
                  height: 40,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '7',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: .5,
            color: AppColors.tableBorder,
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .15,
            child: Center(
              child: Text(
                '33.06',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
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

  FlGridData get gridData => FlGridData(show: false);
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
