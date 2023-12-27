import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../style/text_style.dart';

class PesonalizedSheet extends StatelessWidget {
  final bool switchValue;
  final Function(bool)? onChanged;

  const PesonalizedSheet(
      {Key? key,
        required this.switchValue,
        this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listActive = [
      "Retailing",
      "Coverage",
      "Golden Points",
      "Focus Brand"
    ];
    return const Padding(
      padding: EdgeInsets.only(top: 30, bottom: 40, left: 15, right: 15),
      child: Column(
        children: [
          Text(
            'Personalize',
            style: TextStyle(
                fontSize: 22,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
                color: MyColors.textHeaderColor),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 40),
            child: Text(
              'What you’d like to see on your main screen?',
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: MyColors.textSubHeaderColor),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Included Metrics',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w400,
                  color: MyColors.textHeaderColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 30, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'More Metrics',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                    color: MyColors.textHeaderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}