import 'package:flutter/material.dart';

import '../../../../../helper/http_call.dart';
import '../../../../../utils/colors/colors.dart';
import '../../../../../utils/style/text_style.dart';
import '../../../../select_division_screen.dart';

class TitleWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final bool showHide;
  final bool showHideRetailing;
  final Function() onPressed;
  final Function() onNewMonth;
  final Function() onTapDefaultGoe;

  const TitleWidget({Key? key, required this.title, required this.subTitle, required this.showHide, required this.onPressed, required this.onNewMonth, required this.showHideRetailing, required this.onTapDefaultGoe}) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.transparent,
      width: MediaQuery.of(context).size.width - 280,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      color: MyColors.grayBorder,
                      fontSize: 14,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 0),
                child: Text(
                  widget.subTitle,
                  style: const TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 30,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
              ),
            ],
          ),
          const Spacer(),
          widget.showHide == true? Padding(
            padding: const EdgeInsets.only(right: 80, top: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: widget.onNewMonth,
                    //     (){
                    //   String selectedmonth = 'Jul';
                    //   print(selectedmonth);
                    //   fetchRetailingWeb(context,selectedmonth);
                    //   setState(() {
                    //
                    //   });
                    // },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(
                              width: 1.0, color: MyColors.whiteColor)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5.0))),
                    ),
                    child: const Text(
                      "Change Default Month",
                      style: TextStyle(
                          fontFamily: fontFamily, color: MyColors.whiteColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox (
                  height: 40,
                  child: OutlinedButton(
                    onPressed: widget.onTapDefaultGoe,
                    //     (){
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) =>
                    //       const SelectDivisionScreen(initInitial: true,)));
                    // },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(
                              width: 1.0, color: MyColors.whiteColor)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5.0))),
                    ),
                    child: const Text(
                      "Change Default Geo",
                      style: TextStyle(
                          fontFamily: fontFamily, color: MyColors.whiteColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox (
                  height: 40,
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/profilescreen');
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(
                              width: 1.0, color: MyColors.whiteColor)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5.0))),
                    ),
                    child: const Text(
                      "Change Profile",
                      style: TextStyle(
                          fontFamily: fontFamily, color: MyColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ):Container(),

        ],
      ),
    );
  }
}
