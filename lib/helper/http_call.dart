import 'dart:convert';
import 'package:command_centre/helper/env/env_utils.dart';
import 'package:command_centre/helper/hive/hime_manager.dart';
import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/model/summary_model.dart';
import 'package:command_centre/web_dashboard/model/table_coverage_summary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/app_data.dart';
import '../model/cluster_model.dart';
import '../model/coverage/coverage_sumary_model.dart';
import '../model/retailingp12m_data_model.dart';
import '../utils/const/const_array.dart';
import '../utils/const/const_variable.dart';
import '../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../web_dashboard/model/cc_model.dart';
import '../web_dashboard/model/coveragee_model.dart';
import '../web_dashboard/model/fb_web_model.dart';
import '../web_dashboard/model/gp_model.dart';
import '../web_dashboard/model/productivity_model.dart';
import '../web_dashboard/model/retailing_model.dart';
import 'app_urls.dart';
import 'package:command_centre/helper/global/global.dart' as globals;

Future<DataModel> fetchMtdRetailing(BuildContext context) async {
  var selectedDivision = SharedPreferencesUtils.getString('division') ?? '';
  var selectedSite = SharedPreferencesUtils.getString('site') ?? '';
  var selectedMonth = SharedPreferencesUtils.getString('fullMonth') ?? '';
  var selectedIndia = '';
  // print("$selectedSite $selectedDivision");
  // final response = await http.get(Uri.parse('https://command-centre.azurewebsites.net/appData'));
  // final response = await http.get(Uri.parse('https://run.mocky.io/v3/9a68d4bf-4e3c-4fca-9503-953eb1f69f77'));
  if (selectedDivision == "allIndia") {
    selectedIndia = selectedDivision;
  } else {
    selectedIndia = selectedDivision.toLowerCase();
  }
  final response = await http.get(Uri.parse(
      // 'https://run.mocky.io/v3/f215bdf8-d06b-4d14-91a6-45f1bc081417'));
  '${EnvUtils.baseURL}/appData?$selectedIndia=$selectedSite&date=$selectedMonth'), headers: header);
  // print("$BASE_URL/api/appData?$selectedIndia=$selectedSite&date=$selectedMonth");
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    // print(jsonBody);
    return DataModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

// --------------Coverage Summary--------------
Future<CoverageSummary> fetchCoverageSummary(BuildContext context) async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/621f3814-ab0a-406b-931f-3f855854babb'));
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    // print(jsonBody);

    return CoverageSummary.fromJson(jsonBody);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> fetchRetailingP12M() async {
  String url = retailingP12M;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)['data'][0];
    var list = <RetailingP12MModel>[];
    for (var data in json) {
      RetailingP12MModel.fromJson(data);
      list.add(RetailingP12MModel.fromJson(data));
    }
    // return RetailingP12MModel.fromJson(data);
    return list;
  } else {
    throw Exception('Failed to load data');
  }
}

