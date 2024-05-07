// import 'dart:js_interop';

import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/const/const_array.dart';
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
  bool menuBool = false;
  bool divisionBool = false;
  bool removeBool = false;

  List<dynamic> listRetailing = [];
  List<dynamic> listRetailingData = [];
  List<dynamic> listRetailingDataListCoverage = [];
  List<dynamic> listRetailingData1 = [];
  bool defaultMonthPressed = false;

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

    }
    return '';
  }

  Future<http.Response> postRequest(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/coverage/subChannel';

    var body = json.encode(flattenedList.isEmpty
        ? [
            {"allIndia": "allIndia", "date": "May-2023", "channel": []}
          ]
        : flattenedList);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);

      });
    } else {

      setState(() {
        provider.setCoverageErrorMsg([response.body]);
      });
    }

    return response;
  }

  Future<http.Response> postRequestCCTabs(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/coverage/cc';
    // var url ='https://run.mocky.io/v3/16822299-30a6-427f-8669-407b8ded83d9';
    // var url = 'https://run.mocky.io/v3/6b187fed-0da7-4a67-a6cf-d32e547c990b';
    var body = json.encode(flattenedListCC.isEmpty
        ? flattenedListCC = [
            {"allIndia": "allIndia", "date": "May-2023", "channel": []}
          ]
        : flattenedListCC);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);

      });
    } else {

      setState(() {
        provider.setCoverage1ErrorMsg([response.body]);
      });
    }

    return response;
  }

  Future<http.Response> postRequestProdTabs(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/coverage/productivity';
    // var url = 'https://run.mocky.io/v3/533a2f1b-6163-4694-814a-8adfdc09a432';
    var body = json.encode(flattenedListProd.isEmpty
        ? flattenedListProd = [
            {"allIndia": "allIndia", "date": "Jun-2023", "channel": []}
          ]
        : flattenedListProd);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageProdTabs = jsonDecode(response.body);

      });
    } else {

      setState(() {
        provider.setCoverage2ErrorMsg([response.body]);
      });
    }
    return response;
  }

  Future<http.Response> postRequestBillingTabs(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/coverage/billing';
    // var url = 'https://run.mocky.io/v3/4576ec4e-755a-4645-bf49-bf483f12e7a9';
    var body = json.encode(flattenedListBilling.isEmpty
        ? flattenedListBilling = [
            {"allIndia": "allIndia", "date": "Jun-2023", "channel": []}
          ]
        : flattenedListBilling);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageBillingTabs = jsonDecode(response.body);

      });
    } else {

      setState(() {
        provider.setCoverage3ErrorMsg([response.body]);
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
      {"filter_key": "retailing", "query": []},
      {"filter_key": "gp", "query": []},
      {"filter_key": "fb", "query": []},
      {"filter_key": "cc", "query": []},
      {"filter_key": "coverage", "query": listRetailingData1},
      {"filter_key": "productivity", "query": []}
    ]
        : listRetailingData);

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
    html.window.localStorage['dataSummaryNewCoverage'] = jsonData;
  }

  void loadDataCoverageAllRetailing() {
    final storedValue = html.window.localStorage['dataSummaryNewCoverage'];
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
            {"filter_key": "retailing", "query": []},
            {"filter_key": "gp", "query": []},
            {"filter_key": "fb", "query": []},
            {"filter_key": "cc", "query": []},
            {"filter_key": "coverage", "query": listRetailingData1},
            {"filter_key": "productivity", "query": []}
          ]);
        }else{
          if(defaultMonthPressed){
            listRetailingData.map((entry) {
              if (entry['filter_key'] == 'coverage') {
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
              {"filter_key": "retailing", "query": []},
              {"filter_key": "gp", "query": []},
              {"filter_key": "fb", "query": []},
              {"filter_key": "cc", "query": []},
              {"filter_key": "coverage", "query": jsonToAdd},
              {"filter_key": "productivity", "query": []}
            ];
          }

        }
      });
      saveDataCoverageAllRetailing();
    }
  }

// TODO: Here
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
        if (flattenedList.isEmpty) {
          flattenedList
              .add({"allIndia": "allIndia", "date": "May-2023", "channel": []});
        } else {
          if (bosData.isExpandedMonthFilter) {
            if (dataListCoverage1.isEmpty) {
              flattenedList[bosData.selectedChannelIndex]["channel"] = [];
            } else {
              for (String element in jsonToAdd) {
                flattenedList[bosData.selectedChannelIndex]["channel"]
                    .add(element);
              }
              // flattenedList[bosData.selectedChannelIndex]['channel'].add(jsonToAdd[0]);
              bosData.isExpandedMonthFilter = false;
            }
          } else if (bosData.isExpandedMonthCDFilter) {
            flattenedList[bosData.selectedChannelIndex]['date'] = jsonToAdd[0];
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
    // if(isReloaded){
    // await postRequest(context, channel, month);
    // isReloaded = false;
  // }
}

// TODO: Here
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
          if (dataListCoverageCCTabs1.isEmpty) {
            flattenedListCC[bosData.selectedChannelIndex]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListCC[bosData.selectedChannelIndex]["channel"]
                  .add(element);
            }
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

            }
          }
        }
      });
      saveDataCoverageCCR();
    }
    // await postRequestCCTabs(context, channel, month);
  }

