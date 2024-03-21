import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class CustomExpandedWidget extends StatefulWidget {
  final void Function()? onTap;
  final bool isExpanded;
  final String title;
  final String tabType;
  final void Function()? onAddGeoTap;
  final bool firstColumnWidth;
  final bool secondColumnWidth;
  final String selectedFilterValue;
  final void Function()? onFilterTap;
  final List<List<String>> dataList;
  final bool isSummary;

  const CustomExpandedWidget(
      {super.key,
      required this.title,
      this.onTap,
      required this.isExpanded,
      required this.onFilterTap,
      this.onAddGeoTap,
      required this.dataList,
      this.isSummary = false,
      required this.selectedFilterValue,
      this.secondColumnWidth = false,
      this.firstColumnWidth = false,
      required this.tabType});

  @override
  State<CustomExpandedWidget> createState() => _CustomExpandedWidgetState();
}

class _CustomExpandedWidgetState extends State<CustomExpandedWidget> {
  final List<Color> tableColors = [
        AppColors.blueLight.withOpacity(.39),
        AppColors.blueLight.withOpacity(.25),
        AppColors.blueLight.withOpacity(.15),
      ],
      colorList = [];
  @override
  void initState() {
    super.initState();
  }

  bool isFirst = true;
  void initColor() {
    if (isFirst && widget.dataList.isNotEmpty) {
      isFirst = false;
      var divider = (widget.dataList.length / 3).floor() + 1;
      for (var i = 0; i <= divider; i++) {
        colorList.addAll(tableColors);
      }
      debugPrint(
          '===>DAtaList Lenght:${widget.dataList.length} ====>${colorList.length}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    initColor();
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: widget.isExpanded
              ? Column(
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.title,
                                style: GoogleFonts.ptSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Hero(
                              tag: widget.title,
                              child: const Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(
                              top: 12, left: 12, right: 12),
                          padding: const EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.white,
                            boxShadow: widget.isExpanded
                                ? [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 3,
                                      offset: const Offset(3, 3),
                                    ),
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 3,
                                      offset: const Offset(-3, -3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(
                                  widget.dataList.length == 1 ? 4 : 12.0),
                              child: widget.isSummary
                                  ? SizedBox(
                                      // height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ...widget.dataList
                                                    .asMap()
                                                    .map(
                                                      (index, data) => MapEntry(
                                                        index,
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: .5),
                                                          color: index == 0
                                                              ? null
                                                              : colorList[
                                                                  index - 1],
                                                          child: Row(
                                                            children: [
                                                              ...data
                                                                  .asMap()
                                                                  .map(
                                                                    (i, item) =>
                                                                        MapEntry(
                                                                      i,
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        width:
                                                                            86,
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            index == 0 && i == 0
                                                                                ? const Flexible(child: Text('     '))
                                                                                : Flexible(
                                                                                    child: Text(
                                                                                      item,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 2,
                                                                                      style: GoogleFonts.ptSans(
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .values
                                                                  .toList(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .values
                                                    .toList(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : widget.dataList.isEmpty
                                      ? SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: widget.onFilterTap,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          widget
                                                              .selectedFilterValue,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.edit,
                                                        size: 16,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                child: Center(
                                                  child: Text('No Data Found!'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Table(
                                          columnWidths: widget.secondColumnWidth
                                              ? {
                                                  0: const FlexColumnWidth(1.5),
                                                  1: const FlexColumnWidth(1.2),
                                                }
                                              : widget.firstColumnWidth
                                                  ? {
                                                      0: const FlexColumnWidth(
                                                          2),
                                                    }
                                                  : null,
                                          border: TableBorder.all(
                                              color: Colors.transparent),
                                          children: [
                                            if (widget.dataList.isNotEmpty)
                                              ...widget.dataList
                                                  .asMap()
                                                  .map(
                                                    (index, tableData) =>
                                                        MapEntry(
                                                      index,
                                                      TableRow(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: index == 0
                                                              ? null
                                                              : colorList[
                                                                  index - 1],
                                                        ),
                                                        children: [
                                                          ...tableData
                                                              .asMap()
                                                              .map(
                                                                (i, value) =>
                                                                    MapEntry(
                                                                  i,
                                                                  i == 0 &&
                                                                          index ==
                                                                              0
                                                                      ? InkWell(
                                                                          onTap:
                                                                              widget.onFilterTap,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.all(6),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    widget.selectedFilterValue,
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: GoogleFonts.ptSans(
                                                                                      fontSize: 16,
                                                                                      color: AppColors.primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const Icon(
                                                                                  Icons.edit,
                                                                                  size: 16,
                                                                                  color: AppColors.primary,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child:
                                                                              Text(
                                                                            value,
                                                                            style:
                                                                                GoogleFonts.ptSans(
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ),
                                                              )
                                                              .values
                                                              .toList(),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .values
                                                  .toList(),
                                          ],
                                        )),
                        ),
                        widget.isSummary &&
                                ctlr.isRetailingDeepDiveInd &&
                                widget.tabType == SummaryTypes.retailing.type
                            ? Positioned(
                                top: 6,
                                right: 12,
                                child: IconButton(
                                  onPressed: widget.onFilterTap,
                                  icon: const Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                              )
                            : widget.tabType == SummaryTypes.retailing.type
                                ? const Positioned(
                                    top: 16,
                                    right: 25,
                                    child: Text(
                                      'Switch to \'Distributor\' to Add Geo',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : const SizedBox(),
                        if (widget.isSummary &&
                            widget.tabType != SummaryTypes.retailing.type)
                          Positioned(
                            top: 6,
                            right: 12,
                            child: IconButton(
                              onPressed: widget.onAddGeoTap,
                              icon: const Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                      boxShadow: widget.isExpanded
                          ? null
                          : [
                              BoxShadow(
                                color: Colors.grey[300]!,
                                blurRadius: 3,
                                offset: const Offset(3, 3),
                              ),
                              BoxShadow(
                                color: Colors.grey[300]!,
                                blurRadius: 3,
                                offset: const Offset(-3, -3),
                              ),
                            ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: GoogleFonts.ptSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Hero(
                          tag: widget.title,
                          child: const Icon(
                            Icons.keyboard_double_arrow_down_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
