import 'package:flutter/material.dart';

import '../../colors/colors.dart';
import '../../style/text_style.dart';

class DGPTable extends StatelessWidget {
  final List rowData;

  const DGPTable({Key? key, required this.rowData}) : super(key: key);

  Color getColor(Set<MaterialState> states) {
    return const Color(0x397992D2);
  }

  Color getColorGray(Set<MaterialState> states) {
    return const Color(0x157992D2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xffE1E7EC),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: MyColors.whiteColor
              ),
              child: DataTable(
                columnSpacing: 0,
                dataRowHeight: 40,
                headingRowHeight: 45,
                // border: TableBorder(borderRadius: BorderRadius.circular(20)),
                columns: const [
                  DataColumn(
                    label: SizedBox(
                        width: 60,
                        child: Text(
                          'P3M',
                          textAlign: TextAlign.start,
                          style: ThemeText.tableHeaderText,
                        )),
                    numeric: true,
                    tooltip: 'P3M',
                  ),
                  DataColumn(
                    label: SizedBox(
                        width: 60,
                        child: Text(
                          'P3M',
                          textAlign: TextAlign.center,
                          style: ThemeText.tableHeaderText,
                        )),
                    numeric: true,
                    tooltip: 'P3M',
                  ),
                  DataColumn(
                    label: SizedBox(
                        width: 60,
                        child: Text(
                          'P3M',
                          textAlign: TextAlign.center,
                          style: ThemeText.tableHeaderText,
                        )),
                    numeric: true,
                    tooltip: 'P3M',
                  ),
                  DataColumn(
                    label: SizedBox(
                        width: 60,
                        child: Text(
                          'P3M',
                          textAlign: TextAlign.center,
                          style: ThemeText.tableHeaderText,
                        )),
                    numeric: true,
                    tooltip: 'P3M',
                  ),
                ],
                rows: List.generate(rowData.length, (index) {
                  final item = rowData[index];
                  return DataRow(
                    color: index % 2 == 0
                        ? MaterialStateProperty.resolveWith(getColor)
                        : MaterialStateProperty.resolveWith(getColorGray),
                    cells: [
                      DataCell(SizedBox(width: 60, child: Text('${item.name} '))),
                      DataCell(SizedBox(
                          width: 60,
                          child: Text(
                            '${item.divi}',
                            textAlign: TextAlign.center,
                          ))),
                      DataCell(SizedBox(
                          width: 60,
                          child: Text(
                            '${item.divi1}',
                            textAlign: TextAlign.center,
                          ))),
                      DataCell(
                        SizedBox(
                          width: 60,
                          child: Text(
                            '${item.age}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
