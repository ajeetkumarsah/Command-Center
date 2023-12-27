import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/style/text_style.dart';
import '../coverage_month.dart';

class MonthPositionTable extends StatelessWidget {
  final bool visible;
  final Function() onApplyPressedMonth;
  final Function() onTap;
  const MonthPositionTable({super.key, required this.visible, required this.onApplyPressedMonth, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 30,
      child: Visibility(
        visible: visible,
        child: Container(
            height: 220,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 12,
                  color:
                  Color.fromRGBO(0, 0, 0, 0.16),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  height: 36,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: MyColors.sheetDivider),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Select Month',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w400,
                              color: MyColors
                                  .textHeaderColor),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: onTap,
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0),
                    child: CoverageMonthWebSheet(
                      elName: '',
                      onApplyPressed:
                      onApplyPressedMonth,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
