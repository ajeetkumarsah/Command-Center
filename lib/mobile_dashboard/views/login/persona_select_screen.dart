import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/comman/login_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';


const double margin = 20.0;

class PersonaScreen extends StatefulWidget {
  const PersonaScreen({Key? key}) : super(key: key);

  @override
  State<PersonaScreen> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends State<PersonaScreen>
    with TickerProviderStateMixin {
  int selectedContainerIndex = 1;

  void selectContainer(int index) {
    setState(() {
      if (selectedContainerIndex == index) {
        selectedContainerIndex = 1;
      } else {
        selectedContainerIndex = index;
      }
    });
  }

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    FirebaseCrashlytics.instance.log("Persona Started");
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
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
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginAppBar(),
            Padding(
              padding: const EdgeInsets.only(
                  left: margin, right: margin, bottom: 10, top: 80),
              child: Text(
                'Let\'s set you up!',
                style: GoogleFonts.ptSans(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectContainer(1);
                      _animationController.forward();
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
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Leadership Team',
                            // textAlign: TextAlign.start,
                            style: GoogleFonts.ptSans(
                              fontSize: 18,
                              color: selectedContainerIndex == 1
                                  ? AppColors.primary
                                  : Colors.black,
                              fontWeight: selectedContainerIndex == 1
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      selectContainer(2);
                      _animationController.forward();
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
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Sales Team',
                            // textAlign: TextAlign.start,
                            style: GoogleFonts.ptSans(
                              fontSize: 18,
                              color: selectedContainerIndex == 2
                                  ? AppColors.primary
                                  : Colors.black,
                              fontWeight: selectedContainerIndex == 2
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: SizedBox(
                height: 56,
                width: size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    FirebaseCrashlytics.instance.log("Persona Selected");
                    //// Obtain shared preferences.
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (selectedContainerIndex == 1) {
                      await prefs.setBool(AppConstants.PERSONA, true);
                    } else {
                      await prefs.setBool(AppConstants.PERSONA, false);
                    }
                    Get.toNamed(AppPages.SELECT_GEO_SCREEN);
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
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(width: 5),
                      selectedContainerIndex == 0
                          ? Container()
                          : const Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.white,
                              weight: 100,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            // selectedContainerIndex == 0
            //     ? Container()
            //     : SlideTransition(
            //         position: _animation,
            //         child: const Padding(
            //           padding: EdgeInsets.only(
            //             left: 40,
            //             right: 40,
            //             top: 30,
            //           ),
            //           child: Text(
            //             "Psst! You can always switch to the other mode in the side bar menu!",
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: Color(0xB31D3853),
            //               fontSize: 16,
            //               fontWeight: FontWeight.w400,
            //             ),
            //           ),
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }
}
