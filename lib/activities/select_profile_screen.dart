import 'package:command_centre/activities/purpose_screen.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

import '../utils/comman/login_appbar.dart';
import '../utils/comman/widget/login_header_subtitle.dart';
import '../utils/comman/widget/login_header_widget.dart';

class SelectProfile extends StatefulWidget {
  const SelectProfile({super.key});

  @override
  State<SelectProfile> createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  var itemList = ['Sales', 'Finance', 'Supply Chain'];
  int _selected = -1;
  int selectedContainerIndex = 0;
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: MyColors.toggletextColor,
        // ),
        body: SingleChildScrollView(child: Column(children: [
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
                subtitle: " Choose Profile",
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
              EdgeInsets.only(left: margin, right: margin, bottom: 1),
              child: LoginHeaderSubtitle(
                subtitle: "",
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
                          selectContainer(0);
                          // _animationController.repeat();
                          // _animationController.forward();
                        },
                        child: Container(
                          width: size.width,
                          height: 60,
                          decoration: BoxDecoration(
                              color: selectedContainerIndex == 0
                                  ? MyColors.toggleColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: selectedContainerIndex == 0
                                      ? MyColors.primary
                                      : MyColors.grayBorder,
                                  width:
                                  selectedContainerIndex == 0 ? 3 : 1)),
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
                                  fontWeight: selectedContainerIndex == 0
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
                          // _animationController.forward();
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
                              'Finance',
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
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectContainer(2);
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
                              'Supply Chain',
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
                    ),
                    // const SizedBox(width: 20),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       selectContainer(4);
                    //       // _animationController.forward();
                    //     },
                    //     child: Container(
                    //       width: size.width,
                    //       height: 60,
                    //       decoration: BoxDecoration(
                    //           color: selectedContainerIndex == 4
                    //               ? MyColors.toggleColor
                    //               : Colors.white,
                    //           borderRadius: BorderRadius.circular(10),
                    //           border: Border.all(
                    //               color: selectedContainerIndex == 4
                    //                   ? MyColors.primary
                    //                   : MyColors.grayBorder,
                    //               width:
                    //               selectedContainerIndex == 4 ? 3 : 1)),
                    //       child: Align(
                    //         alignment: Alignment.center,
                    //         child: Text(
                    //           'Site',
                    //           // textAlign: TextAlign.start,
                    //           style: TextStyle(
                    //               fontSize: 18,
                    //               color: selectedContainerIndex == 4
                    //                   ? MyColors.toggletextColor
                    //                   : MyColors.loginTitleColor,
                    //               fontWeight: selectedContainerIndex == 4
                    //                   ? FontWeight.w700
                    //                   : FontWeight.w400,
                    //               fontFamily: fontFamily),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: selectedContainerIndex >=0 ? SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  SharedPreferencesUtils.setString('selectedProfile', itemList[selectedContainerIndex]);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> PurposeScreen(isBool: itemList[selectedContainerIndex]=='Sales'?false:true,)));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const StadiumBorder(),
                    backgroundColor: MyColors.toggletextColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Geography',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: fontFamily,
                          fontSize: 18,
                          letterSpacing: 0.6),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                      weight: 100,
                    ),
                  ],
                ),
              ),
            ):Container(),
          ),
    ],),));
  }
}