// ---------------------------- Web APIs ----------------------
Future<SummaryModel> fetchSummaryData(BuildContext context) async {
  var dateTime = DateTime.now();
  final bosData = Provider.of<SheetProvider>(context, listen: false);
  var selectedDivision =
      SharedPreferencesUtils.getString('webRetailingDivision') ?? 'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webRetailingSite') ?? 'South-West';
  var selectedMonth = SharedPreferencesUtils.getString('webDefaultMonth') ??
      ConstArray().month[dateTime.month - 3];
  var selectedYear = SharedPreferencesUtils.getString('webDefaultYear') ??
      '${dateTime.year}';
  var finalMonth = "$selectedMonth-$selectedYear"; 

  print("$selectedMonth-$selectedYear");

  // List<dynamic> filterGP = bosData.allSummaryGPList.map((item) {
  //   return {"filter": item["filter"]};
  // }).toList();
  // List<dynamic> updatedListGP = filterGP.map((item) {
  //   item["date"] = finalMonth;
  //   return item;
  // }).toList();
  // List<dynamic> filterFP = bosData.allSummaryFBList.map((item) {
  //   return {"filter": item["filter"]};
  // }).toList();
  // List<dynamic> updatedListFP = filterFP.map((item) {
  //   item["date"] = finalMonth;
  //   return item;
  // }).toList();
  // List<dynamic> filterCC = bosData.allSummaryCCList.map((item) {
  //   return {"filter": item["filter"]};
  // }).toList();
  // List<dynamic> updatedListCC = filterCC.map((item) {
  //   item["date"] = finalMonth;
  //   return item;
  // }).toList();
  // List<dynamic> filterCoverage = bosData.allSummaryCoverageList.map((item) {
  //   return {"filter": item["filter"]};
  // }).toList();
  // List<dynamic> updatedListCoverage = filterCoverage.map((item) {
  //   item["date"] = finalMonth;
  //   return item;
  // }).toList();
  // List<dynamic> filterProd = bosData.allSummaryProdList.map((item) {
  //   return {"filter": item["filter"]};
  // }).toList();
  // List<dynamic> updatedListProd = filterProd.map((item) {
  //   item["date"] = finalMonth;
  //   return item;
  // }).toList();
  // List<dynamic> filterRetailing = bosData.allSummaryRetailingList.map((item) {
  //   return {"filter": item["filter"]};
  // }).toList();
  // List<dynamic> updatedListRetailing = filterRetailing.map((item) {
  //   item["date"] = finalMonth;
  //   return item;
  // }).toList();
  // print(updatedListGP);
  // print(updatedListFP);
  // print(updatedListCC);
  // print(updatedListCoverage);
  // print(updatedListProd);
  // print(updatedListRetailing);

  var body = json.encode([
    {
      "filter_key": "retailing",
      "query":[
        {
          "allIndia": "allIndia",
          "date": finalMonth
        },
        {
          "division": "North-East",
          "date": finalMonth
        },
        {
          "cluster": "HR",
          "date": finalMonth
        }
      ]
    },
    {
      "filter_key": "gp",
      "query":[
        {
          "allIndia": "allIndia",
          "date": finalMonth
        },
        {
          "division": "N-E",
          "date": finalMonth
        },
        {
          "cluster": "HR",
          "date": finalMonth
        }
      ]

    },
    {
      "filter_key": "fb",
      "query":[
        {
          "allIndia": "allIndia",
          "date": finalMonth
        },
        {
          "division": "N-E",
          "date": finalMonth
        },
        {
          "cluster": "HR",
          "date": finalMonth
        }
      ]

    },
    {
      "filter_key": "cc",
      "query":[
        {
          "allIndia": "allIndia",
          "date": finalMonth
        },
        {
          "division": "N-E",
          "date": finalMonth
        },
        {
          "cluster": "HR",
          "date": finalMonth
        }
      ]

    },
    {
      "filter_key": "coverage",
      "query":[
        {
          "allIndia": "allIndia",
          "date": finalMonth
        },
        {
          "division": "N-E",
          "date": finalMonth
        },
        {
          "cluster": "HR",
          "date": finalMonth
        }
      ]

    },
    {
      "filter_key": "productivity",
      "query":[
        {
          "allIndia": "allIndia",
          "date": finalMonth
        },
        {
          "division": "N-E",
          "date": finalMonth
        },
        {
          "cluster": "HR",
          "date": finalMonth
        }
      ]

    }
  ]);

  print(body);
  final response = await http.post(
      Uri.parse('$BASE_URL/api/webSummary/allDefaultData'),
      // Uri.parse('https://run.mocky.io/v3/d2007bee-dbcd-446d-8b86-cf5ca19a20ee'),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addRetailingItem(jsonBody.toSet().toList());
    String jsonRetailing = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonAllSummary", jsonRetailing);
    return SummaryModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<RetailingModel> fetchRetailingWeb(
    BuildContext context, String month) async {
  var dateTime = DateTime.now();
  var selectedDivision =
      SharedPreferencesUtils.getString('webRetailingDivision') ?? 'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webRetailingSite') ?? 'South-West';
  var selectedMonth = SharedPreferencesUtils.getString('webRetailingMonth') ??
      ConstArray().month[dateTime.month - 4];
  var selectedYear = SharedPreferencesUtils.getString('webRetailingYear') ??
      '${dateTime.year}';

  final response = await http.get(Uri.parse(
      '$BASE_URL/api/webSummary/retailingData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite'));
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);

    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addRetailingItem(jsonBody.toSet().toList());
    String jsonRetailing = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonRetailing", jsonRetailing);
    return RetailingModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<GPModel> fetchGPWeb(BuildContext context) async {
  var dateTime = DateTime.now();
  var selectedDivision =
      SharedPreferencesUtils.getString('webGPDivision') ?? 'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webGPSite') ?? 'South-West';
  var selectedMonth = SharedPreferencesUtils.getString('webGPMonth') ??
      ConstArray().month[dateTime.month - 4];
  var selectedYear =
      SharedPreferencesUtils.getString('webGPYear') ?? '${dateTime.year}';

  final response = await http.get(Uri.parse(
      '$BASE_URL/api/webSummary/gpData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite'));
  // print('$BASE_URL/api/webSummary/gpData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite');
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);

    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addGPItem(jsonBody.toSet().toList());
    String jsonGP = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonGP", jsonGP);
    return GPModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<CoverageModel> fetchCoverageWeb(BuildContext context) async {
  var dateTime = DateTime.now();
  var selectedDivision =
      SharedPreferencesUtils.getString('webCoverageDivision') ?? 'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webCoverageSite') ?? 'South-West';
  var selectedMonth = SharedPreferencesUtils.getString('webCoverageMonth') ??
      ConstArray().month[dateTime.month - 4];
  var selectedYear =
      SharedPreferencesUtils.getString('webCoverageYear') ?? '${dateTime.year}';
  // print("DivisionD $selectedDivision");
  // print("DivisionS $selectedSite");
  // print("DivisionS $selectedMonth");
  final response = await http.get(Uri.parse(
      '$BASE_URL/api/webSummary/CBPData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite'));

  // print("$BASE_URL/api/webSummary/CBPData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite");
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);

    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addCoverageItem(jsonBody.toSet().toList());
    String jsonCoverage = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonCoverage", jsonCoverage);
    return CoverageModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<FBModel> fetchFocusBWeb(BuildContext context) async {
  var dateTime = DateTime.now();
  var selectedDivision =
      SharedPreferencesUtils.getString('webFBDivision') ?? 'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webFBSite') ?? 'South-West';
  var selectedMonth = SharedPreferencesUtils.getString('webFBMonth') ??
      ConstArray().month[dateTime.month - 4];
  var selectedYear =
      SharedPreferencesUtils.getString('webFBYear') ?? '${dateTime.year}';

  final response = await http.get(Uri.parse(
      '$BASE_URL/api/webSummary/FBData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite'));
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);

    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addFBItem(jsonBody.toSet().toList());
    String jsonFB = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonFB", jsonFB);
    return FBModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ProductivityModel> fetchProductivityWeb(BuildContext context) async {
  var dateTime = DateTime.now();
  var selectedDivision =
      SharedPreferencesUtils.getString('webProductivityDivision') ?? 'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webProductivitySite') ?? 'South-West';
  var selectedMonth =
      SharedPreferencesUtils.getString('webProductivityMonth') ??
          ConstArray().month[dateTime.month - 4];
  var selectedYear = SharedPreferencesUtils.getString('webProductivityYear') ??
      '${dateTime.year}';

  final response = await http.get(Uri.parse(
      '$BASE_URL/api/webSummary/ProductivityData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite'));
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);

    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addProductivityItem(jsonBody.toSet().toList());
    String jsonProd = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonProd", jsonProd);
    return ProductivityModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<CCModel> fetchCCWeb(BuildContext context) async {
  var dateTime = DateTime.now();
  var selectedDivision =
      SharedPreferencesUtils.getString('webCallComplianceDivision') ??
          'division';
  var selectedSite =
      SharedPreferencesUtils.getString('webCallComplianceSite') ?? 'South-West';
  var selectedMonth =
      SharedPreferencesUtils.getString('webCallComplianceMonth') ??
          ConstArray().month[dateTime.month - 4];
  var selectedYear =
      SharedPreferencesUtils.getString('webCallComplianceYear') ??
          '${dateTime.year}';

  final response = await http.get(Uri.parse(
      '$BASE_URL/api/webSummary/ccData?date=$selectedMonth-$selectedYear&$selectedDivision=$selectedSite'));
  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);

    final bosData = Provider.of<SheetProvider>(context, listen: false);
    bosData.addccItem(jsonBody.toSet().toList());
    String jsonCC = jsonEncode(jsonBody) ?? '';
    SharedPreferencesUtils.setString("jsonCC", jsonCC);
    return CCModel.fromJson(jsonBody[0]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> getTableCoverageSummary() async {
  String url = 'https://run.mocky.io/v3/a3d7e8a1-07a7-4204-af35-27402c0a81ba';
  // String url = 'https://run.mocky.io/v3/de82c0e5-9eb5-488c-8734-51f7ce413c10';
  final response = await http.get(Uri.parse(url));
  try {
    var data = <TableCoverageSummary>[];
    var res = jsonDecode(response.body);
    for (var i in res[0]) {
      data.add(TableCoverageSummary.fromJson(i));
    }
    return data;
  } catch (error) {
    print('getCoverageSummary: $error');
  }
}

Future<String>? itemDataAPI(context) async {
  var cluster =
      SharedPreferencesUtils.getString('webCoverageSheetDivision') ?? allIndia;
  var clusterSite =
      SharedPreferencesUtils.getString('webCoverageSheetSite') ?? allIndia;
  var clusterMonth =
      SharedPreferencesUtils.getString('webCoverageMonth') ?? 'Jun';
  var clusterYear =
      SharedPreferencesUtils.getString('webCoverageYear') ?? '2023';
  final bosData = Provider.of<SheetProvider>(context, listen: false);
  var channelName = bosData.selectedChannel;
  var urlEncode = Uri.encodeFull(channelName);
  String encodedChannelParam = Uri.encodeComponent(urlEncode);
  var allIndiaNew = bosData.selectedChannelSite;
  if (allIndiaNew == 'All India') {
    allIndiaNew = 'allIndia';
  } else {
    allIndiaNew = bosData.selectedChannelSite;
  }
  // print("$cluster, $clusterSite, $clusterMonth, $clusterYear");
  var url = 'https://run.mocky.io/v3/174e57f0-aa4f-40ce-8c4c-43e661047344';
  // '$BASE_URL/api/webDeepDive/coverage/branch?date=$clusterMonth-$clusterYear&$cluster=$clusterSite';
  // bosData.isSelectedChannel == true?"$BASE_URL/api/webDeepDive/coverage/subChannel?date=${bosData.selectedChannelMonthFilter}-2023&${bosData.selectedChannelDivision}=$allIndiaNew&channel=$encodedChannelParam":
  //     "$BASE_URL/api/webDeepDive/coverage/subChannel?date=$clusterMonth-$clusterYear&$cluster=$clusterSite&channel=$encodedChannelParam";
  // print(url);

  var response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  });
  if (response.statusCode == 200) {
    var jsonResponse = await jsonDecode(response.body);
    // setState(() {
    //   print(jsonResponse);
    String jsonCoverage = jsonEncode(jsonResponse) ?? '';
    // bosData.storeCoverageData = jsonCoverage;
    // SharedPreferencesUtils.setString(
    //     "coverageTable", jsonEncode(jsonCoverage));
    // });
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return '';
}

//  sendRequest(context) async {
//
//   List<Map<String, String>> data = [
//     {
//       "allIndia": "allIndia",
//       "month": "Jun-2023",
//       "channel": ""
//     }
//   ];
//   final bosData = Provider.of<SheetProvider>(context, listen: false);
//   var url = '$BASE_URL/api/webDeepDive/coverage/subChannel';
//   http.post(Uri.parse(url), body: [
//     {
//       "allIndia": "allIndia",
//       "month": "Jun-2023",
//       "channel": ""
//     }
//   ])
//       .then((response) async {
//     print("Response status: ${response.statusCode}");
//     print("Response body: ${response.body}");
//     var jsonResponse = await jsonDecode(response.body[0]);
//     String jsonCoverage = jsonEncode(jsonResponse) ?? '';
//     bosData.storeCoverageData = jsonCoverage;
//   });
//
// }
