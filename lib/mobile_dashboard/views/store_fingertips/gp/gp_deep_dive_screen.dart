import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_shadow_widget/inner_shadow_widget.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/svg_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/fb/fb_deep_dive.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/widgets/category_bottomsheet.dart';

class GPDeepDiveScreen extends StatelessWidget {
  const GPDeepDiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<StaticGraph> listData = [
      StaticGraph(xValue: 0, yValue: 9),
      StaticGraph(xValue: 1, yValue: 8),
      StaticGraph(xValue: 2, yValue: 7),
      StaticGraph(xValue: 3, yValue: 3),
      StaticGraph(xValue: 4, yValue: 10),
      StaticGraph(xValue: 5, yValue: 7),
      StaticGraph(xValue: 6, yValue: 6),
      StaticGraph(xValue: 7, yValue: 3),
      StaticGraph(xValue: 8, yValue: 8),
      StaticGraph(xValue: 9, yValue: 9),
      StaticGraph(xValue: 10, yValue: 2),
      StaticGraph(xValue: 11, yValue: 1),
    ];
    List<StaticGraph> listData1 = [
      StaticGraph(xValue: 0, yValue: 19),
      StaticGraph(xValue: 1, yValue: 18),
      StaticGraph(xValue: 2, yValue: 17),
      StaticGraph(xValue: 3, yValue: 13),
      StaticGraph(xValue: 4, yValue: 20),
      StaticGraph(xValue: 5, yValue: 17),
      StaticGraph(xValue: 6, yValue: 16),
      StaticGraph(xValue: 7, yValue: 13),
      StaticGraph(xValue: 8, yValue: 18),
      StaticGraph(xValue: 9, yValue: 19),
      StaticGraph(xValue: 10, yValue: 12),
      StaticGraph(xValue: 11, yValue: 11),
    ];
    List<GPDummyData> brandList = [
      GPDummyData(
          name: 'Whspr Ultra XL + 30s',
          p3mAch: true,
          p3mSal: '36%',
          p1mAch: false,
          p1mSal: '36%'),
      GPDummyData(
          name: 'Simply Venus 3s Disp',
          p3mAch: true,
          p3mSal: '19%',
          p1mAch: false,
          p1mSal: ''),
      GPDummyData(
          name: 'BLUE Pants Jumbo New XL',
          p3mAch: true,
          p3mSal: '8%',
          p1mAch: false,
          p1mSal: '8%'),
      GPDummyData(
          name: 'BLUE Pants Value MD',
          p3mAch: true,
          p3mSal: '4%',
          p1mAch: false,
          p1mSal: '4%'),
      GPDummyData(
          name: 'Whspr Ultra XL + 30s',
          p3mAch: true,
          p3mSal: '4%',
          p1mAch: false,
          p1mSal: '4%'),
      GPDummyData(
          name: 'Simply Venus 3s Disp',
          p3mAch: true,
          p3mSal: '3%',
          p1mAch: false,
          p1mSal: '3%'),
      GPDummyData(
          name: 'BLUE Pants Jumbo New XL',
          p3mAch: true,
          p3mSal: '4%',
          p1mAch: false,
          p1mSal: '4%'),
    ];

    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return SingleChildScrollView(
          child: Column(
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
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                child: GridView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index == 0 ? 'SRN%' : 'Scheme Earning',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.storeTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InnerShadow(
                        blur: 4,
                        offset: const Offset(4, 4),
                        color: AppColors.black.withOpacity(.25),
                        child: Container(
                          height: 30,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff7CA0DF),
                            // boxShadow: [
                            //   BoxShadow(
                            //     offset: const Offset(4, 4),
                            //     blurRadius: 4,
                            //     spreadRadius: -4,
                            //     color: AppColors.black.withOpacity(.25),
                            //   ),
                            // ],
                          ),
                          child: Center(
                            child: Text(
                              index == 0
                                  ? '${ctlr.getFBTarget()}%'
                                  : '${ctlr.getFBAchieved()}%',
                              style: GoogleFonts.inter(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                  ),
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
                    ListTile(
                      title: Text(
                        'Trend - Month on Month',
                        style: GoogleFonts.inder(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      trailing: InnerShadow(
                        blur: 4,
                        offset: const Offset(4, 4),
                        color: AppColors.black.withOpacity(.25),
                        child: GestureDetector(
                          onTap: () =>
                              Get.bottomSheet(const StoreCategoryBottomsheet()),
                          child: Container(
                            height: 30,
                            // width: 108,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Category',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.primary,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(right: 6, left: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: AppColors.storeTextColor,
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffA2B7FE),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'GP Target',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.storeTextLightColor,
                            ),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(right: 6, left: 24),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: const Color(0xff009A22),
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff74EC80),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'P3M GP',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.storeTextLightColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          maxY: 22,
                          lineBarsData: [
                            LineChartBarData(
                              belowBarData: BarAreaData(
                                spotsLine: BarAreaSpotsLine(show: false),
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xff009F49).withOpacity(0.24),
                                    const Color(0xff3BE1E1).withOpacity(0.11),
                                    const Color(0xff3BE1E1).withOpacity(0.70),
                                    const Color(0xff54B3E8).withOpacity(0.0),
                                    // Colors.white,
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
                              isCurved: false,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    strokeColor: AppColors.primary,
                                    color: const Color(0xff74EC80),
                                    strokeWidth: 1.5,
                                  );
                                },
                              ),
                              color: const Color(0xff009A22),
                              barWidth: .75,
                            ),
                            LineChartBarData(
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xff8F9FFF).withOpacity(.46),
                                    const Color(0xff98D7E5).withOpacity(.30),
                                    const Color(0xff98D7E5).withOpacity(.14),
                                    const Color(0xff69C2D5).withOpacity(.0),
                                  ],
                                ),
                              ),
                              spots: listData1
                                  .asMap()
                                  .map(
                                    (i, point) => MapEntry(
                                      i,
                                      FlSpot(point.xValue, point.yValue),
                                    ),
                                  )
                                  .values
                                  .toList(),
                              isCurved: false,
                              dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                    return FlDotCirclePainter(
                                      radius: 4,
                                      strokeColor: AppColors.primary,
                                      color: const Color(0xffA2B7FE),
                                      strokeWidth: 1.5,
                                    );
                                  }),
                              color: AppColors.storeTextColor,
                              barWidth: .75,
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
                                        '0.0',
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
                              sideTitles: SideTitles(showTitles: false),
                              // _leftTitles,
                            ),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                // padding: ,
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
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 24, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  SBF Name',
                              style: GoogleFonts.inter(
                                color: AppColors.storeTextLightColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: .5,
                            color: Colors.black,
                            height: 60,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .56,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'P3M',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.storeTextLightColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: .5,
                                      color: Colors.black,
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'P1M',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.storeTextLightColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.black,
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
                                                'GP Ach',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .storeTextLightColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: .5,
                                            color: Colors.black,
                                            height: 30,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Sal%',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .storeTextLightColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: .5,
                                      color: Colors.black,
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'GP Ach',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .storeTextLightColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: .5,
                                            color: Colors.black,
                                            height: 30,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Sal%',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .storeTextLightColor,
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
                            // Center(
                            //   child: Text(
                            //     'FB Ach',
                            //     style: GoogleFonts.inter(
                            //       color: AppColors.storeTextLightColor,
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    ),
                    ...brandList
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                            i,
                            Container(
                              decoration: BoxDecoration(
                                color: i % 2 == 0
                                    ? Colors.white
                                    : const Color(0xffF2F6FD),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        e.name ?? '',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: .5,
                                    color: Colors.black,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .56,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Icon(
                                                    e.p3mAch ?? false
                                                        ? Icons.check
                                                        : Icons.close,
                                                    color: e.p3mAch ?? false
                                                        ? AppColors.green
                                                        : AppColors.red,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: .5,
                                                color: Colors.black,
                                                height: 30,
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    e.p3mSal ?? '',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                          color: Colors.black,
                                          height: 30,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Icon(
                                                    e.p1mAch ?? false
                                                        ? Icons.check
                                                        : Icons.close,
                                                    color: e.p1mAch ?? false
                                                        ? AppColors.green
                                                        : AppColors.red,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: .5,
                                                color: Colors.black,
                                                height: 30,
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    e.p1mSal ?? '',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                        color: brandList.length % 2 == 0
                            ? Colors.white
                            : const Color(0xffF2F6FD),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Total',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .56,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '100%',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '100%',
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 15,
                              color: AppColors.black.withOpacity(.25),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'New Store',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.storeTextColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.asset(
                                        PngFiles.search,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'CY2022-Nov',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.storeTextColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: SvgPicture.asset(
                                        SvgFiles.pen,
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Compare',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.storeTextColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.asset(
                                        PngFiles.compare,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 15,
                            color: AppColors.black.withOpacity(.25),
                          ),
                        ],
                      ),
                      child: Center(child: SvgPicture.asset(SvgFiles.info)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
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

          return Text(
            text,
            style: GoogleFonts.ptSansCaption(color: Colors.black),
          );
        },
      );
}

class GPDummyData {
  final String? name;
  final bool? p3mAch;
  final String? p3mSal;
  final bool? p1mAch;
  final String? p1mSal;

  GPDummyData({this.name, this.p3mAch, this.p3mSal, this.p1mAch, this.p1mSal});
}
