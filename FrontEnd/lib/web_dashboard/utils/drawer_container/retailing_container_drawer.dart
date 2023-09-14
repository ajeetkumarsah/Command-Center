import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/drawer_container/deep_dive_container/retailing_Container/reatiling_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
  RegExp pattern1 = RegExp(r'\b(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-\d{4}\b');
  RegExp pattern2 = RegExp(r'\bCY\d{4}-(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b');

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
    var url =
        '$BASE_URL/api/webDeepDive/rt/monthlyData';
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
    print("Body Retailing Tab 1 $body");
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
    );
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
        print(dataListCoverage);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Future<http.Response> postRequestByGeo(context) async {
    var url =
        '$BASE_URL/api/webDeepDive/rt/geo/monthlyData';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode(flattenedListCC.isEmpty
        ? [
      {
        "allIndia": "allIndia",
        "date": "May-2023",
        "channel": []
      }
    ]
        : flattenedListCC);
    print("Body Retailing Tab 2 $body");
    var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverageCCTabs = jsonDecode(response.body);
        print("Response => $dataListCoverageCCTabs");
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  void saveDataCoverageAll() {
    final jsonData = jsonEncode(flattenedList);
    html.window.localStorage['dataListRetailingDataAll'] = jsonData;
  }

  void loadDataCoverageAll() {
    final storedValue = html.window.localStorage['dataListRetailingDataAll'];
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
    await postRequest(context);
  }

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
        if (flattenedListCC.isEmpty) {
          flattenedListCC.add({
            "allIndia": "allIndia",
            "date": "Jun-2023",
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
      saveDataCoverageCC();
    }
    await postRequestByGeo(context);
  }

  void removeDataAll(int index) {
    if (flattenedList.isNotEmpty) {
      setState(() {
        flattenedList.removeAt(index);
      });
      saveDataCoverageAll();
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
    addDataCoverageAll('', 'Jun-2023');
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
                  indexNew: 1,
                ),
                RetailingContainer(
                  onGeoChanged: () {},
                  onClosedTap: () async{
                    sheetProvider.isLoaderActive = true;
                    setState(() {
                      removeDataAll(sheetProvider.removeIndexRe);
                    });
                    await postRequest(context);
                    sheetProvider.isLoaderActive = false;
                  },
                  onApplyPressedMonth: () async{
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
                  addDataCoverageAll("", "");
                  await postRequest(context);
                  sheetProvider.isLoaderActive = false;
                },
                  onTap1: () async {
                    setState(() {
                      selectedTapAPI = 0;
                      sheetProvider.isCurrentTab = 0;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequest(context);
                    sheetProvider.isLoaderActive = false;
                    print("0: $selectedTapAPI");
                  },
                  onTap2: () async {
                    setState(() {
                      selectedTapAPI = 1;
                      sheetProvider.isCurrentTab = 1;
                    });
                    sheetProvider.isLoaderActive = true;
                    await postRequestByGeo(context);
                    sheetProvider.isLoaderActive = false;
                    print("1: $selectedTapAPI");
                  },
                  onTap3: () async {
                    setState(() {
                      selectedTapAPI = 2;
                      sheetProvider.isCurrentTab = 2;
                    });
                    sheetProvider.isLoaderActive = true;

                    // await postRequestProdTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("2: $selectedTapAPI");
                  },
                  onTap4: () async {
                    setState(() {
                      selectedTapAPI = 3;
                      sheetProvider.isCurrentTab = 3;
                    });
                    sheetProvider.isLoaderActive = true;
                    // await postRequestBillingTabs(context, channelNew, monthNew);
                    sheetProvider.isLoaderActive = false;
                    print("3: $selectedTapAPI");
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

                                      addDataCoverageAll('', '');
                                      Navigator.of(context).pop();
                                      await postRequest(context);
                                      sheetProvider.isLoaderActive = false;

                                    },
                                  );
                                },
                              ),
                            ),
                          );});
                },
                  selectedItemValueChannel: selectedItemValueChannel,
                  onChangedFilter: (value) async {

                  },
                  onRemoveFilter: () async{
                      sheetProvider.isExpandedMonthFilter = true;
                      sheetProvider.isLoaderActive = true;
                      var finalMonth = "Jun-2023";
                      if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                        finalMonth = sheetProvider.myStringMonthFB;
                      } else if (pattern2.hasMatch(sheetProvider.myStringMonthFB)) {
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
                          "category": sheetProvider.selectedCategoryFilter == "Select.."?"":sheetProvider.selectedCategoryFilter,
                          "channel": []
                        }
                      ];
                      setState(() {});
                      selectedCategoryList = 'Select..';
                      selectedItemValueChannel[0] = 'Select..';
                      addDataCoverageAll(channelNew, monthNew);
                      await postRequest(context);
                      sheetProvider.isLoaderActive = false;
                  },
                  categoryApply: () async {
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoaderActive = true;
                    var finalMonth = "Jun-2023";
                    if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                      finalMonth = sheetProvider.myStringMonthFB;
                    } else if (pattern2.hasMatch(sheetProvider.myStringMonthFB)) {
                      String year =
                      sheetProvider.myStringMonthFB.substring(2, 6);
                      String month = sheetProvider.myStringMonthFB.substring(7);
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
                      await postRequest(context);
                      sheetProvider.isLoaderActive = false;

                  },
                  onRemoveFilterCategory: () async{
                    sheetProvider.isExpandedMonthFilter = true;
                    sheetProvider.isLoaderActive = true;
                    var finalMonth = "Jun-2023";
                    if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                      finalMonth = sheetProvider.myStringMonthFB;
                    } else if (pattern2.hasMatch(sheetProvider.myStringMonthFB)) {
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
                  selectedItemValueCategory: selectedItemValueCategory, selectedItemValueBrand: selectedItemValueBrand,
                  selectedItemValueBrandForm: selectedItemValueBrandForm,selectedItemValueBrandFromGroup: [], selectedMonthList: _selectedMonth,
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
                                  // print("BosData ${sheetProvider.isExpandedMonthFilter}");
                                  sheetProvider.isLoaderActive = true;
                                  var finalMonth = "Jun-2023";
                                  if (pattern1.hasMatch(sheetProvider.myStringMonthFB)) {
                                    finalMonth = sheetProvider.myStringMonthFB;
                                  } else if (pattern2.hasMatch(sheetProvider.myStringMonthFB)) {
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
                                  await postRequest(context);
                                  sheetProvider.isLoaderActive = false;
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
                  dataListByGeo: dataListCoverageCCTabs,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
