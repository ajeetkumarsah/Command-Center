import 'dart:async';

import 'package:command_centre/activities/pglogin/fedauth_login.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/routes/routes_name.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

import '../utils/sharedpreferences/sharedpreferences_utils.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _inArrow = false;
  bool _outArrow = false;
  bool _flag = false;

  Future<void> _onIntroEnd(context) async {
    SharedPreferencesUtils.setBool('seen', true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FedAuthLoginPage()));
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _inArrow = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
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
                      color: MyColors.backgroundColor,
                      image: DecorationImage(
                        image: AssetImage('assets/images/app_bar/EE74.png'),
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
                        image: AssetImage('assets/images/app_bar/EE73.png'),
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
                        image: AssetImage('assets/images/app_bar/EE74.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/app_bar/maskgroup.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Welcome Aboard!',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 37,
                        fontFamily: fontFamily),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 60,
                    right: 60,
                  ),
                  child: Text(
                    'Harness the power of data',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: MyColors.textSubHeaderColor,
                        fontFamily: fontFamily),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 60, right: 60, top: 4, bottom: 33),
                  child: Text(
                    'Anytime, Anywhere',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: MyColors.textSubHeaderColor,
                        fontFamily: fontFamily),
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
                        Navigator.pushReplacementNamed(
                            context, RoutesName.pglogin);
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
                            'assets/icon/arrow_left.png',
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
