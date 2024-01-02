import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../activities/dgpcompliance_screen.dart';
import '../colors/colors.dart';
import '../style/text_style.dart';
import 'header_title.dart';

class CircularContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String perTitle;
  final String salience;
  final String sellout;
  final String dgpCom;
  final String actual;
  final String opportunity;

  final Function() onTap;

  const CircularContainer(
      {Key? key,
      required this.title,
      required this.perTitle,
      required this.salience,
      required this.sellout,
      required this.onTap,
      required this.dgpCom,
      required this.actual,
      required this.opportunity,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = dgpCom.replaceAll("%", "");
    final intResult = double.parse(result) /1000;
    double doubleVar = intResult.toDouble();
    final size = MediaQuery.of(context).size;
    // print("Hello $doubleVar");
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        width: size.width,
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xffE1E7EC),
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            HeaderTitle(
              onPressed: onTap,
              title: title,
              subTitle: subTitle,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 0, top: 0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          salience,
                          style: ThemeText.coverageText,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$actual",
                          style: ThemeText.cicularText,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          sellout,
                          style: ThemeText.coverageText,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          opportunity == "-1"?'':"$opportunity",
                          style: ThemeText.subHeadTitleText,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          perTitle,
                          style: ThemeText.coverageText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 10.0,
                          animation: true,
                          percent: doubleVar,
                          center: Text(
                            dgpCom,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: MyColors.textColor,
                              fontFamily: fontFamily,
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: MyColors.progressBack,
                          linearGradient: const LinearGradient(colors: [
                            MyColors.progressStart,
                            MyColors.progressEnd,
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
