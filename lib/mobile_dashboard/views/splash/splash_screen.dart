import 'dart:async';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';

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

  void startTimer() async {
    FirebaseCrashlytics.instance.log("Splash Started");
    bool seen = await controller.getSeen();
    var token = await controller.getUserToken();
    var geo = await controller.getGeo();
    var geoValue = await controller.getGeoValue();
    var accessToken = await controller.getAccessToken();
    Timer(const Duration(seconds: 3), () {
      if (token.isNotEmpty && accessToken.isNotEmpty) {
        FirebaseCrashlytics.instance.log("Splash Token Check");
        debugPrint('===>Firebase Crash Analytics$seen');
        if (seen) {
          if (controller.configModel != null) {
            debugPrint('===>Config Model is not null');
            if (controller.configModel?.onMaintenance ?? false) {
              Get.offAndToNamed(AppPages.maintenanceScreen);
            } else {
              debugPrint('===>Maintenance mode is off');
              if ((Platform.isAndroid
                      ? controller.configModel?.apkVersion ?? ''
                      : controller.configModel?.apkVersion ?? '') !=
                  AppConstants.APP_VERSION) {
                Get.offAndToNamed(AppPages.updateScreen);
              } else {
                if (geo.isNotEmpty && geoValue.isNotEmpty) {
                  FirebaseCrashlytics.instance.log("Splash Geo Check");
                  debugPrint('===>Splash Geo $geo Value $geoValue');
                  // Get.to(const OnboardingScreen());
                  Get.offAndToNamed(AppPages.INITIAL);
                  // Get.offAndToNamed(AppPages.PERSONA_SCREEN);
                } else {
                  Get.offAndToNamed(AppPages.businessOnboarding);
                }
              }
            }
          }
        } else {
          Get.offAndToNamed(AppPages.businessOnboarding);
        }
      } else {
        FirebaseCrashlytics.instance.log("Splash Token False");
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
      }

      //   }
      // }
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
            child: Lottie.asset(
              'assets/json/splashbglottie.json',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),

            // SvgPicture.asset(
            //   SvgFiles.splashScreen,
            //   fit: BoxFit.cover,
            // ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: SvgPicture.asset(
                    'assets/svg/img_cc.svg',
                    height: 150,
                    width: 150,
                  ),
                )

                // Container(
                //   decoration: BoxDecoration(color: Colors.white.withOpacity(0.7)),
                //   child: Image.asset(
                //     'assets/png/img_cc_transparent.png',
                //     height: 150,
                //     width: 150,
                //   ),
                // ),

                ),
          ),
          // InkWell(onTap: (){
          //   debugPrint('base fed ${Obfuscation.encodeString('')}');
          // }, child: Padding(
          //   padding: const EdgeInsets.all(80.0),
          //   child: Container(height: 100,width: 100,color: Colors.black,),
          // ),)
        ],
      ),
    );
  }
}
