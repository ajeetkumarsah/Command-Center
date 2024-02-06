import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/summary_model.dart';

class TrendsYValue {
  final String rvValue;
  final double range;
  TrendsYValue({required this.rvValue, required this.range});
}

class RetailingGraphWidget extends StatefulWidget {
  final List<Trend> trendsData;
  final bool salesValue;
  final double maxValue;
  final double minValue;
  final double interval;
  final List<YAxisData> yAxisData;

  const RetailingGraphWidget(
      {super.key,
      required this.trendsData,
      required this.salesValue,
      required this.minValue,
      required this.maxValue,
      required this.interval,
      required this.yAxisData});

  @override
  State<RetailingGraphWidget> createState() => _RetailingGraphWidgetState();
}

class _RetailingGraphWidgetState extends State<RetailingGraphWidget> {
  int touchedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: widget.trendsData.isNotEmpty
          ? widget.salesValue
              ? BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      enabled: false,
                      // handleBuiltInTouches: true,
                      longPressDuration: const Duration(milliseconds: 100),
                      handleBuiltInTouches: true,
                      // allowTouchBarBackDraw: false,
                      // touchExtraThreshold: EdgeInsets.only(right: 30),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              barTouchResponse == null ||
                              barTouchResponse.spot == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex =
                              barTouchResponse.spot!.touchedBarGroupIndex;
                        });
                      },
                      touchTooltipData: BarTouchTooltipData(
                        // tooltipBgColor: Colors.blueGrey,
                        tooltipHorizontalAlignment:
                            FLHorizontalAlignment.center,
                        tooltipMargin: 0,
                        tooltipBgColor: AppColors.primary,
                        tooltipRoundedRadius: 100,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return touchedIndex == groupIndex
                              ? BarTooltipItem(
                                  getDataTitles(group.x.toDouble(),
                                      widget.trendsData, widget.salesValue),
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
                    titlesData: titlesData(widget.trendsData),
                    borderData: borderData,
                    barGroups: [
                      if (widget.trendsData.isNotEmpty)
                        ...widget.trendsData
                            .map(
                              (v) => BarChartGroupData(
                                x: v.index ?? 0,
                                barRods: [
                                  BarChartRodData(
                                    toY: widget.salesValue
                                        ? double.tryParse(v.cyRt ?? '0.0') ?? 0
                                        : double.tryParse(v.iya ?? '0.0') ?? 0,
                                    gradient: _barsGradient,
                                  )
                                ],
                                showingTooltipIndicators: [0],
                                groupVertically: true,
                              ),
                            )
                            .toList(),
                    ],
                    gridData: FlGridData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: widget.maxValue,
                    minY: widget.minValue,
                  ),
                )
              : LineChart(
                  LineChartData(
                    maxX: 13,
                    minX: 0,
                    maxY: widget.maxValue,
                    minY: 0,
                    baselineX: 1,
                    lineBarsData: [
                      LineChartBarData(
                        spots: widget.trendsData
                            .map(
                              (point) => FlSpot(
                                point.index?.toDouble() ?? 0,
                                double.tryParse((point.iya ?? '0.0')) ?? 0.0,
                              ),
                            )
                            .toList(),
                        isCurved: false,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              strokeColor: AppColors.primary,
                              color: Colors.white,
                              strokeWidth: 1.5,
                            );
                          },
                        ),
                        color: AppColors.primary,
                      ),
                    ],
                    lineTouchData: LineTouchData(
                        enabled: true,
                        touchCallback: (FlTouchEvent event,
                            LineTouchResponse? touchResponse) {},
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: AppColors.primaryDark,
                          tooltipRoundedRadius: 20.0,
                          showOnTopOfTheChartBoxArea: false,
                          fitInsideHorizontally: true,
                          fitInsideVertically: true,
                          tooltipMargin: 40,
                          tooltipHorizontalAlignment:
                              FLHorizontalAlignment.center,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map(
                              (LineBarSpot touchedSpot) {
                                const textStyle = TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                );
                                return LineTooltipItem(
                                  '${widget.trendsData[touchedSpot.spotIndex].month}\n${double.tryParse((widget.trendsData[touchedSpot.spotIndex].iya ?? '0.0'))?.toStringAsFixed(2) ?? '0.0'}',
                                  textStyle,
                                );
                              },
                            ).toList();
                          },
                        ),
                        getTouchedSpotIndicator:
                            (LineChartBarData barData, List<int> indicators) {
                          return indicators.map(
                            (int index) {
                              final line = FlLine(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                  dashArray: [2, 4]);
                              return TouchedSpotIndicatorData(
                                line,
                                FlDotData(show: false),
                              );
                            },
                          ).toList();
                        },
                        getTouchLineEnd: (_, __) => double.infinity),
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(width: .5),
                            left: BorderSide(width: .5))),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: _bottomTitles(widget.trendsData),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 45,
                          interval: widget.interval,
                          getTitlesWidget: (value, meta) =>
                              getLeftLineTitles(value, meta, widget.trendsData),
                        ),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                )
          : const SizedBox(),
    );
  }

  SideTitles _bottomTitles(List<Trend> trendsList) => SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          for (var v in trendsList) {
            if (value.toInt() == v.index) {
              text = v.month ?? '';
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
  Widget getLeftLineTitles(
      double value, TitleMeta meta, List<Trend> yaxisData) {
    final style = GoogleFonts.ptSans(
      color: AppColors.black,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );
    String text = '';
    for (var v in yaxisData) {
      text = v.iya ?? '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget getTitles(double value, TitleMeta meta, List<Trend> trendsModel) {
    final style = GoogleFonts.ptSans(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text = '';
    for (var v in trendsModel) {
      if (value.toInt() == v.index) {
        text = v.month ?? '';
      }
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 5,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget getLeftTitles(
      double value, TitleMeta meta, List<YAxisData> yaxisData) {
    final style = GoogleFonts.ptSans(
      color: AppColors.black,
      fontWeight: FontWeight.w300,
      fontSize: 11,
    );
    String text = '';
    for (var v in yaxisData) {
      if (value == v.yAbs) {
        text = v.yRv ?? '';
      }
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  String getHintTitles(double value, List<Trend> trendsModel) {
    String text = '';
    for (var v in trendsModel) {
      if (value.toInt() == v.index) {
        text = v.month ?? '';
      }
    }
    return text;
  }

  String getDataTitles(double value, List<Trend> trendsModel, bool isSales) {
    String text = '';
    for (var v in trendsModel) {
      if (value.toInt() == v.index) {
        text = '${v.month}\n${isSales ? v.cyRtRv ?? '' : v.iya ?? ''}';
      }
    }
    return text;
  }

  FlTitlesData titlesData(List<Trend> trendsModel) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 45,
            getTitlesWidget: (d, meta) => getTitles(d, meta, trendsModel),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 53,
            interval: widget.interval != 0 ? widget.interval : 1,
            getTitlesWidget: (value, meta) =>
                getLeftTitles(value, meta, widget.yAxisData),
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 15,
            getTitlesWidget: (d, w) => const SizedBox(width: 12),
          ),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(
            width: 1,
            color: AppColors.borderColor,
          ),
        ),
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppColors.contentColorBlue,
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
