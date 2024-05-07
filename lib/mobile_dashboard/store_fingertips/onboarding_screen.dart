import 'package:get/get.dart';
import 'distributor_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_selection_controller.dart';
import 'package:command_centre/mobile_dashboard/store_fingertips/select_state_dropdown.dart';
import 'package:command_centre/mobile_dashboard/store_fingertips/branch_location_dropdown.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isMapVisible = false;
  bool isDropDownVisible = true;
  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  void onChangePage() {
    if (activeIndex < 1) {
      _activeIndex++;
    } else {
      _activeIndex++;
      Future.delayed(const Duration(seconds: 2))
          .then((value) => Get.toNamed(AppPages.STORE_FINGERTIPS_SCREEN));
    }
    setState(() {});
  }

  void onChangePageIndex(int value) {
    if (activeIndex < 1) {
      _activeIndex = value;
    } else {
      _activeIndex++;
      Future.delayed(const Duration(seconds: 2))
          .then((value) => Get.offAndToNamed(AppPages.STORE_FINGERTIPS_SCREEN));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<StepperData> stepperData = [
      StepperData(
        title: StepperText(
          "Get Started",
          textStyle: GoogleFonts.ptSans(
            color: activeIndex > 0 ? AppColors.primary : AppColors.green,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconWidget: GestureDetector(
          onTap: () => onChangePageIndex(0),
          child: Container(
            padding: EdgeInsets.all(activeIndex == 0 ? 6 : 2),
            decoration: BoxDecoration(
              color: activeIndex > 0 ? AppColors.primary : AppColors.green,
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: activeIndex == 0
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                  ),
          ),
        ),
      ),
      StepperData(
        title: StepperText("Select Store & Distributor"),
        // subtitle: StepperText("Your order is being prepared"),
        iconWidget: GestureDetector(
          onTap: () => onChangePageIndex(1),
          child: Container(
            padding: EdgeInsets.all(activeIndex == 1 ? 6 : 2),
            decoration: BoxDecoration(
              color: activeIndex > 1
                  ? AppColors.primary
                  : activeIndex == 1
                      ? AppColors.green
                      : Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: activeIndex == 1
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : activeIndex > 1
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                      )
                    : Center(
                        child: Text(
                          '2',
                          style: GoogleFonts.ptSansCaption(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
          ),
        ),
      ),
      StepperData(
        title: StepperText("Dashboard"),
        iconWidget: GestureDetector(
          onTap: () => onChangePageIndex(2),
          child: Container(
            padding: EdgeInsets.all(activeIndex == 2 ? 6 : 2),
            decoration: BoxDecoration(
                color: activeIndex > 2
                    ? AppColors.primary
                    : activeIndex == 2
                        ? AppColors.green
                        : Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: activeIndex == 2
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : activeIndex > 2
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                      )
                    : Center(
                        child: Text(
                          '3',
                          style: GoogleFonts.ptSansCaption(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
          ),
        ),
      ),
    ];
    return GetBuilder<StoreSelectionController>(
      init: StoreSelectionController(storeRepo: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  margin: const EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  height: 220, //activeIndex == 1 ? 280 :220,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: AppColors.storeBgColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Image.asset("assets/png/Group 35.png", height: 31),
                      const SizedBox(height: 10),
                      Image.asset("assets/png/Rectangle 426.png"),
                      const SizedBox(height: 30),
                      AnotherStepper(
                        stepperList: stepperData,
                        stepperDirection: Axis.horizontal,
                        inverted: true,
                        iconWidth: 30,
                        iconHeight: 30,
                        activeIndex: activeIndex,
                        activeBarColor: AppColors.green,
                        barThickness: 5,
                      ),
                      const SizedBox(height: 20),
                      // activeIndex == 1
                      //     ? Container(
                      //         height: 40,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20),
                      //             color: Colors.white),
                      //         child: Row(
                      //           children: [
                      //             const Padding(padding: EdgeInsets.all(10)),
                      //             Container(
                      //               height: 35,
                      //               decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   color: Colors.blue),
                      //               child: TextButton(
                      //                 onPressed: () {},
                      //                 child: const Text(
                      //                   "Search Manually",
                      //                   style: TextStyle(color: Colors.white),
                      //                 ),
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               width: 50,
                      //             ),
                      //             Container(
                      //               child: TextButton(
                      //                 onPressed: () {},
                      //                 child: const Text(
                      //                   "Find On Map",
                      //                   style: TextStyle(color: Colors.blue),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: activeIndex != 1,
                  child: Image.asset(
                    PngFiles.mapView,
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                ),
                // activeIndex != 2
                //     ? Text(
                //         "* Grant location access and tap below",
                //         style: GoogleFonts.ptSans(
                //           color: Colors.white,
                //           fontStyle: FontStyle.italic,
                //           fontSize: 18,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       )
                //     : const SizedBox(),
                Visibility(
                  visible: activeIndex == 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isDistributorLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                value: ctlr.selectedDistributor,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                hint: Text(
                                  'Distributor Name',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                items: ctlr.distributors.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (dis) =>
                                    ctlr.onChangeDistributor(dis),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isBranchLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                value: ctlr.selectedBranch,
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                hint: Text(
                                  'Branch Location',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                items: ctlr.branches.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) => ctlr.onChangeBranch(v!),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isChannelLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                value: ctlr.selectedChannel,
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                hint: Text(
                                  'Store',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                items: ctlr.channels.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) => ctlr.onChannelChange(v!),
                              ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 30, vertical: 6),
                      //   child: ctlr.selectedChannel != null
                      //       ? Container(
                      //           decoration: const BoxDecoration(
                      //             border: Border(
                      //               bottom: BorderSide(
                      //                 width: 1,
                      //                 color: AppColors.white,
                      //               ),
                      //             ),
                      //           ),
                      //           child: ListTile(
                      //             visualDensity: const VisualDensity(
                      //                 horizontal: 1, vertical: -3),
                      //             contentPadding:
                      //                 const EdgeInsets.symmetric(horizontal: 0),
                      //             title: Text(
                      //               ctlr.selectedChannel ?? '',
                      //               style: GoogleFonts.ptSans(
                      //                 color: AppColors.white,
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.w400,
                      //               ),
                      //             ),
                      //             trailing: IconButton(
                      //               onPressed: () => ctlr.clearChannel(),
                      //               icon: const Icon(
                      //                 Icons.close_rounded,
                      //                 color: AppColors.white,
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //       : TextFormField(
                      //           style: GoogleFonts.ptSans(
                      //             color: AppColors.white,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //           decoration: InputDecoration(
                      //             hintText: ' Store',
                      //             hintStyle: GoogleFonts.ptSans(
                      //               color: AppColors.white,
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //             border: const UnderlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: AppColors.white,
                      //               ),
                      //             ),
                      //             enabledBorder: const UnderlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: AppColors.white,
                      //               ),
                      //             ),
                      //             focusedBorder: const UnderlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: AppColors.white,
                      //               ),
                      //             ),
                      //           ),
                      //           onChanged: (v) =>
                      //               ctlr.getAllFilters(v, type: 'channel'),
                      //         ),
                      // ),
                    ],
                  ),
                ),
                // ctlr.channels.isEmpty && ctlr.isChannelLoading
                //     ? const SizedBox(
                //         height: 150,
                //         child: CustomLoader(color: AppColors.white),
                //       )
                //     : Visibility(
                //         visible: ctlr.channels.isNotEmpty,
                //         child: Container(
                //           color: AppColors.primaryDark,
                //           margin: const EdgeInsets.symmetric(horizontal: 30),
                //           height: 180,
                //           child: ctlr.isChannelLoading
                //               ? const CustomLoader(color: AppColors.white)
                //               : SingleChildScrollView(
                //                   child: Column(
                //                     children: [
                //                       ...ctlr.channels
                //                           .map(
                //                             (e) => ListTile(
                //                               onTap: () =>
                //                                   ctlr.onChannelChange(e),
                //                               visualDensity:
                //                                   const VisualDensity(
                //                                       horizontal: 1,
                //                                       vertical: -3),
                //                               contentPadding:
                //                                   const EdgeInsets.symmetric(
                //                                       horizontal: 30),
                //                               title: Text(
                //                                 e,
                //                                 style: GoogleFonts.ptSans(
                //                                   color: AppColors.white,
                //                                   fontSize: 18,
                //                                   fontWeight: FontWeight.w400,
                //                                 ),
                //                               ),
                //                             ),
                //                           )
                //                           .toList(),
                //                     ],
                //                   ),
                //                 ),
                //         ),
                //       ),

                const SizedBox(height: 20),
                activeIndex != 2
                    ? GestureDetector(
                        onTap: () {
                          if (activeIndex >= 1) {
                            if (ctlr.selectedDistributor != null &&
                                ctlr.selectedBranch != null &&
                                ctlr.selectedChannel != null) {
                              // ctlr.postStoreData().then((v) {
                              //   if (ctlr.storeIntroModel != null) {
                              //     onChangePage();
                              //   } else {
                              //     showCustomSnackBar('Something went wrong!');
                              //   }
                              // });
                            } else {
                              showCustomSnackBar(
                                  'Please Select the required fields.');
                            }
                          } else {
                            onChangePage();
                          }
                        },
                        //{
                        // Get.to(const StoreFingertipsScreen());
                        //},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                offset: const Offset(4, 4),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(6),
                          child: ctlr.isLoading
                              ? const SizedBox(
                                  height: 38,
                                  width: 38,
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: CustomLoader(),
                                  ),
                                )
                              : Image.asset(
                                  "assets/png/Icon Artwork.png",
                                  fit: BoxFit.cover,
                                  height: 38,
                                  width: 38,
                                ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
