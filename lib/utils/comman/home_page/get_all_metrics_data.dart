import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/all_metrics.dart';
import '../../style/text_style.dart';

class Personalized extends StatefulWidget {
  final List<AllMetrics> includedData;
  final List<AllMetrics> metricData;
  final List<AllMetrics> allMetrics;
  final Function() onTap;
  final Function() onPressed;

  const Personalized({
    Key? key,
    required this.includedData,
    required this.metricData,
    required this.allMetrics,
    required this.onTap, required this.onPressed,
  }) : super(key: key);

  @override
  State<Personalized> createState() => _PersonalizedState();
}

class _PersonalizedState extends State<Personalized> {
  // List<AllMetrics> includedData = [];
  // List<AllMetrics> metricData = [];
  // List<AllMetrics> allMetrics = [
  //   AllMetrics(name: 'Retailing', isEnabled: true),
  //   AllMetrics(name: 'Coverage', isEnabled: true),
  //   AllMetrics(name: 'Golden Points', isEnabled: true),
  //   AllMetrics(name: 'Focus Brand', isEnabled: true),
  //   AllMetrics(name: 'Distribution'),
  //   AllMetrics(name: 'Productivity'),
  //   AllMetrics(name: 'Call Compliance'),
  //   AllMetrics(name: 'Shipment'),
  //   AllMetrics(name: 'Inventory'),
  // ];

  void toggleItem(AllMetrics item) {
    setState(() {
      item.isEnabled = !item.isEnabled;

      if (item.isEnabled) {
        widget.includedData.add(item);
        widget.metricData.remove(item);
      } else {
        widget.metricData.add(item);
        widget.includedData.remove(item);
      }
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
    // populateLists();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  'Included Metrics',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400,
                      color: MyColors.textHeaderColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: MyColors.whiteColor,
                ),
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
                      ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Container(
                    height: 40,
                    width: size.width / 2,
                    child: ElevatedButton(
                      onPressed: widget.onPressed,
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
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  'More Metrics',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400,
                      color: MyColors.textHeaderColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: MyColors.whiteColor,
                ),
                //
                child: Column(
                  // onReorder: (int oldIndex, int newIndex) { onReorder(oldIndex, newIndex, includedData); },
                  children: [
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
        ],
      ),
    );
  }

  Widget _buildMetricList(BuildContext context, bool isIcon, int index,
      int dataLength, AllMetrics data) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: index == dataLength - 1
              ? BorderSide.none
              : const BorderSide(width: 1.0, color: MyColors.grey),
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
                  if (isIcon)
                    Image.asset(
                      "assets/images/app_bar/default.png",
                      height: 20,
                      width: 20,
                    ),
                  const SizedBox(
                    width: 20,
                  ),
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
    Function() onTap,
    Function() onCrossTap) {
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
                          Personalized(
                            includedData: includedData,
                            metricData: metricData,
                            allMetrics: allMetrics,
                            onTap: onTap, onPressed: onCrossTap,

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
                        onTap: onCrossTap,
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
