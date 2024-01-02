import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title ;
  const HeaderText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 20, bottom: 15),
      child: Text(
        title,
        style: ThemeText.headerTitleText,
      ),
    );
  }
}
