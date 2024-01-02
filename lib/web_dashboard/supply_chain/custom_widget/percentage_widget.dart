import 'package:flutter/material.dart';

import '../../../utils/style/text_style.dart';

class PercentageWid extends StatefulWidget {
  final String title;
  final String percentage;
  final bool check;

  const PercentageWid({
    super.key,
    required this.percentage,
    required this.check, this.title = '',
  });

  @override
  State<PercentageWid> createState() => _PercentageWidState();
}

class _PercentageWidState extends State<PercentageWid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != '')
              Text(
                widget.title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 12
                ),
              ),
              Row(
                children: [
                  Tooltip(
                    message: "Against last month",
                    child: Text(
                      '2%',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: widget.check
                              ? const Color(0xff00C108)
                              : const Color(0xffF10000),
                          fontFamily: fontFamily,
                          fontSize: 14),
                    ),
                  ),
                  Icon(
                   widget.check!
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up,
                    color: widget.check ? Colors.green : Colors.red,
                    size: 30,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
