import 'package:command_centre/web_dashboard/utils/drawer_container/deep_dive_container/summary_Container/summary_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;
import '../../../helper/app_urls.dart';
import '../../../model/all_metrics.dart';
import '../../../provider/sheet_provider.dart';
import '../../../utils/const/const_array.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../comman_utils/drawer_widget.dart';

class SummaryContainerDrawer extends StatefulWidget {
  final bool initial;
  final bool initialLoading;
  final List items;

  const SummaryContainerDrawer(
      {super.key,
      required this.initial,
      required this.initialLoading,
      required this.items});

  @override
  State<SummaryContainerDrawer> createState() => _SummaryContainerDrawerState();
}

class _SummaryContainerDrawerState extends State<SummaryContainerDrawer> {
  List<AllMetrics> includedData = [];
  List<AllMetrics> metricData = [];
  List<String> filtersList = [];
  List<String> filtersListCoverage = [];
  List<String> filtersListGP = [];
  List<String> filtersListFB = [];
  List<String> filtersListProd = [];
  List<String> filtersListCC = [];
  List<dynamic> allSummary = [];
  List<dynamic> dataList = [];
  List<dynamic> coverageDataList = [];
  List<dynamic> gpDataList = [];
  List<dynamic> fbDataList = [];
  List<dynamic> prodDataList = [];
  List<dynamic> ccDataList = [];
  var divisionCount = [];
  var clusterCount = [];
  var siteCount = [];
  bool initial = false;
  bool showHide = false;
  bool addDataRe = false;
  bool geoUpdateBool = false;
  int setIndex = 0;
  List<AllMetrics> allMetrics = [];

  List<dynamic> dataListCoverage = [];
  List<dynamic> dataListCoverage1 = [];
  List<dynamic> flattenedList = [];

  List<dynamic> localList = [];
  List<dynamic> localListAdd = [];

  List<dynamic> flattenedListRetailing = [];
  List<dynamic> flattenedListGP = [];
  List<dynamic> flattenedListFB = [];
  List<dynamic> flattenedListCoverage = [];
  List<dynamic> flattenedListProd = [];
  List<dynamic> flattenedListCC = [];

  void populateLists() {
    for (var item in allMetrics) {
      if (item.isEnabled) {
        includedData.add(item);
      } else {
        metricData.add(item);
      }
    }
  }

  List<bool> menuBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> addDateBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> divisionBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> removeBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> firstIsHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  List<dynamic> updatedListCCC = [];
  List<dynamic> updatedListFB = [];
  List<dynamic> updatedListRetailing = [];
  List<dynamic> updatedListProd = [];
  List<dynamic> updatedListGP = [];
  List<dynamic> updatedListCoverage = [];
  var finalMonth = 'Jun-2023';

  var dateTime = DateTime.now();

  /////////////////////// API Call for Filters Start//////////////////////
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

  /////////////////////// API Call for Filters Start//////////////////////

