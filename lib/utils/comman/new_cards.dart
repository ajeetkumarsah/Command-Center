import 'package:flutter/material.dart';

import '../style/text_style.dart';
import 'header_title.dart';

class NewCardsForSales extends StatelessWidget {
  final String title;
  final String subTitle;
  const NewCardsForSales({super.key, required this.title, required this.subTitle});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(
              onPressed: () {},
              title: title,
              subTitle: '',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
              child: Text(
                subTitle,
                style: ThemeText.subTitleText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
