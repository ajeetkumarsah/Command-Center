import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/helper/global/global.dart';
import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/deep_dive_container/retailing_Container/reatiling_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;

import '../comman_utils/drawer_widget.dart';

class RetailingContainerDrawer extends StatefulWidget {
  const RetailingContainerDrawer({super.key});

  @override
  State<RetailingContainerDrawer> createState() =>
      _RetailingContainerDrawerState();
}

class _RetailingContainerDrawerState extends State<RetailingContainerDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedTapAPI = 0;
  List<dynamic> dataListCoverage = [];
  List<dynamic> dataListCoverageProdTabs = [];
  List<dynamic> dataListCoverageBillingTabs = [];
  List<dynamic> dataListCoverageCCTabs = [];
  List<dynamic> dataListCoverage1 = [];
  List<dynamic> dataListCoverageProdTabs1 = [];
  List<dynamic> dataListCoverageBillingTabs1 = [];
  List<dynamic> dataListCoverageCCTabs1 = [];
  List<dynamic> flattenedList = [];
  List<dynamic> flattenedListCC = [];
  List<dynamic> flattenedListProd = [];
  List<dynamic> flattenedListBilling = [];
  var divisionCount = [];
  var clusterCount = [];
  var siteCount = [];
  String monthNew = '';
  String channelNew = '';
  List<String> selectedItemValueChannel = [];
  List<String> selectedItemValueCategory = [];
  List<String> selectedItemValueBrand = [];
  List<String> selectedItemValueBrandForm = [];
  List<String> selectedItemValueBrandFromGroup = [];
  String selectedCategoryList = 'Select..';
  RegExp pattern1 =
      RegExp(r'\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-\d{4}\b');
  RegExp pattern2 = RegExp(
      r'\bCY\d{4}-(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b');

  List<dynamic> flattenedListCoverageCV = [];
  List<dynamic> flattenedListCoverageCategory = [];
  List<dynamic> flattenedListCoverageChannel = [];
  List<dynamic> flattenedListCoverageTrend = [];
  List<String> selectedArrayItems = [];
  List<String> selectedArrayItemsCategory = [];
  List<String> selectedArrayItemsChannel = [];
  List<String> selectedArrayItemsTrend = [];
  List<String> selectedArrayItemsSite = [];

  bool menuBool = false;
  bool divisionBool = false;
  bool removeBool = false;

  List<dynamic> listRetailing = [];
  List<dynamic> listRetailing1 = [];
  List<dynamic> listRetailingData = [];
  List<dynamic> listRetailingData1 = [];
  List<dynamic> listRetailingDataListCoverage = [];
  bool geoUpdateBool = false;
  bool defaultMonthPressed = false;
  List<dynamic> updatedListRetailing = [];

  Future<String>? divisionFilterAPI() async {
    // var url = 'https://run.mocky.io/v3/9aa3f386-5275-4213-9372-dcaf9d068388';
    var url = '$BASE_URL/api/appData/divisionFilter';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await jsonDecode(response.body)['data'];
      setState(() {
        divisionCount = jsonResponse;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }

  Future<String>? clusterFilterAPI() async {
    // var url = 'https://run.mocky.io/v3/9aa3f386-5275-4213-9372-dcaf9d068388';
    var url = '$BASE_URL/api/appData/clusterFilter';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await jsonDecode(response.body)['data'];
      setState(() {
        clusterCount = jsonResponse;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }

  Future<String>? siteFilterAPI() async {
    // var url = 'https://run.mocky.io/v3/9aa3f386-5275-4213-9372-dcaf9d068388';
    var url = '$BASE_URL/api/appData/siteFilter';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await jsonDecode(response.body)['data'];
      setState(() {
        siteCount = jsonResponse;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }

  Future<http.Response> postRequest(context) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
    var body = json.encode(flattenedList.isEmpty
        ? [
            {
              "allIndia": "allIndia",
              "date": "May-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedList);
    // print("Body Retailing Tab 1 $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
        // print(dataListCoverage);
      });
    } else {
      print("Else");
      setState(() {
        provider.setRetailingErrorMsg([response.body]);
        // provider.isLoaderActive = false;
      });
    }
    return response;
  }

  Future<http.Response> postRequestByGeo(context) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/rt/geo/monthlyData';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode(flattenedListCC.isEmpty
        ? flattenedListCC = [
            {
              "allIndia": "allIndia",
              "date": "May-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedListCC.toSet().toList());
    // print("Body Retailing Tab 2 $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);
        // print("Response Tab 2=> $dataListCoverageCCTabs");
      });
    } else {
      print("Else");
      setState(() {
        provider.setRetailing1ErrorMsg([response.body]);
        // provider.isLoaderActive = false;
      });
    }
    return response;
  }

  Future<http.Response> postRequestByCategory(context) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/rt/geo/monthlyData';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode(flattenedListBilling.isEmpty
        ? flattenedListBilling = [
      {
        "allIndia": "allIndia",
        "date": "May-2023",
        "brandForm": "",
        "brand": "",
        "sbfGroup": "",
        "category": "",
        "channel": []
      }
    ]
        : flattenedListBilling.toSet().toList());
    // print("Body Retailing Tab 3 $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageBillingTabs = jsonDecode(response.body);
        // print("Response Tab 3=> $dataListCoverageProdTabs");
      });
    } else {
      print("Else");
      setState(() {
        provider.setRetailing2ErrorMsg([response.body]);
        // provider.isLoaderActive = false;
      });
    }
    return response;
  }

  Future<http.Response> postRequestByChannel(context) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/rt/geo/monthlyData';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode(flattenedListProd.isEmpty
        ? flattenedListProd = [
            {
              "allIndia": "allIndia",
              "date": "May-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedListProd.toSet().toList());
    // print("Body Retailing Tab 3 $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageProdTabs = jsonDecode(response.body);
        // print("Response Tab 3=> $dataListCoverageProdTabs");
      });
    } else {
      print("Else");
      setState(() {
        provider.setRetailing3ErrorMsg([response.body]);
        // provider.isLoaderActive = false;
      });
    }
    return response;
  }

  /////////////////////// API Call for All Cards End//////////////////////
  Future<http.Response> postRequestRetailing(context) async {
    var url = '$BASE_URL/api/webSummary/allDefaultData';
    listRetailingData1 =
    [
      {
        findDatasetName(
            SharedPreferencesUtils.getString('webRetailingSite')!):
        SharedPreferencesUtils.getString('webRetailingSite'),
        "date": "${SharedPreferencesUtils.getString('webCoverageMonth') ?? "Jun"}-${SharedPreferencesUtils.getString('webCoverageYear') ?? "2023"}"
        // Here to change month
      }
    ];
    var body = json.encode(listRetailingData.isEmpty
        ? listRetailingData = [
      {"filter_key": "retailing", "query": listRetailingData1},
      {"filter_key": "gp", "query": []},
      {"filter_key": "fb", "query": []},
      {"filter_key": "cc", "query": []},
      {"filter_key": "coverage", "query": []},
      {"filter_key": "productivity", "query": []}
    ]
        : listRetailingData);
    print("Summary Body ${json.encode(listRetailingData)}");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        listRetailingDataListCoverage = jsonDecode(response.body);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  /////////////////////// API Call for All Cards End//////////////////////

  /////////////////////// Local Storage for All Cards Start//////////////////////


// TODO: Here
  void saveDataCoverageAllRetailing() {
    final jsonData = jsonEncode(listRetailingData);
    html.window.localStorage['dataSummaryNewRe'] = jsonData;
  }

  void loadDataCoverageAllRetailing() {
    final storedValue = html.window.localStorage['dataSummaryNewRe'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          listRetailingData = decodedData;
        });
      }
    }
  }

  void addDataCoverageAllRetailing() async {
    dynamic decodedRetailing = listRetailingData1;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
          if(listRetailingData.isEmpty){
            listRetailingData.add([
              {"filter_key": "retailing", "query": listRetailingData1},
              {"filter_key": "gp", "query": []},
              {"filter_key": "fb", "query": []},
              {"filter_key": "cc", "query": []},
              {"filter_key": "coverage", "query": []},
              {"filter_key": "productivity", "query": []}
            ]);
          }else{
            if(defaultMonthPressed){
              listRetailingData.map((entry) {
                if (entry['filter_key'] == 'retailing') {
                  final queries = entry['query'];
                  for (final query in queries) {
                    if (query.containsKey('date')) {
                      query['date'] = "${SharedPreferencesUtils.getString('webCoverageMonth') ?? "Jun"}-${SharedPreferencesUtils.getString('webCoverageYear') ?? "2023"}"; // Replace 'UpdatedDate' with your desired date
                    }
                  }
                }
                return entry;
              }).toList();
              defaultMonthPressed = false;
            }else{
              listRetailingData = [
                {"filter_key": "retailing", "query": jsonToAdd},
                {"filter_key": "gp", "query": []},
                {"filter_key": "fb", "query": []},
                {"filter_key": "cc", "query": []},
                {"filter_key": "coverage", "query": []},
                {"filter_key": "productivity", "query": []}
              ];
            }

          }
      });
      saveDataCoverageAllRetailing();
    }
  }

