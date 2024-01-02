import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomHeaderTitle extends StatelessWidget {
  final List<dynamic> dataList;
  final int selectedIndexLocation;
  final String per;
  final String points;
  final String target;

  const CustomHeaderTitle({super.key, required this.dataList, required this.selectedIndexLocation, required this.per, required this.points, required this.target});

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Padding(
      padding:
      const EdgeInsets.only(
          top: 0,
          bottom: 0,
          left: 15,
          right: 15),
      child: Container(
        decoration:
        const BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 0.5,
                color: MyColors
                    .textColor),
            top: BorderSide(
                width: 0.5,
                color: MyColors
                    .textColor),
          ),
        ),
        child: Padding(
          padding:
          const EdgeInsets
              .only(
              left: 10.0,
              top: 5,
              bottom: 5,
              right: 5),
          child: Row(
            children: [
              TextHeaderWidget(
                title: dataList[selectedIndexLocation]
                [0][
                'filter_key'] ==
                    'All India' || dataList[selectedIndexLocation]
                [0][
                'filter_key'] ==
                    'allIndia'
                    ? 'Country Name'
                    : dataList[selectedIndexLocation][0]['filter_key'] ==
                    'N-E'
                    ? 'Division Name'
                    : dataList[selectedIndexLocation][0]['filter_key'] ==
                    'S-W'
                    ? 'Division Name'
                    : 'Cluster Name',
                align: TextAlign
                    .center,
              ),
              const SizedBox(
                width: 3,
              ),
              Consumer<
                  SheetProvider>(
                builder:
                    (context,
                    state,
                    child) {
                  return SizedBox(
                      width: sheetProvider
                          .isExpandedDivision ==
                          true
                          ? 110
                          : 0,
                      child:
                      Text(
                          sheetProvider
                              .isExpandedDivision ==
                              true
                              ? "Division Name"
                              : "",
                          textAlign:
                          TextAlign
                              .center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily
                          )
                      ));
                },
              ),
              SizedBox(
                width: sheetProvider
                    .isExpandedDivision ==
                    true
                    ? 3
                    : 0,
              ),
              Consumer<
                  SheetProvider>(
                builder:
                    (context,
                    state,
                    child) {
                  return SizedBox(
                    // color: MyColors.deselectColor,
                      width: sheetProvider
                          .isExpanded ==
                          true
                          ? 110
                          : 0,
                      child:
                      Text(
                          sheetProvider
                              .isExpanded ==
                              true
                              ? "Site Name"
                              : "",
                          textAlign:
                          TextAlign
                              .center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily
                          )
                      ));
                },
              ),
              SizedBox(
                width: sheetProvider
                    .isExpanded ==
                    true
                    ? 3
                    : 0,
              ),
              Consumer<
                  SheetProvider>(
                builder:
                    (context,
                    state,
                    child) {
                  return SizedBox(
                      width: sheetProvider
                          .isExpandedBranch ==
                          true
                          ? 110
                          : 0,
                      child:
                      Text(
                          sheetProvider
                              .isExpandedBranch ==
                              true
                              ? "Branch Name"
                              : "",
                          textAlign:
                          TextAlign
                              .center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily
                          )
                      ));
                },
              ),
              SizedBox(
                width: sheetProvider
                    .isExpandedBranch ==
                    true
                    ? 3
                    : 0,
              ),
              Consumer<
                  SheetProvider>(
                builder:
                    (context,
                    state,
                    child) {
                  return SizedBox(
                      width: sheetProvider
                          .isExpandedChannel ==
                          true
                          ? 110
                          : 0,
                      child:
                      Text(
                          sheetProvider
                              .isExpandedChannel ==
                              true
                              ? "Channel Name"
                              : "",
                          textAlign:
                          TextAlign
                              .center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily
                          )
                      ));
                },
              ),
              SizedBox(
                width: sheetProvider
                    .isExpandedChannel ==
                    true
                    ? 3
                    : 0,
              ),
              Consumer<
                  SheetProvider>(
                builder:
                    (context,
                    state,
                    child) {
                  return SizedBox(
                      width: sheetProvider
                          .isExpandedSubChannel ==
                          true
                          ? 110
                          : 0,
                      child:
                      Text(
                          sheetProvider
                              .isExpandedSubChannel ==
                              true
                              ? "Sub Channel Name"
                              : "",
                          textAlign:
                          TextAlign
                              .center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily
                          )
                      ));
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
                per,
                align: TextAlign
                    .center,
              ),
              const SizedBox(
                width: 3,
              ),
              TextHeaderWidget(
                title:
                points,
                align: TextAlign
                    .center,
              ),
              const SizedBox(
                width: 3,
              ),
              TextHeaderWidget(
                title:
                target,
                align: TextAlign
                    .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
