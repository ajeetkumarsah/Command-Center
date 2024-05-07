import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/json/update.json',
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.height * .3,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'We\'re Better than Ever',
                  style: GoogleFonts.ptSansCaption(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
            child: Text(
              'The current version of the application is no longer supported. Please update the app.Update New Version',
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSansCaption(
                fontSize: 12,
                color: AppColors.lightGrey.withOpacity(.6),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            // height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.white,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .2),
            child: Text(
              'Update',
              style: GoogleFonts.ptSansCaption(
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