// TODO: Here
  void saveDataRetailing() {
    final jsonData = jsonEncode(listRetailingData);
    html.window.localStorage['dataListRetailingAllData'] = jsonData;
  }

  void loadDataRetailing() {
    final storedValue = html.window.localStorage['dataListRetailingAllData'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          listRetailingData = decodedData;
        });
      }
    }
  }

  void addDataRetailing() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = updatedListRetailing;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (listRetailingData.isEmpty) {
          listRetailingData.add({
            findDatasetName(
                SharedPreferencesUtils.getString('webRetailingSite')!):
            SharedPreferencesUtils.getString('webRetailingSite'),
            "date": 'Jun-2023'
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            listRetailingData[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              print("1. $listRetailingData");
              print("2. ${jsonToAdd[0]}");
              print("3. $jsonToAdd");
              if (geoUpdateBool) {
                listRetailingData[0] = jsonToAdd[0];
              } else {
                listRetailingData.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataRetailing();
    }
  }

// TODO: Here
  void saveDataCoverageAll() {
    final jsonData = jsonEncode(flattenedList);
    html.window.localStorage['dataListRetailingDataAllLocal'] = jsonData;
  }

  void loadDataCoverageAll() {
    final storedValue = html.window.localStorage['dataListRetailingDataAllLocal'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedList = decodedData;
        });
      }
    }
  }

  void addDataCoverageAll(channel, month) async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = dataListCoverage1;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (flattenedList.isEmpty) {
          flattenedList.add({
            "allIndia": "allIndia",
            "date": "Jun-2023",
            "brandForm": "",
            "brand": "",
            "sbfGroup": "",
            "category": "",
            "channel": []
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            if (dataListCoverage.isEmpty) {
              flattenedList[bosData.selectedChannelIndex]["channel"] = [];
              bosData.isExpandedMonthFilter = false;
            } else {
              for (String element in jsonToAdd) {
                flattenedList[bosData.selectedChannelIndex]["channel"]
                    .add(element);
              }
              // flattenedList[bosData.selectedChannelIndex]["channel"].add(jsonToAdd[0]);
              bosData.isExpandedMonthFilter = false;
            }
          } else if (bosData.isExpandedMonthCDFilter) {
            flattenedList[bosData.selectedChannelIndex]['date'] =
                jsonToAdd[0].toString();
            bosData.isExpandedMonthCDFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedList.add(jsonToAdd[0]);
            }
          }
        }
      });
      saveDataCoverageAll();
    }
    // await postRequest(context);
  }

