import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class CustomExpandedChartWidget extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onFilterTap;
  final bool isExpanded;
  final String title;
  final TrendsModel? trendsList;
  final String summaryType;
  final Widget? coverageWidget;
  const CustomExpandedChartWidget(
      {super.key,
      required this.title,
      this.onTap,
      this.onFilterTap,
      required this.isExpanded,
      this.coverageWidget,
      required this.summaryType,
      required this.trendsList});

  @override
  State<CustomExpandedChartWidget> createState() =>
      _CustomExpandedChartWidgetState();
}

class _CustomExpandedChartWidgetState extends State<CustomExpandedChartWidget> {
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
                                                    ctlr.selectedTrends,
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
                                                    bottom: 4,
                                                  ),
                                                  child: Text(
                                                    ctlr.retailingTrendsValue,
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
                                    widget.coverageWidget ??
                                        Container(
                                          // height: 26,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.lightGrey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => ctlr
                                                    .onChannelSalesChange(true),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ctlr.channelSales
                                                        ? AppColors.primary
                                                        : AppColors.white,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: ctlr.channelSales
                                                          ? AppColors.primary
                                                          : AppColors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                                  child: Text(
                                                    widget.summaryType ==
                                                            SummaryTypes
                                                                .retailing.type
                                                        ? 'Sales Value'
                                                        : widget.summaryType ==
                                                                SummaryTypes
                                                                    .gp.type
                                                            ? 'GP Abs. P3M'
                                                            : widget.summaryType ==
                                                                    SummaryTypes
                                                                        .fb.type
                                                                ? 'FB Abs.'
                                                                : '',
                                                    style: GoogleFonts
                                                        .ptSansCaption(
                                                      color: ctlr.channelSales
                                                          ? Colors.white
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    ctlr.onChannelSalesChange(
                                                        false),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ctlr.channelSales
                                                        ? AppColors.white
                                                        : AppColors.primary,
                                                    border: ctlr.channelSales
                                                        ? null
                                                        : Border.all(
                                                            width: 1,
                                                            color: !ctlr
                                                                    .channelSales
                                                                ? AppColors
                                                                    .primary
                                                                : AppColors
                                                                    .white,
                                                          ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                                  child: Text(
                                                    '  IYA  ',
                                                    style: GoogleFonts
                                                        .ptSansCaption(
                                                      color: !ctlr.channelSales
                                                          ? Colors.white
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                    // GestureDetector(
                                    //   onTap: widget.onFilterTap,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(4.0),
                                    //     child: Text(
                                    //       ctlr.selectedTrends,
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
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: widget.trendsList?.data != null
                                    ? LineChart(
                                        LineChartData(
                                          maxX: 13,
                                          minX: 0,
                                          maxY: ctlr.channelSales
                                              ? widget.trendsList?.yMax
                                              : widget.trendsList?.yPerMax,
                                          minY: ctlr.channelSales
                                              ? widget.trendsList?.yMin
                                              : widget.trendsList?.yPerMin,
                                          baselineX: 1,
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: widget.trendsList!.data!
                                                  .asMap()
                                                  .map(
                                                    (i, point) => MapEntry(
                                                      i,
                                                      FlSpot(
                                                        i.toDouble(),
                                                        double.tryParse(ctlr
                                                                    .channelSales
                                                                ? (point.cyRt ??
                                                                    '0.0')
                                                                : (point.iya ??
                                                                    '0.0')) ??
                                                            0.0,
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
                                              touchCallback: (event, response) {
                                                if (event is FlTapUpEvent) {
                                                  if (response != null &&
                                                      response.lineBarSpots !=
                                                          null) {}
                                                }
                                              },
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
                                                        '${widget.trendsList?.data![touchedSpot.spotIndex].month}\n${ctlr.channelSales ? (widget.trendsList?.data![touchedSpot.spotIndex].cyRtRv ?? '0.0') : double.tryParse((widget.trendsList?.data![touchedSpot.spotIndex].iya ?? '0.0'))?.toStringAsFixed(2) ?? "0.0"}',
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
                                                        dashArray: [2, 4]);
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
                                            // leftTitles: _leftTitles,
                                            bottomTitles: AxisTitles(
                                              sideTitles: _bottomTitles(
                                                  widget.trendsList!),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 46,
                                                interval: ctlr.channelSales
                                                    ? widget.trendsList
                                                                ?.yInterval !=
                                                            0
                                                        ? widget.trendsList
                                                            ?.yInterval
                                                        : 1
                                                    : widget.trendsList
                                                                ?.yPerInterval !=
                                                            0
                                                        ? widget.trendsList
                                                            ?.yPerInterval
                                                        : 1,
                                                getTitlesWidget: (value,
                                                        meta) =>
                                                    getLeftTitles(
                                                        value,
                                                        meta,
                                                        ctlr.channelSales
                                                            ? widget.trendsList
                                                                    ?.yAxisData ??
                                                                []
                                                            : widget.trendsList
                                                                    ?.yAxisDataPer ??
                                                                []),
                                              ),
                                            ),
                                            topTitles: AxisTitles(
                                                sideTitles: SideTitles(
                                                    showTitles: false)),
                                            rightTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: false,
                                                reservedSize: 15,
                                                getTitlesWidget: (d, w) =>
                                                    const SizedBox(width: 12),
                                              ),
                                            ),
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

  SideTitles _bottomTitles(TrendsModel trendsList) => SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          for (var v in trendsList.data!) {
            if (value.toInt() == v.index) {
              text = v.month ?? '';
            }
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            // space: 8,
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
      // angle: 30,
      child: Text(text, style: style),
    );
  }
}
