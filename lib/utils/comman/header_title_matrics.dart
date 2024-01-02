import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../style/text_style.dart';

class HeaderTitleMetrics extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final IconData icon;

  const HeaderTitleMetrics(
      {Key? key, required this.onPressed, required this.title, required this.icon})
      : super(key: key);

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
              Text(
                title,
                style: ThemeText.titleText,
              ),
              const Spacer(),
              InkWell(
                onTap: onPressed,
                child: Icon(
                  icon,
                  color: MyColors.toggletextColor,
                  size: 18,
                ),
              ),
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
