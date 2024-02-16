import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/help_and_support/widgets/support_button.dart';
import 'package:command_centre/mobile_dashboard/views/help_and_support/widgets/feedback_screen.dart';

class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({super.key});

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
          'Help & Support',
          style: GoogleFonts.ptSansCaption(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: 2,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 6,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, i) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.sfPrimary.withOpacity(.3),
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(.05),
                      blurRadius: .5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.primary.withOpacity(.12),
                          ),
                          child: Center(
                              child: Icon(
                                  i == 1 ? Icons.mail_rounded : Icons.call,
                                  color: AppColors.primary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      i == 1 ? 'Mail Us' : 'Call Us',
                      style: GoogleFonts.ptSansCaption(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Talk to our executive',
                      style: GoogleFonts.ptSansCaption(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyTextColor,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          cardWidget(onTap: () => Get.to(const FeedbackScreen())),
          cardWidget(
            icon: Icons.bug_report_rounded,
            title: 'Report a bug',
            subtitle: 'Tell us what is the issue      ',
          ),
          // const SizedBox(height: 50),
          // Image.asset(
          //   PngFiles.pgLogo,
          //   height: 90,
          //   width: 90,
          // ),
          // const SizedBox(height: 30),
          // SupportButton(
          //   icon: Icons.email_outlined,
          //   title: 'Email',
          //   color: Colors.blue,
          //   info: 'dv.nb@pg.com',
          //   onTap: () {},
          // ),
          // const SizedBox(height: 12),
          // SupportButton(
          //   icon: Icons.phone,
          //   title: 'Phone',
          //   color: Colors.green,
          //   info: '91-22-2826-6000',
          //   onTap: () {},
          // ),
          // const SizedBox(height: 12),
          // SupportButton(
          //   icon: Icons.pin_drop_rounded,
          //   title: 'Address',
          //   color: Colors.red,
          //   info:
          //       'India P&G plaza, Cardinal Gracias Road, Chakala,Andheri (E), Mumbai - 400099 India',
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget cardWidget(
      {void Function()? onTap,
      IconData? icon,
      String? title,
      String? subtitle}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.sfPrimary.withOpacity(.3),
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(.05),
              blurRadius: .5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.primary.withOpacity(.12),
            ),
            child: Center(
                child: Icon(icon ?? Icons.insert_comment_rounded,
                    color: AppColors.primary)),
          ),
          title: Center(
            child: Text(
              title ?? 'Feedback      ',
              style: GoogleFonts.ptSansCaption(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          subtitle: Center(
            child: Text(
              'Tell us what you think of our App      ',
              style: GoogleFonts.ptSansCaption(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.greyTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
