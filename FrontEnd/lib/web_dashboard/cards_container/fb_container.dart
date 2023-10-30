import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../helper/http_call.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/colors/colors.dart';
import '../../utils/style/text_style.dart';
import '../model/fb_web_model.dart';

class FBWebContainer extends StatefulWidget {
  final String elName;
  final List<dynamic> fbDataList;

  const FBWebContainer({
    super.key,
    required this.elName,
    required this.fbDataList,
  });

  @override
  State<FBWebContainer> createState() => _FBWebContainerState();
}

class _FBWebContainerState extends State<FBWebContainer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  int newIndex = 0;

  int fbFunc(List<dynamic> currentIndexList) {
    for (int i = 0; i < currentIndexList.length; i++) {
      if (currentIndexList[i]['filter_key'] == "fb") {
        newIndex = i;
      }
    }
    return newIndex;
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: sheetProvider.isLoadingPage == true
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: widget.fbDataList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Scrollbar(
                        thumbVisibility: true,
                        controller: _scrollController,
                        child: Consumer<SheetProvider>(
                          builder: (context, value, child) {
                            return ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: widget.fbDataList[2]['data'].length,
                                itemBuilder: (context, index) {
                                  // sheetProvider.allSummaryFBList = widget.fbDataList[0][newIndex]['data'];
                                  fbFunc(widget.fbDataList);
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      children: [
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        Text(
                                          widget.fbDataList[2]['filter_key'] ==
                                                  'fb'
                                              ? "${widget.fbDataList[2]['data'][index]['filter']}"
                                              : "",
                                          // "${widget.fbDataList[index][0]['focusBrand']['filter']}",
                                          style: ThemeText.coverageText,
                                        ),
                                        // const Text(
                                        //   'Site',
                                        //   style: ThemeText.coverageText,
                                        // ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CircularPercentIndicator(
                                          radius: 40,
                                          lineWidth: 10.0,
                                          animation: true,
                                          percent: int.parse(widget
                                                                  .fbDataList[2]
                                                              ['filter_key'] ==
                                                          'fb'
                                                      ? "${widget.fbDataList[2]['data'][index]['fbIYA']}"
                                                      : "0") >
                                                  100
                                              ? 100.0 / 100
                                              : double.parse(widget
                                                          .fbDataList[2]['data']
                                                      [index]['fbIYA']) /
                                                  100,
                                          center: Text(
                                            // int.parse(widget.fbDataList[2]
                                            //                     ['filter_key'] ==
                                            //                 'fb'
                                            //             ? "${widget.fbDataList[2]['data'][index]['fbIYA']}"
                                            //             : "0") >
                                            //         100
                                            //     ? '100'
                                            //     :
                                            (widget.fbDataList[2]
                                                        ['filter_key'] ==
                                                    'fb'
                                                ? "${widget.fbDataList[2]['data'][index]['fbIYA']}"
                                                : "0"),
                                            style: ThemeText.achText,
                                          ),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          backgroundColor:
                                              MyColors.progressBack,
                                          linearGradient:
                                              const LinearGradient(colors: [
                                            MyColors.progressStart,
                                            MyColors.progressEnd,
                                          ]),
                                        ),
                                        // CircularPercentIndicator(
                                        //   radius: 40,
                                        //   lineWidth: 10.0,
                                        //   animation: true,
                                        //   percent: int.parse(widget.fbDataList[index][0]
                                        //   ['focusBrand']['fbIYA']) > 100?100.0/100:double.parse(
                                        //       widget.fbDataList[index][0]
                                        //       ['focusBrand']['fbIYA']) /
                                        //       100,
                                        //   center: Text(
                                        //     "${int.parse(widget.fbDataList[index][0]
                                        //     ['focusBrand']['fbIYA']) > 100?'100':(widget.fbDataList[index][0]['focusBrand']['fbIYA'])}",
                                        //     style: ThemeText.achText,
                                        //   ),
                                        //   circularStrokeCap: CircularStrokeCap.round,
                                        //   backgroundColor: MyColors.progressBack,
                                        //   linearGradient:
                                        //   const LinearGradient(colors: [
                                        //     MyColors.progressStart,
                                        //     MyColors.progressEnd,
                                        //   ]),
                                        // ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          widget.fbDataList[2]['filter_key'] ==
                                                  'fb'
                                              ? "${widget.fbDataList[2]['data'][index]['month']}"
                                              : "",
                                          // "${widget.fbDataList[index][0]['focusBrand']['month']}",
                                          style: ThemeText.showMoreText,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    // Column(
                                    //   children: [
                                    //     const Text(
                                    //       "Sellout",
                                    //       style: ThemeText.coverageText,
                                    //     ),
                                    //     const SizedBox(
                                    //       height: 5,
                                    //     ),
                                    //     Text(
                                    //       "${value.getgpItem[index][0]['dgpCompliance']['gpAbs']}",
                                    //       style: ThemeText.subTitleText,
                                    //     ),
                                    //     // const SizedBox(
                                    //     //   height: 20,
                                    //     // ),
                                    //     // const Text(
                                    //     //   "Target",
                                    //     //   style: ThemeText.showMoreText,
                                    //     // ),
                                    //     // const SizedBox(
                                    //     //   height: 5,
                                    //     // ),
                                    //     // const Text(
                                    //     //   '113',
                                    //     //   style: ThemeText.showMoreText,
                                    //     // ),
                                    //     const SizedBox(
                                    //       height: 20,
                                    //     ),
                                    //     Text(
                                    //       "${value.getgpItem[index][0]['dgpCompliance']['month']}",
                                    //       style: ThemeText.showMoreText,
                                    //     ),
                                    //     const SizedBox(
                                    //       height: 5,
                                    //     ),
                                    //     Text(
                                    //       "${value.getgpItem[index][0]['dgpCompliance']['filter']}",
                                    //       style: ThemeText.showMoreText,
                                    //     )
                                    //   ],
                                    // ),
                                  );
                                });
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
