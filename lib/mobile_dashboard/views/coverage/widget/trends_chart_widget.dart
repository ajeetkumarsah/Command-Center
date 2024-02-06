import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/coverage_trends_model.dart';

class CoverageTrendsChartWidget extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onFilterTap;
  final bool isExpanded;
  final String title;
  final List<CoverageTrendsModel> trendsList;
  final String summaryType;
  final String? subtitle;
  final Widget? coverageWidget;
  const CoverageTrendsChartWidget(
      {super.key,
      required this.title,
      this.onTap,
      this.onFilterTap,
      required this.isExpanded,
      this.coverageWidget,
      required this.summaryType,
      required this.trendsList,
      this.subtitle});

  @override
  State<CoverageTrendsChartWidget> createState() =>
      _CustomExpandedChartWidgetState();
}

class _CustomExpandedChartWidgetState extends State<CoverageTrendsChartWidget> {
  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.isExpanded
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: SizedBox(
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.title,
                                style: GoogleFonts.ptSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Hero(
                              tag: widget.title,
                              child: const Icon(
                                Icons.keyboard_double_arrow_down_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.white,
                        boxShadow: widget.isExpanded
                            ? [
                                BoxShadow(
                                  color: Colors.grey[300]!,
                                  blurRadius: 3,
                                  offset: const Offset(3, 3),
                                ),
                                BoxShadow(
                                  color: Colors.grey[300]!,
                                  blurRadius: 3,
                                  offset: const Offset(-3, -3),
                                ),
                              ]
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: widget.onFilterTap,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    ctlr.selectedCoverageTrends,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: GoogleFonts.ptSans(
                                                      fontSize: 14,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: widget.onFilterTap,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 4.0),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 16,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4,
                                                          bottom: 4),
                                                  child: Text(
                                                    ctlr.coverageTrendsValue,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: GoogleFonts
                                                        .ptSansCaption(
                                                            fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: widget.onFilterTap,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(4.0),
                                    //     child: Text(
                                    //       ctlr.selectedCoverageTrends,
                                    //       overflow: TextOverflow.ellipsis,
                                    //       maxLines: 1,
                                    //       style: GoogleFonts.ptSans(
                                    //         fontSize: 16,
                                    //         color: AppColors.primary,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // GestureDetector(
                                    //   onTap: widget.onFilterTap,
                                    //   child: const Padding(
                                    //     padding: EdgeInsets.symmetric(
                                    //         horizontal: 2, vertical: 4.0),
                                    //     child: Icon(
                                    //       Icons.edit,
                                    //       size: 16,
                                    //       color: AppColors.primary,
                                    //     ),
                                    //   ),
                                    // ),

                                    widget.coverageWidget ?? const SizedBox(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: widget.trendsList.isNotEmpty &&
                                        widget.trendsList[0].data != null
                                    ? LineChart(
                                        LineChartData(
                                          maxX: 13,
                                          minX: 0,
                                          maxY: widget.trendsList[0].yPerMax,
                                          minY: 0,
                                          baselineX: 1,
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: widget.trendsList[0].data!
                                                  .asMap()
                                                  .map(
                                                    (i, point) => MapEntry(
                                                      i,
                                                      FlSpot(
                                                        i.toDouble(),
                                                        ctlr.selectedCoverageTrendsFilter ==
                                                                'Billing %'
                                                            ? double.tryParse(
                                                                    (point.billingPer ??
                                                                        '0.0')) ??
                                                                0.0
                                                            : ctlr.selectedCoverageTrendsFilter ==
                                                                    'Prod %'
                                                                ? double.tryParse(
                                                                        (point.productivityPer ??
                                                                            '0.0')) ??
                                                                    0.0
                                                                : ctlr.selectedCoverageTrendsFilter ==
                                                                        'Call Hit Rate %'
                                                                    ? double.tryParse((point.ccPer ??
                                                                            '0.0')) ??
                                                                        0.0
                                                                    : 0.0,
                                                      ),
                                                    ),
                                                  )
                                                  .values
                                                  .toList(),
                                              isCurved: false,
                                              dotData: FlDotData(
                                                show: true,
                                                getDotPainter: (spot, percent,
                                                    barData, index) {
                                                  return FlDotCirclePainter(
                                                    radius: 4,
                                                    strokeColor:
                                                        AppColors.primary,
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
                                              touchCallback:
                                                  (FlTouchEvent event,
                                                      LineTouchResponse?
                                                          touchResponse) {},
                                              touchTooltipData:
                                                  LineTouchTooltipData(
                                                tooltipBgColor:
                                                    AppColors.primaryDark,
                                                tooltipRoundedRadius: 20.0,
                                                showOnTopOfTheChartBoxArea:
                                                    false,
                                                fitInsideHorizontally: true,
                                                fitInsideVertically: true,
                                                tooltipMargin: 40,
                                                tooltipHorizontalAlignment:
                                                    FLHorizontalAlignment
                                                        .center,
                                                getTooltipItems:
                                                    (touchedSpots) {
                                                  return touchedSpots.map(
                                                    (LineBarSpot touchedSpot) {
                                                      const textStyle =
                                                          TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      );
                                                      return LineTooltipItem(
                                                        '${widget.trendsList[0].data![touchedSpot.spotIndex].monthYear}\n${ctlr.selectedCoverageTrendsFilter == 'Billing %' ? widget.trendsList[0].data![touchedSpot.spotIndex].billingPer?.toString() ?? '0.0' : ctlr.selectedCoverageTrendsFilter == 'Prod %' ? double.tryParse((widget.trendsList[0].data![touchedSpot.spotIndex].productivityPer ?? '0.0'))?.toStringAsFixed(2) ?? '0.0' : ctlr.selectedCoverageTrendsFilter == 'Call Hit Rate %' ? double.tryParse((widget.trendsList[0].data![touchedSpot.spotIndex].ccPer ?? '0.0'))?.toStringAsFixed(2) ?? '0.0' : '0.0'}',
                                                        textStyle,
                                                      );
                                                    },
                                                  ).toList();
                                                },
                                              ),
                                              getTouchedSpotIndicator:
                                                  (LineChartBarData barData,
                                                      List<int> indicators) {
                                                return indicators.map(
                                                  (int index) {
                                                    final line = FlLine(
                                                        color: Colors.grey,
                                                        strokeWidth: 1,
                                                        dashArray: [4, 2]);
                                                    return TouchedSpotIndicatorData(
                                                      line,
                                                      FlDotData(
                                                        show: false,
                                                        getDotPainter: (spot,
                                                            percent,
                                                            barData,
                                                            index) {
                                                          return FlDotCirclePainter(
                                                            radius: 4,
                                                            strokeColor:
                                                                AppColors
                                                                    .primary,
                                                            color: Colors.white,
                                                            strokeWidth: 1.5,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ).toList();
                                              },
                                              getTouchLineEnd: (_, __) =>
                                                  double.infinity),
                                          borderData: FlBorderData(
                                              border: const Border(
                                                  bottom: BorderSide(width: .5),
                                                  left: BorderSide(width: .5))),
                                          gridData: FlGridData(show: false),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                              sideTitles: _bottomTitles(
                                                  widget.trendsList),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 45,
                                                interval: widget.trendsList[0]
                                                            .yPerInterval !=
                                                        0
                                                    ? widget.trendsList[0]
                                                        .yPerInterval
                                                    : 1,
                                                getTitlesWidget: (value,
                                                        meta) =>
                                                    getLeftTitles(
                                                        value,
                                                        meta,
                                                        widget.trendsList[0]
                                                                .yAxisDataPer ??
                                                            []),
                                              ),
                                            ),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(
                                        child: Center(
                                          child: Text('No Data Found!'),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                      boxShadow: widget.isExpanded
                          ? null
                          : [
                              BoxShadow(
                                color: Colors.grey[300]!,
                                blurRadius: 3,
                                offset: const Offset(3, 3),
                              ),
                              BoxShadow(
                                color: Colors.grey[300]!,
                                blurRadius: 3,
                                offset: const Offset(-3, -3),
                              ),
                            ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: GoogleFonts.ptSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_double_arrow_down_rounded,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
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

  SideTitles _bottomTitles(List<CoverageTrendsModel> trendsList) => SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          for (var v in trendsList[0].data!) {
            if (value.toInt() == v.index) {
              text = v.monthYear ?? '';
            }
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            // space: 4,
            angle: 35,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  text,
                  style: GoogleFonts.ptSansCaption(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      );
  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        reservedSize: 40,
        interval: 1,
        getTitlesWidget: (value, meta) {
          return Text(
            meta.formattedValue,
            style: GoogleFonts.ptSansCaption(color: Colors.black),
          );
        },
      );
}
