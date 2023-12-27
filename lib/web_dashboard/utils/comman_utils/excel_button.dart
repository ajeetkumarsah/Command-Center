import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/style/text_style.dart';

class ExcelImportButton extends StatelessWidget {
  final Function() onClickExcel;
  const ExcelImportButton({super.key, required this.onClickExcel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 20, bottom: 40, top: 0),
      child: SizedBox(
        height: 45,
        width: 200,
        child: OutlinedButton(
          onPressed: onClickExcel,
          style: ButtonStyle(
            side: MaterialStateProperty.all(const BorderSide(
                color: MyColors.toggletextColor,
                width: 1.0,
                style: BorderStyle.solid)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Export to Excel",
                style: TextStyle(
                    color: MyColors.toggletextColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamily),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: MyColors.toggletextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
