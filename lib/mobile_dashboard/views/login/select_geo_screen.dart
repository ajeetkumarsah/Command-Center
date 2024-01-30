import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/login/login_screen.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';

class SelectGeoScreen extends StatefulWidget {
  const SelectGeoScreen({Key? key}) : super(key: key);

  @override
  State<SelectGeoScreen> createState() => _SelectGeoScreenState();
}

class _SelectGeoScreenState extends State<SelectGeoScreen>
    with TickerProviderStateMixin {
  // final  ctlr = Get.put(HomeController(homeRepo: Get.find()));
  int selectedContainerIndex = 1;
  String selectedItemValueGeography = 'Select..';
  String? selectedDivisionValue;
  String? selectedClusterValue;
  String? selectedSiteValue;
  late SharedPreferences sharedPreferences;
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

  // final ctlr = Get.put(HomeController(homeRepo: Get.find()));
  //
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  // List<DropdownMenuItem<String>> _dropDownItem() {
  //   var ddl = selectedContainerIndex == 2
  //       ? divisionCount
  //       : selectedContainerIndex == 3
  //           ? clusterCount
  //           : selectedContainerIndex == 4
  //               ? siteCount
  //               : allIndiaCount;
  //   return ddl
  //       .map((value) => DropdownMenuItem(
  //             value: value.toString(),
  //             child: Text(value.toString()),
  //           ))
  //       .toList();
  // }

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
    return GetBuilder<AuthController>(
      init: AuthController(authRepo: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LoginAppBar(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 80),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 2),
                    child: Text(
                      " Choose location to generate the data for",
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: Text(
                      " Business Overview",
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
                                selectContainer(1);
                                _animationController.repeat();
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
                                            : AppColors.lightGrey,
                                        width: selectedContainerIndex == 1
                                            ? 3
                                            : 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'All India',
                                    // textAlign: TextAlign.start,
                                    style: GoogleFonts.ptSansCaption(
                                      fontSize: 18,
                                      color: selectedContainerIndex == 1
                                          ? AppColors.primary
                                          : Colors.black,
                                      fontWeight: selectedContainerIndex == 1
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
                                selectContainer(2);
                                _animationController.forward();
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
                                            : AppColors.lightGrey,
                                        width: selectedContainerIndex == 2
                                            ? 3
                                            : 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Division',
                                    // textAlign: TextAlign.start,
                                    style: GoogleFonts.ptSansCaption(
                                      fontSize: 18,
                                      color: selectedContainerIndex == 2
                                          ? AppColors.primary
                                          : Colors.black,
                                      fontWeight: selectedContainerIndex == 2
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
                                selectContainer(3);
                                _animationController.forward();
                              },
                              child: Container(
                                width: size.width,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: selectedContainerIndex == 3
                                        ? AppColors.primary.withOpacity(.2)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: selectedContainerIndex == 3
                                            ? AppColors.primary
                                            : AppColors.lightGrey,
                                        width: selectedContainerIndex == 3
                                            ? 3
                                            : 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Cluster',
                                    // textAlign: TextAlign.start,
                                    style: GoogleFonts.ptSansCaption(
                                      fontSize: 18,
                                      color: selectedContainerIndex == 3
                                          ? AppColors.primary
                                          : Colors.black,
                                      fontWeight: selectedContainerIndex == 3
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
                                selectContainer(4);
                                _animationController.forward();
                              },
                              child: Container(
                                width: size.width,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: selectedContainerIndex == 4
                                        ? AppColors.primary.withOpacity(.2)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: selectedContainerIndex == 4
                                            ? AppColors.primary
                                            : AppColors.lightGrey,
                                        width: selectedContainerIndex == 4
                                            ? 3
                                            : 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Focus Area',
                                    // textAlign: TextAlign.start,
                                    style: GoogleFonts.ptSansCaption(
                                      fontSize: 18,
                                      color: selectedContainerIndex == 4
                                          ? AppColors.primary
                                          : Colors.black,
                                      fontWeight: selectedContainerIndex == 4
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
                    ],
                  ),
                ),
                selectedContainerIndex == 0
                    ? Container()
                    : selectedContainerIndex == 1
                        ? Container()
                        : ctlr.isFilterLoading
                            ? CustomShimmer(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(8),
                              )
                            : SlideTransition(
                                position: _animation,
                                child: ctlr.filtersModel != null
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                        padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5,
                                            bottom: 10,
                                            top: 20),
                                        child: DropDownWidget(
                                          selectedValue:
                                              selectedContainerIndex == 2
                                                  ? selectedDivisionValue
                                                  : selectedContainerIndex == 3
                                                      ? selectedClusterValue
                                                      : selectedContainerIndex ==
                                                              4
                                                          ? selectedSiteValue
                                                          : null,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedContainerIndex == 2
                                                  ? selectedDivisionValue =
                                                      value!
                                                  : selectedContainerIndex == 3
                                                      ? selectedClusterValue =
                                                          value!
                                                      : selectedContainerIndex ==
                                                              4
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
                                                      ? 'Select Focus Area'
                                                      : '',
                                          dropDownItem:
                                              selectedContainerIndex == 2
                                                  ? ctlr.filtersModel!.division
                                                      .map((value) =>
                                                          DropdownMenuItem(
                                                            value: value
                                                                .toString(),
                                                            child: Text(value
                                                                .toString()),
                                                          ))
                                                      .toList()
                                                  : selectedContainerIndex == 3
                                                      ? ctlr.filtersModel!
                                                          .district
                                                          .map((value) =>
                                                              DropdownMenuItem(
                                                                value: value
                                                                    .toString(),
                                                                child: Text(value
                                                                    .toString()),
                                                              ))
                                                          .toList()
                                                      : ctlr.filtersModel!.site
                                                          .map((value) =>
                                                              DropdownMenuItem(
                                                                value: value
                                                                    .toString(),
                                                                child: Text(value
                                                                    .toString()),
                                                              ))
                                                          .toList(),
                                          secondIndex: 0,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: SizedBox(
                    height: 56,
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        ctlr.savePurpose('business');
                        if (selectedContainerIndex == 1) {
                          ctlr.onChangeGeo('All India', 'All India');
                          Get.offAndToNamed(AppPages.SPLASH_SCREEN);
                        } else if (selectedContainerIndex == 2) {
                          if (selectedDivisionValue != null) {
                            ctlr.onChangeGeo(
                                'Division', selectedDivisionValue ?? '');
                            Get.offAndToNamed(AppPages.SPLASH_SCREEN);
                          } else {
                            showCustomSnackBar('Please select a division.');
                          }
                        } else if (selectedContainerIndex == 3) {
                          if (selectedClusterValue != null) {
                            ctlr.onChangeGeo(
                                'Cluster', selectedClusterValue ?? '');
                            Get.offAndToNamed(AppPages.SPLASH_SCREEN);
                          } else {
                            showCustomSnackBar('Please select a cluster.');
                          }
                        } else if (selectedContainerIndex == 4) {
                          if (selectedSiteValue != null) {
                            ctlr.onChangeGeo(
                                'Focus Area', selectedSiteValue ?? '');
                            Get.offAndToNamed(AppPages.SPLASH_SCREEN);
                          } else {
                            showCustomSnackBar('Please select a site.');
                          }
                        } else {
                          ctlr.onChangeGeo('All India', 'All India');
                          Get.offAndToNamed(AppPages.SPLASH_SCREEN);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          elevation: 0,
                          backgroundColor: AppColors.primary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Get Started',
                              style: GoogleFonts.ptSansCaption(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.white,
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
                        Get.back();
                      },
                      child: Text(
                        "Go Back",
                        style: GoogleFonts.ptSansCaption(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DropDownWidget extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;
  final String title;
  final List<DropdownMenuItem<String>>? dropDownItem;
  final int secondIndex;

  const DropDownWidget(
      {Key? key,
      required this.selectedValue,
      required this.onChanged,
      required this.title,
      required this.dropDownItem,
      required this.secondIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: GoogleFonts.ptSansCaption(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            letterSpacing: 1,
          ),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.lightGrey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 5,
          ),
        ),
        child: SizedBox(
          height: 60,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: selectedValue,
                style: const TextStyle(fontSize: 14, color: AppColors.black),
                items: dropDownItem,
                onChanged: onChanged,
                hint: const Text("Select.."),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
