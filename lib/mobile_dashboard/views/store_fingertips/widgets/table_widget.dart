import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class StoreTableWidget extends StatefulWidget {
  final List<List<String>> dataList;
  final Color? color;
  final bool isFirst;
  const StoreTableWidget(
      {super.key, required this.dataList, this.color, this.isFirst = false});

  @override
  State<StoreTableWidget> createState() => _StoreTableWidgetState();
}

class _StoreTableWidgetState extends State<StoreTableWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // height: 110,
      width: MediaQuery.of(context).size.width,
      color: widget.color ?? AppColors.white,
      // padding: EdgeInsets.only(left: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(color: Colors.transparent),
            children: [
              ...widget.dataList
                  .asMap()
                  .map(
                    (index, tableData) => MapEntry(
                      index,
                      TableRow(
                        decoration: BoxDecoration(
                            color: index == 0
                                ? widget.isFirst
                                    ? widget.color ?? AppColors.white
                                    : AppColors.white
                                : index % 2 == 0
                                    ? widget.color ?? AppColors.white
                                    : widget.color ?? AppColors.white),
                        children: [
                          ...tableData
                              .asMap()
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: key == 0 && index == 0
                                            ? const Radius.circular(20)
                                            : Radius.zero,
                                        topRight: index == 0 &&
                                                key ==
                                                    (widget.dataList[0].length -
                                                        1)
                                            ? const Radius.circular(20)
                                            : Radius.zero,
                                        bottomRight: index ==
                                                    (widget.dataList.length -
                                                        1) &&
                                                key ==
                                                    (widget.dataList[0].length -
                                                        1)
                                            ? const Radius.circular(20)
                                            : Radius.zero,
                                        bottomLeft: index ==
                                                    (widget.dataList.length -
                                                        1) &&
                                                key == 0
                                            ? const Radius.circular(20)
                                            : Radius.zero,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ptSansCaption(
                                        fontSize: 12,
                                        fontWeight:
                                            index == 0 ? FontWeight.w600 : null,
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
          ),
        ],
      ),
    );
  }
}
