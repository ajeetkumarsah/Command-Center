import 'package:flutter/material.dart';

import '../../../activities/retailing_screen.dart';
import '../../colors/colors.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../const/const_array.dart';
import '../../style/text_style.dart';

class RetailingTrends extends StatelessWidget {
  final double xAlign;
  final Function() onTap;
  final Function() onTapSign;
  final Color loginColor;
  final Color signInColor;
  final Function(bool) onExpansionChanged;
  final bool isExpanded;
  const RetailingTrends({Key? key, required this.xAlign, required this.onTap, required this.onTapSign, required this.loginColor, required this.signInColor, required this.onExpansionChanged, required this.isExpanded}) : super(key: key);


  _getSeriesData() {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
          id: "Sales",
          data: ConstArray().data,
          domainFn: (SalesData series, _) => series.year,
          measureFn: (SalesData series, _) => series.sales,
          colorFn: (SalesData series, _) =>
          charts.MaterialPalette.blue.shadeDefault),
      charts.Series(
          id: "Sales",
          data: ConstArray().data1,
          domainFn: (SalesData series, _) => series.year,
          measureFn: (SalesData series, _) => series.sales,
          colorFn: (SalesData series, _) =>
          charts.MaterialPalette.red.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Theme(
          data: Theme.of(context).copyWith(// here for close state
            colorScheme: ColorScheme.light(
              primary: MyColors.expandedTitle,
            ), // here for open state in replacement of deprecated accentColor
            dividerColor: Colors.transparent, // if you want to remove the border
          ),
          child: ExpansionTile(
            shape: const Border(),
            collapsedBackgroundColor: Colors.white,
            // backgroundColor: Colors.red,
            trailing: isExpanded? const Icon(Icons.keyboard_double_arrow_up_sharp, color: MyColors.primary,): const Icon(Icons.keyboard_double_arrow_down_sharp,color: MyColors.primary,),
            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Retailing Trends",
                style: ThemeText.categoryHeaderText,
              ),
            ),
            onExpansionChanged: onExpansionChanged,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffE2E6E9),
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Category',
                            style: ThemeText.categoryText,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(Icons.edit_outlined,
                              size: 15, color: Color(0xff576DFF)),
                          const Spacer(),
                          Container(
                            width: 160,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              border: Border.all(
                                  width: 1, color: Colors.black12),
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  alignment: Alignment(xAlign, 0),
                                  duration: const Duration(
                                      milliseconds: 300),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      width: width * 0.65,
                                      height: height,
                                      decoration: const BoxDecoration(
                                        color: MyColors.primary,
                                        borderRadius:
                                        BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: onTap,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Container(
                                      width: width * 0.7,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Sales Value',
                                        style: TextStyle(
                                            color: loginColor,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: onTapSign,
                                  child: Align(
                                    alignment: const Alignment(1, 0),
                                    child: Container(
                                      width: width * 0.65,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'IYA',
                                        style: TextStyle(
                                          color: signInColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10),
                        child: Container(
                          height: 2,
                          color: MyColors.dividerColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 4,
                              width: 10,
                              color: Colors.redAccent,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 15.0),
                              child: Text(
                                'Data point',
                                style: ThemeText.datapointText,
                              ),
                            ),
                            Container(
                              height: 4,
                              width: 10,
                              color: MyColors.primary,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0),
                              child: Text(
                                'Data point',
                                style: ThemeText.datapointText,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        // padding: EdgeInsets.all(10),
                        child: charts.LineChart(
                          _getSeriesData(),
                          animate: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
