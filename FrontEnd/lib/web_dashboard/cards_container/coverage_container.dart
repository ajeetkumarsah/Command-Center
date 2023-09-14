import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../helper/http_call.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/colors/colors.dart';
import '../../utils/style/text_style.dart';
import '../model/coveragee_model.dart';

class CoverageWebContainer extends StatefulWidget {
  final String elName;
  final List<dynamic> coverageDataList;

  const CoverageWebContainer({
    super.key,
    required this.elName,
    required this.coverageDataList,
  });

  @override
  State<CoverageWebContainer> createState() => _CoverageWebContainerState();
}

class _CoverageWebContainerState extends State<CoverageWebContainer> {
  late ScrollController _scrollController;

  late Future<CoverageModel> myFuture;

  Future<CoverageModel> _fetchData() async {
    return await fetchCoverageWeb(context);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    myFuture = _fetchData();
  }

  int newIndex = 0;

  int coverageFunc(List<dynamic> currentIndexList) {
    for (int i = 0; i < currentIndexList.length; i++) {
      if (currentIndexList[i]['filter_key'] == "coverage") {
        newIndex = i;
      }
    }
    return newIndex;
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    return FutureBuilder<CoverageModel>(
      future: myFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child:sheetProvider.isLoadingPage == true?const Center(child: CircularProgressIndicator()): Center(
                child: widget.coverageDataList.isEmpty?const Center(child: CircularProgressIndicator()): Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: Consumer<SheetProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget
                              .coverageDataList[4]['data'].length,
                          itemBuilder: (context, index) {
                            // sheetProvider.allSummaryCoverageList = widget.coverageDataList[0][newIndex]['data'];
                            coverageFunc(widget.coverageDataList);
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Column(
                                children: [
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  Text(
                                    widget.coverageDataList[4]
                                                ['filter_key'] ==
                                            'coverage'
                                        ? "${widget.coverageDataList[4]['data'][index]['filter']}"
                                        : "",
                                    // "${widget.coverageDataList[index][0]['coverage']['filter']}",
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
                                    percent: widget.coverageDataList
                                                    [4]['data'][index]
                                                ['Billing_Per'] >
                                            100
                                        ? 100 / 100
                                        : ((widget.coverageDataList[4]
                                                        ['data'][index]
                                                    ['Billing_Per']) ??
                                                0.0) /
                                            100,
                                    center: Text(
                                      "${widget.coverageDataList[4]['data'][index]['Billing_Per'] > 100 ? 100 / 100 : ((widget.coverageDataList[4]['data'][index]['Billing_Per']) ?? '0')}",
                                      style: ThemeText.achText,
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: MyColors.progressBack,
                                    linearGradient:
                                        const LinearGradient(colors: [
                                      MyColors.progressStart,
                                      MyColors.progressEnd,
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.coverageDataList[4]
                                                ['filter_key'] ==
                                            'coverage'
                                        ? "${widget.coverageDataList[4]['data'][index]['month']}"
                                        : "",
                                    // "${widget.coverageDataList[index][0]['coverage']['month']}",
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
      },
    );
  }
}
