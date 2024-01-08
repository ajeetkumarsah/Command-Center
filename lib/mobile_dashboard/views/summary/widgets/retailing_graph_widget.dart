import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/trends_model.dart';

class RetailingGraphWidget extends StatefulWidget {
  final TrendsModel trendsData;
  final bool salesValue;
  const RetailingGraphWidget(
      {super.key, required this.trendsData, required this.salesValue});

  @override
  State<RetailingGraphWidget> createState() => _RetailingGraphWidgetState();
}

class _RetailingGraphWidgetState extends State<RetailingGraphWidget> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData(widget.trendsData),

          titlesData: titlesData(widget.trendsData),
          borderData: borderData,
          barGroups: barGroups(widget.trendsData),
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          // maxY: trendsData.yMax ,
        ),
      ),
    );
  }

  BarTouchData barTouchData(TrendsModel trendsModel) => BarTouchData(
        enabled: false,
        // handleBuiltInTouches: true,
        longPressDuration: const Duration(milliseconds: 100),
        handleBuiltInTouches: false,
        allowTouchBarBackDraw: true,
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
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -4,
          tooltipBgColor: AppColors.bgLight,
          tooltipRoundedRadius: 6,

          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return touchedIndex == groupIndex
                ? BarTooltipItem(
                    ' ${getHintTitles(group.x.toDouble(), trendsModel)} : ${rod.toY.abs().round().toString()}',
                    const TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                : null;
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta, TrendsModel trendsModel) {
    final style = GoogleFonts.ptSans(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = '';
    for (var v in trendsModel.data!) {
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

  String getHintTitles(double value, TrendsModel trendsModel) {
    String text = '';
    for (var v in trendsModel.data!) {
      if (value.toInt() == v.index) {
        text = v.month ?? '';
      }
    }
    return text;
  }

  FlTitlesData titlesData(TrendsModel trendsModel) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (d, meta) => getTitles(d, meta, trendsModel),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 15,
            getTitlesWidget: (d, w) => const SizedBox(width: 12),
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

  List<BarChartGroupData> barGroups(TrendsModel trendsData) => [
        if (trendsData.data != null)
          ...trendsData.data!
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
