import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/style/text_style.dart';

class TableHeaderWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  const TableHeaderWidget({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 650,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                        fontSize:
                        20,
                        color: MyColors
                            .textColor,
                        fontWeight:
                        FontWeight
                            .bold,
                        fontFamily:
                        fontFamily),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Container(
              decoration:
              BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(
                    30.0),
                color: Colors
                    .red
                    .shade100,
              ),
              height: 40,
              width: 40,
              child:
              const Padding(
                padding:
                EdgeInsets
                    .all(
                    5.0),
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: Colors
                      .red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
