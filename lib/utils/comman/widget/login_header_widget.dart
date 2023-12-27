import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../style/text_style.dart';

class LoginHeaderWidget extends StatelessWidget {
  final String title;

  const LoginHeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: MyColors.loginTitleColor,
          fontSize: 40,
          fontFamily: fontFamily),
    );
  }
}
