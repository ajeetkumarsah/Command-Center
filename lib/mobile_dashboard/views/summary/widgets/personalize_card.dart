import 'dart:math';
import 'package:text_3d/text_3d.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/data_not_found_widget.dart';

class PersonalizeCard extends StatelessWidget {
  final String title;
  final bool? isDataFound;
  final void Function()? onPressedShowMore;
  final List<Widget> children;
  final Widget? secondWidget;
  final double top;
  final double bottomInside;
  final String secondTitle;
  final Widget? trailing;
  final bool showMore;
  final Key? showKey;
  const PersonalizeCard({
    super.key,
    this.showKey,
    this.bottomInside = 24,
    this.isDataFound,
    required this.children,
    this.onPressedShowMore,
    this.secondTitle = 'CM',
    required this.title,
    this.trailing,
    this.secondWidget,
    this.showMore = true,
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
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.contentColorCyan.withOpacity(.8),
                  AppColors.contentColorBlue.withOpacity(.8),
                  // AppColors.contentColorCyan.withOpacity(.6),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
              title: secondWidget ??
                  ThreeDText(
                    text: '$title ',
                    textStyle: GoogleFonts.ptSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    depth: 2,
                    style: ThreeDStyle.inset,
                    angle: pi / 6,
                    perspectiveDepth: 10,
                  ),
              // Text(
              //   '$title ',
              //   style: GoogleFonts.ptSans(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //     color: AppColors.white,
              //   ),
              // ),
              subtitle: isDataFound ?? true ? null : const DataNotFoundWidget(),
              trailing: trailing,
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.borderColor,
          ),
          ...children.map((v) => v).toList(),
          SizedBox(height: bottomInside),
          // if (showMore)
          //   Container(
          //     height: .5,
          //     width: double.infinity,
          //     color: AppColors.borderColor,
          //   ),
          if (showMore)
            GestureDetector(
              onTap: isDataFound ?? true ? onPressedShowMore : null,
              child: Container(
                key: showKey,
                // height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  // gradient: isDataFound ?? true
                  //     ? const LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [
                  //           AppColors.contentColorCyan,
                  //           AppColors.contentColorBlue,
                  //         ],
                  //       )
                  //     : null,
                  border: Border.all(
                    width: .5,
                    color: AppColors.primary,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show more ',
                      style: GoogleFonts.ptSans(
                        color: isDataFound ?? true
                            ? AppColors.primary
                            : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_outward_rounded,
                      color:
                          isDataFound ?? true ? AppColors.primary : Colors.grey,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
