import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/model/table_coverage_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../helper/http_call.dart';
import '../../../utils/colors/colors.dart';
import '../comman_utils/text_header_widget.dart';

class CoverageTableSite extends StatefulWidget {
  final List newDataList;
  final String key1;
  final String key2;
  final String key3;

  const CoverageTableSite({
    super.key,
    required this.newDataList, required this.key1, required this.key2, required this.key3,
  });

  @override
  State<CoverageTableSite> createState() => _CoverageTableSiteState();
}

class _CoverageTableSiteState extends State<CoverageTableSite> {
  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height - 470,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget
                              .newDataList
                              .length,
                          itemBuilder: (context, siteIndex) {
                            var sites =
                            widget.newDataList[siteIndex];
                            return ListTileTheme(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              child: ExpansionTile(
                                trailing: const Text(''),
                                textColor: MyColors.textColor,
                                onExpansionChanged: (val) {
                                  setState(() {
                                    sheetProvider.isExpanded =
                                        val;
                                    sheetProvider.isExpandedBranch = false;
                                    sheetProvider.isExpandedChannel = false;
                                    sheetProvider.isExpandedSubChannel = false;
                                  });
                                },
                                // controlAffinity:
                                // ListTileControlAffinity
                                //     .leading,
                                collapsedBackgroundColor:
                                siteIndex % 2 == 0
                                    ? MyColors.dark500
                                    : MyColors.dark400,
                                backgroundColor:
                                siteIndex % 2 == 0
                                    ? MyColors.dark500
                                    : MyColors.dark400,
                                title: SizedBox(
                                  height: 40,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      TextHeaderWidgetWithIcon(
                                        title:
                                        "${sites['filter_key']}",
                                        align:
                                        TextAlign.start, isRequired: false, isExpanded:  sheetProvider.isExpanded,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context,
                                            state, child) {
                                          return Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left:
                                                0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                    .isExpandedBranch ==
                                                    true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider.isExpandedBranch ==
                                                      true
                                                      ? ""
                                                      : "",
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider
                                            .isExpandedBranch ==
                                            true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context,
                                            state, child) {
                                          return Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left:
                                                0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                    .isExpanded ==
                                                    true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider.isExpanded ==
                                                      true
                                                      ? ""
                                                      : "",
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider
                                            .isExpanded ==
                                            true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context,
                                            state, child) {
                                          return Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left:
                                                0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                    .isExpandedChannel ==
                                                    true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider.isExpandedChannel ==
                                                      true
                                                      ? ""
                                                      : "",
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider
                                            .isExpandedChannel ==
                                            true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context,
                                            state, child) {
                                          return Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left:
                                                0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                    .isExpandedSubChannel ==
                                                    true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider.isExpandedSubChannel ==
                                                      true
                                                      ? ""
                                                      : "",
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider
                                            .isExpandedSubChannel ==
                                            true
                                            ? 3
                                            : 0,
                                      ),
                                      TextHeaderWidget(
                                        title:
                                        "${sites[widget.key1]}",
                                        align:
                                        TextAlign.center,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      TextHeaderWidget(
                                        title:
                                        "${sites[widget.key2]}",
                                        align:
                                        TextAlign.center,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      TextHeaderWidget(
                                        title:
                                        "${sites[widget.key3]}",
                                        align:
                                        TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                children: <Widget>[
                                  //Branches
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                          left: 113.0),
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap:
                                              true,
                                              itemCount: widget
                                                  .newDataList[
                                              0][
                                              'division']
                                              [
                                              siteIndex]
                                              [
                                              'Site']
                                                  .length,
                                              itemBuilder:
                                                  (context,
                                                  branchIndex) {
                                                var branches =
                                                widget.newDataList[0]['division']
                                                [
                                                siteIndex]['Site']
                                                [
                                                branchIndex];
                                                // print(
                                                //     branches);
                                                return ListTileTheme(
                                                  dense: true,
                                                  contentPadding:
                                                  EdgeInsets
                                                      .zero,
                                                  child:
                                                  ExpansionTile(
                                                    trailing: const Text(''),
                                                    textColor:
                                                    MyColors
                                                        .textColor,
                                                    onExpansionChanged:
                                                        (val) {
                                                      setState(
                                                              () {
                                                            sheetProvider.isExpandedBranch =
                                                                val;
                                                            sheetProvider.isExpandedChannel = false;
                                                            sheetProvider.isExpandedSubChannel = false;
                                                          });
                                                    },
                                                    // tilePadding: const EdgeInsets.only(left: 10),
                                                    // controlAffinity:
                                                    // ListTileControlAffinity
                                                    //     .leading,
                                                    collapsedBackgroundColor: branchIndex %
                                                        2 ==
                                                        0
                                                        ? MyColors
                                                        .dark600
                                                        : MyColors
                                                        .dark300,
                                                    backgroundColor: branchIndex %
                                                        2 ==
                                                        0
                                                        ? MyColors
                                                        .dark600
                                                        : MyColors
                                                        .dark300,
                                                    title:
                                                    SizedBox(
                                                      height:
                                                      40,
                                                      child:
                                                      Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          TextHeaderWidgetWithIcon(
                                                            title: "${branches['filter_key']}",
                                                            align: TextAlign.start, isRequired: false, isExpanded: sheetProvider.isExpandedBranch,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Consumer<SheetProvider>(
                                                            builder: (context, state, child) {
                                                              return SizedBox(
                                                                  width: sheetProvider.isExpandedBranch == true ? 110 : 0,
                                                                  child: Text(
                                                                    sheetProvider.isExpandedBranch == true ? "" : "",
                                                                    textAlign: TextAlign.center,
                                                                  ));
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: sheetProvider.isExpandedBranch == true ? 3 : 0,
                                                          ),
                                                          Consumer<SheetProvider>(
                                                            builder: (context, state, child) {
                                                              return SizedBox(
                                                                  width: sheetProvider.isExpandedChannel == true ? 110 : 0,
                                                                  child: Text(
                                                                    sheetProvider.isExpandedChannel == true ? "" : "",
                                                                    textAlign: TextAlign.center,
                                                                  ));
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: sheetProvider.isExpandedChannel == true ? 3 : 0,
                                                          ),
                                                          Consumer<SheetProvider>(
                                                            builder: (context, state, child) {
                                                              return SizedBox(
                                                                  width: sheetProvider.isExpandedSubChannel == true ? 110 : 0,
                                                                  child: Text(
                                                                    sheetProvider.isExpandedSubChannel == true ? "" : "",
                                                                    textAlign: TextAlign.center,
                                                                  ));
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: sheetProvider.isExpandedSubChannel == true ? 3 : 0,
                                                          ),
                                                          TextHeaderWidget(
                                                            title: "${branches[widget.key1]}",
                                                            align: TextAlign.center,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          TextHeaderWidget(
                                                            title: "${branches[widget.key2]}",
                                                            align: TextAlign.center,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          TextHeaderWidget(
                                                            title: "${branches[widget.key3]}",
                                                            align: TextAlign.center,
                                                          ),
                                                        ],
                                                        // children: _buildBranchesRow(branches),
                                                      ),
                                                    ),
                                                    children: <Widget>[
                                                      SingleChildScrollView(
                                                        child:
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 114.0),
                                                          child:
                                                          Column(
                                                            children: [
                                                              ListView.builder(
                                                                  shrinkWrap: true,
                                                                  itemCount: widget.newDataList[0]['division'][siteIndex]['Site'][branchIndex]['Branch'].length,
                                                                  itemBuilder: (context, branch2Index) {
                                                                    var branchesSite = widget.newDataList[0]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index];
                                                                    // print(
                                                                    //     branches);
                                                                    return ListTileTheme(
                                                                      dense: true,
                                                                      contentPadding: EdgeInsets.zero,
                                                                      child: ExpansionTile(
                                                                        trailing: const Text(''),
                                                                        textColor: MyColors.textColor,
                                                                        onExpansionChanged: (val) {
                                                                          setState(() {
                                                                            sheetProvider.isExpandedChannel = val;
                                                                            sheetProvider.isExpandedSubChannel = false;
                                                                          });
                                                                        },
                                                                        // tilePadding: const EdgeInsets.only(left: 10),
                                                                        // controlAffinity:
                                                                        // ListTileControlAffinity
                                                                        //     .leading,
                                                                        collapsedBackgroundColor: branch2Index % 2 == 0 ? MyColors.dark500 : MyColors.dark400,
                                                                        backgroundColor: branch2Index % 2 == 0 ? MyColors.dark500 : MyColors.dark400,
                                                                        title: SizedBox(
height: 40,
                                                                          child: Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 3.0),
                                                                                child: TextHeaderWidgetWithIcon(
                                                                                  title: "${branchesSite['filter_key']}",
                                                                                  align: TextAlign.start, isRequired: false, isExpanded: sheetProvider.isExpandedChannel,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              Consumer<SheetProvider>(
                                                                                builder: (context, state, child) {
                                                                                  return SizedBox(
                                                                                      width: sheetProvider.isExpandedChannel == true ? 110 : 0,
                                                                                      child: Text(
                                                                                        sheetProvider.isExpandedChannel == true ? "" : "",
                                                                                        textAlign: TextAlign.center,
                                                                                      ));
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                width: sheetProvider.isExpandedChannel == true ? 3 : 0,
                                                                              ),
                                                                              Consumer<SheetProvider>(
                                                                                builder: (context, state, child) {
                                                                                  return SizedBox(
                                                                                      width: sheetProvider.isExpandedSubChannel == true ? 110 : 0,
                                                                                      child: Text(
                                                                                        sheetProvider.isExpandedSubChannel == true ? "" : "",
                                                                                        textAlign: TextAlign.center,
                                                                                      ));
                                                                                },
                                                                              ),
                                                                              TextHeaderWidget(
                                                                                title: "${branchesSite[widget.key1]}",
                                                                                align: TextAlign.center,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              TextHeaderWidget(
                                                                                title: "${branchesSite[widget.key2]}",
                                                                                align: TextAlign.center,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              TextHeaderWidget(
                                                                                title: "${branchesSite[widget.key3]}",
                                                                                align: TextAlign.center,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        children: <Widget>[
                                                                          SingleChildScrollView(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 115.0),
                                                                              child: Column(
                                                                                children: [
                                                                                  ListView.builder(
                                                                                      shrinkWrap: true,
                                                                                      itemCount: widget.newDataList[0]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'].length,
                                                                                      itemBuilder: (context, channelIndex) {
                                                                                        var channels = widget.newDataList[0]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'][channelIndex];
                                                                                        // print(
                                                                                        //     branches);
                                                                                        return ListTileTheme(
                                                                                          dense: true,
                                                                                          contentPadding: EdgeInsets.zero,
                                                                                          child: ExpansionTile(
                                                                                            trailing: const Text(''),
                                                                                            textColor: MyColors.textColor,
                                                                                            onExpansionChanged: (val) {
                                                                                              setState(() {
                                                                                                sheetProvider.isExpandedSubChannel = val;
                                                                                              });
                                                                                            },
                                                                                            // tilePadding: const EdgeInsets.only(left: 10),
                                                                                            // controlAffinity:
                                                                                            // ListTileControlAffinity
                                                                                            //     .leading,
                                                                                            collapsedBackgroundColor: channelIndex % 2 == 0 ? MyColors.dark600 : MyColors.dark300,
                                                                                            backgroundColor: channelIndex % 2 == 0 ? MyColors.dark600 : MyColors.dark300,
                                                                                            title: SizedBox(
                                                                                              height: 40,
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.only(left: 3.0),
                                                                                                    child: TextHeaderWidgetWithIcon(
                                                                                                      title: "${channels['filter_key']}",
                                                                                                      align: TextAlign.start, isRequired: false, isExpanded: sheetProvider.isExpandedSubChannel,
                                                                                                    ),
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    width: 3,
                                                                                                  ),

                                                                                                  // SizedBox(
                                                                                                  //   width: sheetProvider
                                                                                                  //       .isExpandedSubChannel ==
                                                                                                  //       true
                                                                                                  //       ? 3
                                                                                                  //       : 0,
                                                                                                  // ),
                                                                                                  Consumer<SheetProvider>(
                                                                                                    builder: (context, state, child) {
                                                                                                      return SizedBox(
                                                                                                          width: sheetProvider.isExpandedSubChannel == true ? 110 : 0,
                                                                                                          child: Text(
                                                                                                            sheetProvider.isExpandedSubChannel == true ? "" : "",
                                                                                                            textAlign: TextAlign.center,
                                                                                                          ));
                                                                                                    },
                                                                                                  ),
                                                                                                  TextHeaderWidget(
                                                                                                    title: "${channels[widget.key1]}",
                                                                                                    align: TextAlign.center,
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    width: 3,
                                                                                                  ),
                                                                                                  TextHeaderWidget(
                                                                                                    title: "${channels[widget.key2]}",
                                                                                                    align: TextAlign.center,
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    width: 3,
                                                                                                  ),
                                                                                                  TextHeaderWidget(
                                                                                                    title: "${channels[widget.key3]}",
                                                                                                    align: TextAlign.center,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            children: <Widget>[
                                                                                              SingleChildScrollView(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(left: 115.0),
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      ListView.builder(
                                                                                                          shrinkWrap: true,
                                                                                                          itemCount: widget.newDataList[0]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'][channelIndex]['SubChannel'].length,
                                                                                                          itemBuilder: (context, subChannelIndex) {
                                                                                                            var subChannels = widget.newDataList[0]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'][channelIndex]['SubChannel'][subChannelIndex];
                                                                                                            // print(
                                                                                                            //     branches);
                                                                                                            return Container(
                                                                                                              color: subChannelIndex % 2 == 0 ? MyColors.dark500 : MyColors.dark400,
                                                                                                              height: 40,
                                                                                                              child: Row(
                                                                                                                children: [
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsets.only(right: 0.0),
                                                                                                                    child: TextHeaderWidgetWithIcon(
                                                                                                                      title: "${subChannels['filter_key']}",
                                                                                                                      align: TextAlign.center, isRequired: true, isExpanded: false,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  TextHeaderWidget(
                                                                                                                    title: "${subChannels[widget.key1]}",
                                                                                                                    align: TextAlign.center,
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    width: 3,
                                                                                                                  ),
                                                                                                                  TextHeaderWidget(
                                                                                                                    title: "${subChannels[widget.key2]}",
                                                                                                                    align: TextAlign.center,
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    width: 3,
                                                                                                                  ),
                                                                                                                  TextHeaderWidget(
                                                                                                                    title: "${subChannels[widget.key3]}",
                                                                                                                    align: TextAlign.center,
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            );

                                                                                                          }),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      }),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                  ),
                ],
              ),
            );
  }
}
