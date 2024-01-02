import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/svg_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController controller =
      Get.put(AuthController(authRepo: Get.find()));
  // final HomeController homeCtlr = Get.put(HomeController(homeRepo: Get.find()));
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), () async {
      bool seen = await controller.getSeen();
      var token = await controller.getUserToken();
      var geo = await controller.getGeo();
      var geoValue = await controller.getGeoValue();
      var accessToken = await controller.getAccessToken();
      if (seen) {
        var code = await controller.getPingCode();
        if (token != null && token.isNotEmpty && accessToken.isNotEmpty) {
          if (geo.isNotEmpty && geoValue.isNotEmpty) {
            Get.offAndToNamed(AppPages.INITIAL);
          } else {
            Get.offAndToNamed(AppPages.SELECT_PROFILE);
          }
        } else {
          Get.offAndToNamed(AppPages.FED_AUTH_LOGIN);
        }
      } else {
        Get.offAndToNamed(AppPages.INTRO_SCREEN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SvgPicture.asset(
              SvgFiles.splashScreen,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Image.asset(
                PngFiles.pgLogo,
                height: 90,
                width: 90,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
