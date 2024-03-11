import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/fb/fb_deep_dive.dart';

class SalesDeepDiveScreen extends StatefulWidget {
  const SalesDeepDiveScreen({super.key});

  @override
  State<SalesDeepDiveScreen> createState() => _SalesDeepDiveScreenState();
}

class _SalesDeepDiveScreenState extends State<SalesDeepDiveScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                          Expanded(
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
                          Expanded(
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
                          Expanded(
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
                        indicatorSize: TabBarIndicatorSize.tab,
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
                      Container(
                        height: .5,
                        color: AppColors.tableBorder,
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: TabBarView(
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            retailingTab(),
                            productTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget retailingTab() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Sales Value Trends',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Container(
                  // width: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(5)),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      Text(
                        'Category',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 0, left: 12, right: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.lightGrey,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.sfPrimary,
                          border: Border.all(
                            width: 1,
                            color: AppColors.sfPrimary,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          'Net Retailing Value',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            width: 1,
                            color: AppColors.white,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          'IYA',
                          style: GoogleFonts.inter(
                            color: AppColors.storeTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(value: false, onChanged: (v) {}),
                    Text(
                      '% Change',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LineChart(
            LineChartData(
              maxY: 12,
              // maxX: 6,
              lineBarsData: [
                LineChartBarData(
                  // curveSmoothness: 12,
                  belowBarData: BarAreaData(
                    // spotsLine: BarAreaSpotsLine(show: true),
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff8F9FFF).withOpacity(.46),
                        const Color(0xffAAB7FF).withOpacity(.46),
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  spots: listData
                      .asMap()
                      .map(
                        (i, point) => MapEntry(
                          i,
                          FlSpot(point.xValue, point.yValue),
                        ),
                      )
                      .values
                      .toList(),
                  isCurved: true,
                  dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          strokeColor: AppColors.primary,
                          color: AppColors.white,
                        );
                      }),
                  color: AppColors.primary,
                  barWidth: 1.2,
                ),
              ],
              lineTouchData: LineTouchData(
                  enabled: true,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? touchResponse) {},
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: AppColors.primaryDark,
                    tooltipRoundedRadius: 20.0,
                    showOnTopOfTheChartBoxArea: false,
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    tooltipMargin: 40,
                    tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                          const textStyle = TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          );
                          return LineTooltipItem(
                            '0.0',
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
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: false,
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: _bottomTitles,
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 20,
                    getTitlesWidget: (value, meta) {
                      return const SizedBox();
                    },
                  ),
                  // _leftTitles,
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 20,
                    getTitlesWidget: (value, meta) {
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget productTab() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: .5,
                      color: AppColors.borderColor,
                    ),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppColors.sfPrimary,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.greyTextColor,
                    labelStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: const [
                      Tab(text: ' Category '),
                      Tab(text: ' Brand '),
                      Tab(text: ' SBF '),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.only(left: 1, top: 1, bottom: 1),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Container(
                  // width: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(5)),
                    color: AppColors.white,
                  ),
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.tableBorder,
                  height: .5,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          'Brand Name',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      color: AppColors.tableBorder,
                      width: .5,
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    'CM',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyTextColor,
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
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    'P3M',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greyTextColor,
                                    ),
                                  ),
                                ),
                              ),
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
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          'IYA',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyTextColor,
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
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          'Sal',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyTextColor,
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
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          'Sales(\u{20B9})',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyTextColor,
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
                                height: 30,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          'Sal',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyTextColor,
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
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          'Sales(\u{20B9})',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyTextColor,
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
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: AppColors.tableBorder,
                  height: .5,
                ),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
                productTableRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget productTableRow() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  'Whisper',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              color: AppColors.tableBorder,
              width: .5,
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  '24',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
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
                              flex: 2,
                              child: Center(
                                child: Text(
                                  '50%',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
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
                              flex: 3,
                              child: Center(
                                child: Text(
                                  '12,345',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
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
                        height: 30,
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '36%',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
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
                              flex: 2,
                              child: Center(
                                child: Text(
                                  '66,186',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
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
          ],
        ),
        Container(
          width: double.infinity,
          color: AppColors.tableBorder,
          height: .5,
        ),
      ],
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Jan';
              break;
            case 1:
              text = 'Feb';
              break;
            case 2:
              text = 'Mar';
              break;
            case 3:
              text = 'Apr';
              break;
            case 4:
              text = 'May';
              break;
            case 5:
              text = 'Jun';
              break;
            case 6:
              text = 'Jul';
              break;
            case 7:
              text = 'Aug';
              break;
            case 8:
              text = 'Sep';
              break;
            case 9:
              text = 'Oct';
              break;
            case 10:
              text = 'Nov';
              break;
            case 11:
              text = 'Dec';
              break;
          }
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 8,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                text,
                style: GoogleFonts.ptSansCaption(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      );

  List<StaticGraph> listData = [
    StaticGraph(xValue: 1, yValue: 4),
    StaticGraph(xValue: 2, yValue: 6),
    StaticGraph(xValue: 3, yValue: 3),
    StaticGraph(xValue: 4, yValue: 10),
    StaticGraph(xValue: 5, yValue: 7),
    StaticGraph(xValue: 6, yValue: 6),
    StaticGraph(xValue: 7, yValue: 1),
    StaticGraph(xValue: 8, yValue: 6),
  ];
  Widget tableRow(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 4.0),
      color: AppColors.storeTableRowColor,
      child: Row(
        children: [
          Expanded(
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
          Expanded(
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
          Expanded(
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
              const Icon(Icons.arrow_upward_sharp,
                  color: AppColors.green, size: 18),
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
