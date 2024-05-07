import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class RetailingTableWidget extends StatefulWidget {
  final List<List<String>> dataList;
  const RetailingTableWidget({super.key, required this.dataList});

  @override
  State<RetailingTableWidget> createState() => _RetailingTableWidgetState();
}

class _RetailingTableWidgetState extends State<RetailingTableWidget> {
  // List<List<String>> _data = [];

  // bool isFirst = true;
  // int i = 0;
  // void initCall() {
  //   if (isFirst) {
  //     isFirst = false;
  //     for (var item in widget.dataList) {
  //       if (i <= 6) {
  //         i++;
  //         _data.add(item);
  //       }
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // initCall();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
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
                              ? AppColors.white
                              : index % 2 == 0
                                  ? AppColors.primary.withOpacity(.12)
                                  : AppColors.primary.withOpacity(.25),
                          borderRadius: index == 0
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )
                              : ((widget.dataList.length > 6)
                                      ? index == 6
                                      : index == (widget.dataList.length - 1))
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )
                                  : null,
                        ),
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
