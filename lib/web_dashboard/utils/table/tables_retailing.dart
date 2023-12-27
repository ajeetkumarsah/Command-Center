import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/model/table_coverage_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../helper/http_call.dart';
import '../../../utils/colors/colors.dart';
import '../comman_utils/text_header_widget.dart';

class CoverageTableData extends StatefulWidget {
  final List<dynamic> newDataList;
  final String key1;
  final String key2;
  final String key3;

  const CoverageTableData({
    super.key,
    required this.newDataList, required this.key1, required this.key2, required this.key3,
  });

  @override
  State<CoverageTableData> createState() => _CoverageTableDataState();
}

class _CoverageTableDataState extends State<CoverageTableData> {
  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 470,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.newDataList.length,
                        itemBuilder: (context, index) {
                          var coverage1 = widget.newDataList[index];
                          return ListTileTheme(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            child: ExpansionTile(
                              trailing: const Text(''),
                              textColor: MyColors.textColor,
                              onExpansionChanged: (val) {
                                setState(() {
                                  sheetProvider.isExpandedDivision = val;
                                  sheetProvider.isExpanded = false;
                                  sheetProvider.isExpandedBranch = false;
                                  sheetProvider.isExpandedChannel = false;
                                  sheetProvider.isExpandedSubChannel = false;
                                });
                              },
                              // controlAffinity: ListTileControlAffinity.leading,
                              collapsedBackgroundColor: index % 2 == 0
                                  ? MyColors.dark600
                                  : MyColors.dark400,
                              backgroundColor: index % 2 == 0
                                  ? MyColors.dark600
                                  : MyColors.dark400,
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 5, bottom: 5, right: 5),
                                child: SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      TextHeaderWidgetWithIcon(
                                        title: '${coverage1['filter_key']}',
                                        align: TextAlign.start, isRequired: false, isExpanded: sheetProvider.isExpandedDivision,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                            .isExpandedDivision ==
                                                        true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider
                                                              .isExpandedDivision ==
                                                          true
                                                      ? ""
                                                      : "",
                                                  textAlign: TextAlign.center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width:
                                            sheetProvider.isExpandedDivision ==
                                                    true
                                                ? 3
                                                : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return SizedBox(
                                              width: sheetProvider.isExpanded ==
                                                      true
                                                  ? 110
                                                  : 0,
                                              child: Text(
                                                sheetProvider.isExpanded == true
                                                    ? ""
                                                    : "",
                                                textAlign: TextAlign.center,
                                              ));
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider.isExpanded == true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                            .isExpandedBranch ==
                                                        true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider
                                                              .isExpandedBranch ==
                                                          true
                                                      ? ""
                                                      : "",
                                                  textAlign: TextAlign.center,
                                                )),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: sheetProvider.isExpandedBranch ==
                                                true
                                            ? 3
                                            : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return SizedBox(
                                              width: sheetProvider
                                                          .isExpandedChannel ==
                                                      true
                                                  ? 110
                                                  : 0,
                                              child: Text(
                                                sheetProvider
                                                            .isExpandedChannel ==
                                                        true
                                                    ? ""
                                                    : "",
                                                textAlign: TextAlign.center,
                                              ));
                                        },
                                      ),
                                      SizedBox(
                                        width:
                                            sheetProvider.isExpandedChannel ==
                                                    true
                                                ? 3
                                                : 0,
                                      ),
                                      Consumer<SheetProvider>(
                                        builder: (context, state, child) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: SizedBox(
                                                width: sheetProvider
                                                            .isExpandedSubChannel ==
                                                        true
                                                    ? 110
                                                    : 0,
                                                child: Text(
                                                  sheetProvider
                                                              .isExpandedSubChannel ==
                                                          true
                                                      ? ""
                                                      : "",
                                                  textAlign: TextAlign.center,
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage1[widget.key1]}', //Billing Percentage
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage1[widget.key2]}', //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage1[widget.key3]}', //IYA
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              children: <Widget>[
                                //Sites
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: widget
                                                .newDataList[index]['division']
                                                .length,
                                            itemBuilder: (context, siteIndex) {
                                              var sites =
                                                  widget.newDataList[index]
                                                      ['division'][siteIndex];
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
                                                                        index][
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
                                                                      widget.newDataList[index]['division']
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
                                                                                    itemCount: widget.newDataList[index]['division'][siteIndex]['Site'][branchIndex]['Branch'].length,
                                                                                    itemBuilder: (context, branch2Index) {
                                                                                      var branches = widget.newDataList[index]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index];
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
                                                                                                    title: "${branches['filter_key']}",
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
                                                                                                        itemCount: widget.newDataList[index]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'].length,
                                                                                                        itemBuilder: (context, channelIndex) {
                                                                                                          var branches = widget.newDataList[index]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'][channelIndex];
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
                                                                                                                        title: "${branches['filter_key']}",
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
                                                                                                                            itemCount: widget.newDataList[index]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'][channelIndex]['SubChannel'].length,
                                                                                                                            itemBuilder: (context, subChannelIndex) {
                                                                                                                              var branches = widget.newDataList[index]['division'][siteIndex]['Site'][branchIndex]['Branch'][branch2Index]['Channel'][channelIndex]['SubChannel'][subChannelIndex];
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
                                                                                                                                        title: "${branches['filter_key']}",
                                                                                                                                        align: TextAlign.center, isRequired: true, isExpanded: false,
                                                                                                                                      ),
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
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
        //   } else {
        //     return const Center(child: CircularProgressIndicator());
        //   }
        // });
  }
}
