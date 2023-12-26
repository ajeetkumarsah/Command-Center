import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../style/text_style.dart';

class DivisionDropDown extends StatelessWidget {
  final Function() onTap;
  final Function() onTapMonth;
  final String division;
  final String state;
  final String month;

  const DivisionDropDown(
      {Key? key, required this.onTap, required this.onTapMonth, required this.division, required this.state, required this.month})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    color: const Color(0xE6EFF3F7),
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                        width: 0.1, color: MyColors.whiteColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          division=='allIndia'?'All India':division,
                          style: ThemeText.monthText,
                        ),
                        const SizedBox(width: 10,),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        width: 0.5,
                        color: MyColors.whiteColor,
                      ),
                    ),
                    Text(
                      state=='allIndia'?'All India':state,
                      style: ThemeText.monthText,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: onTapMonth,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  color: const Color(0xE6EFF3F7),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                      width: 0.1, color: MyColors.whiteColor)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      month,
                      style: ThemeText.monthText,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
