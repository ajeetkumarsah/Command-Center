import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class PersonalizeCard extends StatelessWidget {
  final String title;
  final void Function()? onPressedShowMore;
  final List<Widget> children;
  final double top;
  final double bottomInside;
  final String secondTitle;
  const PersonalizeCard({
    super.key,
    this.bottomInside = 24,
    required this.children,
    this.onPressedShowMore,
    this.secondTitle = 'CM',
    required this.title,
    this.top = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      margin: EdgeInsets.only(top: top, bottom: 12, left: 12, right: 12),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '$title ',
              style: GoogleFonts.ptSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            // ),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(
            //         text: '$title ',
            //         style: GoogleFonts.ptSans(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            // WidgetSpan(
            //   child: Container(
            //     margin:
            //         const EdgeInsets.only(bottom: 6, left: 4, right: 4),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       color: AppColors.black,
            //     ),
            //     height: 8,
            //     width: 8,
            //   ),
            // ),
            // TextSpan(
            //   text: ' $secondTitle',
            //   style: GoogleFonts.ptSans(
            //     fontSize: 17,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            //     ],
            //   ),
            // ),
            trailing: TextButton(
              onPressed: onPressedShowMore,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Show more',
                    style: GoogleFonts.ptSans(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_outward_rounded,
                    color: AppColors.primary,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.borderColor,
          ),
          ...children.map((v) => v).toList(),
          SizedBox(height: bottomInside),
        ],
      ),
    );
  }
}
