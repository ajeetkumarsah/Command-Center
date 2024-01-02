import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class GPContainer extends StatelessWidget {
  final String title;
  const GPContainer({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width-300, child: Center(child: Text(title, style: TextStyle(fontSize: 20, fontFamily: fontFamily),),));
  }
}