import 'package:flutter/material.dart';

import '../../../activities/retailing_screen.dart';
import '../../colors/colors.dart';
import '../../const/const_array.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../style/text_style.dart';

class FocusBrandTrends extends StatelessWidget {
  final Function(bool) onExpansionChanged;
  final bool isExpanded;
  const FocusBrandTrends({Key? key, required this.onExpansionChanged, required this.isExpanded}) : super(key: key);

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
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Theme(
          data: Theme.of(context).copyWith(// here for close state
            colorScheme: const ColorScheme.light(
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
                "Focus Brand Trends",
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
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Category',
                            style:
                                ThemeText.categoryText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.edit_outlined,
                              size: 15, color: Color(0xff576DFF)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          height: 2,
                          color: MyColors.dividerColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 4,
                              width: 10,
                              color: Colors.redAccent,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 15.0),
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
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                'Data point',
                                style: ThemeText.datapointText,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
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
