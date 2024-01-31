import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/help_and_support/widgets/support_button.dart';

class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Help & Support',
          style: GoogleFonts.ptSans(),
        ),
      ),
      body: Column(
        children: [
          SupportButton(
            icon: Icons.email_outlined,
            title: 'Email',
            color: Colors.blue,
            // : index == 1
            //     ? Colors.red
            //     : Colors.green,
            info: 'info@pg.com',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
