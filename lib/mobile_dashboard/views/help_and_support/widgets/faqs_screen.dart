import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 18,
          ),
        ),
        title: Text(
          'FAQs',
          style: GoogleFonts.ptSansCaption(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FAQ(
              question: "What is Total Retailing?",
              answer:
                  "Total Retailing comprises total retailing including Distributor as well as Non-Distributor Retailing.",
              ansStyle: GoogleFonts.ptSansCaption(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              queStyle: GoogleFonts.ptSansCaption(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              ansDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.white,
              ),
              queDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sfPrimary.withOpacity(.2),
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    blurRadius: .5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FAQ(
              question: "What is Distributor?",
              answer:
                  "Distributor comprises of only those Retailing which are done by distributors.",
              ansStyle: GoogleFonts.ptSansCaption(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              queStyle: GoogleFonts.ptSansCaption(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              ansDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.white,
              ),
              queDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sfPrimary.withOpacity(.2),
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    blurRadius: .5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
