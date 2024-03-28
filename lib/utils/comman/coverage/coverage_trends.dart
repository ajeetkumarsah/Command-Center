import '../../colors/colors.dart';
import '../../style/text_style.dart';
import '../../const/const_array.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../activities/retailing_screen.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ApiService {
  Future<List<List<double>>> getData() async {
    // API call to fetch data
    // Return a list of two lists of double values
    // Replace this with your actual API implementation
    await Future.delayed(Duration(seconds: 2));
    return [
      [12.5, 10.0, 8.0, 15.0, 7.5, 14.0, 11.0],
      [9.0, 11.0, 13.0, 7.0, 10.5, 8.0, 12.0]
    ];
  }
}

class CoverageTrends extends StatelessWidget {
  final Function(bool) onExpansionChanged;
  final bool isExpanded;
  CoverageTrends(
      {Key? key, required this.onExpansionChanged, required this.isExpanded})
      : super(key: key);

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            // here for close state
            colorScheme: const ColorScheme.light(
              primary: MyColors.expandedTitle,
            ), // here for open state in replacement of deprecated accentColor
            dividerColor:
                Colors.transparent, // if you want to remove the border
          ),
          child: ExpansionTile(
            shape: const Border(),
            collapsedBackgroundColor: Colors.white,
            // backgroundColor: Colors.red,
            trailing: isExpanded
                ? const Icon(
                    Icons.keyboard_double_arrow_up_sharp,
                    color: MyColors.primary,
                  )
                : const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                    color: MyColors.primary,
                  ),

            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Coverage Trends",
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
                      const Row(
                        children: [
                          Text(
                            'Category',
                            style: ThemeText.categoryText,
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
                        child: FutureBuilder<List<List<double>>>(
                          future: apiService
                              .getData(), // Assuming this method fetches data from the API
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error occurred'));
                            } else {
                              final data = snapshot.data;
                              return ChartWidget(
                                  data1: data![0], data2: data[1]);
                            }
                          },
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

class ChartWidget extends StatelessWidget {
  final List<double> data1; // First set of data
  final List<double> data2; // Second set of data

  ChartWidget({required this.data1, required this.data2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: getDataSpots(
                  data1), // Convert the first set of data to FlSpot
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: getDataSpots(
                  data2), // Convert the second set of data to FlSpot
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minX: 0,
          maxX: data1.length.toDouble() - 1,
          minY: 0,
          maxY: calculateMaxY(data1, data2),
        ),
      ),
    );
  }

  List<FlSpot> getDataSpots(List<double> data) {
    return data
        .asMap()
        .entries
        .map((entry) =>
            FlSpot(entry.key.toDouble(), entry.value > 0 ? entry.value : 0))
        .toList();
  }

  double calculateMaxY(List<double> data1, List<double> data2) {
    final List<double> combinedData = [...data1, ...data2];
    return combinedData
        .reduce((value, element) => value > element ? value : element);
  }
}
