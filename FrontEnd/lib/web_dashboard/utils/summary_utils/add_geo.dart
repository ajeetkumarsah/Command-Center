import 'dart:convert';

import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/all_metrics.dart';
import '../../../utils/style/text_style.dart';

class PersonalizeWeb extends StatefulWidget {
  final List<AllMetrics> includedData;
  final List<AllMetrics> metricData;
  final List<AllMetrics> allMetrics;

  // final Function(bool) toggleChanged;
  final Function() onTap;
  final Function() onTapApply;

  const PersonalizeWeb({
    Key? key,
    required this.onTap,
    required this.includedData,
    required this.metricData,
    required this.allMetrics,
    required this.onTapApply,
  }) : super(key: key);

  @override
  State<PersonalizeWeb> createState() => _PersonalizeWebState();
}

class _PersonalizeWebState extends State<PersonalizeWeb> {
  // List<AllMetrics> includedData = [];
  // List<AllMetrics> metricData = [];
  // List<AllMetrics> allMetrics = [
  //   AllMetrics(name: 'Retailing', isEnabled: true),
  //   AllMetrics(name: 'Coverage', isEnabled: true),
  //   AllMetrics(name: 'Golden Points', isEnabled: true),
  //   AllMetrics(name: 'Focus Brand', isEnabled: true),
  //   AllMetrics(name: 'Distribution',isEnabled: true),
  //   AllMetrics(name: 'Productivity', isEnabled: true),
  //   AllMetrics(name: 'Call Compliance', isEnabled: true),
  //   AllMetrics(name: 'Shipment', isEnabled: true),
  //   AllMetrics(name: 'Inventory', isEnabled: true),
  //   AllMetrics(name: '', isEnabled: false),
  // ];
  // late AllMetrics lastItem;

  void toggleItem(AllMetrics item) {
    setState(() {
      item.isEnabled = !item.isEnabled;

      if (item.isEnabled) {
        AllMetrics lastItem = widget.includedData.removeLast();
        widget.includedData.add(item);
        widget.includedData.add(lastItem);
        widget.metricData.remove(item);
      } else {
        widget.metricData.add(item);
        widget.includedData.remove(item);
      }
      SharedPreferencesUtils.setString(
          "metricData", jsonEncode(widget.metricData));
      SharedPreferencesUtils.setString(
          "includedData", jsonEncode(widget.includedData));
    });
  }

  void onReorder(int oldIndex, int newIndex, List<AllMetrics> items) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remove Metrics',
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: MyColors.textHeaderColor),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: widget.onTap,
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // decoration: const BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                //   color: MyColors.whiteColor,
                // ),
                child: Column(
                  // onReorder: (int oldIndex, int newIndex) { onReorder(oldIndex, newIndex, includedData); },
                  children: [
                    for (int index = 0;
                        index < widget.includedData.length;
                        index++)
                      _buildMetricList(
                        context,
                        true,
                        index,
                        widget.includedData.length,
                        widget.includedData[index],
                      )
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // decoration: const BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                //   color: MyColors.whiteColor,
                // ),
                //
                child: Column(
                  // onReorder: (int oldIndex, int newIndex) { onReorder(oldIndex, newIndex, includedData); },
                  children: [
                    widget.metricData.isEmpty
                        ? Container()
                        : const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 30, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Removed Metrics',
                                  style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.textHeaderColor),
                                ),
                                // const Spacer(),
                                // InkWell(
                                //   onTap: widget.onTap,
                                //   child:
                                //   const Icon(
                                //     Icons.close,
                                //     color: Colors
                                //         .red,
                                //     size: 20,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                    for (int index = 0;
                        index < widget.metricData.length;
                        index++)
                      _buildMetricList(
                        context,
                        false,
                        index,
                        widget.metricData.length,
                        widget.metricData[index],
                      )
                  ],
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Container(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: widget.onTapApply,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.toggletextColor,
                        elevation: 0,
                        shape: const StadiumBorder()),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                          letterSpacing: 0.8,
                          fontSize: 14,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildMetricList(BuildContext context, bool isIcon, int index,
      int dataLength, AllMetrics data) {
    return data.name == ''
        ? Container()
        : Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: MyColors.deselectColor),
              ),
            ),
            child: Padding(
              key: Key(data.name),
              padding: const EdgeInsets.only(left: 15, right: 5),
              child: SizedBox(
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // if (isIcon)
                        //   Image.asset(
                        //     "assets/images/app_bar/default.png",
                        //     height: 20,
                        //     width: 20,
                        //   ),
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        Text(
                          data.name,
                          style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: MyColors.textHeaderColor),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.6,
                      child: CupertinoSwitch(
                        value: data.isEnabled,
                        onChanged: (val) => toggleItem(data),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

Future personalizeBottomSheet(
    context,
    List<AllMetrics> includedData,
    List<AllMetrics> metricData,
    List<AllMetrics> allMetrics,
    Function() onTapApply) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: const BoxDecoration(
                color: MyColors.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      // padding: const EdgeInsets.only(bottom: 30),
                      width: double.infinity,
                      // height: MediaQuery.of(context).size.height * 0.88,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                            'Personalize',
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                                color: MyColors.textHeaderColor),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 4, bottom: 40),
                            child: Text(
                              'What you’d like to see on your main screen?',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.textSubHeaderColor),
                            ),
                          ),
                          PersonalizeWeb(
                            includedData: includedData,
                            metricData: metricData,
                            allMetrics: allMetrics,
                            onTap: () {},
                            onTapApply: onTapApply,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: MyColors.backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    height: 36,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
