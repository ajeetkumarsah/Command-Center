import 'dart:convert';

import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../helper/http_call.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/colors/colors.dart';
import '../../utils/style/text_style.dart';
import '../model/cc_model.dart';

class CCWebContainer extends StatefulWidget {
  final String elName;
  final List<dynamic> ccDataList;

  const CCWebContainer(
      {super.key, required this.elName, required this.ccDataList});

  @override
  State<CCWebContainer> createState() => _CCWebContainerState();
}

class _CCWebContainerState extends State<CCWebContainer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  int newIndex = 0;

  int ccFunc(List<dynamic> currentIndexList) {
    for (int i = 0; i < currentIndexList.length; i++) {
      if (currentIndexList[i]['filter_key'] == "cc") {
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
                child: widget.ccDataList.isEmpty
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
                                itemCount: widget.ccDataList[3]['data'].length,
                                itemBuilder: (context, index) {
                                  ccFunc(widget.ccDataList);
                                  // List<dynamic>
                                  // filterCC = widget.ccDataList[newIndex]['data']
                                  //     .allSummaryCCList.map((item) {
                                  //   return {"filter": item["filter"]};
                                  // }).toList();

                                  // SharedPreferencesUtils.setString("cc", jsonEncode(widget.ccDataList[newIndex]['data']));
                                  // sheetProvider.allSummaryCCList = widget.ccDataList[newIndex]['data'];


                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      children: [
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        Text(
                                          widget.ccDataList[3]['filter_key'] ==
                                                  'cc'
                                              ? "${widget.ccDataList[3]['data'][index]['filter']}"
                                              : "",
                                          // "${widget.ccDataList[index][0]['callCompliance']['filter']}" ?? "0",
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
                                          percent: widget.ccDataList[3]['data']
                                                          [index]
                                                      ['ccCurrentMonth'] >
                                                  100
                                              ? 100 / 100
                                              : ((widget.ccDataList[3]['data']
                                                              [index]
                                                          ['ccCurrentMonth']) ??
                                                      0.0) /
                                                  100,
                                          center: Text(
                                            "${widget.ccDataList[3]['data'][index]['ccCurrentMonth'] > 100 ? 100 / 100 : ((widget.ccDataList[3]['data'][index]['ccCurrentMonth']) ?? '0')}",
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
                                        //   percent:widget.ccDataList[index][0]
                                        //   ['callCompliance']
                                        //   ['ccCurrentMonth']>100?100/100: (( widget.ccDataList[index][0]
                                        //   ['callCompliance']
                                        //   ['ccCurrentMonth'])?? 0.0) /
                                        //       100,
                                        //   center: Text(
                                        //     "${widget.ccDataList[index][0]
                                        //     ['callCompliance']
                                        //     ['ccCurrentMonth']>100?100/100:((widget.ccDataList[index][0]['callCompliance']['ccCurrentMonth']) ?? '0')}",
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
                                          widget.ccDataList[3]['filter_key'] ==
                                                  'cc'
                                              ? "${widget.ccDataList[3]['data'][index]['month']}"
                                              : "",
                                          // "${widget.ccDataList[index][0]['callCompliance']['month']}" ?? "0",
                                          style: ThemeText.showMoreText,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
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
