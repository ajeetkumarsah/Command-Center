import 'package:command_centre/web_dashboard/splash_screen.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../activities/responsive.dart';
import '../helper/app_urls.dart';
import '../utils/colors/colors.dart';
import '../utils/comman/widget/login_header_subtitle.dart';
import '../utils/comman/widget/login_header_widget.dart';
import '../utils/const/const_variable.dart';
import '../utils/routes/routes_name.dart';
import '../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../utils/style/text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectDivisionScreen extends StatefulWidget {
  final bool initInitial;

  const SelectDivisionScreen({super.key, required this.initInitial});

  @override
  State<SelectDivisionScreen> createState() => _SelectDivisionScreenState();
}

class _SelectDivisionScreenState extends State<SelectDivisionScreen>
    with TickerProviderStateMixin {
  int selectedContainerIndex = 1;
  String selectedItemValueGeography = 'Select..';
  String? selectedDivisionValue;
  String? selectedClusterValue;
  String? selectedSiteValue;
  double margin = 20.0;

  void selectContainer(int index) {
    setState(() {
      if (selectedContainerIndex == index) {
        // Deselect the container if it was already selected
        selectedContainerIndex = 1;
      } else {
        selectedContainerIndex = index;
      }
    });
  }

  late AnimationController _animationController;
  late Animation<Offset> _animation;
  var divisionCount = [];
  var clusterCount = [];
  var siteCount = [];
  var allIndiaCount = [];

  var arrayData = [];

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
        SharedPreferencesUtils.setString(
            "divisionCount", jsonEncode(jsonResponse));
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
        SharedPreferencesUtils.setString(
            "clusterCount", jsonEncode(jsonResponse));
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
        SharedPreferencesUtils.setString("siteCount", jsonEncode(jsonResponse));
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    var ddl = selectedContainerIndex == 2
        ? divisionCount
        : selectedContainerIndex == 3
            ? clusterCount
            : selectedContainerIndex == 4
                ? siteCount
                : allIndiaCount;
    return ddl
        .map((value) => DropdownMenuItem(
              value: value.toString(),
              child: Text(value.toString()),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animation = Tween<Offset>(
      begin: Offset.zero, // Starting position off the screen
      end: const Offset(0, -0.15), // Ending position at the original position
    ).animate(curvedAnimation);
    clusterFilterAPI();
    siteFilterAPI();
    divisionFilterAPI();
    // checkLogin();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: margin, right: margin, bottom: 10, top: 80),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's set you up!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.whiteColor,
                          fontSize: 40,
                          fontFamily: fontFamily),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: margin, right: margin, bottom: 2),
                      child: const Text(
                        " Choose location to generate the data for Business Overview",
                        style: TextStyle(
                            color: MyColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily),
                      )
                      // const LoginHeaderSubtitle(
                      //   subtitle: " Choose location to generate the data for",
                      // ),
                      ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: margin, right: margin, bottom: 15),
                      child: const Text(
                        "",
                        style: TextStyle(
                            color: MyColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily),
                      )
                      // const LoginHeaderSubtitle(
                      //   subtitle: " Business Overview",
                      // ),
                      ),
                ),
                Container(
                  width: size.width / 1.5,
                  padding: const EdgeInsets.all(20),
                  color: MyColors.whiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      selectContainer(1);
                                      _animationController.repeat();
                                      // _animationController.forward();
                                    },
                                    child: Container(
                                      width: size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: selectedContainerIndex == 1
                                              ? MyColors.toggleColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: selectedContainerIndex == 1
                                                  ? MyColors.primary
                                                  : MyColors.grayBorder,
                                              width: selectedContainerIndex == 1
                                                  ? 3
                                                  : 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'All India',
                                          // textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: selectedContainerIndex == 1
                                                  ? MyColors.toggletextColor
                                                  : MyColors.loginTitleColor,
                                              fontWeight:
                                                  selectedContainerIndex == 1
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                              fontFamily: fontFamily),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      selectContainer(2);
                                      _animationController.forward();
                                      // _animationController.forward();
                                    },
                                    child: Container(
                                      width: size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: selectedContainerIndex == 2
                                              ? MyColors.toggleColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: selectedContainerIndex == 2
                                                  ? MyColors.primary
                                                  : MyColors.grayBorder,
                                              width: selectedContainerIndex == 2
                                                  ? 3
                                                  : 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Division',
                                          // textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: selectedContainerIndex == 2
                                                  ? MyColors.toggletextColor
                                                  : MyColors.loginTitleColor,
                                              fontWeight:
                                                  selectedContainerIndex == 2
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                              fontFamily: fontFamily),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      selectContainer(3);
                                      _animationController.forward();
                                    },
                                    child: Container(
                                      width: size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: selectedContainerIndex == 3
                                              ? MyColors.toggleColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: selectedContainerIndex == 3
                                                  ? MyColors.primary
                                                  : MyColors.grayBorder,
                                              width: selectedContainerIndex == 3
                                                  ? 3
                                                  : 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Cluster',
                                          // textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: selectedContainerIndex == 3
                                                  ? MyColors.toggletextColor
                                                  : MyColors.loginTitleColor,
                                              fontWeight:
                                                  selectedContainerIndex == 3
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                              fontFamily: fontFamily),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      selectContainer(4);
                                      _animationController.forward();
                                    },
                                    child: Container(
                                      width: size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: selectedContainerIndex == 4
                                              ? MyColors.toggleColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: selectedContainerIndex == 4
                                                  ? MyColors.primary
                                                  : MyColors.grayBorder,
                                              width: selectedContainerIndex == 4
                                                  ? 3
                                                  : 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Site',
                                          // textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: selectedContainerIndex == 4
                                                  ? MyColors.toggletextColor
                                                  : MyColors.loginTitleColor,
                                              fontWeight:
                                                  selectedContainerIndex == 4
                                                      ? FontWeight.w700
                                                      : FontWeight.w400,
                                              fontFamily: fontFamily),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      selectedContainerIndex == 0
                          ? Container()
                          : selectedContainerIndex == 1
                              ? Container()
                              : SlideTransition(
                                  position: _animation,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5,
                                        bottom: 10,
                                        top: 20),
                                    child: DropDownWidget(
                                      selectedValue: selectedContainerIndex == 2
                                          ? selectedDivisionValue
                                          : selectedContainerIndex == 3
                                              ? selectedClusterValue
                                              : selectedContainerIndex == 4
                                                  ? selectedSiteValue
                                                  : null,
                                      // selectedValue: null,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedContainerIndex == 2
                                              ? selectedDivisionValue = value!
                                              : selectedContainerIndex == 3
                                                  ? selectedClusterValue =
                                                      value!
                                                  : selectedContainerIndex == 4
                                                      ? selectedSiteValue =
                                                          value!
                                                      : null;
                                        });
                                      },
                                      title: selectedContainerIndex == 2
                                          ? 'Select Division'
                                          : selectedContainerIndex == 3
                                              ? 'Select Cluster'
                                              : selectedContainerIndex == 4
                                                  ? 'Select Site'
                                                  : '',
                                      dropDownItem: _dropDownItem(),
                                      secondIndex: 0,
                                    ),
                                  ),
                                ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: SizedBox(
                          height: 56,
                          width: size.width / 4,
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedContainerIndex == 1) {
                                print("All India");
                                SharedPreferencesUtils.setString(
                                    'webRetailingDivision', allIndia);
                                SharedPreferencesUtils.setString(
                                    'webRetailingSite', allIndia);

                                SharedPreferencesUtils.setString(
                                    'webCoverageDivision', allIndia);
                                SharedPreferencesUtils.setString(
                                    'webCoverageSite', allIndia);

                                SharedPreferencesUtils.setString(
                                    'webGPDivision', allIndia);
                                SharedPreferencesUtils.setString(
                                    'webGPSite', allIndia);

                                SharedPreferencesUtils.setString(
                                    'webFBDivision', allIndia);
                                SharedPreferencesUtils.setString(
                                    'webFBSite', allIndia);

                                SharedPreferencesUtils.setString(
                                    'webProductivityDivision', allIndia);
                                SharedPreferencesUtils.setString(
                                    'webProductivitySite', allIndia);

                                SharedPreferencesUtils.setString(
                                    'webCallComplianceDivision', allIndia);
                                SharedPreferencesUtils.setString(
                                    'webCallComplianceSite', allIndia);

                                SharedPreferencesUtils.setBool(
                                    "business", true);
                                Navigator.pushNamed(
                                  context,
                                  '/summaryscreen',
                                  arguments: ResponsiveHomePage(
                                      initial: widget.initInitial,
                                      initialLoading: true,
                                      items: ['allIndia']
                                  )
                                  // {
                                  //   'initial': true, // Replace with your dynamic initial value
                                  //   'items': ['allIndia'], // Replace with your dynamic list of items
                                  // }, // Replace true with your dynamic value
                                );
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ResponsiveHomePage(
                                //           initial: widget.initInitial,
                                //           initialLoading: true, items: ['allIndia'],
                                //         )));
                              } else if (selectedContainerIndex == 2) {
                                SharedPreferencesUtils.setString(
                                    'webRetailingDivision', 'division');
                                SharedPreferencesUtils.setString(
                                    'webRetailingSite', selectedDivisionValue!);

                                SharedPreferencesUtils.setString(
                                    'webCoverageDivision', 'division');
                                SharedPreferencesUtils.setString(
                                    'webCoverageSite', selectedDivisionValue!);

                                SharedPreferencesUtils.setString(
                                    'webGPDivision', 'division');
                                SharedPreferencesUtils.setString(
                                    'webGPSite', selectedDivisionValue!);

                                SharedPreferencesUtils.setString(
                                    'webFBDivision', 'division');
                                SharedPreferencesUtils.setString(
                                    'webFBSite', selectedDivisionValue!);

                                SharedPreferencesUtils.setString(
                                    'webProductivityDivision', 'division');
                                SharedPreferencesUtils.setString(
                                    'webProductivitySite',
                                    selectedDivisionValue!);

                                SharedPreferencesUtils.setString(
                                    'webCallComplianceDivision', 'division');
                                SharedPreferencesUtils.setString(
                                    'webCallComplianceSite',
                                    selectedDivisionValue!);

                                SharedPreferencesUtils.setBool(
                                    "business", true);
                                Navigator.pushNamed(
                                  context,
                                  '/summaryscreen',
                                    arguments: ResponsiveHomePage(
                                        initial: widget.initInitial,
                                        initialLoading: true,
                                        items: [selectedDivisionValue]
                                    )// Replace true with your dynamic value

                                );
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ResponsiveHomePage(
                                //           initial: widget.initInitial,
                                //           initialLoading: true, items: [selectedDivisionValue],
                                //         )));
                              } else if (selectedContainerIndex == 3) {
                                SharedPreferencesUtils.setString(
                                    'webRetailingDivision', 'cluster');
                                SharedPreferencesUtils.setString(
                                    'webRetailingSite', selectedClusterValue!);

                                SharedPreferencesUtils.setString(
                                    'webCoverageDivision', 'cluster');
                                SharedPreferencesUtils.setString(
                                    'webCoverageSite', selectedClusterValue!);

                                SharedPreferencesUtils.setString(
                                    'webGPDivision', 'cluster');
                                SharedPreferencesUtils.setString(
                                    'webGPSite', selectedClusterValue!);

                                SharedPreferencesUtils.setString(
                                    'webFBDivision', 'cluster');
                                SharedPreferencesUtils.setString(
                                    'webFBSite', selectedClusterValue!);

                                SharedPreferencesUtils.setString(
                                    'webProductivityDivision', 'cluster');
                                SharedPreferencesUtils.setString(
                                    'webProductivitySite',
                                    selectedClusterValue!);

                                SharedPreferencesUtils.setString(
                                    'webCallComplianceDivision', 'cluster');
                                SharedPreferencesUtils.setString(
                                    'webCallComplianceSite',
                                    selectedClusterValue!);

                                SharedPreferencesUtils.setBool(
                                    "business", true);
                                Navigator.pushNamed(
                                    context,
                                    '/summaryscreen',
                                    arguments: ResponsiveHomePage(
                                        initial: widget.initInitial,
                                        initialLoading: true,
                                        items: [selectedClusterValue]
                                    ));
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ResponsiveHomePage(
                                //           initial: widget.initInitial,
                                //           initialLoading: true, items: [selectedClusterValue],
                                //         )));
                              } else if (selectedContainerIndex == 4) {
                                SharedPreferencesUtils.setString(
                                    'webRetailingDivision', 'site');
                                SharedPreferencesUtils.setString(
                                    'webRetailingSite', selectedSiteValue!);

                                SharedPreferencesUtils.setString(
                                    'webCoverageDivision', 'site');
                                SharedPreferencesUtils.setString(
                                    'webCoverageSite', selectedSiteValue!);

                                SharedPreferencesUtils.setString(
                                    'webGPDivision', 'site');
                                SharedPreferencesUtils.setString(
                                    'webGPSite', selectedSiteValue!);

                                SharedPreferencesUtils.setString(
                                    'webFBDivision', 'site');
                                SharedPreferencesUtils.setString(
                                    'webFBSite', selectedSiteValue!);

                                SharedPreferencesUtils.setString(
                                    'webProductivityDivision', 'site');
                                SharedPreferencesUtils.setString(
                                    'webProductivitySite', selectedSiteValue!);

                                SharedPreferencesUtils.setString(
                                    'webCallComplianceDivision', 'site');
                                SharedPreferencesUtils.setString(
                                    'webCallComplianceSite',
                                    selectedSiteValue!);

                                SharedPreferencesUtils.setBool(
                                    "division", true);
                                Navigator.pushNamed(
                                    context,
                                    '/summaryscreen',
                                    arguments: ResponsiveHomePage(
                                        initial: widget.initInitial,
                                        initialLoading: true,
                                        items: [selectedSiteValue]
                                    ));
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ResponsiveHomePage(
                                //           initial: widget.initInitial,
                                //           initialLoading: true, items: [selectedSiteValue],
                                //         )));
                              } else {
                                SharedPreferencesUtils.setString(
                                    'division', 'All-India');
                                SharedPreferencesUtils.setString(
                                    'site', 'All-India');
                                SharedPreferencesUtils.setBool(
                                    "business", true);
                                Navigator.pushNamed(context, RoutesName.home);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                elevation: 0,
                                backgroundColor: MyColors.toggletextColor),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Get Started',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: fontFamily,
                                        fontSize: 18,
                                        letterSpacing: 0.6)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
