import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../style/text_style.dart';

class HeaderTitle extends StatelessWidget {
   final Function() onPressed;
   final String title;
   final String subTitle;
  const HeaderTitle({Key? key, required this.onPressed, required this.title, required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: ThemeText.titleText,
                  ),

                  TextSpan(text: subTitle, style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: MyColors.textSubTitleColor,
                    fontFamily: fontFamily,
                  )),
                ],
              ),
            ),
          ),
          //  Padding(
          //   padding: const EdgeInsets.only(left: 15, top: 15),
          //   child: Text(
          //     title,
          //     style: ThemeText.titleText,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 1.0, right: 10),
            child: TextButton(
              onPressed: onPressed,
              child: const Row(
                children: [
                  Text(
                    "Show more",
                    style: ThemeText.showMoreText,
                  ),
                  Icon(
                    Icons.arrow_outward_outlined,
                    color: MyColors.toggletextColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      Container(
        height: 1,
        color: MyColors.dividerColor,
      ),
    ],);
  }
}
