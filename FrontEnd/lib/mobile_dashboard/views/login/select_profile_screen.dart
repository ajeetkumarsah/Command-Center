import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/login/login_screen.dart';

class SelectProfile extends StatefulWidget {
  const SelectProfile({super.key});

  @override
  State<SelectProfile> createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  var itemList = ['Sales', 'Finance', 'Supply Chain'];
  // int _selected = -1;
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          const LoginAppBar(),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 80),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let's set you up!",
                style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 2),
              child: Text(
                " Choose Profile",
                style: GoogleFonts.ptSans(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 1),
              child: Text(
                "",
                style: GoogleFonts.ptSans(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
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
                                  ? AppColors.primary.withOpacity(.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: selectedContainerIndex == 0
                                      ? AppColors.primary
                                      : Colors.grey,
                                  width: selectedContainerIndex == 0 ? 3 : 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sales',
                              // textAlign: TextAlign.start,
                              style: GoogleFonts.ptSans(
                                fontSize: 18,
                                color: selectedContainerIndex == 0
                                    ? AppColors.primary
                                    : AppColors.black,
                                fontWeight: selectedContainerIndex == 0
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
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
                                  ? AppColors.primary.withOpacity(.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: selectedContainerIndex == 1
                                      ? AppColors.primary
                                      : Colors.grey,
                                  width: selectedContainerIndex == 1 ? 3 : 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Finance',
                              // textAlign: TextAlign.start,
                              style: GoogleFonts.ptSans(
                                fontSize: 18,
                                color: selectedContainerIndex == 1
                                    ? AppColors.primary
                                    : AppColors.black,
                                fontWeight: selectedContainerIndex == 1
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
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
                                  ? AppColors.primary.withOpacity(.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: selectedContainerIndex == 2
                                      ? AppColors.primary
                                      : Colors.grey,
                                  width: selectedContainerIndex == 2 ? 3 : 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Supply Chain',
                              // textAlign: TextAlign.start,
                              style: GoogleFonts.ptSans(
                                fontSize: 18,
                                color: selectedContainerIndex == 2
                                    ? AppColors.primary
                                    : AppColors.black,
                                fontWeight: selectedContainerIndex == 2
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
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
            child: selectedContainerIndex >= 0
                ? SizedBox(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppPages.PURPOSE_SCREEN);
                        // SharedPreferencesUtils.setString('selectedProfile',
                        //     itemList[selectedContainerIndex]);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => PurposeScreen(
                        //               isBool:
                        //                   itemList[selectedContainerIndex] ==
                        //                           'Sales'
                        //                       ? false
                        //                       : true,
                        //             )));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const StadiumBorder(),
                        backgroundColor: AppColors.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select Geography',
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                letterSpacing: 0.6),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            weight: 100,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    ));
  }
}
