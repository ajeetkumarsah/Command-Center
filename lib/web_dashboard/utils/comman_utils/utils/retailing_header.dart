import 'package:flutter/material.dart';

import '../../../../activities/retailing_screen.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/style/text_style.dart';

class RetailingHeader extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subTitle;
  final String dateTitle;
  final String subLabel;
  final String index;
  final double xAlign;
  final Function() onTap;
  final Function() onTapSign;
  final Color loginColor;
  final Color signInColor;
  final bool itemVisibilityList;

  const RetailingHeader(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.subTitle,
      required this.dateTitle,
      required this.subLabel,
      required this.index,
      required this.xAlign,
      required this.onTap,
      required this.onTapSign,
      required this.loginColor,
      required this.signInColor,
      required this.itemVisibilityList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: ThemeText.titleText,
              ),
              const Spacer(),
              InkWell(
                onTap: onPressed,
                child: const Icon(
                  Icons.edit,
                  color: MyColors.toggletextColor,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 7),
          child: Text(
            dateTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: MyColors.textSubTitleColor,
              fontFamily: fontFamily,
            ),
          ),
        ),
        Container(
          height: 1,
          color: MyColors.dividerColor,
        ),
        // MouseRegion(
        //   cursor: SystemMouseCursors.click,
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Padding(
        //       padding:
        //           const EdgeInsets.only(left: 8.0, bottom: 5, right: 15, top: 10),
        //       child: Container(
        //           width: 200,
        //           height: 25,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: const BorderRadius.all(
        //               Radius.circular(50.0),
        //             ),
        //             border: Border.all(width: 1, color: Colors.black12),
        //           ),
        //           child: GestureDetector(
        //             onTap: onTap,
        //             child: Stack(
        //               children: [
        //                 AnimatedAlign(
        //                   alignment:
        //                       Alignment(itemVisibilityList ? 1.0 : -1.0, 0),
        //                   duration: const Duration(milliseconds: 300),
        //                   child: Container(
        //                     width: 100,
        //                     height: 30,
        //                     decoration: BoxDecoration(
        //                       color: Colors.blue,
        //                       borderRadius: BorderRadius.circular(50.0),
        //                     ),
        //                   ),
        //                 ),
        //                 Align(
        //                   alignment: const Alignment(-1, 0),
        //                   child: Container(
        //                     // width: 200,
        //                     color: Colors.transparent,
        //                     alignment: Alignment.centerLeft,
        //                     child: Padding(
        //                       padding: const EdgeInsets.only(left: 20),
        //                       child: Text(
        //                         'Sales Value',
        //                         style: TextStyle(
        //                           color: itemVisibilityList == true
        //                               ? MyColors.textColor
        //                               : Colors.white,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 12,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 Align(
        //                   alignment: const Alignment(1, 0),
        //                   child: Container(
        //                     // width: 200,
        //                     color: Colors.transparent,
        //                     alignment: Alignment.centerRight,
        //                     child: Padding(
        //                       padding: const EdgeInsets.only(right: 40),
        //                       child: Text(
        //                         'IYA',
        //                         style: TextStyle(
        //                           color: itemVisibilityList == true
        //                               ? MyColors.whiteColor
        //                               : MyColors.textColor,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 12,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           )),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
