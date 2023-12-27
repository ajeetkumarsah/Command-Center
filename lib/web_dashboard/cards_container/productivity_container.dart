import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../helper/http_call.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/colors/colors.dart';
import '../../utils/style/text_style.dart';
import '../model/productivity_model.dart';

class ProductivityWebContainer extends StatefulWidget {
  final String elName;
  final List<dynamic> prodDataList;

  const ProductivityWebContainer({
    super.key,
    required this.elName,
    required this.prodDataList,
  });

  @override
  State<ProductivityWebContainer> createState() =>
      _ProductivityWebContainerState();
}

class _ProductivityWebContainerState extends State<ProductivityWebContainer> {
  late ScrollController _scrollController;

  List<String> myDataList = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  int newIndex = 0;

  int prodFunc(List<dynamic> currentIndexList) {
    for (int i = 0; i < currentIndexList.length; i++) {
      if (currentIndexList[i]['filter_key'] == "productivity") {
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
                child: widget.prodDataList.isEmpty
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
                                itemCount:
                                    widget.prodDataList[5]['data'].length,
                                itemBuilder: (context, index) {
                                  // sheetProvider.allSummaryProdList = widget.prodDataList[0][newIndex]['data'];
                                  prodFunc(widget.prodDataList);
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      children: [
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        Text(
                                          widget.prodDataList[5]
                                                      ['filter_key'] ==
                                                  'productivity'
                                              ? "${widget.prodDataList[5]['data'][index]['filter']}"
                                              : "",
                                          // "${widget.prodDataList[index][0]['productivity']['filter']}",
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
                                          percent: widget.prodDataList[5]
                                                          ['data'][index]
                                                      ['Productive_Per'] >
                                                  100
                                              ? 100 / 100
                                              : ((widget.prodDataList[5]['data']
                                                              [index]
                                                          ['Productive_Per']) ??
                                                      0.0) /
                                                  100,
                                          center: Text(
                                            "${widget.prodDataList[5]['data'][index]['Productive_Per'] > 100 ? 100 / 100 : ((widget.prodDataList[5]['data'][index]['Productive_Per']) ?? '0')}",
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          widget.prodDataList[5]
                                                      ['filter_key'] ==
                                                  'productivity'
                                              ? "${widget.prodDataList[5]['data'][index]['month']}"
                                              : "",
                                          // "${widget.prodDataList[index][0]['productivity']['month']}",
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
