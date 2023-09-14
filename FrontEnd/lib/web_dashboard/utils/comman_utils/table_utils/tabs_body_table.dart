import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class TabsBodyTable extends StatelessWidget {
  final Function() onTap;
  final Function() onTapGes;
  final Function() onClosedTap;
  final int selectedIndexLocation;
  final int outerIndex;
  final String title;
  const TabsBodyTable({super.key, required this.onTap, required this.onTapGes, required this.selectedIndexLocation, required this.outerIndex, required this.title, required this.onClosedTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapGes,
      child: SizedBox(
        height: 42,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color:
                selectedIndexLocation ==
                    outerIndex
                    ? MyColors.whiteColor
                    : MyColors
                    .transparent,
                border: Border.all(
                    width: 1,
                    color:
                    MyColors.whiteColor),
                borderRadius:
                const BorderRadius.only(
                    topLeft: Radius
                        .circular(20),
                    topRight: Radius
                        .circular(20)),
              ),
              child: Padding(
                padding:
                const EdgeInsets.only(
                    left: 15,
                    top: 15,
                    right: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: selectedIndexLocation ==
                                  outerIndex
                                  ? MyColors
                                  .toggletextColor
                                  : MyColors
                                  .textColor,
                              fontWeight: selectedIndexLocation ==
                                  outerIndex
                                  ? FontWeight
                                  .bold
                                  : FontWeight
                                  .w400,
                              fontFamily:
                              fontFamily),
                        ),
                        SizedBox(
                          width: selectedIndexLocation ==
                              outerIndex
                              ? 20
                              : 0,),
                        InkWell(
                          onTap: onClosedTap,
                          child: Icon(Icons.close,
                            size: selectedIndexLocation ==
                                outerIndex
                                ? 16
                                : 0,),
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding:
                      const EdgeInsets
                          .only(top: 5.0),
                      child: Container(
                        height:
                        selectedIndexLocation ==
                            outerIndex
                            ? 3
                            : 0,
                        color: selectedIndexLocation ==
                            outerIndex
                            ? MyColors
                            .toggletextColor
                            : MyColors
                            .deselectGray,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
