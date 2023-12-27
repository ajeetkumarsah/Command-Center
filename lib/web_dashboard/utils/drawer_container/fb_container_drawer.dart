import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/deep_dive_container/fb_Container/fb_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import '../../../helper/app_urls.dart';
import '../../../provider/sheet_provider.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../comman_utils/drawer_widget.dart';

class FBContainerDrawer extends StatefulWidget {
  const FBContainerDrawer({super.key});

  @override
  State<FBContainerDrawer> createState() => _FBContainerDrawerState();
}

class _FBContainerDrawerState extends State<FBContainerDrawer> {
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
  List<dynamic> errorMsg = [];
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
  String selectedCategoryList = 'Select..';

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
    }
   else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }

  Future<http.Response> postRequest(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);

    var url = '$BASE_URL/api/webDeepDive/fb/sbf';

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
    print("Body FB Tab 1 $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
      });
    } else {
      print("Else");
      setState(() {
        provider.setFbErrorMsg([response.body]);
        provider.isLoaderActive = false;
      });
      // print(provider.fbErrorMsg);
      // var snackBar = SnackBar(content: Text(response.body));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Future<http.Response> postRequestCCTabs(
      String channelFilter, String monthFilter, context) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/fb/bf';
    var body = json.encode(flattenedListCC.isEmpty
        ? flattenedListCC = [
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
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("FB Tab 2 $body");
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);
      });
    } else {
      print(response.statusCode);
      setState(() {
        provider.setFb1ErrorMsg([response.body]);
        // provider.isLoaderActive = false;
      });
    }
    return response;
  }

  Future<http.Response> postRequestProdTabs(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/fb/monthlyData';
    // var url = 'https://run.mocky.io/v3/533a2f1b-6163-4694-814a-8adfdc09a432';
    var body = json.encode(flattenedListProd.isEmpty
        ? flattenedListProd = [
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
      print(response.body);
      setState(() {
        provider.setFb2ErrorMsg([response.body]);
        // provider.isLoaderActive = false;
      });
    }
    return response;
  }

  Future<http.Response> postRequestBillingTabs(
      context, String channelFilter, String monthFilter) async {
    final provider = Provider.of<SheetProvider>(context, listen: false);
    var url = '$BASE_URL/api/webDeepDive/fb/abs/monthlyData';
    // var url = 'https://run.mocky.io/v3/4576ec4e-755a-4645-bf49-bf483f12e7a9';
    var body = json.encode(flattenedListBilling.isEmpty
        ? flattenedListBilling = [
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
      print(response.body);
      setState(() {
        provider.setFb3ErrorMsg([response.body]);
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
      {"filter_key": "retailing", "query": []},
      {"filter_key": "gp", "query": []},
      {"filter_key": "fb", "query": listRetailingData1},
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
    html.window.localStorage['dataSummaryNewFB'] = jsonData;
  }

  void loadDataCoverageAllRetailing() {
    final storedValue = html.window.localStorage['dataSummaryNewFB'];
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
            {"filter_key": "fb", "query": listRetailingData1},
            {"filter_key": "cc", "query": []},
            {"filter_key": "coverage", "query": []},
            {"filter_key": "productivity", "query": []}
          ]);
        }else{
          if(defaultMonthPressed){
            listRetailingData.map((entry) {
              if (entry['filter_key'] == 'fb') {
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
              {"filter_key": "fb", "query": jsonToAdd},
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
  void saveDataCoverageAll() {
    final jsonData = jsonEncode(flattenedList);
    html.window.localStorage['dataListFBAllData'] = jsonData;
  }

  void loadDataCoverageAll() {
    final storedValue = html.window.localStorage['dataListFBAllData'];
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
            if (dataListCoverage1.isEmpty) {
              flattenedList[bosData.selectedChannelIndexFB]["channel"] = [];
            } else {
              for (String element in jsonToAdd) {
                flattenedList[bosData.selectedChannelIndexFB]["channel"]
                    .add(element);
              }
              bosData.isExpandedMonthFilter = false;
            }
          } else if (bosData.isExpandedMonthCDFilter) {
            flattenedList[bosData.selectedChannelIndexFB]['date'] =
                jsonToAdd[0];
            bosData.isExpandedMonthCDFilter = false;
          } else if (bosData.isExpandedCategoryFilter) {
            flattenedList[bosData.selectedChannelIndexFB]['category'] =
            jsonToAdd[0];
            bosData.isExpandedCategoryFilter = false;
          }else {
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

  // TODO: Here
  void saveDataCoverageCCR() {
    final jsonData = jsonEncode(flattenedListCC);
    html.window.localStorage['dataListFBCategory'] = jsonData;
  }

  void loadDataCoverageCCR() {
    final storedValue = html.window.localStorage['dataListFBCategory'];
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
            flattenedListCC[bosData.selectedChannelIndexFB]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListCC[bosData.selectedChannelIndexFB]["channel"]
                  .add(element);
            }
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListCC[bosData.selectedChannelIndexFB]['date'] =
              jsonToAdd[0].toString();
          bosData.isExpandedMonthCDFilter = false;
        }else if (bosData.isExpandedCategoryFilter) {
          flattenedListCC[bosData.selectedChannelIndexFB]['category'] =
          jsonToAdd[0];
          bosData.isExpandedCategoryFilter = false;
        } else {
          if (!flattenedListCC.contains(jsonToAdd[0])) {
            flattenedListCC.add(jsonToAdd[0]);
          } else {
            print("Value already exists in flattenedListCC");
          }
        }
      });
      saveDataCoverageCCR();
    }
    await postRequestCCTabs(channel, month, context);
  }

  // TODO: Here
  void saveDataCoverageProd() {
    final jsonData = jsonEncode(flattenedListProd);
    html.window.localStorage['dataListFBPer'] = jsonData;
  }

  void loadDataCoverageProd() {
    final storedValue = html.window.localStorage['dataListFBPer'];
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
            flattenedListProd[bosData.selectedChannelIndexFB]["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListProd[bosData.selectedChannelIndexFB]["channel"]
                  .add(element);
            }
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListProd[bosData.selectedChannelIndexFB]['date'] =
              jsonToAdd[0].toString();
          bosData.isExpandedMonthCDFilter = false;
        }else if (bosData.isExpandedCategoryFilter) {
          flattenedListProd[bosData.selectedChannelIndexFB]['category'] =
          jsonToAdd[0];
          bosData.isExpandedCategoryFilter = false;
        } else {
          if (!flattenedListProd.contains(jsonToAdd[0])) {
            flattenedListProd.add(jsonToAdd[0]);
          } else {
            print("Value already exists in flattenedListCC");
          }
        }
      });
      saveDataCoverageProd();
    }
    await postRequestProdTabs(context, channel, month);
  }

  // TODO: Here
  void saveDataCoverageBilling() {
    final jsonData = jsonEncode(flattenedListBilling);
    html.window.localStorage['dataListFBAbs'] = jsonData;
  }

  void loadDataCoverageBilling() {
    final storedValue = html.window.localStorage['dataListFBAbs'];
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
            flattenedListBilling[bosData.selectedChannelIndexFB]
                ["channel"] = [];
            bosData.isExpandedMonthFilter = false;
          } else {
            for (String element in jsonToAdd) {
              flattenedListBilling[bosData.selectedChannelIndexFB]["channel"]
                  .add(element);
            }
            bosData.isExpandedMonthFilter = false;
          }
        } else if (bosData.isExpandedMonthCDFilter) {
          flattenedListBilling[bosData.selectedChannelIndexFB]['date'] =
              jsonToAdd[0].toString();
          bosData.isExpandedMonthCDFilter = false;
        } else if (bosData.isExpandedCategoryFilter) {
          flattenedListBilling[bosData.selectedChannelIndexFB]['category'] =
          jsonToAdd[0];
          bosData.isExpandedCategoryFilter = false;
        }else {
          if (!flattenedListBilling.contains(jsonToAdd[0])) {
            flattenedListBilling.add(jsonToAdd[0]);
          } else {
            print("Value already exists in flattenedListCC");
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

  String _getShortMonthName(String fullName) {
    return fullName.substring(0, 3);
  }

  bool isTabReloaded = false;

  List<String> channelFilter = [];
  List<String> selectedArrayItems = [];

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
    addDataCoverageAll('', 'Jun-2023');
    _selectedMonth = getLast24Months()[0];
    postRequestChannel(context);
    postRequestRetailing(context);
  }

  void popup() {
    Navigator.pop(context);
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
                  indexNew: 4,
                ),
                FBContainerWeb(
                  title: 'Focus Brand',
                  onApplyPressedMonth: () async {
                    sheetProvider.selectMonth = false;
                    sheetProvider.isExpandedMonthFilter = false;
                    var division = SharedPreferencesUtils.getString(
                        'webCoverageSheetDivision');
                    var site = SharedPreferencesUtils.getString(
                        'webCoverageSheetSite');
                    var year =
                        SharedPreferencesUtils.getString('webCoverageYear');
                    var month =
                        SharedPreferencesUtils.getString('webCoverageMonth');
                    var finalSite = site == 'All India' ? 'allIndia' : site;
                    if (sheetProvider.isCurrentTab == 0) {
                      sheetProvider.isLoaderActive = true;
                      dataListCoverage1 = [
                        {
                          "$division": finalSite,
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
                    } else if (sheetProvider.isCurrentTab == 1) {
                      sheetProvider.isLoaderActive = true;
                      sheetProvider.selectMonth = false;
                      dataListCoverageCCTabs1 = [
                        {
                          "$division": finalSite,
                          "date": "$month-$year",
                          "brandForm": "",
                          "brand": "",
                          "sbfGroup": "",
                          "category": "",
                          "channel": []
                        }
                      ];
                      setState(() {});
                      addDataCoverageCCR(channelNew, monthNew);
                      await postRequestCCTabs(channelNew, monthNew, context);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 2) {
                      sheetProvider.isLoaderActive = true;
                      sheetProvider.selectMonth = false;
                      dataListCoverageProdTabs1 = [
                        {
                          "$division": finalSite,
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
                    } else if (sheetProvider.isCurrentTab == 3) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        sheetProvider.selectMonth = false;
                        dataListCoverageBillingTabs1 = [
                          {
                            "$division": finalSite,
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
                  onChangedFilter: (value) async {},
                  onChangedFilterMonth: (value) async {},
                  onChangedFilterBrand: (value) {},
                  categoryApply: () async {
                    // sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isExpandedCategoryFilter = true;
                    sheetProvider.isLoaderActive = true;
                    if (sheetProvider.isCurrentTab == 0) {
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        // Category
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFilter == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilter,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverage1 = [
                          // Brand
                          sheetProvider.selectedCategoryFilterbr == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilterbr,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbf.isNotEmpty) {
                        // SBF
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbf == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbf,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbfg.isNotEmpty) {
                        // SBFG
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbfg == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbfg,
                        ];
                      } else {}
                      setState(() {});
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 1) {
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        // Category
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFilter == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilter,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverage1 = [
                          // Brand
                          sheetProvider.selectedCategoryFilterbr == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilterbr,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbf.isNotEmpty) {
                        // SBF
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbf == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbf,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbfg.isNotEmpty) {
                        // SBFG
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbfg == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbfg,
                        ];
                      } else {}
                      setState(() {});
                      addDataCoverageCCR(channelNew, monthNew);
                      await postRequestCCTabs(channelNew, monthNew, context);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 2) {
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        // Category
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFilter == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilter,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverage1 = [
                          // Brand
                          sheetProvider.selectedCategoryFilterbr == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilterbr,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbf.isNotEmpty) {
                        // SBF
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbf == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbf,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbfg.isNotEmpty) {
                        // SBFG
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbfg == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbfg,
                        ];
                      } else {}
                      setState(() {});
                      addDataCoverageProd(channelNew, monthNew);
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 3) {
                      if (sheetProvider.selectedCategoryFilter.isNotEmpty) {
                        // Category
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFilter == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilter,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFilterbr.isNotEmpty) {
                        dataListCoverage1 = [
                          // Brand
                          sheetProvider.selectedCategoryFilterbr == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFilterbr,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbf.isNotEmpty) {
                        // SBF
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbf == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbf,
                        ];
                      } else if (sheetProvider
                          .selectedCategoryFiltersbfg.isNotEmpty) {
                        // SBFG
                        dataListCoverage1 = [
                          sheetProvider.selectedCategoryFiltersbfg == "Select.."
                              ? ""
                              : sheetProvider.selectedCategoryFiltersbfg,
                        ];
                      } else {}
                      setState(() {});
                      addDataCoverageBilling(channelNew, monthNew);
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    }else{}
                  },
                  onApplyPressedMonthCHRTab: () async {},
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
                  onClosedTap: () async {
                    if (sheetProvider.isCurrentTab == 0) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataAll(sheetProvider.removeIndexFB);
                      });
                      await postRequest(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 1) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataCCR(sheetProvider.removeIndexFB);
                      });
                      await postRequestCCTabs(channelNew, monthNew, context);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 2) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataProd(sheetProvider.removeIndexFB);
                      });
                      await postRequestProdTabs(context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 3) {
                      sheetProvider.isLoaderActive = true;
                      setState(() {
                        removeDataBilling(sheetProvider.removeIndexFB);
                      });
                      await postRequestBillingTabs(
                          context, channelNew, monthNew);
                      sheetProvider.isLoaderActive = false;
                    } else {}
                  },
                  onRemoveFilter: () async {
                    if (sheetProvider.isCurrentTab == 0) {
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      String year =
                          sheetProvider.myStringMonthFB.substring(2, 6);
                      String month = sheetProvider.myStringMonthFB.substring(7);
                      var finalMonth = "$month-$year";
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
                    } else if (sheetProvider.isCurrentTab == 1) {
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
                      dataListCoverageCCTabs1 = [
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
                      addDataCoverageCCR(channelNew, monthNew);
                      await postRequestCCTabs(channelNew, monthNew, context);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 2) {
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
                    } else if (sheetProvider.isCurrentTab == 3) {
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
                                      setState(() {
                                        _selectedMonth = monthYear;
                                      });
                                      sheetProvider.isExpandedMonthCDFilter =
                                          true;
                                      monthNew = "$shortMonth-$year";
                                    });
                                    if (selectedTapAPI == 0) {
                                      sheetProvider.isLoaderActive = true;
                                      dataListCoverage1 = [monthNew];
                                      setState(() {});
                                      addDataCoverageAll('', monthNew);
                                      popup();
                                      await postRequest(context, '', monthNew);
                                      sheetProvider.isLoaderActive = false;
                                    } else if (selectedTapAPI == 1) {
                                      sheetProvider.isLoaderActive = true;
                                      dataListCoverageCCTabs1 = [monthNew];
                                      setState(() {});
                                      addDataCoverageCCR('', monthNew);
                                      popup();
                                      await postRequestCCTabs(
                                          "", monthNew, context);
                                      sheetProvider.isLoaderActive = false;
                                    } else if (selectedTapAPI == 2) {
                                      sheetProvider.isLoaderActive = true;
                                      dataListCoverageProdTabs1 = [monthNew];
                                      setState(() {});
                                      addDataCoverageProd('', monthNew);
                                      popup();
                                      await postRequestProdTabs(
                                          context, channelNew, monthNew);
                                      sheetProvider.isLoaderActive = false;
                                    } else if (selectedTapAPI == 3) {
                                      sheetProvider.isLoaderActive = true;
                                      dataListCoverageBillingTabs1 = [monthNew];
                                      setState(() {});
                                      addDataCoverageBilling('', monthNew);
                                      popup();
                                      await postRequestBillingTabs(
                                          context, channelNew, monthNew);
                                      sheetProvider.isLoaderActive = false;
                                    } else {}
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  onTap1: () async {
                    setState(() {
                      selectedTapAPI = 0;
                      sheetProvider.isCurrentTab = 0;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequest(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("1: $selectedTapAPI");
                  },
                  onTap2: () async {
                    setState(() {
                      selectedTapAPI = 1;
                      sheetProvider.isCurrentTab = 1;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestCCTabs(channelNew, monthNew, context);
                    sheetProvider.isLoaderActive = false;
                    print("2: $selectedTapAPI");
                  },
                  onTap3: () async {
                    setState(() {
                      selectedTapAPI = 2;
                      sheetProvider.isCurrentTab = 2;
                    });
                    sheetProvider.isLoaderActive = true;

                    await postRequestProdTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("3: $selectedTapAPI");
                  },
                  onTap4: () async {
                    setState(() {
                      selectedTapAPI = 3;
                      sheetProvider.isCurrentTab = 3;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestBillingTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("4: $selectedTapAPI");
                  },
                  selectedIndex1: selectedTapAPI,
                  onRemoveFilterCategory: () async {
                    if (sheetProvider.isCurrentTab == 0) {
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
                    } else if (sheetProvider.isCurrentTab == 1) {
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
                      } // var finalMonth = sheetProvider.myStringMonthFB;
                      dataListCoverageCCTabs1 = [
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
                      addDataCoverageCCR(channelNew, monthNew);
                      await postRequestCCTabs(channelNew, monthNew, context);
                      sheetProvider.isLoaderActive = false;
                    } else if (sheetProvider.isCurrentTab == 2) {
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
                    } else if (sheetProvider.isCurrentTab == 3) {
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
                  selectedCategoryList: selectedCategoryList,
                  selectedItemValueCategory: selectedItemValueCategory,
                  selectedItemValueBrand: selectedItemValueBrand,
                  selectedItemValueBrandForm: selectedItemValueBrandForm,
                  selectedItemValueBrandFromGroup: [],
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
                                child: ListView.builder(
                                  itemCount: channelFilter.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return channelFilter.isEmpty
                                        ? const Center(
                                            child: CircularProgressIndicator())
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

                                                      print(selectedArrayItems);
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                            color: selectedArrayItems
                                                                    .contains(
                                                                        channelFilter[
                                                                            index])
                                                                ? Colors.blue
                                                                : MyColors
                                                                    .transparent,
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius
                                                                        .circular(
                                                                            2)),
                                                            border: Border.all(
                                                              color: selectedArrayItems
                                                                      .contains(
                                                                          channelFilter[
                                                                              index])
                                                                  ? Colors.blue
                                                                  : MyColors
                                                                      .grey,
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: selectedArrayItems
                                                                  .contains(
                                                                      channelFilter[
                                                                          index])
                                                              ? const Icon(
                                                                  Icons.check,
                                                                  color: MyColors
                                                                      .whiteColor,
                                                                  size: 13,
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
                                                              fontSize: 14,
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
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      sheetProvider.isExpandedMonthFilter =
                                          true;
                                      sheetProvider.isLoaderActive = true;
                                      if (selectedTapAPI == 0) {
                                        dataListCoverage1 = selectedArrayItems;
                                        setState(() {});
                                        Navigator.pop(context);
                                        addDataCoverageAll(
                                            channelNew, monthNew);
                                        await postRequest(
                                            context, channelNew, monthNew);
                                        sheetProvider.isLoaderActive = false;
                                      } else if (selectedTapAPI == 1) {
                                        dataListCoverageCCTabs1 =
                                            selectedArrayItems;
                                        setState(() {});
                                        Navigator.pop(context);
                                        addDataCoverageCCR(
                                            channelNew, monthNew);
                                        await postRequestCCTabs(
                                            channelNew, monthNew, context);
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
                                        sheetProvider.isLoaderActive = false;
                                      }
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
                      dataListCoverage1 = [];
                      addDataCoverageAll('', monthNew);
                      await postRequest(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 1) {
                      sheetProvider.isLoaderActive = true;
                      dataListCoverageCCTabs1 = [];
                      addDataCoverageCCR('', monthNew);
                      await postRequestCCTabs('', '', context);
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 2) {
                      sheetProvider.isLoaderActive = true;
                      dataListCoverageProdTabs1 = [];
                      addDataCoverageProd('', monthNew);
                      await postRequestProdTabs(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    } else if (selectedTapAPI == 3) {
                      sheetProvider.isLoaderActive = true;
                      dataListCoverageBillingTabs1 = [];
                      addDataCoverageBilling('', monthNew);
                      await postRequestBillingTabs(context, '', '');
                      sheetProvider.isLoaderActive = false;
                    }
                  },
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
                    addDataCoverageAllRetailing();
                    sheetProvider.isMenuActive = false;
                    sheetProvider.isDivisionActive = false;
                    sheetProvider.isRemoveActive = false;
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
                    sheetProvider.setFbErrorMsg([]);
                    sheetProvider.isLoaderActive = true;
                    await postRequest(context, "", "");
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                    },
                  tryAgain1: () async{
                    print('button1');
                    sheetProvider.setFb1ErrorMsg([]);
                    sheetProvider.isLoaderActive = true;
                    await postRequestCCTabs("","", context);
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                  },
                  tryAgain2: () async{
                    print('button');
                    sheetProvider.setFb2ErrorMsg([]);
                    sheetProvider.isLoaderActive = true;
                    await postRequestProdTabs(context, "", "");
                    sheetProvider.isLoaderActive = false;
                    setState(() {});
                  },
                  tryAgain3: () async{
                    print('button');
                    sheetProvider.setFb3ErrorMsg([]);
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
