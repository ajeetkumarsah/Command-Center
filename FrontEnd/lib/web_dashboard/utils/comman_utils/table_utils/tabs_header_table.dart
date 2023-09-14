import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/style/text_style.dart';

class TabsHeaderTable extends StatelessWidget {
  final Function() onTap;
  final Function() onTabClick;
  final ScrollController scrollController1;
  final List arrayRetailing;
  final int selectedIndex;
  const TabsHeaderTable({super.key, required this.onTap, required this.scrollController1, required this.arrayRetailing, required this.selectedIndex, required this.onTabClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20, left: 10, right: 10, bottom: 20),
      child: Row(
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(
              color: MyColors.transparent,
              border: Border.all(
                  width: 1, color: MyColors.whiteColor),
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: InkWell(
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 35,
                  color: MyColors.whiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Scrollbar(
              controller: scrollController1,
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                    controller: scrollController1,
                    itemCount: arrayRetailing.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: onTabClick,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                          ),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? MyColors.whiteColor
                                  : MyColors.transparent,
                              border: Border.all(
                                  width: 1,
                                  color: MyColors.whiteColor),
                              borderRadius:
                              BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0),
                              child: Center(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        arrayRetailing[index],
                                        textAlign: TextAlign
                                            .center,
                                        style: TextStyle(
                                            color: selectedIndex ==
                                                index
                                                ? MyColors
                                                .toggletextColor
                                                : MyColors
                                                .whiteColor,
                                            fontWeight:
                                            selectedIndex ==
                                                index
                                                ? FontWeight
                                                .bold
                                                : FontWeight
                                                .w400,
                                            fontFamily: fontFamily),
                                      ))),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