// TODO: Here
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
          if (dataListCoverageProdTabs1.isEmpty) {
            flattenedListProd[bosData.selectedChannelIndex]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListProd[bosData.selectedChannelIndex]["channel"]
                  .add(element);
            }
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListProd[bosData.selectedChannelIndex]['date'] =
              jsonToAdd[0];
          bosData.isExpandedMonthCDFilter = false;
        } else {
          if (jsonToAdd.isNotEmpty) {
            if (!flattenedListProd.contains(jsonToAdd[0])) {
              flattenedListProd.add(jsonToAdd[0]);
            } else {

            }
          }
        }
      });
      saveDataCoverageProd();
    }
    // await postRequestProdTabs(context, channel, month);
  }

// TODO: Here
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
        if (bosData.isExpandedMonthFilter) {
          if (dataListCoverageBillingTabs1.isEmpty) {
            flattenedListBilling[bosData.selectedChannelIndex]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListBilling[bosData.selectedChannelIndex]["channel"]
                  .add(element);
            }
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListBilling[bosData.selectedChannelIndex]['date'] =
              jsonToAdd[0];
          bosData.isExpandedMonthCDFilter = false;
        } else {
          if (jsonToAdd.isNotEmpty) {
            if (!flattenedListBilling.contains(jsonToAdd[0])) {
              flattenedListBilling.add(jsonToAdd[0]);
            } else {

            }
          }
        }
      });
      saveDataCoverageBilling();
    }
    // await postRequestBillingTabs(context, channel, month);
  }

  void removeDataAll(int index) {
    if (flattenedList.isNotEmpty) {
      try {
        setState(() {
          flattenedList.removeAt(index);
        });
        saveDataCoverageAll();
      } catch (e) {

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

  void removeDataAllChannel(int index) {
    final bosData = Provider.of<SheetProvider>(context, listen: false);

    if (flattenedList.isNotEmpty) {
      try {
        setState(() {
          flattenedList[bosData.selectedChannelIndex]["channel"]
              .removeAt(index);
        });
        saveDataCoverageAll();
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void removeDataCCRChannel(int index) {
    final bosData = Provider.of<SheetProvider>(context, listen: false);

    if (flattenedListCC.isNotEmpty) {
      setState(() {
        flattenedListCC[bosData.selectedChannelIndex]["channel"]
            .removeAt(index);
      });
      saveDataCoverageCCR();
    }
  }

  void removeDataProdChannel(int index) {
    final bosData = Provider.of<SheetProvider>(context, listen: false);

    if (flattenedListProd.isNotEmpty) {
      setState(() {
        flattenedListProd[bosData.selectedChannelIndex]["channel"]
            .removeAt(index);
      });
      saveDataCoverageProd();
    }
  }

  void removeDataBillingChannel(int index) {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    if (flattenedListBilling.isNotEmpty) {
      setState(() {
        flattenedListBilling[bosData.selectedChannelIndex]["channel"]
            .removeAt(index);
      });
      saveDataCoverageBilling();
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
    loadDataCoverageAll();
    loadDataCoverageCCR();
    loadDataCoverageProd();
    loadDataCoverageBilling();
    loadDataCoverageAllRetailing();
    // addDataCoverageAllRetailing();
    addDataCoverageAll('', 'June-2023');
    postRequest(context, '', '');
    _selectedMonth = getLast24Months()[0];
    isReloaded = true;
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
                  indexNew: 2,
                ),
                DistributionContainer(
                  title: 'Coverage & Distribution',
                  onApplyPressedMonth: () async {
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
                      sheetProvider.isLoaderActive = true;
                      sheetProvider.selectMonth = false;
                      sheetProvider.isExpandedMonthFilter = false;
                      sheetProvider.isExpandedMonthCDFilter = false;
                      dataListCoverage1 = [
                        {
                          "$finalDivision": finalSite,
                          "date": "$month-$year",
                          "channel": []
                        }
                      ];
                      print(dataListCoverage1);
                      setState(() {});
                      loadDataCoverageAll();
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 1) {
                      sheetProvider.isLoaderActive = true;
                      sheetProvider.selectMonth = false;
                      sheetProvider.isExpandedMonthFilter = false;
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
                    } else if (selectedTapAPI == 2) {
                      sheetProvider.isLoaderActive = true;
                      sheetProvider.selectMonth = false;
                      sheetProvider.isExpandedMonthFilter = false;
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
                    } else if (selectedTapAPI == 3) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        sheetProvider.selectMonth = false;
                        sheetProvider.isExpandedMonthFilter = false;
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
                  onChangedFilter: (value) async {},
                  onChangedFilterMonth: (value) async {
                  },
                  onApplyPressedMonthCHRTab: () async {},
                  onClosedTap: () async {
                    if (sheetProvider.setCurrentTabCoverage == 0) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataAll(sheetProvider.removeIndexCC);
                        // selectedIndexLocation -= 1;
                        // addDataCoverageAll(channelNew, monthNew);
                      });
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 1) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataCCR(sheetProvider.removeIndexCC);
                      });
                      await postRequestCCTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 2) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataProd(sheetProvider.removeIndexCC);
                      });
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.setCurrentTabCoverage == 3) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataBilling(sheetProvider.removeIndexCC);
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
                                        sheetProvider.isExpandedMonthCDFilter = false;
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
                                        await postRequest(
                                            context, '', monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 1) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageCCTabs1 = [
                                          monthNew,
                                        ];
                                        setState(() {});
                                        addDataCoverageCCR('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestCCTabs(
                                            context, "", monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 2) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageProdTabs1 = [
                                          monthNew,
                                        ];
                                        setState(() {});
                                        addDataCoverageProd('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestProdTabs(
                                            context, channelNew, monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 3) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverageBillingTabs1 = [
                                          monthNew,
                                        ];
                                        setState(() {});
                                        addDataCoverageBilling('', monthNew);
                                        Navigator.pop(context);
                                        await postRequestBillingTabs(
                                            context, channelNew, monthNew);
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
                  onTap1: () async {
                    setState(() {
                      selectedTapAPI = 0;
                      sheetProvider.setCurrentTabCoverage = 0;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequest(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("0: $selectedTapAPI");
                    sheetProvider.isExpandedDivision = false;
                    sheetProvider.isExpanded = false;
                    sheetProvider.isExpandedBranch = false;
                    sheetProvider.isExpandedChannel = false;
                    sheetProvider.isExpandedSubChannel = false;
                  },
                  onTap2: () async {
                    selectedTapAPI = 1;
                    sheetProvider.setCurrentTabCoverage = 1;

                    sheetProvider.isLoaderActive = true;
                    await postRequestCCTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                    print("1: $selectedTapAPI");
                    sheetProvider.isExpandedDivision = false;
                    sheetProvider.isExpanded = false;
                    sheetProvider.isExpandedBranch = false;
                    sheetProvider.isExpandedChannel = false;
                    sheetProvider.isExpandedSubChannel = false;
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
                    sheetProvider.isExpandedDivision = false;
                    sheetProvider.isExpanded = false;
                    sheetProvider.isExpandedBranch = false;
                    sheetProvider.isExpandedChannel = false;
                    sheetProvider.isExpandedSubChannel = false;
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
                    sheetProvider.isExpandedDivision = false;
                    sheetProvider.isExpanded = false;
                    sheetProvider.isExpandedBranch = false;
                    sheetProvider.isExpandedChannel = false;
                    sheetProvider.isExpandedSubChannel = false;
                  },
                  selectedIndex1: selectedTapAPI,
                  selectedChannelList: '',
                  onTapChannelFilter: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
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
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: selectedArrayItems.length ==
                                              channelFilter.length,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value != null) {
                                                if (value) {
                                                  selectedArrayItems
                                                      .addAll(channelFilter);
                                                } else {
                                                  selectedArrayItems.clear();
                                                }
                                              }
                                            });
                                          },
                                        ),
                                        const Text("Select All"),
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: channelFilter.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
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
                                      sheetProvider.isExpandedMonthCDFilter = false;
                                      sheetProvider.isExpandedMonthFilter =
                                          true;
                                      if (selectedTapAPI == 0) {
                                        sheetProvider.isLoaderActive = true;
                                        dataListCoverage1 = selectedArrayItems;
                                        setState(() {});
                                        Navigator.pop(context);
                                        addDataCoverageAll(
                                            channelNew, monthNew);
                                        await postRequest(
                                            context, channelNew, monthNew);
                                        selectedArrayItems = [];
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 1) {
                                        print(selectedArrayItems);
                                        dataListCoverageCCTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        Navigator.pop(context);
                                        addDataCoverageCCR(
                                            channelNew, monthNew);
                                        await postRequestCCTabs(
                                            context, channelNew, monthNew);
                                        selectedArrayItems = [];
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 2) {
                                        dataListCoverageProdTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        Navigator.pop(context);
                                        addDataCoverageProd(
                                            channelNew, monthNew);
                                        await postRequestProdTabs(
                                            context, channelNew, monthNew);
                                        selectedArrayItems = [];
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 3) {
                                        dataListCoverageBillingTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        Navigator.pop(context);
                                        addDataCoverageBilling(
                                            channelNew, monthNew);
                                        await postRequestBillingTabs(
                                            context, channelNew, monthNew);
                                        selectedArrayItems = [];
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
                  onTapRemoveFilter: () async {
                    sheetProvider.isExpandedMonthFilter = true;
                    if (selectedTapAPI == 0) {
                      sheetProvider.isLoaderActive = true;
                      removeDataAllChannel(sheetProvider.isCloseSelectCD);
                      Navigator.of(context).pop();
                      await postRequest(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 1) {
                      sheetProvider.isLoaderActive = true;
                      removeDataCCRChannel(sheetProvider.isCloseSelectCD);
                      Navigator.of(context).pop();
                      await postRequestCCTabs(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 2) {
                      sheetProvider.isLoaderActive = true;
                      removeDataProdChannel(sheetProvider.isCloseSelectCD);
                      Navigator.of(context).pop();
                      await postRequestProdTabs(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 3) {
                      sheetProvider.isLoaderActive = true;
                      removeDataBillingChannel(sheetProvider.isCloseSelectCD);
                      Navigator.of(context).pop();
                      await postRequestBillingTabs(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    }
                  },
                  selectedIndexLocation: selectedIndexLocation,
                  listRetailingDataListCoverage: listRetailingDataListCoverage,
                  onTapContainer: () {  },
                  onApplyRetailingSummary: () async{
                    menuBool = !menuBool;
                    divisionBool = !divisionBool;
                    removeBool = !removeBool;
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoadingPage = true;
                    var newElement =
                        '{"${SharedPreferencesUtils.getString('webRetailingSummaryDivision')}": "${SharedPreferencesUtils.getString('webRetailingSummarySite')}", "date": "${SharedPreferencesUtils.getString('webCoverageMonth') ?? "Jun"}-${SharedPreferencesUtils.getString('webCoverageYear') ?? "2023"}"}';
                    var ele = json.decode(newElement);
                    listRetailingData1.add(ele);
                    sheetProvider.isMenuActive = false;
                    sheetProvider.isDivisionActive = false;
                    sheetProvider.isRemoveActive = false;
                    addDataCoverageAllRetailing();
                    await postRequestRetailing(context);
                    sheetProvider.isLoadingPage = false;
                    setState(() {});
                  },
                  onRemoveGeoPressed: () async {
                    menuBool = !menuBool;
                    divisionBool = !divisionBool;
                    removeBool = !removeBool;
                    sheetProvider.isLoadingPage = true;
                    removeDataRetailing(sheetProvider.removeIndexRetailingSummary);
                    sheetProvider.isMenuActive = false;
                    sheetProvider.isDivisionActive = false;
                    sheetProvider.isRemoveActive = false;
                    await postRequestRetailing(context);
                    sheetProvider.isLoadingPage = false;
                    setState(() {});
                  },
                  onMonthChangedDefault: () {
                    setState(() {
                    });
                    sheetProvider.selectMonth = true;
                  }, onApplySummaryDefaultMonth: () async{
                  defaultMonthPressed = true;
                  sheetProvider.isLoadingPage = true;
                  addDataCoverageAllRetailing();
                  sheetProvider.selectMonth = false;
                  await postRequestRetailing(context);
                  sheetProvider.isLoadingPage = false;
                  setState(() {});
                }, tryAgain: () async{
                  print('button');
                  sheetProvider.setCoverageErrorMsg([]);
                  sheetProvider.isLoaderActive = true;
                  await postRequest(context, "", "");
                  sheetProvider.isLoaderActive = false;
                  setState(() {});
                },
                  tryAgain1: () async{
                    print('button');
                    sheetProvider.setCoverage1ErrorMsg([]);
                    sheetProvider.isLoaderActive = true;
                    await postRequestCCTabs(context, "", "");
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                  },
                  tryAgain2: () async{
                    print('button');
                    sheetProvider.setCoverage2ErrorMsg([]);
                    sheetProvider.isLoaderActive = true;
                    await postRequestProdTabs(context, "", "");
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                  },
                  tryAgain3: () async{
                    print('button');
                    sheetProvider.setCoverage3ErrorMsg([]);
                    sheetProvider.isLoaderActive = true;
                    await postRequestBillingTabs(context, "", "");
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
}
