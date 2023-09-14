import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/http_call.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/style/text_style.dart';
import '../model/gp_model.dart';

class GPWebContainer extends StatefulWidget {
  final String elName;
  final List<dynamic> gpDataList;

  const GPWebContainer({
    super.key,
    required this.elName,
    required this.gpDataList,
  });

  @override
  State<GPWebContainer> createState() => _GPWebContainerState();
}

class _GPWebContainerState extends State<GPWebContainer> {
  late ScrollController _scrollController;

  late Future<GPModel> myFuture;

  Future<GPModel> _fetchData() async {
    return await fetchGPWeb(context);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    myFuture = _fetchData();
  }

  int newIndex = 0;

  int gpFunc(List<dynamic> currentIndexList) {
    for (int i = 0; i < currentIndexList.length; i++) {
      if (currentIndexList[i]['filter_key'] == "gp") {
        newIndex = i;
      }
    }
    return newIndex;
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    return FutureBuilder<GPModel>(
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
              child: sheetProvider.isLoadingPage == true?const Center(child: CircularProgressIndicator()):Center(
                child: widget.gpDataList.isEmpty?const Center(child: CircularProgressIndicator()):Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: Consumer<SheetProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.gpDataList[1]['data'].length,
                          itemBuilder: (context, index) {
                            // sheetProvider.allSummaryGPList = widget.gpDataList[0][newIndex]['data'];
                            gpFunc(widget.gpDataList);
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Column(
                                children: [
                                  Text(
                                    widget.gpDataList[1]
                                                ['filter_key'] ==
                                            'gp'
                                        ? "${widget.gpDataList[1]['data'][index]['filter']}"
                                        : "",
                                    style: ThemeText.coverageText,
                                  ),
                                  // const Text(
                                  //   "Sellout",
                                  //   style: ThemeText.coverageText,
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.gpDataList[1]
                                                ['filter_key'] ==
                                            'gp'
                                        ? "${widget.gpDataList[1]['data'][index]['gpAbs']}"
                                        : "",
                                    // widget.gpDataList[index][0]['dgpCompliance']['filter']=='All India'?"45MM":widget.gpDataList[index][0]['dgpCompliance']['filter']=='Cochin'?"2.3MM":'23MM',
                                    // "${widget.gpDataList[index][0]['dgpCompliance']['gpAbs']}",
                                    style: ThemeText.subTitleText,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.gpDataList[1]
                                                ['filter_key'] ==
                                            'gp'
                                        ? "${widget.gpDataList[1]['data'][index]['month']}"
                                        : "",
                                    style: ThemeText.showMoreText,
                                  ),
                                  // Text(
                                  //   "${widget.gpDataList[index][0]['dgpCompliance']['month']}",
                                  //   style: ThemeText.showMoreText,
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   "${widget.gpDataList[index][0]['dgpCompliance']['filter']}",
                                  //   style: ThemeText.showMoreText,
                                  // )
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
      },
    );
  }
}
