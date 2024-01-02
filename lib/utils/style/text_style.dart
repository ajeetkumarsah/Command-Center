import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

const fontFamily = 'Product Sans';

abstract class ThemeText {
  static const TextStyle sheetText = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Color(0xff344C65));

  static const TextStyle sheetCancelText =
      TextStyle(fontFamily: fontFamily, color: Color(0xff778898), fontSize: 16);

  static const TextStyle sheetallFilterText =
      TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, color: MyColors.showMoreColor, fontSize: 16);

  static const TextStyle appBarTitleText = TextStyle(
      fontFamily: fontFamily,
      color: MyColors.whiteColor,
      fontWeight: FontWeight.bold,
      fontSize: 22);

  static const TextStyle divisionText = TextStyle(
    fontSize: 18,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle headerTitleText = TextStyle(
    fontSize: 16,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  // static const TextStyle tableHeaderText = TextStyle(
  //   fontSize: 12,
  //   fontFamily: fontFamily,
  // );

  static const TextStyle categoryHeaderText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: MyColors.textColor
  );

  static const TextStyle sellectAllText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static const TextStyle categoryText = TextStyle(
    fontSize: 12,
    color: Color(0xff576DFF),
    fontFamily: fontFamily,
  );

  static const TextStyle searchText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Color(0xff344C65),
    fontFamily: fontFamily,
  );

  static const TextStyle datapointText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const TextStyle titleText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: MyColors.textHeaderColor,
    fontFamily: fontFamily,
  );

  static const TextStyle showMoreText = TextStyle(
    fontSize: 14,
    color: MyColors.toggletextColor,
    fontFamily: fontFamily,
  );

  static const TextStyle coverageText = TextStyle(
    fontSize: 16,
    color: MyColors.textSubHeaderColor,
    fontFamily: fontFamily,
  );

  static const TextStyle coverageDataText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 40,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle monthText = TextStyle(
    fontSize: 16,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle helloText =
      TextStyle(fontSize: 22, color: Colors.white, fontFamily: fontFamily);

  static const TextStyle nameText = TextStyle(
    fontSize: 22,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static const TextStyle normalText = TextStyle(
    fontSize: 16,
    color: Colors.white60,
    fontFamily: fontFamily,
  );

  static const TextStyle cicularText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 40,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle achText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle subHeadText = TextStyle(
    fontSize: 16,
    color: MyColors.headTextColor,
    fontFamily: fontFamily,
  );

  static const TextStyle subHeadTitleText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle subTitleText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 40,
    color: MyColors.textColor,
    fontFamily: fontFamily,
  );

  static const TextStyle searchHintText = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
  );

  static const TextStyle tableTextText = TextStyle(fontFamily: fontFamily, color: MyColors.textColor);
  static const TextStyle tableHeaderText = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
      color: MyColors.deselectGray
  );
}
