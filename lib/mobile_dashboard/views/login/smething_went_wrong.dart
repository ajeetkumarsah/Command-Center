import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/global.dart' as globals;
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';

class SomethingWentWrong extends StatefulWidget {
  const SomethingWentWrong({super.key});

  @override
  State<SomethingWentWrong> createState() => _SomethingWentWrongState();
}

class _SomethingWentWrongState extends State<SomethingWentWrong> {
  void initCall() {
    globals.navigate = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(authRepo: Get.find()),
      initState: (_) {},
      builder: (ctlr) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/json/went_wrong.json',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .45,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Something went wrong! ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSansCaption(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initCall();
                      ctlr.logout();
                    },
                    child: Container(
                      // height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.primary,
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .2),
                      child: Text(
                        'Retry',
                        style: GoogleFonts.ptSansCaption(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
