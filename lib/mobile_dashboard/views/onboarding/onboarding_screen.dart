import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

class BusinessOnboardingScreen extends StatefulWidget {
  const BusinessOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<BusinessOnboardingScreen> createState() =>
      _BusinessOnboardingScreenState();
}

class _BusinessOnboardingScreenState extends State<BusinessOnboardingScreen> {
  late PageController _controller;
  final controller = Get.put(HomeController(homeRepo: Get.find()));

  @override
  void initState() {
    _controller = PageController();
    controller.setSeen(true);
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: AppColors.primary,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  // static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    // blockH = screenW! / 100;
    blockV = screenH! / 100;
  }

  List<OnboardingContents> contents = [
    OnboardingContents(
      title: "Track Your Business Summary",
      image: "assets/svg/on.svg",
      desc:
          "Track all India Retailing, Coverage, Golden Points and Focus Brand across channels and categories",
    ),
    OnboardingContents(
      title: "Stay updated with the data everyday.",
      image: "assets/svg/on1.svg",
      desc: "Stay updated with latest data till D-1 everyday",
    ),
    // OnboardingContents(
    //   title: "Get notified when work happens",
    //   image: "assets/svg/on2.svg",
    //   desc:
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    init(context);
    double width = screenW!;
    double height = screenH!;

    return Scaffold(
      backgroundColor: AppColors.white,
      //colors[_currentPage],
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(
        init: AuthController(authRepo: Get.find()),
        initState: (_) {},
        builder: (ctlr) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) =>
                        setState(() => _currentPage = value),
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              contents[i].image,
                              height: blockV! * 30,
                            ),
                            SizedBox(
                              height: (height >= 840) ? 60 : 30,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ptSansCaption(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                fontSize: (width <= 550) ? 30 : 35,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              contents[i].desc,
                              style: GoogleFonts.ptSansCaption(
                                fontWeight: FontWeight.w300,
                                fontSize: (width <= 550) ? 17 : 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     ctlr.clearSharedData();
                //     Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
                //   },
                //   icon: const Icon(
                //     Icons.login,
                //     color: AppColors.primary,
                //   ),
                // ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      _currentPage + 1 == contents.length
                          ? Padding(
                              padding: const EdgeInsets.all(30),
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'hero1',
                                child: ElevatedButton(
                                  onPressed: () => Get.offAndToNamed(
                                      AppPages.PERSONA_SCREEN),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: (width <= 550)
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 100, vertical: 20)
                                        : EdgeInsets.symmetric(
                                            horizontal: width * 0.2,
                                            vertical: 25),
                                    textStyle: GoogleFonts.ptSansCaption(
                                        fontSize: (width <= 550) ? 13 : 17),
                                  ),
                                  child: Text(
                                    "START",
                                    style: GoogleFonts.ptSansCaption(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _controller.jumpToPage(2);
                                    },
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      textStyle: GoogleFonts.ptSansCaption(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (width <= 550) ? 13 : 17,
                                      ),
                                    ),
                                    child: Text(
                                      "SKIP",
                                      style: GoogleFonts.ptSansCaption(
                                          color: Colors.black),
                                    ),
                                  ),
                                  Hero(
                                    tag: 'hero1',
                                    transitionOnUserGestures: true,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        elevation: 0,
                                        padding: (width <= 550)
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 20)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 25),
                                        textStyle: GoogleFonts.ptSansCaption(
                                            fontSize: (width <= 550) ? 13 : 17),
                                      ),
                                      child: Text(
                                        "NEXT",
                                        style: GoogleFonts.ptSansCaption(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
