import 'package:command_centre/web_dashboard/select_division_screen.dart';
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

class SelectProfileScreenWeb extends StatefulWidget {
  const SelectProfileScreenWeb({super.key});

  @override
  State<SelectProfileScreenWeb> createState() => _SelectProfileScreenWebState();
}

class _SelectProfileScreenWebState extends State<SelectProfileScreenWeb>
    with TickerProviderStateMixin {
  int selectedContainerIndex = 0;
  String selectedItemValueGeography = 'Select..';
  String? selectedDivisionValue;
  String? selectedClusterValue;
  String? selectedSiteValue;
  double margin = 20.0;
  var itemList = ['Sales', 'Finance', 'Supply Chain'];

  void selectContainer(int index) {
    setState(() {
      if (selectedContainerIndex == index) {
        // Deselect the container if it was already selected
        selectedContainerIndex = 0;
      } else {
        selectedContainerIndex = index;
      }
    });
  }

  var divisionCount = [];
  var clusterCount = [];
  var siteCount = [];
  var allIndiaCount = [];

  var arrayData = [];

  Future<String>? checkLogin() async {
    // var url = 'https://run.mocky.io/v3/9aa3f386-5275-4213-9372-dcaf9d068388';
    // var url = 'http://localhost:3000/api/is_logged_in';
    var url = '$BASE_URL/api/is_logged_in';
    // var url = 'https://run.mocky.io/v3/873c3d23-1369-4784-9e53-9d27dd8a411a';
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonResponse = await jsonDecode(response.body);
      setState(() {
        jsonResponse;
        print(jsonResponse['trigger']);
        if (jsonResponse['trigger'] == true) {
          print(jsonResponse['user']['name']);
          SharedPreferencesUtils.setString(
              'userName', jsonResponse['user']['name']);
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) =>  const SelectProfileScreenWeb());
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const WebSplashScreen()));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
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
                        " Choose Profile",
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
                                      selectContainer(0);
                                    },
                                    child: Container(
                                      width: size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: selectedContainerIndex == 0
                                              ? MyColors.toggleColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: selectedContainerIndex == 0
                                                  ? MyColors.primary
                                                  : MyColors.grayBorder,
                                              width: selectedContainerIndex == 0
                                                  ? 3
                                                  : 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sales',
                                          // textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: selectedContainerIndex == 0
                                                  ? MyColors.toggletextColor
                                                  : MyColors.loginTitleColor,
                                              fontWeight:
                                                  selectedContainerIndex == 0
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
                                      selectContainer(1);
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
                                          'Finance',
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
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 120, right: 120),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        selectContainer(2);
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
                                                color:
                                                    selectedContainerIndex == 2
                                                        ? MyColors.primary
                                                        : MyColors.grayBorder,
                                                width:
                                                    selectedContainerIndex == 2
                                                        ? 3
                                                        : 1)),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Supply Chain',
                                            // textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: selectedContainerIndex ==
                                                        2
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
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                              SharedPreferencesUtils.setBool("business", true);
                              SharedPreferencesUtils.setString(
                                  'selectedProfile',
                                  itemList[selectedContainerIndex]);

                              print(SharedPreferencesUtils.getBool("business"));
                              print(SharedPreferencesUtils.getString(
                                  "selectedProfile"));
                              selectedContainerIndex == 2
                                  ? Navigator.of(context)
                                      .pushNamed('/supplydashboardscreen')
                                  : Navigator.of(context)
                                      .pushNamed('/divisionscreen');
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
