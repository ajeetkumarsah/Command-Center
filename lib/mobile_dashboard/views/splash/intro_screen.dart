import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _inArrow = false;
  bool _outArrow = false;
  bool _flag = false;
  final controller = Get.put(HomeController(homeRepo: Get.find()));
  Future<void> _onIntroEnd(context) async {
    // SharedPreferencesUtils.setBool('seen', true);
    Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => FedAuthLoginPage()));
  }

  @override
  void initState() {
    super.initState();
    FirebaseCrashlytics.instance.log("Intro Started");
    Timer(const Duration(seconds: 2), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // setState(() {
          _inArrow = true;
        // });
      });
    });
    FirebaseCrashlytics.instance.log("Intro Seen Check");
    controller.setSeen(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomClipNormalPath(),
                  child: Container(
                    width: double.infinity,
                    height: size.height / 1.5,
                    decoration: const BoxDecoration(
                      color: AppColors.bgLight,
                      image: DecorationImage(
                        image: AssetImage('assets/png/EE74.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: double.infinity,
                    height: size.height / 1.55,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/png/EE73.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    width: double.infinity,
                    height: size.height / 1.55,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/png/EE74.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Image.asset(
                      "assets/png/maskgroup.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Welcome Aboard!',
                    style: GoogleFonts.ptSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 37,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                    right: 60,
                  ),
                  child: Text(
                    'Harness the power of data',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 60, right: 60, top: 4, bottom: 33),
                  child: Text(
                    'Anytime, Anywhere',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    left: _inArrow
                        ? !_outArrow
                            ? 0.0
                            : 50
                        : -50.0,
                    // Hide the arrow by moving it outside the screen
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _flag = !_flag;
                          _onIntroEnd(context);
                        });
                        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
                        // Navigator.pushReplacementNamed(
                        //     context, RoutesName.pgl.ogin);
                      },
                      child: Container(
                        width: _inArrow
                            ? !_outArrow
                                ? 100
                                : 0
                            : 0,
                        height: _inArrow
                            ? !_outArrow
                                ? 100
                                : 0
                            : 0,
                        decoration: BoxDecoration(
                          color: _flag ? const Color(0xffEBEDF0) : Colors.white,
                          // Customize the background color
                          shape: BoxShape.circle,
                        ),
                        child: Opacity(
                          opacity: _inArrow
                              ? !_outArrow
                                  ? 1.0
                                  : 0.0
                              : 0.0,
                          child: Image.asset(
                            'assets/png/arrow_left.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 42.5);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipNormalPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 42.5);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
