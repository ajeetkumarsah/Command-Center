import 'package:command_centre/web_dashboard/utils/summary_utils/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../activities/responsive.dart';
import '../../../helper/app_urls.dart';
import '../../../provider/sheet_provider.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/const/const_variable.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../../../utils/style/text_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectDivisionPopUp extends StatefulWidget {
  final Function() onPressedGeo;

  const SelectDivisionPopUp({super.key, required this.onPressedGeo});

  @override
  State<SelectDivisionPopUp> createState() => _SelectDivisionPopUpState();
}

class _SelectDivisionPopUpState extends State<SelectDivisionPopUp>
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
    divisionCount =
        jsonDecode(SharedPreferencesUtils.getString("divisionCount") ?? '');
    siteCount = jsonDecode(SharedPreferencesUtils.getString("siteCount") ?? '');
    clusterCount =
        jsonDecode(SharedPreferencesUtils.getString("clusterCount") ?? '');
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: margin, right: margin, bottom: 10, top: 80),
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
              padding: EdgeInsets.only(left: margin, right: margin, bottom: 2),
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
              padding: EdgeInsets.only(left: margin, right: margin, bottom: 15),
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
                              sheetProvider.selectedContainerIndex = 1;
                              print(selectedContainerIndex);
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
                              print(selectedContainerIndex);
                              sheetProvider.selectedContainerIndex = 2;
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
                              print(selectedContainerIndex);
                              sheetProvider.selectedContainerIndex = 3;
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
                              print(selectedContainerIndex);
                              sheetProvider.selectedContainerIndex = 4;
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
                            decoration:
                                const BoxDecoration(color: Colors.white),
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
                                selectedContainerIndex == 2
                                    ? sheetProvider.selectedValue =
                                        selectedDivisionValue!
                                    : selectedContainerIndex == 3
                                        ? sheetProvider.selectedValue =
                                            selectedClusterValue!
                                        : selectedContainerIndex == 4
                                            ? sheetProvider.selectedValue =
                                                selectedSiteValue!
                                            : sheetProvider.selectedValue =
                                                allIndia;
                                print(sheetProvider.selectedValue);
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
                  width: size.width / 4,
                  child: ElevatedButton(
                    onPressed: widget.onPressedGeo,
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
    );
  }
}
