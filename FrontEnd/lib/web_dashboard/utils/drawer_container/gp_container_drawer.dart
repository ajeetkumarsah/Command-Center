import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/deep_dive_container/gp_Container/gp_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:html' as html;
import '../../../helper/app_urls.dart';
import '../../../provider/sheet_provider.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../comman_utils/drawer_widget.dart';

class GPContainerDrawer extends StatefulWidget {
  const GPContainerDrawer({super.key});

  @override
  State<GPContainerDrawer> createState() => _GPContainerDrawerState();
}

class _GPContainerDrawerState extends State<GPContainerDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedItemValueChannel = [];
  List<String> selectedItemValueChannelMonth = [];
  List<String> selectedItemValueChannelBrand = [];
  List<String> selectedItemValueCategory = [];
  List<String> selectedItemValueBrand = [];
  List<String> selectedItemValueBrandForm = [];
  List<String> selectedItemValueBrandFromGroup = [];
  var divisionCount = [];
  var clusterCount = [];
  var siteCount = [];
  bool addMonthBool = false;
  String selectedCategoryList = 'Select..';
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
  RegExp pattern1 =
      RegExp(r'\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-\d{4}\b');
  RegExp pattern2 = RegExp(
      r'\bCY\d{4}-(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b');
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
  String brandNew = '';

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
        '$BASE_URL/api/webDeepDive/goldenPoint/gp';
    // var url = 'https://run.mocky.io/v3/311f279a-7619-4c71-a7cd-d03b889abb63';

    var body = json.encode(flattenedList.isEmpty
        ? [
            {
              "allIndia": "allIndia",
              "date": "Jun-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedList);
    print("Body! FB $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }

    return response;
  }

  Future<http.Response> postRequestCCTabs(
      String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/fb/bf';
    // var url ='https://run.mocky.io/v3/16822299-30a6-427f-8669-407b8ded83d9';
    // var url = 'https://run.mocky.io/v3/6b187fed-0da7-4a67-a6cf-d32e547c990b';
    var body = json.encode(flattenedListCC.isEmpty
        ? [
            {
              "allIndia": "allIndia",
              "date": "Jun-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedListCC);
    print(body);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }
    return response;
  }

  //
  Future<http.Response> postRequestProdTabs(
      context, String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/goldenPoint/monthly';
    // var url = 'https://run.mocky.io/v3/533a2f1b-6163-4694-814a-8adfdc09a432';
    var body = json.encode(flattenedListProd.isEmpty
        ? [
            {
              "allIndia": "allIndia",
              "date": "Jun-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedListProd);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageProdTabs = jsonDecode(response.body);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }
    return response;
  }

  //
  Future<http.Response> postRequestBillingTabs(
      context, String channelFilter, String monthFilter) async {
    var url =
        '$BASE_URL/api/webDeepDive/goldenPoint/abs/monthly';
    // var url = 'https://run.mocky.io/v3/4576ec4e-755a-4645-bf49-bf483f12e7a9';
    var body = json.encode(flattenedListBilling.isEmpty
        ? [
            {
              "allIndia": "allIndia",
              "date": "Jun-2023",
              "brandForm": "",
              "brand": "",
              "sbfGroup": "",
              "category": "",
              "channel": []
            }
          ]
        : flattenedListBilling);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageBillingTabs = jsonDecode(response.body);
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
    html.window.localStorage['dataListGPAll'] = jsonData;
  }

  void loadDataCoverageAll() {
    final storedValue = html.window.localStorage['dataListGPAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedList = decodedData;
          print("Saved $flattenedList");
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
            flattenedList[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            // print("jsonToAdd[0] ${jsonToAdd[0]}");
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
    html.window.localStorage['dataListGPCategory'] = jsonData;
  }

  void loadDataCoverageCCR() {
    final storedValue = html.window.localStorage['dataListGPCategory'];
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
        if (flattenedListCC.isEmpty) {
          flattenedListCC.add({
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
            flattenedListCC[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedListCC.add(jsonToAdd[0]);
            }
          }
        }
      });
      saveDataCoverageCCR();
    }
    await postRequestCCTabs(channel, month);
  }

  //
  void saveDataCoverageProd() {
    final jsonData = jsonEncode(flattenedListProd);
    html.window.localStorage['dataListGPPer'] = jsonData;
  }

  void loadDataCoverageProd() {
    final storedValue = html.window.localStorage['dataListGPPer'];
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
        if (flattenedListProd.isEmpty) {
          flattenedListProd.add({
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
            flattenedListProd[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedListProd.add(jsonToAdd[0]);
            }
          }
        }
      });
      saveDataCoverageProd();
    }
    await postRequestProdTabs(context, channel, month);
  }

  //
  void saveDataCoverageBilling() {
    final jsonData = jsonEncode(flattenedListBilling);
    html.window.localStorage['dataListGPAbs'] = jsonData;
  }

  void loadDataCoverageBilling() {
    final storedValue = html.window.localStorage['dataListGPAbs'];
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
        if (flattenedListBilling.isEmpty) {
          flattenedListBilling.add({
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
            flattenedListBilling[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              flattenedListBilling.add(jsonToAdd[0]);
            }
          }
        }
      });
      saveDataCoverageBilling();
    }
    await postRequestBillingTabs(context, channel, month);
  }

  void removeDataAll(int index) {
    if (flattenedList.isNotEmpty) {
      setState(() {
        flattenedList.removeAt(index);
      });
      saveDataCoverageAll();
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

  String _getShortMonthName(String fullName) {
    return fullName.substring(0, 3);
  }

  List<String> channelFilter = [];
  List<String> selectedArrayItems = [];

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
    loadDataCoverageCCR();
    loadDataCoverageProd();
    loadDataCoverageBilling();
    addDataCoverageAll('', 'June-2023');
    // addDataCoverageCCR('', 'June-2023');
    // addDataCoverageProd('', 'June-2023');
    // addDataCoverageBilling('', 'June-2023');
    _selectedMonth = getLast24Months()[0];
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
                  indexNew: 3,
                ),
                GPContainerWeb(
                  title: 'Focus Brand',
                  onApplyPressedMonth: () async {
                    if (sheetProvider.setCurrentTabGP == 0) {
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
                      var finalDivision = division == 'All India' || division == "" ? 'allIndia' : division;
                      var finalSite = site == 'All India' || site == "" ? 'allIndia' : site;

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
                      setState(() {});
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 1) {
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
                      var finalDivision = division == 'All India' || division == "" ? 'allIndia' : division;
                      var finalSite = site == 'All India' || site == "" ? 'allIndia' : site;
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
                      setState(() {});
                      addDataCoverageProd(channelNew, monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 2) {
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
                        var finalDivision = division == 'All India' || division == "" ? 'allIndia' : division;
                        var finalSite = site == 'All India' || site == "" ? 'allIndia' : site;
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
                    sheetProvider.isExpandedMonthFilter = true;
                    selectedItemValueChannelMonth[0] = value!;
                    monthNew = "${selectedItemValueChannelMonth[0]}-2023";
                    print("Month New $monthNew");
                    if (sheetProvider.setCurrentTabGP == 0) {
                      print("Here now ${sheetProvider.selectedChannelIndex}");
                      sheetProvider.isLoaderActive = true;
                      dataListCoverage1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": monthNew,
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      setState(() {});

                      addDataCoverageAll('', monthNew);
                      await postRequest(context, '', monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 1) {
                      sheetProvider.isLoaderActive = true;
                      dataListCoverageProdTabs1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": monthNew,
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      setState(() {});
                      addDataCoverageProd('', monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 2) {
                      sheetProvider.isLoaderActive = true;
                      dataListCoverageBillingTabs1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": monthNew,
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      setState(() {});
                      addDataCoverageBilling('', monthNew);
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else {}
                  },
                  onChangedFilterBrand: (value) {},
                  categoryApply: () async {
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoaderActive = true;
                    if (sheetProvider.setCurrentTabGP == 0) {
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
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
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "channel": selectedArrayItems
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
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
                            "channel": selectedArrayItems
                          }
                        ];
                      } else {
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
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
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
                      }
                      setState(() {});
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 1) {
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        dataListCoverageProdTabs1 = [
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
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "channel": selectedArrayItems
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverageProdTabs1 = [
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
                            "channel": selectedArrayItems
                          }
                        ];
                      } else {
                        dataListCoverageProdTabs1 = [
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
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
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
                      }
                      setState(() {});
                      addDataCoverageProd(channelNew, monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 2) {
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        dataListCoverageBillingTabs1 = [
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
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
                                ? ""
                                : sheetProvider.selectedCategoryFilter,
                            "channel": selectedArrayItems
                          }
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverageBillingTabs1 = [
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
                            "channel": selectedArrayItems
                          }
                        ];
                      } else {
                        dataListCoverageBillingTabs1 = [
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
                            "category": sheetProvider.selectedCategoryFilter ==
                                    "Select.."
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
                      }
                      setState(() {});
                      addDataCoverageBilling(channelNew, monthNew);
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else {}
                  },
                  onApplyPressedMonthCHRTab: () async {},
                  onClosedTap: () async {
                    if (sheetProvider.setCurrentTabGP == 0) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataAll(sheetProvider.removeIndexGP);
                      });
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 1) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataProd(sheetProvider.removeIndexGP);
                      });
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 2) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataBilling(sheetProvider.removeIndexGP);
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
                  selectedItemValueChannelBrand: selectedItemValueChannelBrand,
                  selectedMonthList: _selectedMonth,
                  onTapMonthFilter: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Month'),
                        content: Container(
                          width: 300,
                          height: 300,
                          child: ListView.builder(
                            itemCount: getLast24Months().length,
                            itemBuilder: (context, index) {
                              var monthYear = last24Months[index];
                              var shortMonth =
                              _getShortMonthName(monthYear.split(' ')[0]);
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
                                  if (sheetProvider.setCurrentTabGP == 0) {
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
                                        "brandForm": "",
                                        "brand": "",
                                        "sbfGroup": "",
                                        "category": "",
                                        "channel": []
                                      }
                                    ];
                                    setState(() {});

                                    addDataCoverageAll('', monthNew);
                                    Navigator.pop(context);
                                    await postRequest(context, '', monthNew);
                                    sheetProvider.isLoaderActive = false;
                                  }
                                  // else if (sheetProvider.setCurrentTabGP == 1) {
                                  //   print("Month New $monthNew");
                                  //   sheetProvider.isLoaderActive = true;
                                  //   dataListCoverageCCTabs1 = [
                                  //     {
                                  //       sheetProvider.selectedChannelDivision:
                                  //       sheetProvider.selectedChannelSite ==
                                  //           "All India"
                                  //           ? 'allIndia'
                                  //           : sheetProvider
                                  //           .selectedChannelSite,
                                  //       "date": monthNew,
                                  //       "brandForm": "",
                                  //       "brand": "",
                                  //       "sbfGroup": "",
                                  //       "category": "",
                                  //       "channel": ""
                                  //     }
                                  //   ];
                                  //   setState(() {});
                                  //   addDataCoverageCCR('', monthNew);
                                  //   await postRequestCCTabs("", monthNew);
                                  //   sheetProvider.isLoaderActive = false;
                                  // }
                                  else if (sheetProvider.setCurrentTabGP == 1) {
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
                                        "brandForm": "",
                                        "brand": "",
                                        "sbfGroup": "",
                                        "category": "",
                                        "channel": []
                                      }
                                    ];
                                    setState(() {});
                                    addDataCoverageProd('', monthNew);
                                    Navigator.pop(context);
                                    await postRequestProdTabs(
                                        context, channelNew, monthNew);
                                    sheetProvider.isLoaderActive = false;
                                  }
                                  else {
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
                                        "brandForm": "",
                                        "brand": "",
                                        "sbfGroup": "",
                                        "category": "",
                                        "channel": []
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
                      );});

                  },
                  onTap1: () async {
                    setState(() {
                      selectedTapAPI = 0;
                      sheetProvider.setCurrentTabGP = 0;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequest(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("1: $selectedTapAPI");
                  },
                  onTap2: () async {
                    setState(() {
                      selectedTapAPI = 1;
                      sheetProvider.setCurrentTabGP = 1;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestProdTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("2: $selectedTapAPI");
                  },
                  onTap3: () async {
                    setState(() {
                      selectedTapAPI = 2;
                      sheetProvider.setCurrentTabGP = 2;
                    });
                    sheetProvider.isLoaderActive = true;

                    await postRequestBillingTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("3: $selectedTapAPI");
                  },
                  onTap4: () async {
                    setState(() {
                      selectedTapAPI = 3;
                      sheetProvider.setCurrentTabGP = 3;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestBillingTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("4: $selectedTapAPI");
                  },
                  selectedIndex1: selectedTapAPI,
                  onRemoveFilterTap: () async {
                    if (sheetProvider.setCurrentTabGP == 0) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      print("Final $finalMonth");
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
                          "category":
                              sheetProvider.selectedCategoryFilter == "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFilter,
                          "channel": []
                        }
                      ];
                      setState(() {});
                      selectedCategoryList = 'Select..';
                      selectedItemValueChannel[0] = 'Select..';
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    }
                    // else if (sheetProvider.setCurrentTabGP == 1) {
                    // sheetProvider.isExpandedMonthFilter = true;
                    // sheetProvider.isLoaderActive = true;
                    // String year =
                    // sheetProvider.myStringMonthFB.substring(2, 6);
                    // String month = sheetProvider.myStringMonthFB.substring(7);
                    // var finalMonth = sheetProvider.myStringMonthFB;
                    // print("Final $finalMonth");
                    // dataListCoverageCCTabs1 = [
                    //   {
                    //     sheetProvider.selectedChannelDivision:
                    //     sheetProvider.selectedChannelSite == "All India"
                    //         ? 'allIndia'
                    //         : sheetProvider.selectedChannelSite,
                    //     "date": finalMonth,
                    //     "brandForm": "",
                    //     "brand": "",
                    //     "sbfGroup": "",
                    //     "category": sheetProvider.selectedCategoryFilter =="Select.."?"":sheetProvider.selectedCategoryFilter,
                    //     "channel": ""
                    //   }
                    // ];
                    // setState(() {});
                    // selectedCategoryList = 'Select..';
                    // selectedItemValueChannel[0] = 'Select..';
                    // addDataCoverageCCR(channelNew, monthNew);
                    // await postRequestCCTabs(channelNew, monthNew);
                    // sheetProvider.isLoaderActive = false;
                    // }
                    else if (sheetProvider.setCurrentTabGP == 1) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      dataListCoverageProdTabs1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": finalMonth,
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category":
                              sheetProvider.selectedCategoryFilter == "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFilter,
                          "channel": []
                        }
                      ];
                      setState(() {});
                      selectedCategoryList = 'Select..';
                      selectedItemValueChannel[0] = 'Select..';
                      addDataCoverageProd(channelNew, monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 2) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      dataListCoverageBillingTabs1 = [
                        {
                          sheetProvider.selectedChannelDivision:
                              sheetProvider.selectedChannelSite == "All India"
                                  ? 'allIndia'
                                  : sheetProvider.selectedChannelSite,
                          "date": finalMonth,
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category":
                              sheetProvider.selectedCategoryFilter == "Select.."
                                  ? ""
                                  : sheetProvider.selectedCategoryFilter,
                          "channel": []
                        }
                      ];
                      setState(() {});
                      selectedCategoryList = 'Select..';
                      selectedItemValueChannel[0] = 'Select..';
                      addDataCoverageBilling(channelNew, monthNew);
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else {}
                  },
                  onRemoveFilterCategory: () async {
                    // print("Here $selectedCategoryList");
                    if (sheetProvider.setCurrentTabGP == 0) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
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
                      sheetProvider.selectedCategoryFilter = 'Select..';
                      sheetProvider.selectedCategoryFilterbr = 'Select..';
                      sheetProvider.selectedCategoryFiltersbf = 'Select..';
                      sheetProvider.selectedCategoryFiltersbfg = 'Select..';
                      selectedCategoryList = 'Select..';
                      selectedItemValueCategory[0] = 'Select..';
                      selectedItemValueBrand[0] = 'Select..';
                      selectedItemValueBrandForm[0] = 'Select..';
                      // selectedItemValueBrandFromGroup[0] = 'Select..';
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                      print("Removed");
                    }
                    // else if (sheetProvider.setCurrentTabGP == 1) {
                    //   sheetProvider.isExpandedMonthFilter = true;
                    //   sheetProvider.isLoaderActive = true;
                    //   String year =
                    //   sheetProvider.myStringMonthFB.substring(2, 6);
                    //   String month = sheetProvider.myStringMonthFB.substring(7);
                    //   var finalMonth = "$month-$year";
                    //   dataListCoverageCCTabs1 = [
                    //     {
                    //       sheetProvider.selectedChannelDivision:
                    //       sheetProvider.selectedChannelSite == "All India"
                    //           ? 'allIndia'
                    //           : sheetProvider.selectedChannelSite,
                    //       "date": finalMonth,
                    //       "brandForm": "",
                    //       "brand": "",
                    //       "sbfGroup": "",
                    //       "category": "",
                    //       "channel": selectedItemValueChannel[0] == "Select.."
                    //           ? ""
                    //           : selectedItemValueChannel[0]
                    //     }
                    //   ];
                    //   setState(() {});
                    //   sheetProvider.selectedCategoryFilter = 'Select..';
                    //   sheetProvider.selectedCategoryFilterbr = 'Select..';
                    //   sheetProvider.selectedCategoryFiltersbf = 'Select..';
                    //   sheetProvider.selectedCategoryFiltersbfg = 'Select..';
                    //   selectedCategoryList = 'Select..';
                    //   addDataCoverageCCR(channelNew, monthNew);
                    //   await postRequestCCTabs(channelNew, monthNew);
                    //   sheetProvider.isLoaderActive = false;
                    // }
                    else if (sheetProvider.setCurrentTabGP == 1) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      dataListCoverageProdTabs1 = [
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
                      sheetProvider.selectedCategoryFilter = 'Select..';
                      sheetProvider.selectedCategoryFilterbr = 'Select..';
                      sheetProvider.selectedCategoryFiltersbf = 'Select..';
                      sheetProvider.selectedCategoryFiltersbfg = 'Select..';
                      selectedCategoryList = 'Select..';
                      selectedItemValueCategory[0] = 'Select..';
                      selectedItemValueBrand[0] = 'Select..';
                      selectedItemValueBrandForm[0] = 'Select..';
                      // selectedItemValueBrandFromGroup[0] = 'Select..';
                      addDataCoverageProd(channelNew, monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabGP == 2) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2
                          .hasMatch(sheetProvider.myStringMonthFB)) {
                        String year =
                            sheetProvider.myStringMonthFB.substring(2, 6);
                        String month =
                            sheetProvider.myStringMonthFB.substring(7);
                        finalMonth = "$month-$year";
                      } else {
                        finalMonth = "Jun-2023";
                      }
                      dataListCoverageBillingTabs1 = [
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
                      sheetProvider.selectedCategoryFilter = 'Select..';
                      sheetProvider.selectedCategoryFilterbr = 'Select..';
                      sheetProvider.selectedCategoryFiltersbf = 'Select..';
                      sheetProvider.selectedCategoryFiltersbfg = 'Select..';
                      selectedCategoryList = 'Select..';
                      selectedItemValueCategory[0] = 'Select..';
                      selectedItemValueBrand[0] = 'Select..';
                      selectedItemValueBrandForm[0] = 'Select..';
                      // selectedItemValueBrandFromGroup[0] = 'Select..';
                      addDataCoverageBilling(channelNew, monthNew);
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else {
                      print("nothing");
                    }
                  },
                  selectedItemValueCategory: selectedItemValueCategory,
                  selectedItemValueBrand: selectedItemValueBrand,
                  selectedItemValueBrandForm: selectedItemValueBrandForm,
                  selectedItemValueBrandFromGroup: [],
                  onTapChannelFilter: () {
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
                              content: SizedBox(
                                width: 300,
                                height: 400,
                                child: ListView.builder(
                                  itemCount: channelFilter.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return channelFilter.isEmpty?const Center(child: CircularProgressIndicator()): Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (selectedArrayItems
                                                    .contains(channelFilter[index])) {
                                                  selectedArrayItems
                                                      .remove(channelFilter[index]);
                                                } else {
                                                  selectedArrayItems.add(channelFilter[index]);
                                                }

                                                print(selectedArrayItems);
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
                                                          ? Colors.blue
                                                          : MyColors.transparent,
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(2)),
                                                      border: Border.all(
                                                        color: selectedArrayItems
                                                            .contains(channelFilter[index])
                                                            ? Colors.blue
                                                            : MyColors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: selectedArrayItems
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
                              actions: [
                                TextButton(onPressed: () async{
                                  sheetProvider.isExpandedMonthFilter = true;
                                  // selectedItemValueChannel[0] = value!;
                                  // channelNew = selectedItemValueChannel[0];
                                  print("BosData ${sheetProvider.isExpandedMonthFilter}");
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
                                  if (sheetProvider.setCurrentTabGP == 0) {
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
                                        "category":
                                        sheetProvider.selectedCategoryFilter == "Select.."
                                            ? ""
                                            : sheetProvider.selectedCategoryFilter,
                                        "channel": selectedArrayItems
                                      }
                                    ];
                                    setState(() {});
                                    Navigator.pop(context);
                                    addDataCoverageAll(channelNew, monthNew);
                                    await postRequest(context, channelNew, monthNew);
                                    sheetProvider.isLoaderActive = false;
                                  } else if (sheetProvider.setCurrentTabGP == 1) {
                                    // sheetProvider.isExpandedMonthFilter = true;
                                    var finalMonth = "Jun-2023";
                                    if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                                      finalMonth = sheetProvider.myStringMonthFB;
                                    } else if (pattern2
                                        .hasMatch(sheetProvider.myStringMonthFB)) {
                                      String year =
                                      sheetProvider.myStringMonthFB.substring(2, 6);
                                      String month =
                                      sheetProvider.myStringMonthFB.substring(7);
                                      finalMonth = "$month-$year";
                                    } else {
                                      finalMonth = "Jun-2023";
                                    }
                                    dataListCoverageProdTabs1 = [
                                      {
                                        sheetProvider.selectedChannelDivision:
                                        sheetProvider.selectedChannelSite == "All India"
                                            ? 'allIndia'
                                            : sheetProvider.selectedChannelSite,
                                        "date": finalMonth,
                                        "brandForm": "",
                                        "brand": "",
                                        "sbfGroup": "",
                                        "category":
                                        sheetProvider.selectedCategoryFilter == "Select.."
                                            ? ""
                                            : sheetProvider.selectedCategoryFilter,
                                        "channel": selectedArrayItems
                                      }
                                    ];
                                    setState(() {});
                                    Navigator.pop(context);
                                    addDataCoverageProd(channelNew, monthNew);
                                    await postRequestProdTabs(context, channelNew, monthNew);
                                    sheetProvider.isLoaderActive = false;
                                  } else if (sheetProvider.setCurrentTabGP == 2) {
                                    var finalMonth = "Jun-2023";
                                    if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                                      finalMonth = sheetProvider.myStringMonthFB;
                                    } else if (pattern2
                                        .hasMatch(sheetProvider.myStringMonthFB)) {
                                      String year =
                                      sheetProvider.myStringMonthFB.substring(2, 6);
                                      String month =
                                      sheetProvider.myStringMonthFB.substring(7);
                                      finalMonth = "$month-$year";
                                    } else {
                                      finalMonth = "Jun-2023";
                                    }
                                    dataListCoverageBillingTabs1 = [
                                      {
                                        sheetProvider.selectedChannelDivision:
                                        sheetProvider.selectedChannelSite == "All India"
                                            ? 'allIndia'
                                            : sheetProvider.selectedChannelSite,
                                        "date": finalMonth,
                                        "brandForm": "",
                                        "brand": "",
                                        "sbfGroup": "",
                                        "category":
                                        sheetProvider.selectedCategoryFilter == "Select.."
                                            ? ""
                                            : sheetProvider.selectedCategoryFilter,
                                        "channel": selectedArrayItems
                                      }
                                    ];
                                    setState(() {});
                                    Navigator.pop(context);
                                    addDataCoverageBilling(channelNew, monthNew);
                                    await postRequestBillingTabs(
                                        context, channelNew, monthNew);
                                    sheetProvider.isLoaderActive = false;
                                  } else {}
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
