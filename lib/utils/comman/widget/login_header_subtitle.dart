import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../style/text_style.dart';

class LoginHeaderSubtitle extends StatelessWidget {
  final String subtitle;

  const LoginHeaderSubtitle({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: const TextStyle(
          color: MyColors.deselectGray,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily),
    );
  }
}
