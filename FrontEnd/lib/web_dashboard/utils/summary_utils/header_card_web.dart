import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../activities/retailing_screen.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/const/const_array.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../../../utils/style/text_style.dart';

class HeaderWebCard extends StatelessWidget {
  final Function() onPressed;
  final Function() onTapTitle;
  final Function() onTitle;
  final String elName;
  final String title;
  final String subTitle;
  final String dateTitle;
  final String subLabel;
  final String index;
  final double xAlign;
  final Function() onTap;
  final Function() onTapSign;
  final Function() onDateSelected;
  final Color loginColor;
  final Color signInColor;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final bool isHovering;

  const HeaderWebCard({
    Key? key,
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
    required this.onEnter,
    required this.isHovering,
    required this.onExit,
    required this.onTapTitle,
    required this.onTitle,
    required this.onDateSelected,
    required this.elName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: onTapTitle,
                child: MouseRegion(
                  onEnter: onEnter,
                  onExit: onExit,
                  cursor: SystemMouseCursors.click,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: isHovering ? 0.5 : 0,
                                color: isHovering
                                    ? MyColors.toggletextColor
                                    : MyColors.transparent),
                          ),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isHovering
                                ? MyColors.toggletextColor
                                : MyColors.textHeaderColor,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyColors.textColor),
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: MyColors.textSubTitleColor,
                  fontFamily: fontFamily,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onPressed,
                child: Row(
                  children: [
                    Text(
                      'Location',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: MyColors.textSubTitleColor,
                        fontFamily: fontFamily,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.edit,
                      color: MyColors.toggletextColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        index == "Retailing"
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5, right: 15),
                child: Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 160,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          border: Border.all(width: 1, color: Colors.black12),
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              alignment: Alignment(xAlign, 0),
                              duration: const Duration(milliseconds: 300),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  width: width * 0.65,
                                  height: height,
                                  decoration: const BoxDecoration(
                                    color: MyColors.primary,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: onTap,
                              child: Align(
                                alignment: const Alignment(-1, 0),
                                child: Container(
                                  width: width * 0.7,
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sales Value',
                                    style: TextStyle(
                                        color: loginColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: onTapSign,
                              child: Align(
                                alignment: const Alignment(1, 0),
                                child: Container(
                                  width: width * 0.65,
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'IYA',
                                    style: TextStyle(
                                        color: signInColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // InkWell(
                    //   onTap: onDateSelected,
                    //   child: Row(
                    //
                    //     children: [
                    //       Text(
                    //         'Month',
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 16,
                    //           color: MyColors.textSubTitleColor,
                    //           fontFamily: fontFamily,
                    //         ),
                    //       ),
                    //       SizedBox(width: 4,),
                    //       const Icon(
                    //         Icons.edit,
                    //         color: MyColors.toggletextColor,
                    //         size: 16,
                    //       ),
                    //     ],
                    //   ),
                    //   // Text(
                    //   //   elName == "Retailing"? date:elName == "Coverage"? date1: dateTitle,
                    //   //   style: const TextStyle(
                    //   //     fontWeight: FontWeight.w400,
                    //   //     fontSize: 16,
                    //   //     color: MyColors.textSubTitleColor,
                    //   //     fontFamily: fontFamily,
                    //   //   ),
                    //   // ),
                    // ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 0, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      subLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: MyColors.textSubTitleColor,
                        fontFamily: fontFamily,
                      ),
                    ),
                    const Spacer(),
                    // InkWell(
                    //   onTap: onDateSelected,
                    //   child:Row(
                    //
                    //     children: [
                    //       Text(
                    //         'Month',
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 16,
                    //           color: MyColors.textSubTitleColor,
                    //           fontFamily: fontFamily,
                    //         ),
                    //       ),
                    //       SizedBox(width: 4,),
                    //       const Icon(
                    //         Icons.edit,
                    //         color: MyColors.toggletextColor,
                    //         size: 16,
                    //       ),
                    //     ],
                    //   ),
                    //   // Text(
                    //   //   elName == "Coverage"? date1:elName == "Focus Brand"? date2:elName == "Golden points"? date3:elName == "Productivity"? date4:elName == "Call Compliance"? date5: dateTitle,
                    //   //   style: const TextStyle(
                    //   //     fontWeight: FontWeight.w400,
                    //   //     fontSize: 16,
                    //   //     color: MyColors.textSubTitleColor,
                    //   //     fontFamily: fontFamily,
                    //   //   ),
                    //   // ),
                    // ),
                  ],
                ),
              ),
        Container(
          height: 1,
          color: MyColors.dividerColor,
        ),
      ],
    );
  }
}
