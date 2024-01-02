import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/style/text_style.dart';

class DropDownWidget extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;
  final String title;
  final List<DropdownMenuItem<String>>? dropDownItem;
  final int secondIndex;

  const DropDownWidget(
      {Key? key,
      required this.selectedValue,
      required this.onChanged,
      required this.title,
      required this.dropDownItem,
      required this.secondIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: MyColors.textSubTitleColor,
            letterSpacing: 1,
            fontFamily: fontFamily,
          ),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.grayBorder)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 5,
          ),
        ),
        child: SizedBox(
          height: 60,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: selectedValue,
                style: const TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    color: MyColors.textColor),
                items: dropDownItem,
                onChanged: onChanged,
                hint: const Text("Select.."),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
