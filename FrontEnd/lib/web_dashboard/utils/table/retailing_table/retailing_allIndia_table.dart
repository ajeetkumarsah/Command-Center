import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/helper/http_call.dart';
import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/web_dashboard/model/table_coverage_summary_model.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RetailingAllIndiaTableData extends StatefulWidget {
  final List newDataList;
  final int selectedIndex;
  final String division;
  final String divisionName;
  final String month;

  const RetailingAllIndiaTableData({
    super.key,
    required this.newDataList, required this.selectedIndex, required this.division, required this.divisionName, required this.month,
  });

  @override
  State<RetailingAllIndiaTableData> createState() => _RetailingAllIndiaTableDataState();
}

class _RetailingAllIndiaTableDataState extends State<RetailingAllIndiaTableData> {

  List<dynamic> dataListCoverageCCTabs = [];
  List<dynamic> flattenedListCC = [];

  List<dynamic> dataListRetailingSite = [];
  List<dynamic> flattenedListSite = [];

  List<dynamic> dataListRetailingBranch = [];
  List<dynamic> flattenedListBranch = [];

  Future<http.Response> postRequestByGeo(context) async {
    var url =
        '$BASE_URL/api/webDeepDive/rt/geo/monthlyData/division';

    var body = json.encode(flattenedListCC.isEmpty
        ? [
      {
        widget.division: widget.divisionName,
        "date": widget.month,
        "channel": []
      }
    ]
        : flattenedListCC);
    print("Body division Tab 2 $body");
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);
        print("Response 111111111 => $dataListCoverageCCTabs");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Future<http.Response> postRequestBySite(context) async {
    var url =
        '$BASE_URL/api/webDeepDive/rt/geo/monthlyData/site';

    var body = json.encode(flattenedListSite.isEmpty
        ? [
      {
        widget.division: widget.divisionName,
        "date": widget.month,
        "channel": [],
        "division": "South-West"
      }
    ]
        : flattenedListSite);
    print("Body Retailing Tab 2 $body");
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (response.statusCode == 200) {
      setState(() {
        dataListRetailingSite = jsonDecode(response.body);
        print("Response => $dataListRetailingSite");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Future<http.Response> postRequestByBranch(context) async {
    var url =
        '$BASE_URL/api/webDeepDive/rt/geo/monthlyData/branch';

    var body = json.encode(flattenedListBranch.isEmpty
        ? [
      {
        widget.division: widget.divisionName,
        "date": widget.month,
        "channel": [],
          "division": "South-West",
          "site": "Goa"
      }
    ]
        : flattenedListBranch);
    print("Body Retailing Tab 2 $body");
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (response.statusCode == 200) {
      setState(() {
        dataListRetailingBranch = jsonDecode(response.body);
        print("Response => $dataListRetailingBranch");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    // return FutureBuilder(
    //     future: getTableCoverageSummary(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 470,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.newDataList.length,
                        itemBuilder: (context, index) {
                          var coverage0 = widget.newDataList[0];
                          var coverage1 = widget.newDataList[index]['cm'][0];
                          var coverage2 = widget.newDataList[index]['p1m'][0];
                          var coverage3 = widget.newDataList[index]['p3m'][0];
                          var coverage4 = widget.newDataList[index]['p3m'][0];
                          var coverage5 = widget.newDataList[index]['p12m'][0];
                          var coverage6 = widget.newDataList[index]['financial_year'][0];
                          // print("Coverage 1 $coverage0");
                          // var coverage7 = widget.newDataList[6][0]['data'][0];
                          return ListTileTheme(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            child: ExpansionTile(
                              trailing: const Text(''),
                              textColor: MyColors.textColor,
                              onExpansionChanged: (val) {
                                setState(() {
                                  sheetProvider.isExpandedDivision = val;
                                  sheetProvider.isExpanded = false;
                                  sheetProvider.isExpandedBranch = false;
                                  sheetProvider.isExpandedChannel = false;
                                  sheetProvider.isExpandedSubChannel = false;
                                  // print();
                                  postRequestByGeo(context);
                                });
                              },
                              // controlAffinity: ListTileControlAffinity.leading,
                              collapsedBackgroundColor: index % 2 == 0
                                  ? MyColors.dark600
                                  : MyColors.dark400,
                              backgroundColor: index % 2 == 0
                                  ? MyColors.dark600
                                  : MyColors.dark400,
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 5, bottom: 5, right: 5),
                                child: SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width + 100,
                                  child: Row(
                                    children: [
                                      TextHeaderWidgetWithIcon(
                                        title: coverage0['filter_key'] == "allIndia" || coverage0['filter_key'] == "All India"?'All India':coverage0['filter_key'],
                                        align: TextAlign.start,
                                        isRequired: false,
                                        isExpanded:
                                            sheetProvider.isExpandedDivision,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                            .isExpandedDivision ==
                                                        true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider
                                                              .isExpandedDivision ==
                                                          true
                                                      ? ""
                                                      : "",
                                                  textAlign: TextAlign.center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width:
                                            sheetProvider.isExpandedDivision ==
                                                    true
                                                ? 3
                                                : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return SizedBox(
                                              width: sheetProvider.isExpanded ==
                                                      true
                                                  ? 110
                                                  : 0,
                                              child: Text(
                                                sheetProvider.isExpanded == true
                                                    ? ""
                                                    : "",
                                                textAlign: TextAlign.center,
                                              ));
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider.isExpanded == true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                            .isExpandedBranch ==
                                                        true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider
                                                              .isExpandedBranch ==
                                                          true
                                                      ? ""
                                                      : "",
                                                  textAlign: TextAlign.center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider.isExpandedBranch ==
                                                true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return SizedBox(
                                              width: sheetProvider
                                                          .isExpandedChannel ==
                                                      true
                                                  ? 110
                                                  : 0,
                                              child: Text(
                                                sheetProvider
                                                            .isExpandedChannel ==
                                                        true
                                                    ? ""
                                                    : "",
                                                textAlign: TextAlign.center,
                                              ));
                                        },
                                      ),
                                      SizedBox(
                                        width:
                                            sheetProvider.isExpandedChannel ==
                                                    true
                                                ? 3
                                                : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                            .isExpandedSubChannel ==
                                                        true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider
                                                              .isExpandedSubChannel ==
                                                          true
                                                      ? ""
                                                      : "",
                                                  textAlign: TextAlign.center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider
                                                    .isExpandedSubChannel ==
                                                true
                                            ? 3
                                            : 0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage1['cy_retailing_sum']}',
                                          //Billing Percentage
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage1['IYA']}',
                                          //Billing Percentage
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage2['IYA']}',
                                          //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title:
                                              '${coverage3['IYA']}',
                                          //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title:
                                          '${coverage4['IYA']}',
                                          //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title:
                                          '${coverage5['IYA']}',
                                          //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title:
                                          '${coverage6['cy_retailing_sum']}',
                                          //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title:
                                          '${coverage6['IYA']}',
                                          //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              children: <Widget>[
                                dataListCoverageCCTabs.isEmpty?CircularProgressIndicator():SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context).size.height - 470,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: dataListCoverageCCTabs[0][0]['cm'].length,
                                              itemBuilder: (context, indexx) {
                                                var coverage1 = dataListCoverageCCTabs[0][0]['cm'][indexx];
                                                var coverage2 = dataListCoverageCCTabs[0][0]['p1m'][indexx];
                                                var coverage3 = dataListCoverageCCTabs[0][0]['p3m'][indexx];
                                                var coverage4 = dataListCoverageCCTabs[0][0]['p6m'][indexx];
                                                var coverage5 = dataListCoverageCCTabs[0][0]['p12m'][indexx];
                                                var coverage6 = dataListCoverageCCTabs[0][0]['financial_year'][indexx];

                                                return ListTileTheme(
                                                  dense: true,
                                                  contentPadding: EdgeInsets.zero,
                                                  child: ExpansionTile(
                                                    trailing: const Text(''),
                                                    textColor: MyColors.textColor,
                                                    onExpansionChanged: (val) {
                                                      setState(() {
                                                        // sheetProvider.isExpandedDivision = val;
                                                        sheetProvider.isExpanded = val;
                                                        sheetProvider.isExpandedBranch = false;
                                                        sheetProvider.isExpandedChannel = false;
                                                        sheetProvider.isExpandedSubChannel = false;
                                                        postRequestBySite(context);
                                                      });
                                                    },
                                                    // controlAffinity: ListTileControlAffinity.leading,
                                                    collapsedBackgroundColor: index % 2 == 0
                                                        ? MyColors.dark600
                                                        : MyColors.dark400,
                                                    backgroundColor: index % 2 == 0
                                                        ? MyColors.dark600
                                                        : MyColors.dark400,
                                                    title: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 10.0, top: 5, bottom: 5, right: 5),
                                                      child: SizedBox(
                                                        height: 40,
                                                        child: Row(
                                                          children: [
                                                            TextHeaderWidgetWithIcon(
                                                              title: coverage1['division'] == "allIndia" || coverage1['division'] == "All India"?'All India':coverage1['division'],
                                                              align: TextAlign.start,
                                                              isRequired: false,
                                                              isExpanded:
                                                              sheetProvider.isExpandedDivision,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            // Consumer<SheetProvider>(
                                                            //   builder: (context, state, child) {
                                                            //     return Padding(
                                                            //       padding: const EdgeInsets.only(
                                                            //           left: 0.0),
                                                            //       child: SizedBox(
                                                            //           width: sheetProvider
                                                            //               .isExpandedDivision ==
                                                            //               true
                                                            //               ? 110
                                                            //               : 0,
                                                            //           child: Text(
                                                            //             sheetProvider
                                                            //                 .isExpandedDivision ==
                                                            //                 true
                                                            //                 ? ""
                                                            //                 : "",
                                                            //             textAlign: TextAlign.center,
                                                            //           )),
                                                            //     );
                                                            //   },
                                                            // ),
                                                            // SizedBox(
                                                            //   width:
                                                            //   sheetProvider.isExpandedDivision ==
                                                            //       true
                                                            //       ? 3
                                                            //       : 0,
                                                            // ),
                                                            Consumer<SheetProvider>(
                                                              builder: (context, state, child) {
                                                                return SizedBox(
                                                                    width: sheetProvider.isExpanded ==
                                                                        true
                                                                        ? 110
                                                                        : 0,
                                                                    child: Text(
                                                                      sheetProvider.isExpanded == true
                                                                          ? ""
                                                                          : "",
                                                                      textAlign: TextAlign.center,
                                                                    ));
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: sheetProvider.isExpanded == true
                                                                  ? 3
                                                                  : 0,
                                                            ),
                                                            Consumer<SheetProvider>(
                                                              builder: (context, state, child) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 0.0),
                                                                  child: SizedBox(
                                                                      width: sheetProvider
                                                                          .isExpandedBranch ==
                                                                          true
                                                                          ? 110
                                                                          : 0,
                                                                      child: Text(
                                                                        sheetProvider
                                                                            .isExpandedBranch ==
                                                                            true
                                                                            ? ""
                                                                            : "",
                                                                        textAlign: TextAlign.center,
                                                                      )),
                                                                );
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: sheetProvider.isExpandedBranch ==
                                                                  true
                                                                  ? 3
                                                                  : 0,
                                                            ),
                                                            Consumer<SheetProvider>(
                                                              builder: (context, state, child) {
                                                                return SizedBox(
                                                                    width: sheetProvider
                                                                        .isExpandedChannel ==
                                                                        true
                                                                        ? 110
                                                                        : 0,
                                                                    child: Text(
                                                                      sheetProvider
                                                                          .isExpandedChannel ==
                                                                          true
                                                                          ? ""
                                                                          : "",
                                                                      textAlign: TextAlign.center,
                                                                    ));
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width:
                                                              sheetProvider.isExpandedChannel ==
                                                                  true
                                                                  ? 3
                                                                  : 0,
                                                            ),
                                                            Consumer<SheetProvider>(
                                                              builder: (context, state, child) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 0.0),
                                                                  child: SizedBox(
                                                                      width: sheetProvider
                                                                          .isExpandedSubChannel ==
                                                                          true
                                                                          ? 110
                                                                          : 0,
                                                                      child: Text(
                                                                        sheetProvider
                                                                            .isExpandedSubChannel ==
                                                                            true
                                                                            ? ""
                                                                            : "",
                                                                        textAlign: TextAlign.center,
                                                                      )),
                                                                );
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: sheetProvider
                                                                  .isExpandedSubChannel ==
                                                                  true
                                                                  ? 3
                                                                  : 0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title: '${coverage1['cy_retailing_sum']}',
                                                                //Billing Percentage
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title: '${coverage1['IYA']}',
                                                                //Billing Percentage
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title: '${coverage2['IYA']}',
                                                                //IYA
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title:
                                                                '${coverage3['IYA']}',
                                                                //IYA
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title:
                                                                '${coverage4['IYA']}',
                                                                //IYA
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title:
                                                                '${coverage5['IYA']}',
                                                                //IYA
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title:
                                                                '${coverage6['cy_retailing_sum']}',
                                                                //IYA
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(left: 0.0),
                                                              child: TextHeaderWidget(
                                                                title:
                                                                '${coverage6['IYA']}',
                                                                //IYA
                                                                align: TextAlign.center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    children: <Widget>[

                                                      dataListRetailingSite.isEmpty?CircularProgressIndicator():SingleChildScrollView(
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 110.0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: MediaQuery.of(context).size.height - 470,
                                                                width: MediaQuery.of(context).size.width - 100,
                                                                child: ListView.builder(
                                                                    shrinkWrap: true,
                                                                    itemCount: dataListRetailingSite[0][0]['data'].length,
                                                                    itemBuilder: (context, index) {
                                                                      var coverage1 = dataListRetailingSite[0][0]['data'][index];
                                                                      var coverage2 = dataListRetailingSite[0][1]['data'][index];
                                                                      var coverage3 = dataListRetailingSite[0][2]['data'][index];
                                                                      var coverage4 = dataListRetailingSite[0][3]['data'][index];
                                                                      var coverage5 = dataListRetailingSite[0][4]['data'][index];
                                                                      var coverage6 = dataListRetailingSite[0][5]['data'][index];
                                                                      return ListTileTheme(
                                                                        dense: true,
                                                                        contentPadding: EdgeInsets.zero,
                                                                        child: ExpansionTile(
                                                                          trailing: const Text(''),
                                                                          textColor: MyColors.textColor,
                                                                          onExpansionChanged: (val) {
                                                                            setState(() {
                                                                              // sheetProvider.isExpandedDivision = val;
                                                                              // sheetProvider.isExpanded = false;
                                                                              sheetProvider.isExpandedBranch = val;
                                                                              sheetProvider.isExpandedChannel = false;
                                                                              sheetProvider.isExpandedSubChannel = false;
                                                                              postRequestByBranch(context);
                                                                            });
                                                                          },
                                                                          // controlAffinity: ListTileControlAffinity.leading,
                                                                          collapsedBackgroundColor: index % 2 == 0
                                                                              ? MyColors.dark600
                                                                              : MyColors.dark400,
                                                                          backgroundColor: index % 2 == 0
                                                                              ? MyColors.dark600
                                                                              : MyColors.dark400,
                                                                          title: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 10.0, top: 5, bottom: 5, right: 5),
                                                                            child: SizedBox(
                                                                              height: 40,
                                                                              child: Row(
                                                                                children: [
                                                                                  TextHeaderWidgetWithIcon(
                                                                                    title: coverage1['site'] == "allIndia" || coverage1['site'] == "All India"?'All India':coverage1['site'],
                                                                                    align: TextAlign.start,
                                                                                    isRequired: false,
                                                                                    isExpanded:
                                                                                    sheetProvider.isExpandedDivision,
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),

                                                                                  Consumer<SheetProvider>(
                                                                                    builder: (context, state, child) {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.only(
                                                                                            left: 0.0),
                                                                                        child: SizedBox(
                                                                                            width: sheetProvider
                                                                                                .isExpandedBranch ==
                                                                                                true
                                                                                                ? 110
                                                                                                : 0,
                                                                                            child: Text(
                                                                                              sheetProvider
                                                                                                  .isExpandedBranch ==
                                                                                                  true
                                                                                                  ? ""
                                                                                                  : "",
                                                                                              textAlign: TextAlign.center,
                                                                                            )),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: sheetProvider.isExpandedBranch ==
                                                                                        true
                                                                                        ? 3
                                                                                        : 0,
                                                                                  ),
                                                                                  Consumer<SheetProvider>(
                                                                                    builder: (context, state, child) {
                                                                                      return SizedBox(
                                                                                          width: sheetProvider
                                                                                              .isExpandedChannel ==
                                                                                              true
                                                                                              ? 110
                                                                                              : 0,
                                                                                          child: Text(
                                                                                            sheetProvider
                                                                                                .isExpandedChannel ==
                                                                                                true
                                                                                                ? ""
                                                                                                : "",
                                                                                            textAlign: TextAlign.center,
                                                                                          ));
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width:
                                                                                    sheetProvider.isExpandedChannel ==
                                                                                        true
                                                                                        ? 3
                                                                                        : 0,
                                                                                  ),
                                                                                  Consumer<SheetProvider>(
                                                                                    builder: (context, state, child) {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.only(
                                                                                            left: 0.0),
                                                                                        child: SizedBox(
                                                                                            width: sheetProvider
                                                                                                .isExpandedSubChannel ==
                                                                                                true
                                                                                                ? 110
                                                                                                : 0,
                                                                                            child: Text(
                                                                                              sheetProvider
                                                                                                  .isExpandedSubChannel ==
                                                                                                  true
                                                                                                  ? ""
                                                                                                  : "",
                                                                                              textAlign: TextAlign.center,
                                                                                            )),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: sheetProvider
                                                                                        .isExpandedSubChannel ==
                                                                                        true
                                                                                        ? 3
                                                                                        : 0,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title: '${coverage1['cy_retailing_sum']}',
                                                                                      //Billing Percentage
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title: '${coverage1['IYA']}',
                                                                                      //Billing Percentage
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title: '${coverage2['IYA']}',
                                                                                      //IYA
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title:
                                                                                      '${coverage3['IYA']}',
                                                                                      //IYA
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title:
                                                                                      '${coverage4['IYA']}',
                                                                                      //IYA
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title:
                                                                                      '${coverage5['IYA']}',
                                                                                      //IYA
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title:
                                                                                      '${coverage6['cy_retailing_sum']}',
                                                                                      //IYA
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 3,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding:
                                                                                    const EdgeInsets.only(left: 0.0),
                                                                                    child: TextHeaderWidget(
                                                                                      title:
                                                                                      '${coverage6['IYA']}',
                                                                                      //IYA
                                                                                      align: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          children: <Widget>[
                                                                            dataListRetailingBranch.isEmpty?CircularProgressIndicator():SingleChildScrollView(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 110.0),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      height: MediaQuery.of(context).size.height - 470,
                                                                                      width: MediaQuery.of(context).size.width - 100,
                                                                                      child: ListView.builder(
                                                                                          shrinkWrap: true,
                                                                                          itemCount: dataListRetailingBranch[0][0]['cm'].length,
                                                                                          itemBuilder: (context, inde) {
                                                                                            var coverage1 = dataListRetailingBranch[0][0]['cm'][inde];
                                                                                            var coverage2 = dataListRetailingBranch[0][0]['p1m'][inde];
                                                                                            var coverage3 = dataListRetailingBranch[0][0]['p3m'][inde];
                                                                                            var coverage4 = dataListRetailingBranch[0][0]['p6m'][inde];
                                                                                            var coverage5 = dataListRetailingBranch[0][0]['p12m'][inde];
                                                                                            var coverage6 = dataListRetailingBranch[0][0]['financial_year'][inde];

                                                                                        // itemCount: dataListCoverageCCTabs[0][0]['cm'].length,
                                                                                        // itemBuilder: (context, indexx) {
                                                                                        // var coverage1 = dataListCoverageCCTabs[0][0]['cm'][indexx];
                                                                                        // var coverage2 = dataListCoverageCCTabs[0][0]['p1m'][indexx];
                                                                                        // var coverage3 = dataListCoverageCCTabs[0][0]['p3m'][indexx];
                                                                                        // var coverage4 = dataListCoverageCCTabs[0][0]['p6m'][indexx];
                                                                                        // var coverage5 = dataListCoverageCCTabs[0][0]['p12m'][indexx];
                                                                                        // var coverage6 = dataListCoverageCCTabs[0][0]['financial_year'][indexx];
                                                                                            return ListTileTheme(
                                                                                              dense: true,
                                                                                              contentPadding: EdgeInsets.zero,
                                                                                              child: ExpansionTile(
                                                                                                trailing: const Text(''),
                                                                                                textColor: MyColors.textColor,
                                                                                                onExpansionChanged: (val) {
                                                                                                  setState(() {
                                                                                                    // sheetProvider.isExpandedDivision = val;
                                                                                                    // sheetProvider.isExpanded = false;
                                                                                                    // sheetProvider.isExpandedBranch = false;
                                                                                                    sheetProvider.isExpandedChannel = val;
                                                                                                    // sheetProvider.isExpandedSubChannel = false;
                                                                                                    postRequestByBranch(context);
                                                                                                  });
                                                                                                },
                                                                                                // controlAffinity: ListTileControlAffinity.leading,
                                                                                                collapsedBackgroundColor: index % 2 == 0
                                                                                                    ? MyColors.dark600
                                                                                                    : MyColors.dark400,
                                                                                                backgroundColor: index % 2 == 0
                                                                                                    ? MyColors.dark600
                                                                                                    : MyColors.dark400,
                                                                                                title: Padding(
                                                                                                  padding: const EdgeInsets.only(
                                                                                                      left: 10.0, top: 5, bottom: 5, right: 5),
                                                                                                  child: SizedBox(
                                                                                                    height: 40,
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        TextHeaderWidgetWithIcon(
                                                                                                          title: coverage1['branch'] == "allIndia" || coverage1['branch'] == "All India"?'All India':coverage1['branch'],
                                                                                                          align: TextAlign.start,
                                                                                                          isRequired: false,
                                                                                                          isExpanded:
                                                                                                          sheetProvider.isExpandedDivision,
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        // Consumer<SheetProvider>(
                                                                                                        //   builder: (context, state, child) {
                                                                                                        //     return Padding(
                                                                                                        //       padding: const EdgeInsets.only(
                                                                                                        //           left: 0.0),
                                                                                                        //       child: SizedBox(
                                                                                                        //           width: sheetProvider
                                                                                                        //               .isExpandedDivision ==
                                                                                                        //               true
                                                                                                        //               ? 110
                                                                                                        //               : 0,
                                                                                                        //           child: Text(
                                                                                                        //             sheetProvider
                                                                                                        //                 .isExpandedDivision ==
                                                                                                        //                 true
                                                                                                        //                 ? ""
                                                                                                        //                 : "",
                                                                                                        //             textAlign: TextAlign.center,
                                                                                                        //           )),
                                                                                                        //     );
                                                                                                        //   },
                                                                                                        // ),
                                                                                                        // SizedBox(
                                                                                                        //   width:
                                                                                                        //   sheetProvider.isExpandedDivision ==
                                                                                                        //       true
                                                                                                        //       ? 3
                                                                                                        //       : 0,
                                                                                                        // ),
                                                                                                        // Consumer<SheetProvider>(
                                                                                                        //   builder: (context, state, child) {
                                                                                                        //     return SizedBox(
                                                                                                        //         width: sheetProvider.isExpanded ==
                                                                                                        //             true
                                                                                                        //             ? 110
                                                                                                        //             : 0,
                                                                                                        //         child: Text(
                                                                                                        //           sheetProvider.isExpanded == true
                                                                                                        //               ? ""
                                                                                                        //               : "",
                                                                                                        //           textAlign: TextAlign.center,
                                                                                                        //         ));
                                                                                                        //   },
                                                                                                        // ),
                                                                                                        // SizedBox(
                                                                                                        //   width: sheetProvider.isExpanded == true
                                                                                                        //       ? 3
                                                                                                        //       : 0,
                                                                                                        // ),
                                                                                                        // Consumer<SheetProvider>(
                                                                                                        //   builder: (context, state, child) {
                                                                                                        //     return Padding(
                                                                                                        //       padding: const EdgeInsets.only(
                                                                                                        //           left: 0.0),
                                                                                                        //       child: SizedBox(
                                                                                                        //           width: sheetProvider
                                                                                                        //               .isExpandedBranch ==
                                                                                                        //               true
                                                                                                        //               ? 110
                                                                                                        //               : 0,
                                                                                                        //           child: Text(
                                                                                                        //             sheetProvider
                                                                                                        //                 .isExpandedBranch ==
                                                                                                        //                 true
                                                                                                        //                 ? ""
                                                                                                        //                 : "",
                                                                                                        //             textAlign: TextAlign.center,
                                                                                                        //           )),
                                                                                                        //     );
                                                                                                        //   },
                                                                                                        // ),
                                                                                                        // SizedBox(
                                                                                                        //   width: sheetProvider.isExpandedBranch ==
                                                                                                        //       true
                                                                                                        //       ? 3
                                                                                                        //       : 0,
                                                                                                        // ),
                                                                                                        Consumer<SheetProvider>(
                                                                                                          builder: (context, state, child) {
                                                                                                            return SizedBox(
                                                                                                                width: sheetProvider
                                                                                                                    .isExpandedChannel ==
                                                                                                                    true
                                                                                                                    ? 110
                                                                                                                    : 0,
                                                                                                                child: Text(
                                                                                                                  sheetProvider
                                                                                                                      .isExpandedChannel ==
                                                                                                                      true
                                                                                                                      ? ""
                                                                                                                      : "",
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                ));
                                                                                                          },
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width:
                                                                                                          sheetProvider.isExpandedChannel ==
                                                                                                              true
                                                                                                              ? 3
                                                                                                              : 0,
                                                                                                        ),
                                                                                                        Consumer<SheetProvider>(
                                                                                                          builder: (context, state, child) {
                                                                                                            return Padding(
                                                                                                              padding: const EdgeInsets.only(
                                                                                                                  left: 0.0),
                                                                                                              child: SizedBox(
                                                                                                                  width: sheetProvider
                                                                                                                      .isExpandedSubChannel ==
                                                                                                                      true
                                                                                                                      ? 110
                                                                                                                      : 0,
                                                                                                                  child: Text(
                                                                                                                    sheetProvider
                                                                                                                        .isExpandedSubChannel ==
                                                                                                                        true
                                                                                                                        ? ""
                                                                                                                        : "",
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                  )),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          width: sheetProvider
                                                                                                              .isExpandedSubChannel ==
                                                                                                              true
                                                                                                              ? 3
                                                                                                              : 0,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title: '${coverage1['cy_retailing_sum']}',
                                                                                                            //Billing Percentage
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title: '${coverage1['IYA']}',
                                                                                                            //Billing Percentage
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title: '${coverage2['IYA']}',
                                                                                                            //IYA
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title:
                                                                                                            '${coverage3['IYA']}',
                                                                                                            //IYA
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title:
                                                                                                            '${coverage4['IYA']}',
                                                                                                            //IYA
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title:
                                                                                                            '${coverage5['IYA']}',
                                                                                                            //IYA
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title:
                                                                                                            '${coverage6['cy_retailing_sum']}',
                                                                                                            //IYA
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                        const SizedBox(
                                                                                                          width: 3,
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.only(left: 0.0),
                                                                                                          child: TextHeaderWidget(
                                                                                                            title:
                                                                                                            '${coverage6['IYA']}',
                                                                                                            //IYA
                                                                                                            align: TextAlign.center,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                children: <Widget>[

                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          }),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
        //   } else {
        //     return const Center(child: CircularProgressIndicator());
        //   }
        // });
  }
}
