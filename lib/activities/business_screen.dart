import 'package:command_centre/activities/home_screen.dart';
import 'package:command_centre/activities/purpose_screen.dart';
import 'package:command_centre/helper/env/env_utils.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/dropdown_widget.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

import '../utils/colors/colors.dart';
import '../utils/comman/login_appbar.dart';
import '../utils/comman/widget/login_header_subtitle.dart';
import '../utils/comman/widget/login_header_widget.dart';
import '../utils/const/const_variable.dart';
import '../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../utils/style/text_style.dart';
import 'package:http/http.dart' as http;

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen>
    with TickerProviderStateMixin {
  int selectedContainerIndex = 1;
  String selectedItemValueGeography = 'Select..';
  String? selectedDivisionValue;
  String? selectedClusterValue;
  String? selectedSiteValue;

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

  Future<String>? divisionFilterAPI() async {
    // var url = 'https://run.mocky.io/v3/c52ff7cc-dd98-4909-aeb5-df7b53afc3bf';
    var url = '${EnvUtils.baseURL}/appData/branchlist?filter=division';
    var response = await http.get(Uri.parse(url), headers: header);
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
    var url = '${EnvUtils.baseURL}/appData/branchlist?filter=cluster';
    var response = await http.get(Uri.parse(url), headers: header);
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
    // var url = 'https://run.mocky.io/v3/5129f388-f278-4065-9886-d69e9992cc01';
    var url = '${EnvUtils.baseURL}/appData/branchlist?filter=site';
    var response = await http.get(Uri.parse(url), headers: header);
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // for (int j = 0; j <100; j++) {
    //   selectedItemValueGeography
    //       .add("Select..");
    // }
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginAppBar(),
            const Padding(
              padding: EdgeInsets.only(
                  left: margin, right: margin, bottom: 10, top: 80),
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginHeaderWidget(
                  title: "Let's set you up!",
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: margin, right: margin, bottom: 2),
                child: LoginHeaderSubtitle(
                  subtitle: " Choose location to generate the data for",
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: margin, right: margin, bottom: 15),
                child: LoginHeaderSubtitle(
                  subtitle: " Business Overview",
                ),
              ),
            ),
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selectedContainerIndex == 1
                                        ? MyColors.primary
                                        : MyColors.grayBorder,
                                    width:
                                        selectedContainerIndex == 1 ? 3 : 1)),
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
                                    fontWeight: selectedContainerIndex == 1
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selectedContainerIndex == 2
                                        ? MyColors.primary
                                        : MyColors.grayBorder,
                                    width:
                                        selectedContainerIndex == 2 ? 3 : 1)),
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
                                    fontWeight: selectedContainerIndex == 2
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selectedContainerIndex == 3
                                        ? MyColors.primary
                                        : MyColors.grayBorder,
                                    width:
                                        selectedContainerIndex == 3 ? 3 : 1)),
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
                                    fontWeight: selectedContainerIndex == 3
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
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: selectedContainerIndex == 4
                                        ? MyColors.primary
                                        : MyColors.grayBorder,
                                    width:
                                        selectedContainerIndex == 4 ? 3 : 1)),
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
                                    fontWeight: selectedContainerIndex == 4
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
                          decoration: const BoxDecoration(color: Colors.white),
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, bottom: 10, top: 20),
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
                                        ? selectedClusterValue = value!
                                        : selectedContainerIndex == 4
                                            ? selectedSiteValue = value!
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: SizedBox(
                height: 56,
                width: size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedContainerIndex == 1) {
                      print("All India");
                      SharedPreferencesUtils.setString('division', allIndia);
                      SharedPreferencesUtils.setString('site', allIndia);
                      SharedPreferencesUtils.setBool("business", true);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
                      // Navigator.pushNamed(context, RoutesName.home);
                    } else if (selectedContainerIndex == 2) {
                      SharedPreferencesUtils.setString('division', 'Division');
                      SharedPreferencesUtils.setString(
                          'site', selectedDivisionValue!);
                      SharedPreferencesUtils.setBool("business", true);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
                      // Navigator.pushNamed(context, RoutesName.home);
                    } else if (selectedContainerIndex == 3) {
                      SharedPreferencesUtils.setString('division', 'Cluster');
                      SharedPreferencesUtils.setString(
                          'site', selectedClusterValue!);
                      SharedPreferencesUtils.setBool("business", true);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
                      // Navigator.pushNamed(context, RoutesName.home);
                    } else if (selectedContainerIndex == 4) {
                      SharedPreferencesUtils.setString('division', 'Site');
                      SharedPreferencesUtils.setString(
                          'site', selectedSiteValue!);
                      SharedPreferencesUtils.setBool("business", true);
                      // Navigator.pushNamed(context, RoutesName.home);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
                    } else {
                      SharedPreferencesUtils.setString('division', allIndia);
                      SharedPreferencesUtils.setString('site', allIndia);
                      SharedPreferencesUtils.setBool("business", true);
                      // Navigator.pushNamed(context, RoutesName.home);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage()));
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: MyColors.showMoreColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
