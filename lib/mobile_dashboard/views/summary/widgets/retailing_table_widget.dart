import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';

class RetailingTableWidget extends StatelessWidget {
  final List<List<String>> data;
  const RetailingTableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        border: Border.all(
          width: .5,
          color: AppColors.borderColor,
        ),
        // borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              border: TableBorder.all(color: Colors.transparent),
              children: [
                ...data
                    .asMap()
                    .map(
                      (index, tableData) => MapEntry(
                        index,
                        TableRow(
                          decoration: BoxDecoration(
                            color: index == 0
                                ? AppColors.white
                                : index % 2 == 0
                                    ? AppColors.blueLight.withOpacity(.17)
                                    : AppColors.blueLight.withOpacity(.25),
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
                                                  key == (data[0].length - 1)
                                              ? const Radius.circular(20)
                                              : Radius.zero,
                                          bottomRight: index ==
                                                      (data.length - 1) &&
                                                  key == (data[0].length - 1)
                                              ? const Radius.circular(20)
                                              : Radius.zero,
                                          bottomLeft:
                                              index == (data.length - 1) &&
                                                      key == 0
                                                  ? const Radius.circular(20)
                                                  : Radius.zero,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value),
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
      ),
    );
  }
}
