import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:flutter/material.dart';

import '../../../activities/select_profile_screen.dart';
import '../../colors/colors.dart';
import '../../style/text_style.dart';

class DrawerSheet extends StatelessWidget {
  final Function() onTapBO;
  final Function() onTapMV;
  final Color colorBO;
  final Color colorMV;

  const DrawerSheet(
      {Key? key,
      required this.onTapBO,
      required this.onTapMV,
      required this.colorBO,
      required this.colorMV})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const SelectProfile()));
            },
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Account (${SharedPreferencesUtils.getString("selectedProfile")})',
                        style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            color: MyColors.textHeaderColor),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_outward_outlined,
                        color: MyColors.showMoreColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   'Switch Mode',
                    //   style: TextStyle(
                    //       fontFamily: fontFamily,
                    //       fontSize: 16,
                    //       color: MyColors.textHeaderColor),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'To organize the data for you according to your',
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          color: MyColors.grey),
                    ),
                    const SizedBox(height: 3,),
                    const Text(
                      'purpose today',
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          color: MyColors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: onTapBO,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorBO,
                                  border: Border.all(
                                      width: 1, color: MyColors.toggletextColor),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              height: 56,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Business Overview',
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontFamily),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: onTapMV,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorMV,
                                  border: Border.all(
                                      width: 1, color: MyColors.toggletextColor),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              height: 56,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Market Visit',
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColors.textHeaderColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: fontFamily),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Abbreviations',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColors.textHeaderColor),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_outward_outlined,
                        color: MyColors.showMoreColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Definitions',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColors.textHeaderColor),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_outward_outlined,
                        color: MyColors.showMoreColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 80,)
        ],
      ),
    );
  }
}
