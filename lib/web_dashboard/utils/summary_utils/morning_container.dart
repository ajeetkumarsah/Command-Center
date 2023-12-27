import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';
import '../../../utils/style/text_style.dart';

class MorningContainer extends StatelessWidget {
  const MorningContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8, bottom: 20),
      child: Container(
        height: 64,
        width: size.width,
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          border: Border.all(width: 0.4, color: MyColors.deselectColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello',
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: fontFamily),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    SharedPreferencesUtils.getString('userName') ?? 'Demo',
                    style: const TextStyle(
                        color: MyColors.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontFamily),
                  ),
                ],
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyColors.deselectColor,

                    // border: Border.all(width: 0.4, color: MyColors.deselectColor),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: MyColors.whiteColor,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
