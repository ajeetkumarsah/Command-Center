import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  final String title;
  final bool isLast;
  const TabItemWidget({super.key, required this.title, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.only(right: 20),
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color(0xffC5C5C5),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
      child: Tab(
        child: Text(title),
      ),
    );
  }
}
