import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class BackButtonTable extends StatelessWidget {
  final Function() onTap;

  const BackButtonTable({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        color: MyColors.transparent,
        border: Border.all(width: 1, color: MyColors.whiteColor),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 35,
            color: MyColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
