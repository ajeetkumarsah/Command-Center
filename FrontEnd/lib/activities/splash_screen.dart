import 'dart:async';

import 'package:command_centre/activities/home_screen.dart';
import 'package:command_centre/activities/intro_screen.dart';
import 'package:command_centre/activities/pglogin/fedauth_login.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../utils/style/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primary,
        body: Stack(
          children: [
            Container(
              color: MyColors.primary,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Lottie.asset(
                'assets/json/splashbglottie.json',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/icon.png",
                    height: 96,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Command Centre",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: fontFamily,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), () {
      bool seen = SharedPreferencesUtils.getBool('seen') ?? false;
      if (seen) {
        var code = SharedPreferencesUtils.getString('pingCode');
        if (code != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FedAuthLoginPage()));
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const IntroScreen()));
      }
    });
  }
}
