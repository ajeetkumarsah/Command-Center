import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/help_and_support/widgets/support_button.dart';

class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 20,
          ),
        ),
        title: Text(
          'Help & Support',
          style: GoogleFonts.ptSans(color: AppColors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Image.asset(
            PngFiles.pgLogo,
            height: 90,
            width: 90,
          ),
          const SizedBox(height: 30),
          SupportButton(
            icon: Icons.email_outlined,
            title: 'Email',
            color: Colors.blue,
            info: 'support@pg.com',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          SupportButton(
            icon: Icons.phone,
            title: 'Phone',
            color: Colors.green,
            info: '91-22-2826-6000',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          SupportButton(
            icon: Icons.pin_drop_rounded,
            title: 'Address',
            color: Colors.red,
            info:
                'India P&G plaza, Cardinal Gracias Road, Chakala,Andheri (E), Mumbai - 400099 India',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
