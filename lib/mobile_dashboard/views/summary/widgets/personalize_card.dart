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
  const PersonalizeCard({
    super.key,
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
          ListTile(
            title: secondWidget ??
                Text(
                  '$title ',
                  style: GoogleFonts.ptSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            subtitle: isDataFound ?? true ? null : const DataNotFoundWidget(),
            trailing: trailing,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.borderColor,
          ),
          ...children.map((v) => v).toList(),
          SizedBox(height: bottomInside),
          if (showMore)
            Container(
              height: .5,
              width: double.infinity,
              color: AppColors.borderColor,
            ),
          if (showMore)
            GestureDetector(
              onTap: isDataFound ?? true ? onPressedShowMore : null,
              child: Container(
                // height: 1,
                width: double.infinity,
                color: AppColors.white,
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show more ',
                      style: GoogleFonts.ptSans(
                        color: isDataFound ?? true
                            ? AppColors.primary
                            : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
