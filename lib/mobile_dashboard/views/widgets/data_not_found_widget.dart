import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class DataNotFoundWidget extends StatelessWidget {
  const DataNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container(
        //     width: 8,
        //     height: 8,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(100),
        //       color: AppColors.contentColorYellow,
        //     ),
        //     margin: const EdgeInsets.only(right: 4),
        //     child:),
        const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.contentColorYellow,
          size: 18,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            'Data Not Found!',
            style: GoogleFonts.ptSans(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
