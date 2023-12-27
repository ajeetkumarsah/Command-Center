import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/model/table_coverage_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../../helper/http_call.dart';
import '../../../../utils/colors/colors.dart';
import '../../comman_utils/text_header_widget.dart';

class CoverageTableDataBilling extends StatefulWidget {
  final List newDataList;

  const CoverageTableDataBilling({
    super.key,
    required this.newDataList,
  });

  @override
  State<CoverageTableDataBilling> createState() =>
      _CoverageTableDataBillingState();
}

class _CoverageTableDataBillingState extends State<CoverageTableDataBilling> {
  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    // return FutureBuilder(
    //     future: getTableCoverageSummary(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 470,
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
                                        align: TextAlign.start,
                                        isRequired: false,
                                        isExpanded:
                                            sheetProvider.isExpandedDivision,
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
                                      // SizedBox(
                                      //   width: sheetProvider
                                      //               .isExpandedSubChannel ==
                                      //           true
                                      //       ? 3
                                      //       : 0,
                                      // ),
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(left: 0.0),
                                      //   child: TextHeaderWidget(
                                      //     title: '${coverage1['month']}',
                                      //     //Billing Percentage
                                      //     align: TextAlign.center,
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: TextHeaderWidget(
                                          title: '${coverage1['billing_per1']}',
                                          //IYA
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
                                          title: '${coverage1['billing_per2']}',
                                          //IYA
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
                                          title: '${coverage1['billing_per3']}',
                                          //IYA
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
                                              print(widget
                                                  .newDataList[index]
                                                      ['division']
                                                  .length);
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
                                                      sheetProvider
                                                              .isExpandedBranch =
                                                          false;
                                                      sheetProvider
                                                              .isExpandedChannel =
                                                          false;
                                                      sheetProvider
                                                              .isExpandedSubChannel =
                                                          false;
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
                                                              TextAlign.start,
                                                          isRequired: false,
                                                          isExpanded:
                                                              sheetProvider
                                                                  .isExpanded,
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
                                                        // const TextHeaderWidget(
                                                        //   title: "",
                                                        //   align:
                                                        //       TextAlign.center,
                                                        // ),
                                                        TextHeaderWidget(
                                                          title:
                                                              "${sites['billing_per1']}",
                                                          align:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        TextHeaderWidget(
                                                          title:
                                                          "${sites['billing_per2']}",
                                                          align:
                                                          TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        TextHeaderWidget(
                                                          title:
                                                          "${sites['billing_per3']}",
                                                          align:
                                                          TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  children: <Widget>[
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
                                                                        ['site']
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        branchIndex) {
                                                                  var branches =
                                                                      widget.newDataList[index]['division']
                                                                              [
                                                                              siteIndex]['site']
                                                                          [
                                                                          branchIndex];
                                                                  return ListTileTheme(
                                                                    dense: true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    child:
                                                                        ExpansionTile(
                                                                      trailing:
                                                                          const Text(
                                                                              ''),
                                                                      textColor:
                                                                          MyColors
                                                                              .textColor,
                                                                      onExpansionChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {
                                                                          sheetProvider.isExpandedBranch =
                                                                              val;
                                                                          sheetProvider.isExpandedChannel =
                                                                              false;
                                                                          sheetProvider.isExpandedSubChannel =
                                                                              false;
                                                                        });
                                                                      },
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
                                                                              align: TextAlign.start,
                                                                              isRequired: false,
                                                                              isExpanded: sheetProvider.isExpandedBranch,
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
                                                                            // const TextHeaderWidget(
                                                                            //   title: "",
                                                                            //   align: TextAlign.center,
                                                                            // ),
                                                                            const SizedBox(
                                                                              width: 3,
                                                                            ),
                                                                            TextHeaderWidget(
                                                                              title: "${branches['billing_per1']}",
                                                                              align: TextAlign.center,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 3,
                                                                            ),
                                                                            TextHeaderWidget(
                                                                              title: "${branches['billing_per2']}",
                                                                              align: TextAlign.center,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 3,
                                                                            ),
                                                                            TextHeaderWidget(
                                                                              title: "${branches['billing_per3']}",
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
                                                                                    itemCount: widget.newDataList[index]['division'][siteIndex]['site'][branchIndex]['branch'].length,
                                                                                    itemBuilder: (context, branch2Index) {
                                                                                      var branchesdiv = widget.newDataList[index]['division'][siteIndex]['site'][branchIndex]['branch'][branch2Index];

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
                                                                                          collapsedBackgroundColor: branch2Index % 2 == 0 ? MyColors.dark500 : MyColors.dark400,
                                                                                          backgroundColor: branch2Index % 2 == 0 ? MyColors.dark500 : MyColors.dark400,
                                                                                          title: SizedBox(
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 3.0),
                                                                                                  child: TextHeaderWidgetWithIcon(
                                                                                                    title: "${branchesdiv['filter_key']}",
                                                                                                    align: TextAlign.start,
                                                                                                    isRequired: false,
                                                                                                    isExpanded: sheetProvider.isExpandedChannel,
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

                                                                                                const SizedBox(
                                                                                                  width: 3,
                                                                                                ),
                                                                                                TextHeaderWidget(
                                                                                                  title: "${branchesdiv['billing_per1']}",
                                                                                                  align: TextAlign.center,
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 3,
                                                                                                ),
                                                                                                TextHeaderWidget(
                                                                                                  title: "${branchesdiv['billing_per2']}",
                                                                                                  align: TextAlign.center,
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 3,
                                                                                                ),
                                                                                                TextHeaderWidget(
                                                                                                  title: "${branchesdiv['billing_per3']}",
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
                                                                                                        itemCount: widget.newDataList[index]['division'][siteIndex]['site'][branchIndex]['branch'][branch2Index]['channel'].length,
                                                                                                        itemBuilder: (context, channelIndex) {
                                                                                                          var channel = widget.newDataList[index]['division'][siteIndex]['site'][branchIndex]['branch'][branch2Index]['channel'][channelIndex];
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
                                                                                                              collapsedBackgroundColor: channelIndex % 2 == 0 ? MyColors.dark600 : MyColors.dark300,
                                                                                                              backgroundColor: channelIndex % 2 == 0 ? MyColors.dark600 : MyColors.dark300,
                                                                                                              title: SizedBox(
                                                                                                                height: 40,
                                                                                                                child: Row(
                                                                                                                  children: [
                                                                                                                    Padding(
                                                                                                                      padding: const EdgeInsets.only(left: 3.0),
                                                                                                                      child: TextHeaderWidgetWithIcon(
                                                                                                                        title: "${channel['filter_key']}",
                                                                                                                        align: TextAlign.start,
                                                                                                                        isRequired: false,
                                                                                                                        isExpanded: sheetProvider.isExpandedSubChannel,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    const SizedBox(
                                                                                                                      width: 3,
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
                                                                                                                    // const TextHeaderWidget(
                                                                                                                    //   title: "",
                                                                                                                    //   align: TextAlign.center,
                                                                                                                    // ),
                                                                                                                    const SizedBox(
                                                                                                                      width: 3,
                                                                                                                    ),
                                                                                                                    TextHeaderWidget(
                                                                                                                      title: "${channel['billing_per1']}",
                                                                                                                      align: TextAlign.center,
                                                                                                                    ),
                                                                                                                    const SizedBox(
                                                                                                                      width: 3,
                                                                                                                    ),
                                                                                                                    TextHeaderWidget(
                                                                                                                      title: "${channel['billing_per2']}",
                                                                                                                      align: TextAlign.center,
                                                                                                                    ),
                                                                                                                    const SizedBox(
                                                                                                                      width: 3,
                                                                                                                    ),
                                                                                                                    TextHeaderWidget(
                                                                                                                      title: "${channel['billing_per3']}",
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
                                                                                                                            itemCount: widget.newDataList[index]['division'][siteIndex]['site'][branchIndex]['branch'][branch2Index]['channel'][channelIndex]['subChannel'].length,
                                                                                                                            itemBuilder: (context, subChannelIndex) {
                                                                                                                              var subChannel = widget.newDataList[index]['division'][siteIndex]['site'][branchIndex]['branch'][branch2Index]['channel'][channelIndex]['subChannel'][subChannelIndex];
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
                                                                                                                                        title: "${subChannel['filter_key']}",
                                                                                                                                        align: TextAlign.center,
                                                                                                                                        isRequired: true,
                                                                                                                                        isExpanded: false,
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                    // const TextHeaderWidget(
                                                                                                                                    //   title: "",
                                                                                                                                    //   align: TextAlign.center,
                                                                                                                                    // ),
                                                                                                                                    const SizedBox(
                                                                                                                                      width: 3,
                                                                                                                                    ),
                                                                                                                                    TextHeaderWidget(
                                                                                                                                      title: "${subChannel['billing_per1']}",
                                                                                                                                      align: TextAlign.center,
                                                                                                                                    ),
                                                                                                                                    const SizedBox(
                                                                                                                                      width: 3,
                                                                                                                                    ),
                                                                                                                                    TextHeaderWidget(
                                                                                                                                      title: "${subChannel['billing_per2']}",
                                                                                                                                      align: TextAlign.center,
                                                                                                                                    ),
                                                                                                                                    const SizedBox(
                                                                                                                                      width: 3,
                                                                                                                                    ),
                                                                                                                                    TextHeaderWidget(
                                                                                                                                      title: "${subChannel['billing_per3']}",
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
