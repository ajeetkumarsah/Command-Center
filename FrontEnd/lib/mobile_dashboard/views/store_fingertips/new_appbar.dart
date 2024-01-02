import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class NewAppBar extends StatelessWidget {
  const NewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      // height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            PngFiles.newAppBar,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Shashi Medical and General Store',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.white,
              ),
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.white,
                  AppColors.white.withOpacity(.0),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    PngFiles.calendar,
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'CY 2022, November',
                    style: GoogleFonts.inter(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
