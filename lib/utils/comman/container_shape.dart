import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../activities/retailing_screen.dart';
import '../style/text_style.dart';
import 'header_title.dart';

class ContainerShape extends StatelessWidget {
  final String cmIya;
  final String cmSalience;
  final String cmSellout;
  final int tgtiya;
  final int tgtSalience;
  final int tgtSellout;
  const ContainerShape({Key? key, required this.cmIya, required this.cmSalience, required this.cmSellout, required this.tgtiya, required this.tgtSalience, required this.tgtSellout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        width: size.width,
        margin: const EdgeInsets.only(bottom: 20.0, top: 0),
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
            HeaderTitle(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RetailingScreen()));
            },title: 'Retailing - ', subTitle: 'CM',),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "IYA",
                        style: ThemeText.coverageText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$cmIya",
                        style: ThemeText.subTitleText,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Salience%",
                        style: ThemeText.coverageText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$cmSalience",
                        style: ThemeText.subTitleText,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sellout (in Cr)",
                        style: ThemeText.coverageText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$cmSellout",
                        style: ThemeText.subTitleText,
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15, right: 15, top: 15, bottom: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             "Tgt IYA",
            //             style: ThemeText.coverageText,
            //           ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           Text(
            //             "$tgtiya",
            //             style: ThemeText.subHeadTitleText,
            //           ),
            //         ],
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             "Tgt Sal%",
            //             style: ThemeText.coverageText,
            //           ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           Text(
            //             "$tgtSalience",
            //             style: ThemeText.subHeadTitleText,
            //           ),
            //         ],
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             "Tgt Sellout",
            //             style: ThemeText.coverageText,
            //           ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           Text(
            //             "$tgtSellout",
            //             style: ThemeText.subHeadTitleText,
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
