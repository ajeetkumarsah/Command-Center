import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../activities/coverage_screen.dart';
import '../../colors/colors.dart';

class CoverageTable extends StatelessWidget {
  final List rowData;
  final List rowsItems;
  final bool sort;
  final Function() onTap;
  final Function() onTapAdd;
  final List<CityData> data;

  const CoverageTable(
      {Key? key,
      required this.rowData,
      required this.sort,
      required this.onTap,
      required this.data,
      required this.rowsItems,
      required this.onTapAdd})
      : super(key: key);

  Color getColor(Set<MaterialState> states) {
    return const Color(0x397992D2);
  }

  Color getColorGray(Set<MaterialState> states) {
    return const Color(0x157992D2);
  }

  List<DataColumn> getColumnData() {
    final columns = <DataColumn>[
      const DataColumn(label: Text(''), numeric: false)
    ];
    for (var cityData in data) {
      columns.add(DataColumn(label: Text(cityData.city), numeric: true));
    }
    return columns;
  }

  List<DataRow> getRowData() {
    final rows = <DataRow>[];

    final billingRowCells = <DataCell>[
      const DataCell(Text(''), placeholder: false),
      ...data
          .map((cityData) => DataCell(Text(cityData.data['Billing'].toString()),
              placeholder: false))
          .toList(),
    ];
    rows.add(DataRow(
        cells: billingRowCells,
        color: MaterialStateColor.resolveWith((states) => getColor(states))));

    final coverageRowCells = <DataCell>[
      const DataCell(Text(''), placeholder: false),
      ...data
          .map((cityData) => DataCell(
              Text(cityData.data['Coverage'].toString()),
              placeholder: false))
          .toList(),
    ];
    rows.add(DataRow(
        cells: coverageRowCells,
        color:
            MaterialStateColor.resolveWith((states) => getColorGray(states))));

    final productiveCallsRowCells = <DataCell>[
      const DataCell(Text(''), placeholder: false),
      ...data
          .map((cityData) => DataCell(
              Text(cityData.data['Productive Calls'].toString()),
              placeholder: false))
          .toList(),
    ];
    rows.add(DataRow(
        cells: productiveCallsRowCells,
        color: MaterialStateColor.resolveWith((states) => getColor(states))));

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
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
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(children: [
                  SizedBox(
                    width: 90,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: MyColors.whiteColor),
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
                                  'CM',
                                  textAlign: TextAlign.start,
                                  style: ThemeText.tableHeaderText,
                                )),
                            numeric: true,
                            tooltip: 'CM',
                          ),
                        ],
                        rows: List.generate(rowsItems.length, (index) {
                          final item = rowData[index];
                          return DataRow(
                            color: index % 2 == 0
                                ? MaterialStateProperty.resolveWith(getColor)
                                : MaterialStateProperty.resolveWith(
                                    getColorGray),
                            cells: [
                              DataCell(SizedBox(
                                  width: 60,
                                  child: Text('${rowsItems[index]}')))
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: MyColors.whiteColor),
                        child: DataTable(
                          columnSpacing: 30,
                          dataRowHeight: 40,
                          headingRowHeight: 45,
                          columns: getColumnData(),
                          rows: getRowData(),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        Positioned(
            right: 13,
            top: 5,
            child: InkWell(
              onTap: onTapAdd,
              child: Container(
                // color: MyColors.whiteColor,
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.add),
                ),
              ),
            ))
      ],
    );
  }
}
