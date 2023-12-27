import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:command_centre/activities/fragments/metrics_fragment.dart';
import 'package:command_centre/activities/fragments/summary_fragment.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../helper/app_urls.dart';
import '../model/all_metrics.dart';
import '../provider/sheet_provider.dart';
import '../utils/comman/bottom_sheet/division_sheet.dart';
import '../utils/comman/bottom_sheet/month_sheet.dart';
import '../utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int current_index = 0;
  int _selected = 0;
  List<String> items = ['All India', 'Division', 'Cluster', 'Site'];
  List<bool> _checkedItems = List<bool>.generate(5, (index) => false);
  bool _myBool = false;
  bool switchValue = true;
  int pageIndex = 0;

  void OnTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  int selectedContainerIndex = 2;

  void selectContainer(int index) {
    setState(() {
      if (selectedContainerIndex == index) {
        selectedContainerIndex = 2;
      } else {
        selectedContainerIndex = index;
      }
    });
  }

  List itemCount = [];
  List channelCount = [];
  List clusterCount = [];
  List divisionCount = [];
  List siteCount = [];
  List branchCount = [];

  Future<void> clusterFilterAPI() async {
    var url = 'https://run.mocky.io/v3/64496a8b-11ff-414b-b0ca-d7d861653287';
    // var url = '${BASE_URL}/api/appData/clusterFilter';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      // print(jsonResponse["data"]);
      setState(() {
        clusterCount = jsonResponse["data"];
        print(clusterCount);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  var now = DateTime.now();
  String year = '';
  String selectedDivision = '';
  String selectedSite = '';
  String selectedMonth = '';
  String currentDataYear = '';
  String currentDataYearForAPI = '';
  List<AllMetrics> includedData = [];
  List<AllMetrics> metricData = [];
  List<AllMetrics> allMetrics = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clusterFilterAPI();
    year = "${now.year}";
    var checkProfile = SharedPreferencesUtils.getString('selectedProfile');
    allMetrics = [
      AllMetrics(
          name: 'Retailing',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),

      AllMetrics(
          name: 'Coverage',
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
          name: 'Shipment',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Inventory',
          isEnabled: checkProfile == "Sales" ? true : false,
          subtitle: ''),
      AllMetrics(
          name: 'Billing',
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
    ];
    populateLists();
    itemCount =
        jsonDecode(SharedPreferencesUtils.getString('clusterCount') ?? "");
    divisionCount =
        jsonDecode(SharedPreferencesUtils.getString('divisionCount') ?? "");
    siteCount = jsonDecode(SharedPreferencesUtils.getString('siteCount') ?? "");
  }

  void populateLists() {
    for (var item in allMetrics) {
      if (item.isEnabled) {
        includedData.add(item);
      } else {
        metricData.add(item);
      }
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                // onPressed: () => Navigator.of(context).pop(true),
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    selectedDivision = SharedPreferencesUtils.getString('division') ?? '';
    selectedSite = SharedPreferencesUtils.getString('site') ?? '';
    selectedMonth = SharedPreferencesUtils.getString('month') ?? '';
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    currentDataYear = "${months[now.month - 2]}'${year.substring(2)}";
    currentDataYearForAPI = "${months[now.month - 2]}-${year}";
    sheetProvider.month =
        sheetProvider.month == '' ? currentDataYearForAPI : sheetProvider.month;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: MyColors.textColor));
    final pages = [
      SummaryFragment(
        myBool: _myBool,
        selected: _selected,
        colorMV: MyColors.whiteColor,
        colorBO: MyColors.toggletextColor,
        onTapBO: () {
          selectContainer(1);
        },
        onTapMV: () {
          selectContainer(2);
        },
        onTap: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (BuildContext context,
                    StateSetter setState /*You can rename this!*/) {
                  return DivisionSheet(
                    list: itemCount,
                    divisionList: divisionCount,
                    siteList: siteCount,
                    branchList: branchCount,
                    selectedGeo: selectedDivision == 'All India'
                        ? 0
                        : selectedDivision == 'Division'
                            ? 1
                            : selectedDivision == 'Cluster'
                                ? 2
                                : selectedDivision == 'Site'
                                    ? 3
                                    : selectedDivision == 'Branch'
                                        ? 4
                                        : 0,
                    clusterList: clusterCount, onApplyClick: () {  },
                  );
                });
              }).then((value) {
            setState(() {});
          });
        },
        onTapMonth: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              builder: (context) {
                return const MonthSheet();
              }).then((value) {
            setState(() {});
          });
        },
        switchValue: switchValue,
        onChanged: (value) {
          setState(() {
            switchValue = value;
          });
        },
        division: selectedDivision,
        state: selectedSite,
        month: selectedMonth == '' ? currentDataYear : selectedMonth,
        includedData: includedData,
        metricData: metricData,
        allMetrics: allMetrics,
        onTapPer: () {},
        onCrossTap: () {
          setState(() {
            Navigator.pop(context);
          });
        },
        itemCount: itemCount,
        divisionCount: divisionCount,
        siteCount: siteCount,
        branchCount: branchCount,
        channelCount: channelCount,
      ),
      const MetricsFragment(),
    ];
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        backgroundColor: MyColors.backgroundColor,
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
          border: Border.all(width: 0.4, color: MyColors.deselectColor),
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        pageIndex == 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 6),
                                child: Image.asset(
                                  "assets/images/app_bar/vectorselect.png",
                                  height: 25,
                                  width: 25,
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 6),
                                child: Image.asset(
                                  "assets/images/app_bar/vectordeselect.png",
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                        Text(
                          "Summary",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: pageIndex == 0
                                  ? MyColors.toggletextColor
                                  : MyColors.deselectGray),
                        ),
                        const Spacer(),
                        Container(
                          height: pageIndex == 0 ? 3 : 0,
                          width: 59,
                          color: pageIndex == 0
                              ? MyColors.toggletextColor
                              : MyColors.deselectGray,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 9.5, bottom: 6),
                          child: Icon(
                            Icons.apps,
                            color: pageIndex == 1
                                ? MyColors.toggletextColor
                                : MyColors.deselectGray,
                            size: 30,
                          ),
                        ),
                        Text(
                          "All Metrics",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: pageIndex == 1
                                  ? MyColors.toggletextColor
                                  : MyColors.deselectGray),
                        ),
                        const Spacer(),
                        Container(
                          height: pageIndex == 1 ? 3 : 0,
                          width: 59,
                          color: pageIndex == 1
                              ? MyColors.primary
                              : MyColors.deselectColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
