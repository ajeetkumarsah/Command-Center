import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class GetStaredIntroWidget extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;

  const GetStaredIntroWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        // Text(
        //   title,
        //   maxLines: 2,
        //   style: TextStyle(
        //       color: color,
        //       fontFamily: fontFamily,
        //
        //       fontWeight: FontWeight.w500),
        // )
      ],
    );
  }
}