  /////////////////////// API Call for All Cards End//////////////////////
  Future<http.Response> postRequest(context) async {
    var url = '$BASE_URL/api/webSummary/allDefaultData';
    // var url = 'https://run.mocky.io/v3/311f279a-7619-4c71-a7cd-d03b889abb63';

    var body = json.encode(localList.isEmpty
        ? [
            {"filter_key": "retailing", "query": flattenedListRetailing},
            {"filter_key": "gp", "query": flattenedListGP},
            {"filter_key": "fb", "query": flattenedListFB},
            {"filter_key": "cc", "query": flattenedListCC},
            {"filter_key": "coverage", "query": flattenedListCoverage},
            {"filter_key": "productivity", "query": flattenedListProd}
          ]
        : localList);
    print("Summary Body ${json.encode(localList)}");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        dataListCoverage = jsonDecode(response.body);
        print("Summary Response $dataListCoverage");
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
  void saveDataCoverageAll() {
    final jsonData = jsonEncode(localList);
    html.window.localStorage['dataListSummaryAll'] = jsonData;
  }

  void loadDataCoverageAll() {
    final storedValue = html.window.localStorage['dataListSummaryAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          localList = decodedData;
        });
      }
    }
  }

  void addDataCoverageAll() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = localList;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (localList.isEmpty) {
          flattenedListCC = [
            {
              findDatasetName(
                      SharedPreferencesUtils.getString('webRetailingSite')!):
                  SharedPreferencesUtils.getString('webRetailingSite'),
              "date": finalMonth
            }
          ];
          flattenedListFB = [
            {
              findDatasetName(
                      SharedPreferencesUtils.getString('webRetailingSite')!):
                  SharedPreferencesUtils.getString('webRetailingSite'),
              "date": finalMonth
            }
          ];
          flattenedListRetailing = [
            {
              findDatasetName(
                      SharedPreferencesUtils.getString('webRetailingSite')!):
                  SharedPreferencesUtils.getString('webRetailingSite'),
              "date": finalMonth
            }
          ];
          flattenedListGP = [
            {
              findDatasetName(
                      SharedPreferencesUtils.getString('webRetailingSite')!):
                  SharedPreferencesUtils.getString('webRetailingSite'),
              "date": finalMonth
            }
          ];
          flattenedListCoverage = [
            {
              findDatasetName(
                      SharedPreferencesUtils.getString('webRetailingSite')!):
                  SharedPreferencesUtils.getString('webRetailingSite'),
              "date": finalMonth
            }
          ];
          flattenedListProd = [
            {
              findDatasetName(
                      SharedPreferencesUtils.getString('webRetailingSite')!):
                  SharedPreferencesUtils.getString('webRetailingSite'),
              "date": finalMonth
            }
          ];
          localList.add([
            {"filter_key": "retailing", "query": flattenedListRetailing},
            {"filter_key": "gp", "query": flattenedListGP},
            {"filter_key": "fb", "query": flattenedListFB},
            {"filter_key": "cc", "query": flattenedListCC},
            {"filter_key": "coverage", "query": flattenedListCoverage},
            {"filter_key": "productivity", "query": flattenedListProd}
          ]);
        } else {
          if (bosData.isExpandedMonthFilter) {
            localList[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              localList = jsonToAdd;
            }
          }
        }
      });
      saveDataCoverageAll();
    }
    await postRequest(context);
  }

