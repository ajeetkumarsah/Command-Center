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
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: widget.trendsData.isNotEmpty
          ? BarChart(
              BarChartData(
                barTouchData: barTouchData(widget.trendsData),
                titlesData: titlesData(widget.trendsData),
                borderData: borderData,
                barGroups: barGroups(widget.trendsData),
                gridData: FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: widget.maxValue,
                minY: widget.minValue,
              ),
            )
          : const SizedBox(),
    );
  }

  BarTouchData barTouchData(List<Trend> trendList) => BarTouchData(
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
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: 0,
          tooltipBgColor: AppColors.primary,
          tooltipRoundedRadius: 100,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return touchedIndex == groupIndex
                ? BarTooltipItem(
                    getDataTitles(group.x.toDouble(),
                        trendList), //${getHintTitles(group.x.toDouble(), trendList)} :
                    const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  )
                : null;
          },
        ),
      );

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
      fontSize: 12,
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

  String getDataTitles(double value, List<Trend> trendsModel) {
    String text = '';
    for (var v in trendsModel) {
      if (value.toInt() == v.index) {
        text = v.cyRtRv ?? '';
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
            reservedSize: 50,
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

  List<BarChartGroupData> barGroups(List<Trend> trendsData) => [
        if (trendsData.isNotEmpty)
          ...trendsData
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
      ];
}
