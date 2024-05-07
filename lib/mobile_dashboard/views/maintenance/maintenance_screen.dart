import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/json/maintenance.json',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .45,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Hang on! \nWe are under maintenance',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ptSansCaption(
                    fontSize: 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12),
            child: Text(
              'We apologise for any inconvenience caused. We\'ve almost done.',
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSansCaption(
                fontSize: 12,
                color: AppColors.primary.withOpacity(.7),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
