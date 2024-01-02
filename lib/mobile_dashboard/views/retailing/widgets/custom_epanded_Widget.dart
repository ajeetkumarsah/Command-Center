import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class CustomExpandedWidget extends StatefulWidget {
  final void Function()? onTap;
  final bool isExpanded;
  final String title;
  final Widget? firstWidget;
  final void Function()? onFilterTap;
  final List<List<String>>? dataList;
  final bool isSummary;
  const CustomExpandedWidget(
      {super.key,
      required this.title,
      this.onTap,
      required this.isExpanded,
      this.onFilterTap,
      this.dataList,
      this.isSummary = false,
      this.firstWidget});

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
    if (widget.dataList != null && widget.dataList!.isNotEmpty) {
      var divider = (widget.dataList!.length / 3).floor();
      for (var i = 0; i <= divider; i++) {
        colorList.addAll(tableColors);
      }
      debugPrint(
          '===>DAtaList Lenght:${widget.dataList!.length} ====>${colorList.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                Icons.keyboard_double_arrow_down_rounded,
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
                            padding: const EdgeInsets.all(12.0),
                            child: widget.dataList != null
                                ? widget.isSummary
                                    ? SizedBox(
                                        // height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ...widget.dataList!
                                                      .asMap()
                                                      .map(
                                                        (index, data) =>
                                                            MapEntry(
                                                          index,
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        .5),
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
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          width:
                                                                              86,
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              index == 0 && i == 0
                                                                                  ? widget.firstWidget ?? const Flexible(child: Text('     '))
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
                                    : Table(
                                        border: TableBorder.all(
                                            color: Colors.transparent),
                                        children: [
                                          if (widget.dataList != null &&
                                              widget.dataList!.isNotEmpty)
                                            ...widget.dataList!
                                                .asMap()
                                                .map(
                                                  (index, tableData) =>
                                                      MapEntry(
                                                    index,
                                                    TableRow(
                                                      decoration: BoxDecoration(
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
                                                                    ? widget.firstWidget ??
                                                                        const Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text('   '),
                                                                        )
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          value,
                                                                          style:
                                                                              GoogleFonts.ptSans(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
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
                                                .toList()
                                        ],
                                      )
                                : Table(
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      if (widget.dataList != null)
                                        ...widget.dataList!
                                            .asMap()
                                            .map(
                                              (index, tableData) => MapEntry(
                                                index,
                                                TableRow(
                                                  children: [
                                                    ...tableData
                                                        .asMap()
                                                        .map(
                                                          (key, value) =>
                                                              MapEntry(
                                                            key,
                                                            key == 0 &&
                                                                    index == 0
                                                                ? widget.firstWidget ??
                                                                    const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          '   '),
                                                                    )
                                                                : Container(
                                                                    color: index ==
                                                                            0
                                                                        ? null
                                                                        : AppColors
                                                                            .blueLight
                                                                            .withOpacity(.25),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                        value),
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
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            widget.firstWidget ??
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text('   '),
                                                ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('BRANCH'),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('SITE'),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('AI'),
                                            ),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('CY Sales'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('CY Sales'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('CY Sales'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('CY Sales'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.39),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('CY Sales'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.25),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('CY Sales'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              color: AppColors.blueLight
                                                  .withOpacity(.15),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                      if (widget.dataList == null)
                                        TableRow(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.blueLight
                                                      .withOpacity(.39),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15))),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text('CY Sales'),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.blueLight
                                                    .withOpacity(.39),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.blueLight
                                                    .withOpacity(.39),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('34,689'),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.blueLight
                                                    .withOpacity(.39),
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Text('34,689'),
                                            ),
                                            // const SizedBox(),
                                          ],
                                        ),
                                    ],
                                  ),
                          ),
                        ),
                        if (widget.isSummary)
                          Positioned(
                            top: 14,
                            right: 20,
                            child: IconButton(
                              onPressed: widget.onFilterTap,
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
