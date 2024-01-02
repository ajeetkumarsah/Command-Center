import 'dart:async';

import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/comman/market_visit/getstartedIntro.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class PromptToLocationScreen extends StatefulWidget {
  const PromptToLocationScreen({super.key});

  @override
  State<PromptToLocationScreen> createState() => _PromptToLocationScreenState();
}

class _PromptToLocationScreenState extends State<PromptToLocationScreen> {
  bool _inArrow = false;
  bool _outArrow = false;
  bool _flag = false;

  @override
  void initState() {
    // TODO: implement initState
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
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff587DDD),
                Color(0xff69B9D7),
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                width: size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffF2F6FD),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(0.0, 0.5), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/icon/storeicon.png"),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 11, left: 25, right: 25),
                        child: Container(
                          height: 2,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: MyColors.primary,
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffD9D9D9),
                                MyColors.primary,
                                MyColors.primary,
                                Color(0xffD9D9D9),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const GetStaredIntroWidget(
                              color: Color(0xff1ACA8E),
                              title: 'Get Started',
                              icon: Icons.flag,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.width/15),
                              child: Container(height: 5,width: size.width / 4, color: const Color(0xffCCCDD2),),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              // padding: EdgeInsets.only(top: 18.0),
                              child: GetStaredIntroWidget(
                                color: Color(0xffCCCDD2),
                                title: 'Select Store \n& Distributor',
                                icon: Icons.storefront,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.width/15),
                              child: Container(height: 5,width: size.width / 4, color: const Color(0xffCCCDD2),),
                            ),
                            const GetStaredIntroWidget(
                              color: Color(0xffCCCDD2),
                              title: 'Dashboard',
                              icon: Icons.insert_chart_outlined,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Get Started",
                              maxLines: 2,
                              style: TextStyle(
                                  color: MyColors.primary,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Container(height: 5,width: size.width / 6.2, ),
                            Text(
                              "Select Store \n& Distributor",
                              maxLines: 2,
                              style: TextStyle(
                                  color: MyColors.primary,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Container(height: 5,width: size.width / 6.2, ),
                            Text(
                              "Dashboard",
                              maxLines: 2,
                              style: TextStyle(
                                  color: MyColors.primary,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.asset("assets/icon/storebg.png"),
              ),
              Column(
                children: [
                  const Text(
                    "*Grant location access and tap below",
                    maxLines: 2,
                    style: TextStyle(
                        color: Color(0xffF4F4F4),
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    // decoration: _inArrow
                    //     ? !_outArrow?BoxDecoration(): BoxDecoration(
                    //   borderRadius: BorderRadius.circular(35),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey,
                    //       offset: Offset(0.0, 1.0), //(x,y)
                    //       blurRadius: 6.0,
                    //     ),
                    //   ],
                    // ):BoxDecoration(),
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
                                // _outArrow = !_outArrow;
                                _flag = !_flag;
                                // _onIntroEnd(context);
                              });
                              // Navigator.pushReplacementNamed(
                              //     context, RoutesName.pglogin);
                            },
                            child: Container(
                              width: _inArrow
                                  ? !_outArrow
                                      ? 70
                                      : 0
                                  : 0,
                              height: _inArrow
                                  ? !_outArrow
                                      ? 70
                                      : 0
                                  : 0,
                              decoration: BoxDecoration(
                                color: _flag
                                    ? const Color(0xffEBEDF0)
                                    : Colors.white,
                                // Customize the background color
                                shape: BoxShape.circle,
                              ),
                              child: Opacity(
                                opacity: _inArrow
                                    ? !_outArrow
                                        ? 1.0
                                        : 0.0
                                    : 0.0,
                                // Show/hide the arrow
                                // child: const Icon(
                                //   Icons.arrow_forward,
                                //   color: MyColors.primary,
                                //   size: 39,
                                // ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
