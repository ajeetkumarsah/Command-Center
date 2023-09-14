import 'dart:js_interop';

import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/deep_dive_container/distribution_coverage_Container/distribution_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import '../../../helper/app_urls.dart';
import '../../../provider/sheet_provider.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../comman_utils/drawer_widget.dart';

class CoverageDistributionContainerDrawer extends StatefulWidget {
  const CoverageDistributionContainerDrawer({super.key});

  @override
  State<CoverageDistributionContainerDrawer> createState() =>
      _CoverageDistributionContainerDrawerState();
}

class _CoverageDistributionContainerDrawerState
    extends State<CoverageDistributionContainerDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedItemValueChannel = [];
  List<String> selectedItemValueChannelMonth = [];
  var divisionCount = [];
  var clusterCount = [];
  var siteCount = [];
  bool addMonthBool = false;
  List<dynamic> coverageDataListAPI = [];
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


  List<dynamic> flattenedListCoverageCV = [];
  List<dynamic> flattenedListCoverageCategory = [];
  List<dynamic> flattenedListCoverageChannel = [];
  List<dynamic> flattenedListCoverageTrend = [];





  final jsonBody = [
    {
      "mtdRetailing": {
        "cmIya": "225",
        "cmSellout": "22Lk",
        "filter": "Cochin",
        "month": "Jun-2023"
      }
    },
    {
      "mtdRetailing": {
        "cmIya": "225",
        "cmSellout": "22Lk",
        "filter": "Mumbai",
        "month": "Jun-2023"
      }
    }
  ];

  String channelNew = '';
  String monthNew = '';
  bool isReloaded = false;

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

  Future<http.Response> postRequest(
      context, String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/coverage/subChannel';

    var body = json.encode(flattenedList.isEmpty
        ? [
            {"allIndia": "allIndia", "date": "May-2023", "channel": []}
          ]
        : flattenedList);
    print("Consolidated View $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
        // print("Coverage Consolidated View! ${response.statusCode}, $dataListCoverage");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }

    return response;
  }

  Future<http.Response> postRequestCCTabs(
      context, String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/coverage/cc';
    // var url ='https://run.mocky.io/v3/16822299-30a6-427f-8669-407b8ded83d9';
    // var url = 'https://run.mocky.io/v3/6b187fed-0da7-4a67-a6cf-d32e547c990b';
    var body = json.encode(flattenedListCC.isEmpty
        ? [
            {"allIndia": "allIndia", "date": "Jun-2023", "channel": []}
          ]
        : flattenedListCC);
    print(body);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);
        print("Coverage Call Hit Rate! ${response.statusCode}");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }

    return response;
  }

  Future<http.Response> postRequestProdTabs(
      context, String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/coverage/productivity';
    // var url = 'https://run.mocky.io/v3/533a2f1b-6163-4694-814a-8adfdc09a432';
    var body = json.encode(flattenedListProd.isEmpty
        ? [
            {"allIndia": "allIndia", "date": "Jun-2023", "channel": []}
          ]
        : flattenedListProd);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageProdTabs = jsonDecode(response.body);
        print("Coverage Productivity! ${response.statusCode}");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }
    return response;
  }

  Future<http.Response> postRequestBillingTabs(
      context, String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/coverage/billing';
    // var url = 'https://run.mocky.io/v3/4576ec4e-755a-4645-bf49-bf483f12e7a9';
    var body = json.encode(flattenedListBilling.isEmpty
        ? [
            {"allIndia": "allIndia", "date": "Jun-2023", "channel": []}
          ]
        : flattenedListBilling);
    print("Coverage 4 tap $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageBillingTabs = jsonDecode(response.body);
        print("Coverage PxM Billing! ${response.statusCode}");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }
    return response;
  }

  void saveDataCoverageAll() {
    final jsonData = jsonEncode(flattenedList);
    html.window.localStorage['dataListCoverageAllData'] = jsonData;
  }

  void loadDataCoverageAll() {
    final storedValue = html.window.localStorage['dataListCoverageAllData'];
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
        print(flattenedList);
        print(dataListCoverage1);
        if (flattenedList.isEmpty) {
          flattenedList
              .add({"allIndia": "allIndia", "date": "May-2023", "channel": []});
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedList[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedList.add(jsonToAdd[0]);
            }
          }
        }
      });
      saveDataCoverageAll();
    }
    await postRequest(context, channel, month);
  }

  void saveDataCoverageCCR() {
    final jsonData = jsonEncode(flattenedListCC);
    html.window.localStorage['dataListCoverageCCR'] = jsonData;
  }

  void loadDataCoverageCCR() {
    final storedValue = html.window.localStorage['dataListCoverageCCR'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCC = decodedData;
        });
      }
    }
  }

  void addDataCoverageCCR(channel, month) async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = dataListCoverageCCTabs1;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
          if (bosData.isExpandedMonthFilter) {
            flattenedListCC = [{"allIndia": "allIndia", "date": "Jun-2023", "channel": []}];
            flattenedListCC[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            print("Empty List4 found");
            if (jsonToAdd.isNotEmpty) {
              flattenedListCC.add(jsonToAdd[0]);
            }
        }
      });
      saveDataCoverageCCR();
    }
    await postRequestCCTabs(context, channel, month);
  }

  void saveDataCoverageProd() {
    final jsonData = jsonEncode(flattenedListProd);
    html.window.localStorage['dataListCoverageProd'] = jsonData;
  }

  void loadDataCoverageProd() {
    final storedValue = html.window.localStorage['dataListCoverageProd'];
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
            flattenedListProd = [{"allIndia": "allIndia", "date": "Jun-2023", "channel": []}];
            flattenedListProd[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedListProd.add(jsonToAdd[0]);
            }
        }
      });
      saveDataCoverageProd();
    }
    await postRequestProdTabs(context, channel, month);
  }

  void saveDataCoverageBilling() {
    final jsonData = jsonEncode(flattenedListBilling);
    html.window.localStorage['dataListCoverageBilling'] = jsonData;
  }

  void loadDataCoverageBilling() {
    final storedValue = html.window.localStorage['dataListCoverageBilling'];
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
        // if (flattenedListBilling.isEmpty) {
        //   flattenedListBilling
        //       .add({"allIndia": "allIndia", "date": 'Jun-2023', "channel": []});
        // } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListBilling = [{"allIndia": "allIndia", "date": "Jun-2023", "channel": []}];
            flattenedListBilling[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedListBilling.add(jsonToAdd[0]);
            // }
          }
        }
      });
      saveDataCoverageBilling();
    }
    await postRequestBillingTabs(context, channel, month);
  }

  /////////////////////////// Local Storage for Channel Filter //////////////////
  void saveDataCoverageCV() {
    final jsonData = jsonEncode(flattenedListCoverageCV);
    html.window.localStorage['dataListCoverageCV'] = jsonData;
  }

  void loadDataCoverageCV() {
    final storedValue = html.window.localStorage['dataListCoverageCV'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCoverageCV = decodedData;
        });
      }
    }
  }

  void addDataCoverageCV() async {
      setState(() {
              flattenedListCoverageCV.add(selectedArrayItems);
      });
      saveDataCoverageCV();
  }

  void saveDataCoverageCategory() {
    final jsonData = jsonEncode(flattenedListCoverageCategory);
    html.window.localStorage['dataListCoverageCategory'] = jsonData;
  }

  void loadDataCoverageCategory() {
    final storedValue = html.window.localStorage['dataListCoverageCategory'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCoverageCategory = decodedData;
        });
      }
    }
  }

  void addDataCoverageCategory() async {
    setState(() {
      flattenedListCoverageCategory.add(selectedArrayItemsCategory);
    });
    saveDataCoverageCategory();
  }

  void saveDataCoverageChannel() {
    final jsonData = jsonEncode(flattenedListCoverageChannel);
    html.window.localStorage['dataListCoverageChannel'] = jsonData;
  }

  void loadDataCoverageChannel() {
    final storedValue = html.window.localStorage['dataListCoverageChannel'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCoverageChannel = decodedData;
        });
      }
    }
  }

  void addDataCoverageChannel() async {
    setState(() {
      flattenedListCoverageChannel.add(selectedArrayItemsChannel);
    });
    saveDataCoverageChannel();
  }

  void saveDataCoverageTrend() {
    final jsonData = jsonEncode(flattenedListCoverageTrend);
    html.window.localStorage['dataListCoverageTrend'] = jsonData;
  }

  void loadDataCoverageTrend() {
    final storedValue = html.window.localStorage['dataListCoverageTrend'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCoverageTrend = decodedData;
        });
      }
    }
  }

  void addDataCoverageTrend() async {
    setState(() {
      flattenedListCoverageTrend.add(selectedArrayItemsTrend);
    });
    saveDataCoverageTrend();
  }

  /////////////////////////// Local Storage for Channel Filter //////////////////

  void removeDataAll(int index) {
    if (flattenedList.isNotEmpty) {
      try {
        setState(() {
          flattenedList.removeAt(index);
        });
        saveDataCoverageAll();
      } catch (e) {
        print("Error: $e");
      }

    }
  }

  void removeDataCCR(int index) {
    if (flattenedListCC.isNotEmpty) {
      setState(() {
        flattenedListCC.removeAt(index);
      });
      saveDataCoverageCCR();
    }
  }

  void removeDataProd(int index) {
    if (flattenedListProd.isNotEmpty) {
      setState(() {
        flattenedListProd.removeAt(index);
      });
      saveDataCoverageProd();
    }
  }

  void removeDataBilling(int index) {
    if (flattenedListBilling.isNotEmpty) {
      setState(() {
        flattenedListBilling.removeAt(index);
      });
      saveDataCoverageBilling();
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
  int selectedTapAPI = 0;
  int selectedIndexLocation = 0;

  String _getShortMonthName(String fullName) {
    return fullName.substring(0, 3);
  }

  List<String> channelFilter = [];
  List<String> selectedArrayItems = [];
  List<String> selectedArrayItemsCategory = [];
  List<String> selectedArrayItemsChannel = [];
  List<String> selectedArrayItemsTrend = [];

  Future<List<String>> postRequestChannel(context) async {
    var url =
        '$BASE_URL/api/appData/channelFilter/category';

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
    loadDataCoverageAll();
    loadDataCoverageCV();
    loadDataCoverageCCR();
    loadDataCoverageProd();
    loadDataCoverageBilling();
    // if(isReloaded==false){
    // addDataCoverageCV();
    addDataCoverageAll('', 'June-2023');
    // addDataCoverageCCR('', '');
    // addDataCoverageCCR('', 'June-2023');
    // addDataCoverageProd('', 'June-2023');
    // addDataCoverageBilling('', 'June-2023');
    _selectedMonth = getLast24Months()[0];
    // }
    isReloaded = true;
    postRequestChannel(context);
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
                  indexNew: 2,
                ),
                DistributionContainer(
                  title: 'Coverage & Distribution',
                  onApplyPressedMonth: () async {
                    if (sheetProvider.setCurrentTabCoverage == 0) {
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
                      dataListCoverage1 = [];
                      dataListCoverage1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "channel": []
                        }
                      ];
                      setState(() {});
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 1) {
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
                      dataListCoverageCCTabs1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "channel": []
                        }
                      ];
                      setState(() {});
                      loadDataCoverageCCR();
                      addDataCoverageCCR(channelNew, monthNew);

                      await postRequestCCTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 2) {
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
                      dataListCoverageProdTabs1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "channel": []
                        }
                      ];
                      setState(() {});
                      addDataCoverageProd(channelNew, monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 3) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        sheetProvider.selectMonth = false;
                        var division = SharedPreferencesUtils.getString(
                            'webCoverageSheetDivision');
                        var site = SharedPreferencesUtils.getString(
                            'webCoverageSheetSite');
                        var year =
                            SharedPreferencesUtils.getString('webCoverageYear');
                        var month = SharedPreferencesUtils.getString(
                            'webCoverageMonth');
                        var finalDivision =
                            division == 'All India' || division == ""
                                ? 'allIndia'
                                : division;
                        var finalSite = site == 'All India' || site == ""
                            ? 'allIndia'
                            : site;
                        dataListCoverageBillingTabs1 = [
                          {
                            "$finalDivision": finalSite,
                            "date": "$month-$year",
                            "channel": []
                          }
                        ];
                      });
                      addDataCoverageBilling(channelNew, monthNew);
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    }
                  },
                  onChangedFilter: (value) async {

                  },
                  onChangedFilterMonth: (value) async {
                    // sheetProvider.isExpandedMonthFilter = true;
                    // selectedItemValueChannelMonth[0] = value!;
                    // monthNew = "${selectedItemValueChannelMonth[0]}-2023";
                    // print("Month New $monthNew");
                    // if (sheetProvider.setCurrentTabCoverage == 0) {
                    //   print("Here now ${sheetProvider.selectedChannelIndex}");
                    //   sheetProvider.isLoaderActive = true;
                    //   dataListCoverage1 = [
                    //     {
                    //       SharedPreferencesUtils.getString('divisionChannelSelected'):
                    //       SharedPreferencesUtils.getString('siteChannelSelected') == "All India"
                    //               ? 'allIndia'
                    //               : SharedPreferencesUtils.getString('siteChannelSelected'),
                    //       "date": monthNew,
                    //       "channel": []
                    //     }
                    //   ];
                    //   setState(() {});
                    //
                    //   addDataCoverageAll('', monthNew);
                    //   await postRequest(context, '', monthNew);
                    //   sheetProvider.isLoaderActive = false;
                    // }
                    // else if (sheetProvider.setCurrentTabCoverage == 1) {
                    //   print("Month New $monthNew");
                    //   sheetProvider.isLoaderActive = true;
                    //   dataListCoverageCCTabs1 = [
                    //     {
                    //       sheetProvider.selectedChannelDivision:
                    //           sheetProvider.selectedChannelSite == "All India"
                    //               ? 'allIndia'
                    //               : sheetProvider.selectedChannelSite,
                    //       "date": monthNew,
                    //       "channel": []
                    //     }
                    //   ];
                    //   setState(() {});
                    //   addDataCoverageCCR('', monthNew);
                    //   await postRequestCCTabs(context, "", monthNew);
                    //   sheetProvider.isLoaderActive = false;
                    // }
                    // else if (sheetProvider.setCurrentTabCoverage == 2) {
                    //   sheetProvider.isLoaderActive = true;
                    //   dataListCoverageProdTabs1 = [
                    //     {
                    //       sheetProvider.selectedChannelDivision:
                    //           sheetProvider.selectedChannelSite,
                    //       "date": monthNew,
                    //       "channel": []
                    //     }
                    //   ];
                    //   setState(() {});
                    //   addDataCoverageProd('', monthNew);
                    //   await postRequestProdTabs(context, channelNew, monthNew);
                    //   sheetProvider.isLoaderActive = false;
                    // }
                    // else {
                    //   sheetProvider.isLoaderActive = true;
                    //   dataListCoverageBillingTabs1 = [
                    //     {
                    //       sheetProvider.selectedChannelDivision:
                    //           sheetProvider.selectedChannelSite == "All India"
                    //               ? 'allIndia'
                    //               : sheetProvider.selectedChannelSite,
                    //       "date": monthNew,
                    //       "channel": []
                    //     }
                    //   ];
                    //   setState(() {});
                    //   addDataCoverageBilling('', monthNew);
                    //   await postRequestBillingTabs(
                    //       context, channelNew, monthNew);
                    //   sheetProvider.isLoaderActive = false;
                    // }
                  },
                  onApplyPressedMonthCHRTab: () async {},
                  onClosedTap: () async {
                    if (sheetProvider.setCurrentTabCoverage == 0) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataAll(sheetProvider.removeIndexFB);
                        selectedIndexLocation -= 1;
                        // addDataCoverageAll(channelNew, monthNew);
                      });
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 1) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataCCR(sheetProvider.removeIndexFB);
                      });
                      await postRequestCCTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 2) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataProd(sheetProvider.removeIndexFB);
                      });
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 3) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataBilling(sheetProvider.removeIndexFB);

                      });
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else {}
                  },
                  addMonthBool: addMonthBool,
                  divisionList: divisionCount,
                  siteList: siteCount,
                  branchList: [],
                  selectedGeo: 0,
                  clusterList: clusterCount,
                  dataList: dataListCoverage,
                  dataListTabs: dataListCoverageProdTabs,
                  dataListBillingTabs: dataListCoverageBillingTabs,
                  dataListCCTabs: dataListCoverageCCTabs,
                  coverageAPIList: coverageDataListAPI,
                  selectedItemValueChannel: selectedItemValueChannel,
                  selectedItemValueChannelMonth: selectedItemValueChannelMonth,
                  selectedMonthList: _selectedMonth,
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
                                child: Text('Select Month', style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff344C65)),),
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
                                            true;
                                        monthNew = "$shortMonth-$year";
                                      });
                                      if (sheetProvider.setCurrentTabCoverage ==
                                          0) {
                                        dataListCoverage1 = [];
                                        print(
                                            "Here now ${sheetProvider.selectedChannelIndex}");
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverage1 = [
                                          {
                                            sheetProvider.selectedChannelDivision ==
                                                        ""
                                                    ? "allIndia"
                                                    : sheetProvider
                                                        .selectedChannelDivision:
                                                sheetProvider.selectedChannelSite ==
                                                            "All India" ||
                                                        sheetProvider
                                                                .selectedChannelSite ==
                                                            ""
                                                    ? 'allIndia'
                                                    : sheetProvider
                                                        .selectedChannelSite,
                                            "date": monthNew,
                                            "channel": flattenedListCoverageCV
                                          }
                                        ];
                                        setState(() {});

                                        addDataCoverageAll('', monthNew);
                                        Navigator.pop(context);
                                        await postRequest(
                                            context, '', monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (sheetProvider
                                              .setCurrentTabCoverage ==
                                          1) {
                                        print("Month New $monthNew");
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageCCTabs1 = [
                                          {
                                            sheetProvider.selectedChannelDivision ==
                                                        ""
                                                    ? "allIndia"
                                                    : sheetProvider
                                                        .selectedChannelDivision:
                                                sheetProvider.selectedChannelSite ==
                                                            "All India" ||
                                                        sheetProvider
                                                                .selectedChannelSite ==
                                                            ""
                                                    ? 'allIndia'
                                                    : sheetProvider
                                                        .selectedChannelSite,
                                            "date": monthNew,
                                            "channel": flattenedListCoverageCategory[0]
                                          }
                                        ];
                                        setState(() {});
                                        addDataCoverageCCR('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestCCTabs(
                                            context, "", monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (sheetProvider
                                              .setCurrentTabCoverage ==
                                          2) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageProdTabs1 = [
                                          {
                                            sheetProvider.selectedChannelDivision ==
                                                        ""
                                                    ? "allIndia"
                                                    : sheetProvider
                                                        .selectedChannelDivision:
                                                sheetProvider.selectedChannelSite ==
                                                            "All India" ||
                                                        sheetProvider
                                                                .selectedChannelSite ==
                                                            ""
                                                    ? 'allIndia'
                                                    : sheetProvider
                                                        .selectedChannelSite,
                                            "date": monthNew,
                                            "channel": flattenedListCoverageChannel[0]
                                          }
                                        ];
                                        setState(() {});
                                        addDataCoverageProd('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestProdTabs(
                                            context, channelNew, monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageBillingTabs1 = [
                                          {
                                            sheetProvider.selectedChannelDivision ==
                                                        ""
                                                    ? "allIndia"
                                                    : sheetProvider
                                                        .selectedChannelDivision:
                                                sheetProvider.selectedChannelSite ==
                                                            "All India" ||
                                                        sheetProvider
                                                                .selectedChannelSite ==
                                                            ""
                                                    ? 'allIndia'
                                                    : sheetProvider
                                                        .selectedChannelSite,
                                            "date": monthNew,
                                            "channel": flattenedListCoverageTrend[0]
                                          }
                                        ];
                                        setState(() {});
                                        addDataCoverageBilling('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestBillingTabs(
                                            context, channelNew, monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text('Cancel', style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: MyColors.primary),))
                            ],
                          );
                        });
                  },
                  onTap1: () async {
                    setState(() {
                      selectedTapAPI = 0;
                      sheetProvider.setCurrentTabCoverage = 0;

                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequest(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("0: $selectedTapAPI");
                  },
                  onTap2: () async {

                      selectedTapAPI = 1;
                      sheetProvider.setCurrentTabCoverage = 1;

                    sheetProvider.isLoaderActive = true;
                    await postRequestCCTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                    print("1: $selectedTapAPI");
                  },
                  onTap3: () async {
                    setState(() {
                      selectedTapAPI = 2;
                      sheetProvider.setCurrentTabCoverage = 2;
                    });
                    sheetProvider.isLoaderActive = true;

                    await postRequestProdTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("2: $selectedTapAPI");
                  },
                  onTap4: () async {
                    setState(() {
                      selectedTapAPI = 3;
                      sheetProvider.setCurrentTabCoverage = 3;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestBillingTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("3: $selectedTapAPI");
                  },
                  selectedIndex1: selectedTapAPI, selectedChannelList: '',
                  onTapChannelFilter: () {
                    print("On Tap channel ${sheetProvider.selectedChannelFromAPI}");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState){
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0),
                            title: Container(
                              color: MyColors.dark600,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Select Channel', style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff344C65)),),
                              ),
                            ),
                            content:SizedBox(
                              width: 300,
                              height: 400,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value:
                                        // selectedArrayItems.length == channelFilter.length,
                                        sheetProvider.setCurrentTabCoverage == 0? selectedArrayItems.length == channelFilter.length
                                            :sheetProvider.setCurrentTabCoverage == 1?selectedArrayItemsCategory.length == channelFilter.length
                                            :sheetProvider.setCurrentTabCoverage == 2?selectedArrayItemsChannel.length == channelFilter.length:
                                        selectedArrayItemsTrend.length == channelFilter.length,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if(selectedArrayItems.length == channelFilter.length){
                                              if (value != null) {
                                                if (value) {
                                                  selectedArrayItems.addAll(channelFilter);
                                                } else {
                                                  selectedArrayItems.clear();
                                                }
                                              }
                                            }else if(selectedArrayItemsCategory.length == channelFilter.length){
                                              if (value != null) {
                                                if (value) {
                                                  selectedArrayItemsCategory.addAll(channelFilter);
                                                } else {
                                                  selectedArrayItemsCategory.clear();
                                                }
                                              }
                                            }else if(selectedArrayItemsChannel.length == channelFilter.length){
                                              if (value != null) {
                                                if (value) {
                                                  selectedArrayItemsChannel.addAll(channelFilter);
                                                } else {
                                                  selectedArrayItemsChannel.clear();
                                                }
                                              }
                                            }else if(selectedArrayItemsTrend.length == channelFilter.length){
                                              if (value != null) {
                                                if (value) {
                                                  selectedArrayItemsTrend.addAll(channelFilter);
                                                } else {
                                                  selectedArrayItemsTrend.clear();
                                                }
                                              }
                                            }else{}
                                          });
                                        },
                                      ),
                                      Text("Select All"),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: channelFilter.length,
                                      itemBuilder: (BuildContext context, index) {
                                        return channelFilter.isEmpty
                                            ? const Center(child: CircularProgressIndicator())
                                            : Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if(sheetProvider.setCurrentTabCoverage == 0){
                                                      if (selectedArrayItems.contains(channelFilter[index])) {
                                                        selectedArrayItems.remove(channelFilter[index]);
                                                      } else {
                                                        selectedArrayItems.add(channelFilter[index]);
                                                      }
                                                    }else if (sheetProvider.setCurrentTabCoverage == 1){
                                                      if (selectedArrayItemsCategory.contains(channelFilter[index])) {
                                                        selectedArrayItemsCategory.remove(channelFilter[index]);
                                                      } else {
                                                        selectedArrayItemsCategory.add(channelFilter[index]);
                                                      }
                                                    }else if (sheetProvider.setCurrentTabCoverage == 2){
                                                      if (selectedArrayItemsChannel.contains(channelFilter[index])) {
                                                        selectedArrayItemsChannel.remove(channelFilter[index]);
                                                      } else {
                                                        selectedArrayItemsChannel.add(channelFilter[index]);
                                                      }
                                                    }else if (sheetProvider.setCurrentTabCoverage == 0){
                                                      if (selectedArrayItemsTrend.contains(channelFilter[index])) {
                                                        selectedArrayItemsTrend.remove(channelFilter[index]);
                                                      } else {
                                                        selectedArrayItemsTrend.add(channelFilter[index]);
                                                      }
                                                    }else{

                                                    }
                                                    print(selectedArrayItems);
                                                    print(selectedArrayItemsCategory);
                                                    print(selectedArrayItemsChannel);
                                                    print(selectedArrayItemsTrend);
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                    left: 20,
                                                    top: 5,
                                                    bottom: 4,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 15,
                                                        width: 15,
                                                        decoration: BoxDecoration(
                                                          color: selectedArrayItems
                                                              .contains(channelFilter[index])
                                                              || selectedArrayItemsCategory
                                                              .contains(channelFilter[index]) || selectedArrayItemsChannel
                                                              .contains(channelFilter[index]) || selectedArrayItemsTrend
                                                              .contains(channelFilter[index])
                                                              ? Colors.blue
                                                              : MyColors.transparent,
                                                          borderRadius:
                                                          const BorderRadius.all(Radius.circular(2)),
                                                          border: Border.all(
                                                            color: selectedArrayItems
                                                                .contains(channelFilter[index])
                                                                || selectedArrayItemsCategory
                                                                .contains(channelFilter[index]) || selectedArrayItemsChannel
                                                                .contains(channelFilter[index]) || selectedArrayItemsTrend
                                                                .contains(channelFilter[index])
                                                                ? Colors.blue
                                                                : MyColors.grey,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: selectedArrayItems
                                                            .contains(channelFilter[index])
                                                            || selectedArrayItemsCategory
                                                            .contains(channelFilter[index]) || selectedArrayItemsChannel
                                                            .contains(channelFilter[index]) || selectedArrayItemsTrend
                                                            .contains(channelFilter[index])
                                                            ? const Icon(
                                                          Icons.check,
                                                          color: MyColors.whiteColor,
                                                          size: 13,
                                                        )
                                                            : null,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          channelFilter[index],
                                                          maxLines: 2,
                                                          style: const TextStyle(
                                                            fontFamily: fontFamily,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                            color: Color(0xff344C65),
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
                              TextButton(onPressed: () async{
                                sheetProvider.isExpandedMonthFilter = true;
                                sheetProvider.isLoaderActive = true;
                                if (sheetProvider.setCurrentTabCoverage == 0) {
                                  addDataCoverageCV();
                                  dataListCoverage1 = [
                                    {
                                      SharedPreferencesUtils.getString('divisionChannelSelected'):
                                      SharedPreferencesUtils.getString('siteChannelSelected') == "All India"
                                          ? 'allIndia'
                                          : SharedPreferencesUtils.getString('siteChannelSelected'),
                                      "date": sheetProvider.myStringMonth,
                                      // "channel": selectedArrayItems,
                                      "channel": flattenedListCoverageCV[0],
                                    }
                                  ];
                                  setState(() {});
                                  Navigator.pop(context);
                                  addDataCoverageAll(channelNew, monthNew);
                                  await postRequest(context, channelNew, monthNew);
                                  sheetProvider.isLoaderActive = false;
                                }
                                else if (sheetProvider.setCurrentTabCoverage == 1) {
                                  addDataCoverageCategory();
                                  dataListCoverageCCTabs1 = [
                                    {
                                      SharedPreferencesUtils.getString('divisionChannelSelected1'):
                                      SharedPreferencesUtils.getString('siteChannelSelected1') == "All India"
                                          ? 'allIndia'
                                          : SharedPreferencesUtils.getString('siteChannelSelected1'),
                                      "date": sheetProvider.myStringMonth,
                                      // "channel": selectedArrayItems,
                                      "channel": flattenedListCoverageCategory[0],
                                    }
                                  ];
                                  print("What $dataListCoverageCCTabs1");
                                  setState(() {});
                                  Navigator.pop(context);
                                  addDataCoverageCCR(channelNew, monthNew);
                                  await postRequestCCTabs(context, channelNew, monthNew);
                                  sheetProvider.isLoaderActive = false;
                                }
                                else if (sheetProvider.setCurrentTabCoverage == 2) {
                                  // sheetProvider.isExpandedMonthFilter = true;
                                  addDataCoverageChannel();
                                  dataListCoverageProdTabs1 = [
                                    {
                                      SharedPreferencesUtils.getString('divisionChannelSelected2'):
                                      SharedPreferencesUtils.getString('siteChannelSelected2') == "All India"
                                          ? 'allIndia'
                                          : SharedPreferencesUtils.getString('siteChannelSelected2'),
                                      "date": sheetProvider.myStringMonth,
                                      // "channel": selectedArrayItems,
                                      "channel": flattenedListCoverageChannel[0],
                                    }
                                  ];
                                  setState(() {});
                                  Navigator.pop(context);
                                  addDataCoverageProd(channelNew, monthNew);
                                  await postRequestProdTabs(context, channelNew, monthNew);
                                  sheetProvider.isLoaderActive = false;
                                }
                                else if (sheetProvider.setCurrentTabCoverage == 3) {
                                  addDataCoverageTrend();
                                  dataListCoverageBillingTabs1 = [
                                    {
                                      SharedPreferencesUtils.getString('divisionChannelSelected3'):
                                      SharedPreferencesUtils.getString('siteChannelSelected3') == "All India"
                                          ? 'allIndia'
                                          : SharedPreferencesUtils.getString('siteChannelSelected3'),
                                      "date": sheetProvider.myStringMonth,
                                      // "channel": selectedArrayItems,
                                      "channel": flattenedListCoverageTrend[0],
                                    }
                                  ];
                                  flattenedListCoverageTrend=[];
                                  setState(() {});
                                  Navigator.pop(context);
                                  addDataCoverageBilling(channelNew, monthNew);
                                  await postRequestBillingTabs(
                                  context, channelNew, monthNew);
                                  sheetProvider.isLoaderActive = false;
                                }else{

                                }
                              }, child: const Text('Apply',style: TextStyle(
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: MyColors.primary),)),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text('Cancel',style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: MyColors.primary),))
                            ],
                          );
                        });
                      });
                },
                  onTapRemoveFilter: () {  },
                  selectedIndexLocation: selectedIndexLocation,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
