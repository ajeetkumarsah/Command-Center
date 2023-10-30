import 'dart:html';

import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class LineChartSample extends StatefulWidget {
  const LineChartSample({super.key});

  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  int showingTooltipSpot = -1;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransportationProvider>(context);
    if (provider.graphDataList!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      List<FlSpot> chartData = List.generate(
        provider.graphDataList!.length,
        (index) => FlSpot(index.toDouble(), provider.graphDataList![index]["data"].toDouble()),
      );
      // List<ShowingTooltipIndicators> dataIntList = provider.garphDataList!
      //     .map<ShowingTooltipIndicators>((item) => (item['data'] is double) ? item['data'].toInt() : item['data'])
      //     .toList();

      final _lineBarsData = [
          LineChartBarData(
            show: true,
            preventCurveOverShooting: false,
            isStrokeJoinRound: true,
            barWidth: 1.0,
            spots: chartData,
            isCurved: false,
            color: MyColors.iconColorBlue,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  strokeWidth: 2,
                  strokeColor: Colors.blue,
                  color: Colors.white,
                );
              },
            ),
            // dotData: const FlDotData(
            //
            //   show: true,
            // ),
            belowBarData: BarAreaData(
              // spotsLine: BarAreaSpotsLine(show: true),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(143, 159, 255, 0.464),
                  Color.fromRGBO(170, 183, 255, 0.464),
                  Color.fromRGBO(152, 215, 229, 0.304),
                  Color.fromRGBO(105, 194, 213, 0),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
              show: true,
            ),
          ),
      ];

      return Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: LineChart(
          LineChartData(
            showingTooltipIndicators: showingTooltipSpot != -1 ? [ShowingTooltipIndicators([
              LineBarSpot(_lineBarsData[0], showingTooltipSpot,
                  _lineBarsData[0].spots[showingTooltipSpot]),
            ])] : [],
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blue,
                tooltipRoundedRadius: 20.0,
                fitInsideHorizontally: true,
                tooltipMargin: 0,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                      const textStyle = TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      );
                      return LineTooltipItem(
                        chartData[touchedSpot.spotIndex].y.toStringAsFixed(2),
                        textStyle,
                      );
                    },
                  ).toList();
                },
              ),
              handleBuiltInTouches: false,
              touchCallback: (event, response) {
                  setState(() {
                    final spotIndex = response?.lineBarSpots?[0].spotIndex ?? -1;
                      showingTooltipSpot = spotIndex;
                  });
              },
            ),
            // lineTouchData: LineTouchData(
            //     enabled: true,
            //     touchCallback: (_, __) => true,
            //     touchTooltipData: LineTouchTooltipData(
            //       tooltipBgColor: Colors.blue,
            //       tooltipRoundedRadius: 20.0,
            //       showOnTopOfTheChartBoxArea: true,
            //       fitInsideHorizontally: true,
            //       tooltipMargin: 0,
            //       getTooltipItems: (touchedSpots) {
            //         return touchedSpots.map(
            //               (LineBarSpot touchedSpot) {
            //             const textStyle = TextStyle(
            //               fontSize: 10,
            //               fontWeight: FontWeight.w700,
            //               color: Colors.white,
            //             );
            //             return LineTooltipItem(
            //               chartData[touchedSpot.spotIndex].y.toStringAsFixed(2),
            //               textStyle,
            //             );
            //           },
            //         ).toList();
            //       },
            //     ),
            //     // getTouchedSpotIndicator:
            //     //     (LineChartBarData barData, List<int> indicators) {
            //     //   return indicators.map(
            //     //         (int index) {
            //     //       final line = const FlLine(
            //     //           color: Colors.grey,
            //     //           strokeWidth: 1,
            //     //           dashArray: [2, 4]);
            //     //       return TouchedSpotIndicatorData(
            //     //         line,
            //     //         FlDotData(show: true),
            //     //       );
            //     //     },
            //     //   ).toList();
            //     // },
            //     // getTouchLineEnd: (_, __) => double.infinity
            // ),
            borderData: FlBorderData(
              show: false,
            ),
            baselineX: 10.0,
            // clipData: FlClipData(top: true, bottom: false, left: true, right: false),
            gridData: FlGridData(show: true,),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
              )), // Hide left titles
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide right titles
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), // Show top titles
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, TitleMeta) {
                        // print(value);
                        if (value.toInt() >= 0 && value.toInt() < provider.graphDataList!.length) {
                          return Transform.rotate(
                            angle: -math.pi / 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 10.0),
                              child: Text(
                                "${provider.graphDataList![value.toInt()]['month']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink(); // Return an empty widget if the value is out of range.
                      })), // Hide bottom titles
            ),
            lineBarsData: _lineBarsData,
          ),
        ),
      );
    }
  }
}
