import 'package:flutter/material.dart';

import '../../style/text_style.dart';
import 'package:command_centre/helper/global/global.dart' as globals;

class HeaderContainer extends StatelessWidget {
  final Function() onTap;
  const HeaderContainer({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Hello, ',
                    style: ThemeText.helloText,
                  ),
                  TextSpan(text: globals.fullName, style: ThemeText.nameText),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              "Here's your MTD summary",
              style: ThemeText.normalText,
            )
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              // border: Border.all(
              //   color: Colors.white,
              //   style: BorderStyle.solid,
              //   width: 1.5,
              // ),
              // color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Image.asset("assets/images/app_bar/artwork.png"),
            ),
          ),
        ),
      ],
    );
  }
}
