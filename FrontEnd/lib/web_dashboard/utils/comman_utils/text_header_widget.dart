import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';

class TextHeaderWidget extends StatelessWidget {
  final String title;
  final TextAlign align;

  const TextHeaderWidget({super.key, required this.title, required this.align});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        // color: MyColors.deselectColor,
        child: Text(
          title,
          textAlign: align,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: fontFamily
          ),
        ));
  }
}

class TextHeaderWidgetWithIcon extends StatelessWidget {
  final String title;
  final TextAlign align;
  final bool isRequired;
  final bool isExpanded;

  const TextHeaderWidgetWithIcon({super.key, required this.title, required this.align, required this.isRequired, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        // color: MyColors.deselectColor,
        child: Row(
          children: [
            isRequired==true?Container():
            Container(height: 15,width: 15, decoration: BoxDecoration(color: MyColors.primary, borderRadius: BorderRadius.circular(5)), child: Icon(isExpanded == true?Icons.remove_sharp: Icons.add, size: 12,color: MyColors.whiteColor,)),
            const SizedBox(width: 10,),
            Expanded(
              child: Text(
                title,
                textAlign: align,
                maxLines: 2,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: fontFamily
                ),
              ),
            ),
          ],
        ));
  }
}
