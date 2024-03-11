import 'login_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';



const double margin = 20.0;

class PurposeScreen extends StatefulWidget {
  final bool isBool;
  const PurposeScreen({Key? key, required this.isBool}) : super(key: key);

  @override
  State<PurposeScreen> createState() => _PurposeScreenState();
}

class _PurposeScreenState extends State<PurposeScreen>
    with TickerProviderStateMixin {
  int selectedContainerIndex = 1;

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

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);

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
              padding:
                  const EdgeInsets.only(left: margin, right: margin, bottom: 2),
              child: Text(
                'Help us organize the data for you according to',
                style: GoogleFonts.ptSans(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: margin, right: margin, bottom: 35),
              child: Text(
                " your purpose today",
                style: GoogleFonts.ptSans(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
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
                            'Business Overview',
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
                  widget.isBool == false
                      ? GestureDetector(
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
                                    width:
                                        selectedContainerIndex == 2 ? 3 : 1)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Market Visit',
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
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: SizedBox(
                height: 56,
                width: size.width,
                child: ElevatedButton(
                  onPressed: () async{
                    // await PushNotifications.init();
                    Get.toNamed(AppPages.SELECT_GEO_SCREEN);
                    if (selectedContainerIndex == 1) {
                      //business visit
                    } else {
                      //market visit
                    }
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
                            letterSpacing: 0.6),
                      ),
                      const SizedBox(width: 5),
                      selectedContainerIndex == 0
                          ? Container()
                          : const Icon(
                              Icons.arrow_forward,
                              size: 20,
                              weight: 100,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            selectedContainerIndex == 0
                ? Container()
                : SlideTransition(
                    position: _animation,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                        right: 40,
                        top: 30,
                      ),
                      child: Text(
                        "Psst! You can always switch to the other mode in the side bar menu!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xB31D3853),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
