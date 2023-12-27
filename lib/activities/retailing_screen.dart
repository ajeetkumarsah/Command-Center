import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/comman/bottom_sheet/division_sheet.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/data_table_model.dart';
import '../utils/comman/app_bar.dart';

import '../utils/comman/retailing_table/retailing_category.dart';
import '../utils/comman/retailing_table/retailing_channel.dart';
import '../utils/comman/retailing_table/retailing_table.dart';
import '../utils/comman/retailing_table/retailing_trends.dart';
import '../utils/const/header_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const double width = 110.0;
const double height = 50.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class RetailingScreen extends StatefulWidget {
  const RetailingScreen({Key? key}) : super(key: key);

  @override
  State<RetailingScreen> createState() => _RetailingScreenState();
}

class _RetailingScreenState extends State<RetailingScreen> {
  late List<DataTableModel> rowData;
  late bool sort = true;

  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  List<ChartData>? chartData;

  var isExpanded = false;

  List<dynamic> flattenedList = [];
  List<dynamic> dataListCoverage = [];

  List<dynamic> updatedList = [];

  Future<http.Response> postRequest(context) async {
    var url = '$BASE_URL/api/appData/mtdRetailingTable';

    var body = json.encode({
      "name": "channel",
      "type": "monthlyData",
      "query": updatedList.isEmpty
          ? updatedList = [
              {"date": "Jun-2023", "allIndia": "allIndia", "channel": []}
            ]
          : updatedList
    });
    print("Body Retailing Geo $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    rowData = DataTableModel.getRowsData();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    super.initState();
    postRequest(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: MyColors.textColor));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: CustumAppBar(title: 'Retailing'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              // Container(
              //   height: size.height,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/app_bar/background.png'),
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(title: "Retailing Summary"),
                  RetailingTable(
                    onTap: () {
                      //     backgroundColor: Colors.white,
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(15.0),
                      //           topRight: Radius.circular(15.0)),
                      //     ),
                      // _openModalForAddColumn(context);
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (BuildContext
                                    context,
                                StateSetter setState /*You can rename this!*/) {
                              return DivisionSheet(
                                list: ['All India'],
                                divisionList: ConstArray().divisionNewList,
                                siteList: ConstArray().siteNewList,
                                branchList: ConstArray().brandFilter,
                                selectedGeo: 0,
                                // selectedDivision == 'All India'
                                //     ? 0
                                //     : selectedDivision == 'Division'
                                //     ? 1
                                //     : selectedDivision == 'Cluster'
                                //     ? 2
                                //     : selectedDivision == 'Site'
                                //     ? 3
                                //     : selectedDivision == 'Branch'
                                //     ? 4
                                //     : 0,
                                clusterList: ConstArray().clusterNewList,
                                onApplyClick: () async {
                                  print(SharedPreferencesUtils.getString(
                                      'mobileDivision'));
                                  print(SharedPreferencesUtils.getString(
                                      'mobileSite'));

                                  if(SharedPreferencesUtils.getString('mobileDivision') == 'site'){
                                    updatedList.add({
                                      "date": "Jun-2023",
                                      "allIndia":"allIndia",
                                      "${SharedPreferencesUtils.getString('mobileDivision')}":
                                      "${SharedPreferencesUtils.getString('mobileSite')}",
                                      "channel": []
                                    });
                                  }else{
                                  updatedList.add({
                                    "date": "Jun-2023",
                                    "${SharedPreferencesUtils.getString('mobileDivision')}":
                                        "${SharedPreferencesUtils.getString('mobileSite')}",
                                    "channel": []
                                  });
                                  }
                                  Navigator.of(context).pop();
                                  await postRequest(context);

                                  print("New List Updated ===> $updatedList");
                                },
                              );
                            });
                          }).then((value) {
                        setState(() {});
                      });
                    },
                    rowData: rowData,
                    sort: sort,
                    rowData1: dataListCoverage,
                  ),
                  const RetailingCategory(),
                  const RetailingChannel(),
                  RetailingTrends(
                    isExpanded: isExpanded,
                    onExpansionChanged: (bool expanded) {
                      setState(() => isExpanded = expanded);
                    },
                    xAlign: xAlign,
                    onTap: () {
                      setState(() {
                        xAlign = loginAlign;
                        loginColor = selectedColor;
                        signInColor = normalColor;
                      });
                    },
                    loginColor: loginColor,
                    signInColor: signInColor,
                    onTapSign: () {
                      setState(() {
                        xAlign = signInAlign;
                        signInColor = selectedColor;

                        loginColor = normalColor;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Private class for storing the stacked line 100 chart.
class ChartData {
  ChartData(this.x, this.father, this.mother, this.son, this.daughter);

  final String x;
  final num father;
  final num mother;
  final num son;
  final num daughter;
}

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}