// TODO: Here
  void saveDataRetailing() {
    final jsonData = jsonEncode(flattenedListRetailing);
    html.window.localStorage['dataListRetailingAll'] = jsonData;
  }

  void loadDataRetailing() {
    final storedValue = html.window.localStorage['dataListRetailingAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListRetailing = decodedData;
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
        if (flattenedListRetailing.isEmpty) {
          flattenedListRetailing.add({
            findDatasetName(
                    SharedPreferencesUtils.getString('webRetailingSite')!):
                SharedPreferencesUtils.getString('webRetailingSite'),
            "date": finalMonth
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListRetailing[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              print("1. $flattenedListRetailing");
              print("2. ${jsonToAdd[0]}");
              print("3. $jsonToAdd");
              if (geoUpdateBool) {
                flattenedListRetailing[0] = jsonToAdd[0];
              } else {
                flattenedListRetailing.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataRetailing();
    }
  }

// TODO: Here
  void saveDataGP() {
    final jsonData = jsonEncode(flattenedListGP);
    html.window.localStorage['dataListGPAll'] = jsonData;
  }

  void loadDataGP() {
    final storedValue = html.window.localStorage['dataListGPAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListGP = decodedData;
        });
      }
    }
  }

  void addDataGP() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = updatedListGP;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (flattenedListGP.isEmpty) {
          flattenedListGP.add({
            findDatasetName(
                    SharedPreferencesUtils.getString('webRetailingSite')!):
                SharedPreferencesUtils.getString('webRetailingSite'),
            "date": finalMonth
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListGP[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              if (geoUpdateBool) {
                flattenedListGP[0] = jsonToAdd[0];
              } else {
                flattenedListGP.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataGP();
    }
  }

// TODO: Here
  void saveDataFB() {
    final jsonData = jsonEncode(flattenedListFB);
    html.window.localStorage['dataListFBAll'] = jsonData;
  }

  void loadDataFB() {
    final storedValue = html.window.localStorage['dataListFBAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListFB = decodedData;
        });
      }
    }
  }

  void addDataFB() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = updatedListFB;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (flattenedListFB.isEmpty) {
          flattenedListFB.add({
            findDatasetName(
                    SharedPreferencesUtils.getString('webRetailingSite')!):
                SharedPreferencesUtils.getString('webRetailingSite'),
            "date": finalMonth
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListFB[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              if (geoUpdateBool) {
                flattenedListFB[0] = jsonToAdd[0];
              } else {
                flattenedListFB.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataFB();
    }
  }

// TODO: Here
  void saveDataCoverage() {
    final jsonData = jsonEncode(flattenedListCoverage);
    html.window.localStorage['dataListCoverageAll'] = jsonData;
  }

  void loadDataCoverage() {
    final storedValue = html.window.localStorage['dataListCoverageAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCoverage = decodedData;
        });
      }
    }
  }

  void addDataCoverage() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = updatedListCoverage;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (flattenedListCoverage.isEmpty) {
          flattenedListCoverage.add({
            findDatasetName(
                    SharedPreferencesUtils.getString('webRetailingSite')!):
                SharedPreferencesUtils.getString('webRetailingSite'),
            "date": finalMonth
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListCoverage[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              if (geoUpdateBool) {
                flattenedListCoverage[0] = jsonToAdd[0];
              } else {
                flattenedListCoverage.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataCoverage();
    }
  }

// TODO: Here
  void saveDataProd() {
    final jsonData = jsonEncode(flattenedListProd);
    html.window.localStorage['dataListProdAll'] = jsonData;
  }

  void loadDataProd() {
    final storedValue = html.window.localStorage['dataListProdAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListProd = decodedData;
        });
      }
    }
  }

  void addDataProd() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = updatedListProd;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (flattenedListProd.isEmpty) {
          flattenedListProd.add({
            findDatasetName(
                    SharedPreferencesUtils.getString('webRetailingSite')!):
                SharedPreferencesUtils.getString('webRetailingSite'),
            "date": finalMonth
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListProd[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              if (geoUpdateBool) {
                flattenedListProd[0] = jsonToAdd[0];
              } else {
                flattenedListProd.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataProd();
    }
  }

// TODO: Here
  void saveDataCC() {
    final jsonData = jsonEncode(flattenedListCC);
    html.window.localStorage['dataListCCAll'] = jsonData;
  }

  void loadDataCC() {
    final storedValue = html.window.localStorage['dataListCCAll'];
    if (storedValue != null) {
      final decodedData = jsonDecode(storedValue);
      if (decodedData is List<dynamic>) {
        setState(() {
          flattenedListCC = decodedData;
        });
      }
    }
  }

  void addDataCC() async {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    dynamic decodedRetailing = updatedListCCC;
    if (decodedRetailing is List<dynamic>) {
      List<dynamic> retailingObject = decodedRetailing;
      final jsonToAdd = retailingObject;
      setState(() {
        if (flattenedListCC.isEmpty) {
          flattenedListCC.add({
            findDatasetName(
                    SharedPreferencesUtils.getString('webRetailingSite')!):
                SharedPreferencesUtils.getString('webRetailingSite'),
            "date": finalMonth
          });
        } else {
          if (bosData.isExpandedMonthFilter) {
            flattenedListCC[bosData.selectedChannelIndex] = jsonToAdd[0];
            bosData.isExpandedMonthFilter = false;
          } else {
            if (jsonToAdd.isNotEmpty) {
              if (geoUpdateBool) {
                flattenedListCC[0] = jsonToAdd[0];
              } else {
                flattenedListCC.add(jsonToAdd[0]);
              }
            }
          }
        }
      });
      saveDataCC();
    }
  }

  /////////////////////// Local Storage for All Cards End //////////////////////

  /////////////////////// Remove Local Storage for All Cards One By One Start//////////////////////
  void removeDataRetailing(int index) {
    if (index >= 0 && index < flattenedListRetailing.length) {
      setState(() {
        flattenedListRetailing.removeAt(index);
        saveDataRetailing(); // Save the updated list after removal
      });
    }
  }

  void removeDataGP(int index) {
    if (index >= 0 && index < flattenedListGP.length) {
      setState(() {
        flattenedListGP.removeAt(index);
        saveDataGP(); // Save the updated list after removal
      });
    }
  }

  void removeDataFB(int index) {
    if (index >= 0 && index < flattenedListFB.length) {
      setState(() {
        flattenedListFB.removeAt(index);
        saveDataFB(); // Save the updated list after removal
      });
    }
  }

  void removeDataCoverage(int index) {
    if (index >= 0 && index < flattenedListCoverage.length) {
      setState(() {
        flattenedListCoverage.removeAt(index);
        saveDataCoverage(); // Save the updated list after removal
      });
    }
  }

  void removeDataProd(int index) {
    if (index >= 0 && index < flattenedListProd.length) {
      setState(() {
        flattenedListProd.removeAt(index);
        saveDataProd(); // Save the updated list after removal
      });
    }
  }

  void removeDataCC(int index) {
    if (index >= 0 && index < flattenedListCC.length) {
      setState(() {
        flattenedListCC.removeAt(index);
        saveDataCC(); // Save the updated list after removal
      });
    }
  }

  /////////////////////// Remove Local Storage for All Cards One By One End//////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    divisionFilterAPI();
    clusterFilterAPI();
    siteFilterAPI();
    var selectedMonth = SharedPreferencesUtils.getString('webDefaultMonth') ??
        ConstArray().month[dateTime.month - 4];
    var selectedYear = SharedPreferencesUtils.getString('webDefaultYear') ??
        '${dateTime.year}';
    finalMonth = "$selectedMonth-$selectedYear";
    SharedPreferencesUtils.setInt('int', setIndex);
    initial = widget.initial;
    var checkProfile = SharedPreferencesUtils.getString('selectedProfile');
    SharedPreferencesUtils.setBool('firstTime', false);
    allMetrics = [
      AllMetrics(
          name: 'Retailing',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'PXM billing',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Golden Points',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Focus Brand',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Productivity',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Call Compliance',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Cost/MSU',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Shortages/Damages (Rs.)',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'VFR',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'MSU/Truck',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Debits (Rs.)',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'CFR',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'SRN',
          isEnabled: checkProfile == "Supply Chain" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'BT%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'NOS (MM)',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'MSE%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'CTS%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'SD%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'SRA%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'TDC%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'GOS%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'GM%',
          isEnabled: checkProfile == "Finance" ? true : false,
          subtitle: ''),
      AllMetrics(name: '', isEnabled: true, subtitle: '')
    ];
    populateLists();
    loadDataRetailing();
    addDataRetailing();
    loadDataCoverage();
    addDataCoverage();
    loadDataFB();
    addDataFB();
    loadDataGP();
    addDataGP();
    loadDataProd();
    addDataProd();
    loadDataCC();
    addDataCC();
    loadDataCoverageAll();
    addDataCoverageAll();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Scaffold(
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
                  indexNew: 0,
                ),
                SummaryContainer(
                  widgetList: allMetrics,
                  ////// For Navigation //////
                  onTapContainer: () {
                    setState(() {
                      if (sheetProvider.selectedCard == "Retailing") {
                        Navigator.of(context).pushNamed('/retailingsummary');
                      } else if (sheetProvider.selectedCard == "PXM billing") {
                        Navigator.of(context).pushNamed('/cndsummary');
                      }
                      if (sheetProvider.selectedCard == "Golden Points") {
                        Navigator.of(context).pushNamed('/gpsummary');
                      } else if (sheetProvider.selectedCard == "Focus Brand") {
                        Navigator.of(context).pushNamed('/fbsummary');
                      }
                      if (sheetProvider.selectedCard == "Distribution") {
                        Navigator.of(context).pushNamed('/cndsummary');
                      } else if (sheetProvider.selectedCard == "Productivity") {
                        Navigator.of(context).pushNamed('/commonsummary');
                      }
                      if (sheetProvider.selectedCard == "Call Compliance") {
                        Navigator.of(context).pushNamed('/ccsummary');
                      } else if (sheetProvider.selectedCard == "Shipment") {
                        Navigator.of(context).pushNamed('/commonsummary');
                      } else if (sheetProvider.selectedCard == "Inventory") {
                        Navigator.of(context).pushNamed('/commonsummary');
                      } else {}
                    });
                  },
                  includedData: includedData,
                  metricData: metricData,
                  allMetrics: allMetrics,
                  list: [],
                  divisionList: divisionCount,
                  siteList: siteCount,
                  branchList: [],
                  selectedGeo: 0,
                  clusterList: clusterCount,
                  onApplyPressed: () {},
                  menuBool: menuBool,
                  divisionBool: divisionBool,
                  removeBool: removeBool,
                  firstIsHovering: firstIsHovering,
                  ////// Hide All Open Pop Up //////
                  onGestureTap: () {
                    setState(() {
                      showHide = false;
                      menuBool = [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ];
                      divisionBool = [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ];
                      removeBool = [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ];
                      addDateBool = [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ];
                    });
                  },
                  addDateBool: addDateBool,
                  dataList: dataList,
                  coverageDataList: coverageDataList,
                  gpDataList: gpDataList,
                  fbDataList: fbDataList,
                  prodDataList: prodDataList,
                  ccDataList: ccDataList,
                  ////// Add new Geo According to Cards //////
                  onApplyPressedMonth: () async {
                    menuBool = [
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false
                    ];
                    divisionBool = [
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false
                    ];
                    addDateBool = [
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false
                    ];
                    setIndex = 1;
                    SharedPreferencesUtils.setInt('int', setIndex);
                    initial = false;
                    var selectedKey =
                        SharedPreferencesUtils.getString('keyName');
                    if (selectedKey == "Retailing") {
                      sheetProvider.isLoadingPage = true;
                      updatedListRetailing = [];
                      var newElement =
                          '{"${SharedPreferencesUtils.getString('webRetailingDivision')}": "${SharedPreferencesUtils.getString('webRetailingSite')}", "date": "$finalMonth"}';
                      var ele = json.decode(newElement);
                      updatedListRetailing.add(ele);
                      addDataRetailing();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      sheetProvider.isLoadingPage = false;
                      updatedListRetailing = [];
                      setState(() {});
                    } else if (selectedKey == "PXM billing") {
                      updatedListCoverage = [];
                      sheetProvider.isLoadingPage = true;
                      print(SharedPreferencesUtils.getString(
                          'webCoverageDivision'));
                      print(
                          SharedPreferencesUtils.getString('webCoverageSite'));
                      var newElement =
                          '{"${SharedPreferencesUtils.getString('webCoverageDivision')}": "${SharedPreferencesUtils.getString('webCoverageSite')}", "date": "$finalMonth"}';
                      var ele = json.decode(newElement);
                      updatedListCoverage.add(ele);
                      print("Coverage $updatedListCoverage");
                      addDataCoverage();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      sheetProvider.isLoadingPage = false;
                      updatedListCoverage = [];
                      // await postRequest(context);
                      setState(() {});
                    } else if (selectedKey == "Golden Points") {
                      updatedListGP = [];
                      sheetProvider.isLoadingPage = true;
                      var newElement =
                          '{"${SharedPreferencesUtils.getString('webGPDivision')}": "${SharedPreferencesUtils.getString('webGPSite')}", "date": "$finalMonth"}';
                      var ele = json.decode(newElement);
                      updatedListGP.add(ele);
                      addDataGP();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      updatedListGP = [];
                      await postRequest(context);
                      sheetProvider.isLoadingPage = false;
                      // await postRequest(context);

                      setState(() {});
                    } else if (selectedKey == "Focus Brand") {
                      updatedListFB = [];
                      sheetProvider.isLoadingPage = true;
                      var newElement =
                          '{"${SharedPreferencesUtils.getString('webFBDivision')}": "${SharedPreferencesUtils.getString('webFBSite')}", "date": "$finalMonth"}';
                      var ele = json.decode(newElement);
                      updatedListFB.add(ele);
                      addDataFB();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      updatedListFB = [];
                      await postRequest(context);
                      sheetProvider.isLoadingPage = false;
                      // await postRequest(context);
                      setState(() {});
                    } else if (selectedKey == "Productivity") {
                      updatedListProd = [];
                      sheetProvider.isLoadingPage = true;
                      var newElement =
                          '{"${SharedPreferencesUtils.getString('webProductivityDivision')}": "${SharedPreferencesUtils.getString('webProductivitySite')}", "date": "$finalMonth"}';
                      var ele = json.decode(newElement);
                      updatedListProd.add(ele);
                      addDataProd();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      updatedListProd = [];
                      await postRequest(context);
                      sheetProvider.isLoadingPage = false;
                      setState(() {});
                    } else if (selectedKey == "Call Compliance") {
                      updatedListCCC = [];
                      sheetProvider.isLoadingPage = true;
                      var newElement =
                          '{"${SharedPreferencesUtils.getString('webCallComplianceDivision')}": "${SharedPreferencesUtils.getString('webCallComplianceSite')}", "date": "$finalMonth"}';
                      var ele = json.decode(newElement);
                      updatedListCCC.add(ele);
                      addDataCC();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      updatedListCCC = [];
                      await postRequest(context);
                      sheetProvider.isLoadingPage = false;
                      setState(() {});
                    } else {
                      var snackBar = const SnackBar(
                          content: Text('Something went wrong!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  updateDefault: showHide,
                  // Clear Filter
                  onPressed: () {},
                  ////// Update Default Geo //////
                  onPressedGeo: () async {
                    sheetProvider.isLoadingPage = true;
                    geoUpdateBool = true;
                    updatedListRetailing = [];
                    var newElement =
                        '{"${findDatasetName(sheetProvider.selectedValue)}": "${sheetProvider.selectedValue}", "date": "$finalMonth"}';
                    var ele = json.decode(newElement);
                    updatedListRetailing.add(ele);
                    updatedListCoverage.add(ele);
                    updatedListFB.add(ele);
                    updatedListGP.add(ele);
                    updatedListCCC.add(ele);
                    updatedListProd.add(ele);

                    addDataRetailing();
                    addDataCoverage();
                    addDataFB();
                    addDataGP();
                    addDataCC();
                    addDataProd();
                    localList = [
                      {
                        "filter_key": "retailing",
                        "query": flattenedListRetailing
                      },
                      {"filter_key": "gp", "query": flattenedListGP},
                      {"filter_key": "fb", "query": flattenedListFB},
                      {"filter_key": "cc", "query": flattenedListCC},
                      {
                        "filter_key": "coverage",
                        "query": flattenedListCoverage
                      },
                      {"filter_key": "productivity", "query": flattenedListProd}
                    ];
                    addDataCoverageAll();
                    showHide = !showHide;
                    updatedListRetailing = [];
                    updatedListCoverage = [];
                    updatedListFB = [];
                    updatedListGP = [];
                    updatedListCCC = [];
                    updatedListProd = [];
                    geoUpdateBool = false;
                    await postRequest(context);
                    sheetProvider.isLoadingPage = false;
                    setState(() {});
                  },
                  ////// Remove geo according to cards //////
                  onRemoveGeoPressed: () async {
                    removeBool = [
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                    ];
                    menuBool = [
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                      false,
                    ];
                    var selectedKey =
                        SharedPreferencesUtils.getString('keyName');
                    if (selectedKey == "Retailing") {
                      removeDataRetailing(sheetProvider.removeIndexRetailing);
                      sheetProvider.isLoadingPage = true;
                      addDataRetailing();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      setState(() {});
                      sheetProvider.isLoadingPage = false;
                    } else if (selectedKey == "PXM billing") {
                      removeDataCoverage(sheetProvider.removeIndexCoverage);
                      sheetProvider.isLoadingPage = true;
                      addDataCoverage();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      setState(() {});
                      sheetProvider.isLoadingPage = false;
                    } else if (selectedKey == "Golden Points") {
                      removeDataGP(sheetProvider.removeIndexGoldenPoint);
                      sheetProvider.isLoadingPage = true;
                      addDataGP();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      setState(() {});
                      sheetProvider.isLoadingPage = false;
                    } else if (selectedKey == "Focus Brand") {
                      removeDataFB(sheetProvider.removeIndexFocusBrand);
                      sheetProvider.isLoadingPage = true;
                      addDataFB();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      setState(() {});
                      sheetProvider.isLoadingPage = false;
                    } else if (selectedKey == "Productivity") {
                      sheetProvider.isLoadingPage = true;
                      removeDataProd(sheetProvider.removeIndexProductivity);
                      addDataProd();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      setState(() {});
                      sheetProvider.isLoadingPage = false;
                    } else if (selectedKey == "Call Compliance") {
                      removeDataCC(sheetProvider.removeIndexCallC);
                      sheetProvider.isLoadingPage = true;
                      addDataCC();
                      localList = [
                        {
                          "filter_key": "retailing",
                          "query": flattenedListRetailing
                        },
                        {"filter_key": "gp", "query": flattenedListGP},
                        {"filter_key": "fb", "query": flattenedListFB},
                        {"filter_key": "cc", "query": flattenedListCC},
                        {
                          "filter_key": "coverage",
                          "query": flattenedListCoverage
                        },
                        {
                          "filter_key": "productivity",
                          "query": flattenedListProd
                        }
                      ];
                      addDataCoverageAll();
                      await postRequest(context);
                      setState(() {});
                      sheetProvider.isLoadingPage = false;
                    } else {}
                  },
                  ////// Open default month popup //////
                  onNewMonth: () async {
                    sheetProvider.isDefaultMonth =
                        !sheetProvider.isDefaultMonth;
                  },
                  updateMonth: sheetProvider.isDefaultMonth,
                  ////// Update default month for all the Geo and Cards //////
                  onApplyPressedMonthDefault: () async {
                    var selectedMonth =
                        SharedPreferencesUtils.getString('webDefaultMonth') ??
                            ConstArray().month[dateTime.month - 4];
                    var selectedYear =
                        SharedPreferencesUtils.getString('webDefaultYear') ??
                            '${dateTime.year}';
                    finalMonth = "$selectedMonth-$selectedYear";
                    sheetProvider.isDefaultMonth =
                        !sheetProvider.isDefaultMonth;

                    for (var entry in flattenedListCC) {
                      entry["date"] = finalMonth;
                    }

                    for (var entry in flattenedListProd) {
                      entry["date"] = finalMonth;
                    }

                    for (var entry in flattenedListCoverage) {
                      entry["date"] = finalMonth;
                    }

                    for (var entry in flattenedListFB) {
                      entry["date"] = finalMonth;
                    }

                    for (var entry in flattenedListGP) {
                      entry["date"] = finalMonth;
                    }

                    for (var entry in flattenedListRetailing) {
                      entry["date"] = finalMonth;
                    }
                    addDataRetailing();
                    addDataProd();
                    addDataCoverage();
                    addDataFB();
                    addDataGP();
                    addDataRetailing();
                    sheetProvider.isLoadingPage = true;
                    localList = [
                      {
                        "filter_key": "retailing",
                        "query": flattenedListRetailing
                      },
                      {"filter_key": "gp", "query": flattenedListGP},
                      {"filter_key": "fb", "query": flattenedListFB},
                      {"filter_key": "cc", "query": flattenedListCC},
                      {
                        "filter_key": "coverage",
                        "query": flattenedListCoverage
                      },
                      {"filter_key": "productivity", "query": flattenedListProd}
                    ];
                    addDataCoverageAll();
                    await postRequest(context);
                    sheetProvider.isLoadingPage = false;
                    setState(() {});
                  },
                  allSummary: dataListCoverage,
                  ////// Open Default Geo Pop up //////
                  onTapDefaultGoe: () {
                    setState(() {
                      showHide = !showHide;
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
