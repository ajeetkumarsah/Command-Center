import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class TitleWidgetCard extends StatelessWidget {
  final String title;

  const TitleWidgetCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
      child: Text(
        title,
        style: ThemeText.subTitleText,
      ),
    );
  }
}
