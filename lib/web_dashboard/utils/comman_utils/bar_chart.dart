import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final double width;
  final String title;
  final int categoryWiseNum;
  final int percentage;
  final bool change;
  final bool check;

  const BarChart(
      {Key? key,
      required this.width,
      required this.title,
      required this.categoryWiseNum,
      required this.percentage,
      required this.change,
      required this.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      child: Row(
        children: [
          Container(
              width: 120,
              child: Text(
                title,
                textAlign: TextAlign.left,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 125,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 16,
                      width: width + 10,
                      color: MyColors.barColor,
                    ),
                    SizedBox(width: 5,),
                    Text('$categoryWiseNum',),
                  ],
                ),
              ),
              change ?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: check ? MyColors.iconColorGreen : MyColors.iconColorRed,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  check ? Icon(Icons.arrow_drop_down, color: check ? MyColors.iconColorGreen : MyColors.iconColorRed,) : Icon(Icons.arrow_drop_up,color: check ? MyColors.iconColorGreen : MyColors.iconColorRed,),
                ],
              )
                  : SizedBox(),
            ],
          )


        ],
      ),
    );
  }
}
