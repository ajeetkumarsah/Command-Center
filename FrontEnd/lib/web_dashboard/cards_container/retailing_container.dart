import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../helper/http_call.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/style/text_style.dart';
import '../model/retailing_model.dart';

class RetailingSummaryContainer extends StatefulWidget {
  final int iya;
  final String elName;
  final List<dynamic> dataList;

  const RetailingSummaryContainer(
      {super.key,
      required this.iya,
      required this.elName,
      required this.dataList});

  @override
  State<RetailingSummaryContainer> createState() =>
      _RetailingSummaryContainerState();
}

class _RetailingSummaryContainerState extends State<RetailingSummaryContainer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  int newIndex = 0;

  int retailingFunc(List<dynamic> currentIndexList) {
    for (int i = 0; i < currentIndexList.length; i++) {
      if (currentIndexList[i]['filter_key'] == "retailing") {
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
        height: 190,
        child: sheetProvider.isLoadingPage == true
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: widget.dataList.isEmpty
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
                                itemCount: widget.dataList[0]['data'].length,
                                itemBuilder: (context, index) {
                                  // sheetProvider.allSummaryRetailingList = widget.dataList[0][newIndex]['data'];
                                  retailingFunc(widget.dataList);
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.dataList[0]['filter_key'] ==
                                                  'retailing'
                                              ? "${widget.dataList[0]['data'][index]['filter']}"
                                              : "",
                                          style: ThemeText.coverageText,
                                        ),
                                        // Text(
                                        //   "${widget.dataList[index][0]['mtdRetailing']['filter']}",
                                        //   style: ThemeText.coverageText,
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        widget.iya == 0
                                            ? Text(
                                                widget.dataList[0]
                                                            ['filter_key'] ==
                                                        'retailing'
                                                    ? "${widget.dataList[0]['data'][index]['cmSellout']}"
                                                    : "",
                                                // widget.dataList[index][0]['mtdRetailing']['filter']=='All India'?
                                                // "1309Cr":widget.dataList[index][0]['mtdRetailing']['filter']=='Cochin'?
                                                // "65Cr":'782Cr',
                                                // "${widget.dataList[index][0]['mtdRetailing']['cmSellout']}",
                                                style: ThemeText.subTitleText,
                                              )
                                            : Text(
                                                widget.dataList[0]
                                                            ['filter_key'] ==
                                                        'retailing'
                                                    ? "${widget.dataList[0]['data'][index]['cmIya']}"
                                                    : "",
                                                // "${widget.dataList[index][0]['mtdRetailing']['cmIya']}",
                                                style: ThemeText.subTitleText,
                                              ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          widget.dataList[0]['filter_key'] ==
                                                  'retailing'
                                              ? "${widget.dataList[0]['data'][index]['month']}"
                                              : "",
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
