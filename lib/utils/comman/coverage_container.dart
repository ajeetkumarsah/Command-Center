import 'package:command_centre/utils/comman/header_title.dart';
import 'package:flutter/material.dart';

import '../../activities/coverage_screen.dart';
import '../colors/colors.dart';
import '../style/text_style.dart';

class CoverageContainer extends StatelessWidget {
  final String cmCoverage;
  final String billingPercentage;
  final String title;
  final List itemCount;
  final List divisionCount;
  final List siteCount;
  final List branchCount;
  final List channelCount;

  const CoverageContainer(
      {Key? key,
      required this.cmCoverage,
      required this.billingPercentage,
      required this.title, required this.divisionCount, required this.siteCount, required this.branchCount, required this.itemCount, required this.channelCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CoverageScreen(itemCount: itemCount, divisionCount: divisionCount, siteCount: siteCount, branchCount: branchCount, channelCount: channelCount,)));
              },
              title: '$title - ',
              subTitle: 'CM',
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title (in MM)",
                        style: ThemeText.coverageText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        cmCoverage,
                        style: ThemeText.coverageDataText,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PXM $title%",
                        style: ThemeText.coverageText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        billingPercentage,
                        style: ThemeText.coverageDataText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
