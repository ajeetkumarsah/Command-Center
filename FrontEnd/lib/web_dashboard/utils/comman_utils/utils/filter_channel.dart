import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/http_call.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/comman/header_title_matrics.dart';
import '../../../../utils/style/text_style.dart';
import '../../summary_utils/dropdown_widget.dart';

class FiltersChannel extends StatefulWidget {
  final String selectedMonthList;
  final Function() onTapMonthFilter;
  final String selectedChannelList;
  final Function() onTapChannelFilter;

  const FiltersChannel({
    Key? key,
    required this.selectedMonthList,
    required this.onTapMonthFilter,
    required this.selectedChannelList, required this.onTapChannelFilter,
  }) : super(key: key);

  @override
  State<FiltersChannel> createState() => _FiltersChannelState();
}

class _FiltersChannelState extends State<FiltersChannel> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: checked ? 30 : 250,
        height: size.height,
        decoration: BoxDecoration(
          color: const Color(0xE6EFF3F7),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
          border: Border.all(width: 0.4, color: MyColors.deselectColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding:
              checked ? const EdgeInsets.all(5) : const EdgeInsets.all(0.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            decoration: const BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                HeaderTitleMetrics(
                                  onPressed: () {},
                                  title: 'Month Filter',
                                  icon: Icons.edit,
                                ),
                                GestureDetector(
                                  onTap: widget.onTapMonthFilter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyColors.grayBorder),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(widget.selectedMonthList ??
                                          'Select a month'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                HeaderTitleMetrics(
                                  onPressed: () {},
                                  title: 'Channel Filter',
                                  icon: Icons.edit,
                                ),
                                // widget.selectedChannelList == "Select.."?Container():
                                // Padding(
                                //   padding:
                                //   const EdgeInsets.only(
                                //       left: 15.0,
                                //       right: 15,
                                //       top: 10),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment
                                //         .center,
                                //     children: [
                                //       Expanded(
                                //         child: Text(
                                //           widget.selectedChannelList.isEmpty?"Select..":widget.selectedChannelList,
                                //           style: const TextStyle(
                                //               fontFamily:
                                //               fontFamily,
                                //               fontWeight:
                                //               FontWeight
                                //                   .w500,
                                //               fontSize: 14,
                                //               color: Color(
                                //                   0xff344C65)),
                                //         ),
                                //       ),
                                //       const Spacer(),
                                //       InkWell(
                                //           onTap: widget
                                //               .onTapRemoveFilter,
                                //           child: const Icon(
                                //             Icons.close,
                                //             size: 16,
                                //             color: MyColors
                                //                 .primary,
                                //           ))
                                //     ],
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: widget.onTapChannelFilter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0, horizontal: 16.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: MyColors.grayBorder),
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                            ),
                                            child: Text(
                                              widget.selectedChannelList.isEmpty?"Select..":widget.selectedChannelList,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: fontFamily,
                                                color: Color(0xFF212121),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF3F7),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checked
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                checked = !checked;
                              });
                            },
                            child: const Icon(
                              Icons.filter_alt_outlined,
                              size: 20,
                              color: MyColors.toggletextColor,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  checked = !checked;
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.double_arrow,
                                    size: 20,
                                    color: MyColors.toggletextColor,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8),
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Filters',
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: 14,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Container(
                      height: 1,
                      color: MyColors.dividerColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