// TODO: Here
  void saveDataCoverageCC() {
    final jsonData = jsonEncode(flattenedListCC);
    html.window.localStorage['dataListRetailingDataGeoAll'] = jsonData;
  }

  void loadDataCoverageCC() {
    final storedValue = html.window.localStorage['dataListRetailingDataGeoAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCC = decodedData;
        });
      }
    }
  }

  void addDataCoverageCC(channel, month) async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = dataListCoverageCCTabs1;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;

      setState(() {
        if (bosData.isExpandedMonthFilter) {
          if (dataListCoverageCCTabs1.isEmpty) {
            flattenedListCC[bosData.selectedChannelIndex]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListCC[bosData.selectedChannelIndex]["channel"]
                  .add(element);
            }

            // flattenedListCC[bosData.selectedChannelIndex]["channel"].add(jsonToAdd.join(', '));
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListCC[bosData.selectedChannelIndex]['date'] =
              jsonToAdd[0].toString();
          bosData.isExpandedMonthCDFilter = false;
        } else {
          if (jsonToAdd.isNotEmpty) {
            if (!flattenedListCC.contains(jsonToAdd[0])) {
              flattenedListCC.add(jsonToAdd[0]);
            } else {
              print("Value already exists in flattenedListCC");
            }
          }
        }
      });
      saveDataCoverageCC();
    }
  }

  // TODO: Here
  void saveDataCoverageProd() {
    final jsonData = jsonEncode(flattenedListProd);
    html.window.localStorage['dataListRetailingDataChannelAll'] = jsonData;
  }

  void loadDataCoverageProd() {
    final storedValue =
        html.window.localStorage['dataListRetailingDataChannelAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListProd = decodedData;
        });
      }
    }
  }

  void addDataCoverageProd(channel, month) async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = dataListCoverageProdTabs1;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;

      setState(() {
        if (bosData.isExpandedMonthFilter) {
          if (dataListCoverage.isEmpty) {
            flattenedListProd[bosData.selectedChannelIndex]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            flattenedListProd[bosData.selectedChannelIndex]["channel"]
                .add(jsonToAdd[0]);
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListProd[bosData.selectedChannelIndex]['date'] =
              jsonToAdd[0].toString();
          bosData.isExpandedMonthCDFilter = false;
        }
        // if (bosData.isExpandedMonthFilter) {
        //   flattenedListProd[bosData.selectedChannelIndex] = jsonToAdd[0];
        //   bosData.isExpandedMonthFilter = false;
        // }
        else {
          if (jsonToAdd.isNotEmpty) {
            if (!flattenedListProd.contains(jsonToAdd[0])) {
              flattenedListProd.add(jsonToAdd[0]);
            } else {
              print("Value already exists in flattenedListCC");
            }
          }
        }
      });
      saveDataCoverageProd();
    }
  }


  // TODO: Here
  void saveDataCoverageBilling() {
    final jsonData = jsonEncode(flattenedListBilling);
    html.window.localStorage['dataListRetailingDataChannelDataAll'] = jsonData;
  }

  void loadDataCoverageBilling() {
    final storedValue =
    html.window.localStorage['dataListRetailingDataChannelDataAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListBilling = decodedData;
        });
      }
    }
  }

  void addDataCoverageBilling(channel, month) async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = dataListCoverageBillingTabs1;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;

      setState(() {
        if (bosData.isExpandedMonthFilter) {
          if (dataListCoverageBillingTabs.isEmpty) {
            flattenedListBilling[bosData.selectedChannelIndex]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            flattenedListBilling[bosData.selectedChannelIndex]["channel"]
                .add(jsonToAdd[0]);
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListBilling[bosData.selectedChannelIndex]['date'] =
              jsonToAdd[0].toString();
          bosData.isExpandedMonthCDFilter = false;
        }
        // if (bosData.isExpandedMonthFilter) {
        //   flattenedListProd[bosData.selectedChannelIndex] = jsonToAdd[0];
        //   bosData.isExpandedMonthFilter = false;
        // }
        else {
          if (jsonToAdd.isNotEmpty) {
            if (!flattenedListBilling.contains(jsonToAdd[0])) {
              flattenedListBilling.add(jsonToAdd[0]);
            } else {
              print("Value already exists in flattenedListCC");
            }
          }
        }
      });
      saveDataCoverageBilling();
    }
  }

  void removeDataAll(int index) {
    if (flattenedList.isNotEmpty) {
      setState(() {
        flattenedList.removeAt(index);
      });
      saveDataCoverageAll();
    }
  }

  void removeDataCCR(int index) {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    if (flattenedListCC.isNotEmpty) {
      setState(() {
        flattenedListCC[bosData.selectedChannelIndex]["channel"]
            .removeAt(index);
      });
      saveDataCoverageCC();
    }
  }

  void removeDataDaily(int index) {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    if (flattenedList.isNotEmpty) {
      setState(() {
        flattenedList[bosData.selectedChannelIndex]["channel"]
            .removeAt(index);
      });
      saveDataCoverageAll();
    }
  }

  void removeDataRetailing(int index) {
    if (index >= 0 && index < listRetailingData.length) {
      setState(() {
        listRetailingData.removeAt(index);
        saveDataCoverageAllRetailing(); // Save the updated list after removal
      });
    }
  }

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<String> getLast24Months() {
    var currentDate = DateTime.now();
    var last24Months = <String>[];

    for (var i = 0; i < 24; i++) {
      var year = currentDate.year - ((currentDate.month - i - 1) < 0 ? 1 : 0);
      var monthIndex = ((currentDate.month - i - 1) % 12 + 12) %
          12; // Ensure positive month index
      var month = months[monthIndex];
      last24Months.add('$month $year');
    }

    return last24Months;
  }

  String _selectedMonth = '';
  String _selectedSite = '';

  String _getShortMonthName(String fullName) {
    return fullName.substring(0, 3);
  }

  List<String> channelFilter = [];

  Future<List<String>> postRequestChannel(context) async {
    var url = '$BASE_URL/api/appData/channelFilter/category';

    var body = json.encode({"table": "fb", "date": "Jun-2023"});
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      setState(() {
        channelFilter = categories;
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return channelFilter;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    divisionFilterAPI();
    clusterFilterAPI();
    siteFilterAPI();
    addDataCoverageAll('', 'Jun-2023');
    loadDataCoverageAllRetailing();
    postRequest(context);
    loadDataCoverageAll();
    loadDataCoverageCC();
    _selectedMonth = getLast24Months()[0];
    postRequestChannel(context);
    postRequestRetailing(context);
  }

  @override
  Widget build(BuildContext context) {
    var last24Months = getLast24Months();
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/svg/image65.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DrawerWidget(
                  indexNew: 1,
                ),
                RetailingContainer(
                  onGeoChanged: () {},
                  onClosedTap: () async {
                    sheetProvider.isLoaderActive = true;
                    setState(() {
                      removeDataAll(sheetProvider.removeIndexRe);
                    });
                    await postRequest(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  onApplyPressedMonth: () async {
                    sheetProvider.isExpandedMonthFilter =
                    false;
                    sheetProvider.isExpandedMonthCDFilter =
                    false;
                    sheetProvider.isLoaderActive = true;
                    sheetProvider.selectMonth = false;
                    var division = SharedPreferencesUtils.getString(
                        'webCoverageSheetDivision');
                    var site = SharedPreferencesUtils.getString(
                        'webCoverageSheetSite');
                    var year =
                        SharedPreferencesUtils.getString('webCoverageYear');
                    var month =
                        SharedPreferencesUtils.getString('webCoverageMonth');
                    var finalDivision =
                        division == 'All India' || division == ""
                            ? 'allIndia'
                            : division;
                    var finalSite =
                        site == 'All India' || site == "" ? 'allIndia' : site;
                    if (selectedTapAPI == 0) {
                      dataListCoverage1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      addDataCoverageAll("", "");
                      setState(() {});
                      await postRequest(context);
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 1) {
                      dataListCoverageCCTabs1 = [];
                      dataListCoverageCCTabs1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      addDataCoverageCC('', '');
                      setState(() {});
                      await postRequestByGeo(context);
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 2) {
                      dataListCoverageProdTabs1 = [];
                      dataListCoverageProdTabs1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      addDataCoverageProd('', '');
                      setState(() {});
                      await postRequestByCategory(context);
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 3) {
                      dataListCoverageBillingTabs1 = [];
                      dataListCoverageBillingTabs1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      addDataCoverageBilling('', '');
                      setState(() {});
                      await postRequestByChannel(context);
                      sheetProvider.isLoaderActive = false;
                    }
                  },
                  onTap1: () async {
                    setState(() {
                      selectedTapAPI = 0;
                      sheetProvider.isCurrentTab = 0;
                    });
                    sheetProvider.isLoaderActive = true;
                    // await postRequest(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  onTap2: () async {
                    setState(() {
                      selectedTapAPI = 1;
                      sheetProvider.isCurrentTab = 1;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestByGeo(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  onTap3: () async {
                    setState(() {
                      selectedTapAPI = 2;
                      sheetProvider.isCurrentTab = 2;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestByGeo(context);

                    // await postRequestByCategory(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  onTap4: () async {
                    setState(() {
                      selectedTapAPI = 3;
                      sheetProvider.isCurrentTab = 3;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestByGeo(context);

                    // await postRequestByChannel(context);
                    // await postRequestBillingTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                  },
                  selectedIndex1: selectedTapAPI,
                  divisionList: divisionCount,
                  siteList: siteCount,
                  branchList: [],
                  selectedGeo: 0,
                  clusterList: clusterCount,
                  dataList: dataListCoverage,
                  onTapMonthFilter: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0),
                            title: Container(
                              color: MyColors.dark600,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Select Month',
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff344C65)),
                                ),
                              ),
                            ),
                            content: SizedBox(
                              width: 300,
                              height: 400,
                              child: ListView.builder(
                                itemCount: getLast24Months().length,
                                itemBuilder: (context, index) {
                                  var monthYear = last24Months[index];
                                  var shortMonth = _getShortMonthName(
                                      monthYear.split(' ')[0]);
                                  var year = monthYear.split(' ')[1];
                                  return ListTile(
                                    title: Text(getLast24Months()[index]),
                                    onTap: () async {
                                      setState(() {
                                        _selectedMonth = monthYear;
                                        sheetProvider.isExpandedMonthFilter =
                                        false;
                                        sheetProvider.isExpandedMonthCDFilter =
                                            true;
                                        monthNew = "$shortMonth-$year";
                                      });
                                      if (selectedTapAPI == 0) {
                                        dataListCoverage1 = [];
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverage1 = [
                                          monthNew,
                                        ];
                                        setState(() {});
                                        addDataCoverageAll('', monthNew);
                                        Navigator.pop(context);
                                        await postRequest(context);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 1) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageCCTabs1 = [monthNew];
                                        setState(() {});
                                        addDataCoverageCC('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestByGeo(context);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 2) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageProdTabs1 = [
                                          monthNew,
                                        ];
                                        setState(() {});
                                        addDataCoverageProd('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestByChannel(context);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 3) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageBillingTabs1 = [
                                          monthNew,

                                        ];
                                        setState(() {});
                                        addDataCoverageBilling('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestByChannel(context);
                                        sheetProvider.isLoaderActive = false;
                                      } else {}
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: MyColors.primary),
                                  ))
                            ],
                          );
                        });
                  },
                  selectedItemValueChannel: selectedItemValueChannel,
                  onChangedFilter: (value) async {},
                  onRemoveFilter: () async {
                    // sheetProvider.isExpandedMonthFilter = true;
                    // sheetProvider.isLoaderActive = true;
                    // var finalMonth = "Jun-2023";
                    // if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                    //   finalMonth = sheetProvider.myStringMonthFB;
                    // } else if (pattern2
                    //     .hasMatch(sheetProvider.myStringMonthFB)) {
                    //   String year =
                    //       sheetProvider.myStringMonthFB.substring(2, 6);
                    //   String month = sheetProvider.myStringMonthFB.substring(7);
                    //   finalMonth = "$month-$year";
                    // } else {
                    //   finalMonth = "Jun-2023";
                    // }
                    // dataListCoverage1 = [
                    //   {
                    //     sheetProvider.selectedChannelDivision:
                    //         sheetProvider.selectedChannelSite == "All India"
                    //             ? 'allIndia'
                    //             : sheetProvider.selectedChannelSite,
                    //     "date": finalMonth,
                    //     "brandForm": "",
                    //     "brand": "",
                    //     "sbfGroup": "",
                    //     "category":
                    //         sheetProvider.selectedCategoryFilter == "Select.."
                    //             ? ""
                    //             : sheetProvider.selectedCategoryFilter,
                    //     "channel": []
                    //   }
                    // ];
                    // setState(() {});
                    // selectedCategoryList = 'Select..';
                    // selectedItemValueChannel[0] = 'Select..';
                    // addDataCoverageAll(channelNew, monthNew);
                    // await postRequest(context);
                    // sheetProvider.isLoaderActive = false;
                  },
                  categoryApply: () async {
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoaderActive = true;
                    var finalMonth = "Jun-2023";
                    if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                      finalMonth = sheetProvider.myStringMonthFB;
                    } else if (pattern2
                        .hasMatch(sheetProvider.myStringMonthFB)) {
                      String year =
                          sheetProvider.myStringMonthFB.substring(2, 6);
                      String month = sheetProvider.myStringMonthFB.substring(7);
                      finalMonth = "$month-$year";
                    } else {
                      finalMonth = "Jun-2023";
                    }
                    if (selectedTapAPI == 0) {
                      dataListCoverage1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": finalMonth,
                          "brandForm":
                              sheetProvider.selectedCategoryFiltersbf ==
                                      "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFiltersbf,
                          "brand": sheetProvider.selectedCategoryFilterbr ==
                                  "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilterbr,
                          "sbfGroup":
                              sheetProvider.selectedCategoryFiltersbfg ==
                                      "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFiltersbfg,
                          "category":
                              sheetProvider.selectedCategoryFilter == "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFilter,
                          "channel": selectedArrayItems
                        }
                      ];
                    } else if (selectedTapAPI == 1) {
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        dataListCoverageCCTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected1'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected1') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected1'),
                            "date": finalMonth,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverageCCTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected1'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected1') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected1'),
                            "date": finalMonth,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbf.isNotEmpty) {
                        dataListCoverageCCTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected1'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected1') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected1'),
                            "date": finalMonth,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbfg.isNotEmpty) {
                        dataListCoverageCCTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected1'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected1') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected1'),
                            "date": finalMonth,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else {}
                    } else if (selectedTapAPI == 2) {
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        dataListCoverageProdTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected2'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected2') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected2'),
                            "date": finalMonth,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverageProdTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected2'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected2') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected2'),
                            "date": finalMonth,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbf.isNotEmpty) {
                        dataListCoverageProdTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected2'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected2') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected2'),
                            "date": finalMonth,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbfg.isNotEmpty) {
                        dataListCoverageProdTabs1 = [
                          {
                            SharedPreferencesUtils.getString(
                                    'divisionChannelSelected2'):
                                SharedPreferencesUtils.getString(
                                            'siteChannelSelected2') ==
                                        "All India"
                                    ? 'allIndia'
                                    : SharedPreferencesUtils.getString(
                                        'siteChannelSelected2'),
                            "date": finalMonth,
                            "brandForm":
                                sheetProvider.selectedCategoryFiltersbf ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbf,
                            "brand": sheetProvider.selectedCategoryFilterbr ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilterbr,
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "sbfGroup":
                                sheetProvider.selectedCategoryFiltersbfg ==
                                        "Select.."
                                    ? ""
                                    : sheetProvider.selectedCategoryFiltersbfg,
                            "channel": flattenedListCoverageCategory
                          }
                        ];
                      } else {}
                    } else if (selectedTapAPI == 3) {
                      dataListCoverage1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": finalMonth,
                          "sbfGroup":
                              sheetProvider.selectedCategoryFiltersbfg ==
                                      "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFiltersbfg,
                          "category":
                              sheetProvider.selectedCategoryFilter == "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFilter,
                          "brand": sheetProvider.selectedCategoryFilterbr ==
                                  "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilterbr,
                          "brandForm":
                              sheetProvider.selectedCategoryFiltersbf ==
                                      "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFiltersbf,
                          "channel": selectedArrayItems
                        }
                      ];
                    } else {}
                    setState(() {});
                    addDataCoverageCC(channelNew, monthNew);
                    await postRequestByGeo(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  onRemoveFilterCategory: () async {
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoaderActive = true;
                    var finalMonth = "Jun-2023";
                    if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                      finalMonth = sheetProvider.myStringMonthFB;
                    } else if (pattern2
                        .hasMatch(sheetProvider.myStringMonthFB)) {
                      String year =
                          sheetProvider.myStringMonthFB.substring(2, 6);
                      String month = sheetProvider.myStringMonthFB.substring(7);
                      finalMonth = "$month-$year";
                    } else {
                      finalMonth = "Jun-2023";
                    }
                    dataListCoverage1 = [
                      {
                        sheetProvider.selectedChannelDivision:
                            sheetProvider.selectedChannelSite == "All India"
                                ? 'allIndia'
                                : sheetProvider.selectedChannelSite,
                        "date": finalMonth,
                        "brandForm": "",
                        "brand": "",
                        "sbfGroup": "",
                        "category": "",
                        "channel": selectedArrayItems
                      }
                    ];
                    setState(() {});
                    selectedCategoryList = 'Select..';
                    selectedItemValueCategory[0] = 'Select..';
                    selectedItemValueBrand[0] = 'Select..';
                    selectedItemValueBrandForm[0] = 'Select..';
                    // selectedItemValueBrandFromGroup[0] = 'Select..';
                    addDataCoverageAll(channelNew, monthNew);
                    await postRequest(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  selectedItemValueCategory: selectedItemValueCategory,
                  selectedItemValueBrand: selectedItemValueBrand,
                  selectedItemValueBrandForm: selectedItemValueBrandForm,
                  selectedItemValueBrandFromGroup: [],
                  selectedMonthList: _selectedMonth,
                  onTapChannelFilter: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          List secondList = [
                            "MM 2",
                            "Super",
                            "WS Feeder Beauty",
                            "Medium Traditional"
                          ];
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0),
                              title: Container(
                                color: MyColors.dark600,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Select Channel',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xff344C65)),
                                  ),
                                ),
                              ),
                              content: SizedBox(
                                width: 300,
                                height: 400,
                                child: Column(
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Checkbox(
                                    //       value:
                                    //       selectedArrayItems
                                    //                   .length ==
                                    //               channelFilter.length,
                                    //       onChanged: (bool? value) {
                                    //         setState(() {
                                    //           if (value != null) {
                                    //             if (value) {
                                    //               selectedArrayItems
                                    //                   .addAll(channelFilter);
                                    //             } else {
                                    //               selectedArrayItems
                                    //                   .clear();
                                    //             }
                                    //           }
                                    //         });
                                    //       },
                                    //     ),
                                    //     Text("Select All"),
                                    //   ],
                                    // ),
                                    Expanded(
                                      // child: ListView.builder(
                                      //   itemCount: channelFilter.length,
                                      //   itemBuilder: (BuildContext context, index) {
                                      //     // Check if the item is in the second list
                                      //     bool isSelected = secondList.contains(channelFilter[index]);
                                      //     List newMainList = [...secondList, ...selectedArrayItems].toList();
                                      //     return Row(
                                      //       children: [
                                      //         Expanded(
                                      //           child: InkWell(
                                      //             onTap: () {
                                      //               setState(() {
                                      //                 if (isSelected) {
                                      //                   // If the item is already selected, remove it
                                      //                   selectedArrayItems.remove(channelFilter[index]);
                                      //                 } else {
                                      //                   // If the item is not selected, add it
                                      //                   selectedArrayItems.add(channelFilter[index]);
                                      //                 }
                                      //                 print(newMainList);
                                      //                 isSelected = !isSelected; // Toggle the isSelected flag
                                      //               });
                                      //             },
                                      //             child: Padding(
                                      //               padding: const EdgeInsets.only(
                                      //                 left: 20,
                                      //                 top: 5,
                                      //                 bottom: 4,
                                      //               ),
                                      //               child: Row(
                                      //                 children: [
                                      //                   Container(
                                      //                     height: 15,
                                      //                     width: 15,
                                      //                     decoration: BoxDecoration(
                                      //                       color: selectedArrayItems.contains(channelFilter[index])? Colors.blue : isSelected ?Colors.blue : MyColors.transparent,
                                      //                       borderRadius: const BorderRadius.all(
                                      //                         Radius.circular(2),
                                      //                       ),
                                      //                       border: Border.all(
                                      //                         color: isSelected ? Colors.blue : MyColors.grey,
                                      //                         width: 1,
                                      //                       ),
                                      //                     ),
                                      //                     child: isSelected
                                      //                         ? const Icon(
                                      //                       Icons.check,
                                      //                       color: MyColors.whiteColor,
                                      //                       size: 13,
                                      //                     )
                                      //                         : null,
                                      //                   ),
                                      //                   const SizedBox(
                                      //                     width: 8,
                                      //                   ),
                                      //                   Expanded(
                                      //                     child: Text(
                                      //                       channelFilter[index],
                                      //                       maxLines: 2,
                                      //                       style: const TextStyle(
                                      //                         fontFamily: fontFamily,
                                      //                         fontWeight: FontWeight.w500,
                                      //                         fontSize: 14,
                                      //                         color: Color(0xff344C65),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     );
                                      //   },
                                      // ),
                                      child: ListView.builder(
                                        itemCount: channelFilter.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          print("List Channel $channelFilter");
                                          return channelFilter.isEmpty
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (selectedArrayItems
                                                                .contains(
                                                                    channelFilter[
                                                                        index])) {
                                                              selectedArrayItems
                                                                  .remove(
                                                                      channelFilter[
                                                                          index]);
                                                            } else {
                                                              selectedArrayItems.add(
                                                                  channelFilter[
                                                                      index]);
                                                            }
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 20,
                                                            top: 5,
                                                            bottom: 4,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 15,
                                                                width: 15,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: selectedArrayItems.contains(
                                                                          channelFilter[
                                                                              index])
                                                                      ? Colors
                                                                          .blue
                                                                      : MyColors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              2)),
                                                                  border: Border
                                                                      .all(
                                                                    color: selectedArrayItems.contains(channelFilter[
                                                                            index])
                                                                        ? Colors
                                                                            .blue
                                                                        : MyColors
                                                                            .grey,
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                                child: selectedArrayItems
                                                                        .contains(
                                                                            channelFilter[index])
                                                                    ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyColors
                                                                            .whiteColor,
                                                                        size:
                                                                            13,
                                                                      )
                                                                    : null,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  channelFilter[
                                                                      index],
                                                                  maxLines: 2,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        fontFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        0xff344C65),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      sheetProvider.isExpandedMonthFilter =
                                          true;
                                      if (selectedTapAPI == 0) {
                                        dataListCoverage1 = [];
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverage1 = selectedArrayItems;
                                        setState(() {});
                                        addDataCoverageAll('', monthNew);
                                        Navigator.pop(context);
                                        await postRequest(context);
                                        selectedArrayItemsCategory = [];
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 1) {
                                        dataListCoverageCCTabs1 = [];
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageCCTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        addDataCoverageCC('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestByGeo(context);
                                        selectedArrayItemsCategory = [];
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 2) {
                                        dataListCoverageProdTabs1 = [];
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageProdTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        addDataCoverageProd('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestByChannel(context);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 3) {
                                        dataListCoverageBillingTabs1 = [];
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageBillingTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        addDataCoverageBilling('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestByCategory(context);
                                        sheetProvider.isLoaderActive = false;
                                      } else {}
                                    },
                                    child: const Text(
                                      'Apply',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: MyColors.primary),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: MyColors.primary),
                                    ))
                              ],
                            );
                          });
                        });
                  },
                  dataListByGeo: dataListCoverageCCTabs,
                  onTapRemoveFilter: () async {
                    sheetProvider.isExpandedMonthFilter = true;
                    if (selectedTapAPI == 0) {
                      removeDataDaily(sheetProvider.isCloseSelect);
                      sheetProvider.isLoaderActive = true;
                      Navigator.of(context).pop();
                      await postRequest(context);
                      sheetProvider.isLoaderActive = false;
                    }
                    else if (selectedTapAPI == 1) {
                      removeDataCCR(sheetProvider.isCloseSelect);
                      sheetProvider.isLoaderActive = true;
                      Navigator.of(context).pop();
                      await postRequestByGeo(context);
                      sheetProvider.isLoaderActive = false;
                    }
                  },
                  onTapSiteFilter: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0),
                            title: Container(
                              color: MyColors.dark600,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Select Site',
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff344C65)),
                                ),
                              ),
                            ),
                            content: SizedBox(
                              width: 300,
                              height: 400,
                              child: ListView.builder(
                                itemCount: siteCount.length,
                                itemBuilder: (context, index) {
                                  var monthYear = siteCount[index];
                                  // var shortMonth = _getShortMonthName(
                                  //     monthYear.split(' ')[0]);
                                  // var year = monthYear.split(' ')[1];
                                  return ListTile(
                                    title: Text(siteCount[index]),
                                    onTap: () async {
                                      setState(() {
                                        _selectedSite = monthYear;
                                        sheetProvider.isExpandedMonthFilter =
                                            true;
                                      });
                                      // if (selectedTapAPI == 0) {
                                      //   dataListCoverage1 = [];
                                      //   sheetProvider.isLoaderActive = true;
                                      //   dataListCoverage1 = [
                                      //     {
                                      //       sheetProvider.selectedChannelDivision ==
                                      //           ""
                                      //           ? "allIndia"
                                      //           : sheetProvider
                                      //           .selectedChannelDivision:
                                      //       sheetProvider.selectedChannelSite ==
                                      //           "All India" ||
                                      //           sheetProvider
                                      //               .selectedChannelSite ==
                                      //               ""
                                      //           ? 'allIndia'
                                      //           : sheetProvider
                                      //           .selectedChannelSite,
                                      //       "date": monthNew,
                                      //       "channel": flattenedListCoverageCV
                                      //     }
                                      //   ];
                                      //   setState(() {});
                                      //   addDataCoverageAll('', monthNew);
                                      //   Navigator.pop(context);
                                      //   await postRequest(context);
                                      //   sheetProvider.isLoaderActive = false;
                                      // }
                                      // else if (selectedTapAPI == 1) {
                                      //   sheetProvider.isLoaderActive = true;
                                      //   dataListCoverageCCTabs1 = [
                                      //     {
                                      //       SharedPreferencesUtils.getString('divisionChannelSelected1') ==
                                      //           ""
                                      //           ? "allIndia"
                                      //           : SharedPreferencesUtils.getString('divisionChannelSelected1'):
                                      //       SharedPreferencesUtils.getString('siteChannelSelected1') ==
                                      //           "All India" ||
                                      //           SharedPreferencesUtils.getString('siteChannelSelected1') ==
                                      //               ""
                                      //           ? 'allIndia'
                                      //           : SharedPreferencesUtils.getString('siteChannelSelected1'),
                                      //       "date": monthNew,
                                      //       "channel": []
                                      //     }
                                      //   ];
                                      //   setState(() {});
                                      //   addDataCoverageCC('', monthNew);
                                      //   Navigator.pop(context);
                                      //   await postRequestByGeo(context);
                                      //   sheetProvider.isLoaderActive = false;
                                      // }
                                      // else if (selectedTapAPI == 2) {
                                      // }
                                      // else if (selectedTapAPI == 3) {
                                      // } else {}
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: MyColors.primary),
                                  ))
                            ],
                          );
                        });
                  },
                  onTapBranchFilter: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0),
                            title: Container(
                              color: MyColors.dark600,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Select Branch',
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Color(0xff344C65)),
                                ),
                              ),
                            ),
                            content: SizedBox(
                              width: 300,
                              height: 400,
                              child: ListView.builder(
                                itemCount: siteCount.length,
                                itemBuilder: (context, index) {
                                  var monthYear = siteCount[index];
                                  return ListTile(
                                    title: Text(siteCount[index]),
                                    onTap: () async {
                                      setState(() {
                                        _selectedSite = monthYear;
                                        sheetProvider.isExpandedMonthFilter =
                                            true;
                                      });
                                      // if (selectedTapAPI == 0) {
                                      //   dataListCoverage1 = [];
                                      //   sheetProvider.isLoaderActive = true;
                                      //   dataListCoverage1 = [
                                      //     {
                                      //       sheetProvider.selectedChannelDivision ==
                                      //           ""
                                      //           ? "allIndia"
                                      //           : sheetProvider
                                      //           .selectedChannelDivision:
                                      //       sheetProvider.selectedChannelSite ==
                                      //           "All India" ||
                                      //           sheetProvider
                                      //               .selectedChannelSite ==
                                      //               ""
                                      //           ? 'allIndia'
                                      //           : sheetProvider
                                      //           .selectedChannelSite,
                                      //       "date": monthNew,
                                      //       "channel": flattenedListCoverageCV
                                      //     }
                                      //   ];
                                      //   setState(() {});
                                      //   addDataCoverageAll('', monthNew);
                                      //   Navigator.pop(context);
                                      //   await postRequest(context);
                                      //   sheetProvider.isLoaderActive = false;
                                      // }
                                      // else if (selectedTapAPI == 1) {
                                      //   sheetProvider.isLoaderActive = true;
                                      //   dataListCoverageCCTabs1 = [
                                      //     {
                                      //       SharedPreferencesUtils.getString('divisionChannelSelected1') ==
                                      //           ""
                                      //           ? "allIndia"
                                      //           : SharedPreferencesUtils.getString('divisionChannelSelected1'):
                                      //       SharedPreferencesUtils.getString('siteChannelSelected1') ==
                                      //           "All India" ||
                                      //           SharedPreferencesUtils.getString('siteChannelSelected1') ==
                                      //               ""
                                      //           ? 'allIndia'
                                      //           : SharedPreferencesUtils.getString('siteChannelSelected1'),
                                      //       "date": monthNew,
                                      //       "channel": []
                                      //     }
                                      //   ];
                                      //   setState(() {});
                                      //   addDataCoverageCC('', monthNew);
                                      //   Navigator.pop(context);
                                      //   await postRequestByGeo(context);
                                      //   sheetProvider.isLoaderActive = false;
                                      // }
                                      // else if (selectedTapAPI == 2) {
                                      // }
                                      // else if (selectedTapAPI == 3) {
                                      // } else {}
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: MyColors.primary),
                                  ))
                            ],
                          );
                        });
                  },
                  listRetailingDataListCoverage: listRetailingDataListCoverage,
                  onTapContainer: () {  },
                  onApplyRetailingSummary: () async{
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoadingPage = true;
                    var newElement =
                        '{"${SharedPreferencesUtils.getString('webRetailingSummaryDivision')}": "${SharedPreferencesUtils.getString('webRetailingSummarySite')}", "date": "${SharedPreferencesUtils.getString('webCoverageMonth') ?? "Jun"}-${SharedPreferencesUtils.getString('webCoverageYear') ?? "2023"}"}';
                    var ele = json.decode(newElement);
                    listRetailingData1.add(ele);
                    addDataCoverageAllRetailing();
                    sheetProvider.isMenuActive = false;
                    sheetProvider.isDivisionActive = false;
                    sheetProvider.isRemoveActive = false;
                    await postRequestRetailing(context);

                    sheetProvider.isLoadingPage = false;
                    setState(() {});
                  },
                  onRemoveGeoPressed: () async{
                    menuBool = !menuBool;
                    divisionBool = !divisionBool;
                    removeBool = !removeBool;
                    sheetProvider.isLoadingPage = true;
                    removeDataRetailing(sheetProvider.removeIndexRetailingSummary);
                    await postRequestRetailing(context);
                    sheetProvider.isLoadingPage = false;
                    setState(() {});
                  },
                  menuBool: menuBool, divisionBool: divisionBool, removeBool: removeBool,
                  onMonthChangedDefault: () {
                    setState(() {
                    });
                    sheetProvider.selectMonth = true;
                  },
                  onApplySummaryDefaultMonth: () async{
                    defaultMonthPressed = true;
                    sheetProvider.isLoadingPage = true;
                    addDataCoverageAllRetailing();
                    sheetProvider.selectMonth = false;
                    await postRequestRetailing(context);
                    sheetProvider.isLoadingPage = false;
                    setState(() {});

                }, tryAgain: () async{
                  sheetProvider.setRetailingErrorMsg([]);
                  sheetProvider.isLoaderActive = true;
                  await postRequest(context);
                  sheetProvider.isLoaderActive = false;
                  setState(() {});
                }, tryAgain1: () async{
                  print('button');
                  sheetProvider.setRetailing1ErrorMsg([]);
                  sheetProvider.isLoaderActive = true;
                  await postRequestByGeo(context);
                  sheetProvider.isLoaderActive = false;
                  setState(() {});
                },tryAgain2: () async{
                  print('button');
                  sheetProvider.setRetailing2ErrorMsg([]);
                  sheetProvider.isLoaderActive = true;
                  await postRequestByCategory(context);
                  sheetProvider.isLoaderActive = false;
                  setState(() {});
                },tryAgain3: () async{
                  print('button');
                  sheetProvider.setRetailing3ErrorMsg([]);
                  sheetProvider.isLoaderActive = true;
                  await postRequestByChannel(context);
                  sheetProvider.isLoaderActive = false;
                  setState(() {});
                },
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}
////// Get Geo category according to Geo //////
findDatasetName(String selectedKey) {
  List<dynamic> cluster = ConstArray().clusterNewList;
  List<dynamic> site = ConstArray().siteNewList;
  List<dynamic> division = ConstArray().divisionNewList;
  List<dynamic> divisionN = ['S-W', 'N-E'];

  if (site.contains(selectedKey)) {
    return "site";
  } else if (cluster.contains(selectedKey)) {
    return "cluster";
  } else if (divisionN.contains(selectedKey)) {
    return "division";
  } else if (division.contains(selectedKey)) {
    return "division";
  } else if (selectedKey == 'allIndia') {
    return "allIndia";
  } else {
    if (selectedKey == 'All India') {
      return "allIndia";
    }
  }
}