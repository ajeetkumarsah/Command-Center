import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../style/text_style.dart';

class RetailingTable extends StatelessWidget {
  final List rowData;
  final List<dynamic> rowData1;
  final bool sort;
  final Function() onTap;

  const RetailingTable(
      {Key? key,
      required this.rowData,
      required this.sort,
      required this.onTap,
      required this.rowData1})
      : super(key: key);

  Color getColor(Set<MaterialState> states) {
    return MyColors.dark600;
  }

  Color getColorHeader(Set<MaterialState> states) {
    return MyColors.dark500;
  }

  Color getColorGray(Set<MaterialState> states) {
    return MyColors.dark400;
  }

  @override
  Widget build(BuildContext context) {
    return rowData1.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Stack(
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
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            // color: MyColors.primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Row(children: [
                            SizedBox(
                              width: 84,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    dividerColor: MyColors.whiteColor),
                                child: DataTable(
                                  columnSpacing: 0,
                                  dataRowHeight: 35,
                                  headingRowHeight: 35,
                                  columns: const [
                                    DataColumn(
                                      label:
                                          SizedBox(width: 50, child: Text('')),
                                      numeric: true,
                                      tooltip: '',
                                    ),
                                  ],
                                  rows: List.generate(
                                      rowData1[0][0]['table'].length, (index) {
                                    return DataRow(
                                      color: index == 0
                                          ? MaterialStateProperty.resolveWith(
                                              getColorHeader)
                                          : index == 1
                                              ? MaterialStateProperty
                                                  .resolveWith(getColor)
                                              : index == 2
                                                  ? MaterialStateProperty
                                                      .resolveWith(getColorGray)
                                                  : index == 3
                                                      ? MaterialStateProperty
                                                          .resolveWith(
                                                              getColorHeader)
                                                      : index == 4
                                                          ? MaterialStateProperty
                                                              .resolveWith(
                                                                  getColor)
                                                          : index == 5
                                                              ? MaterialStateProperty
                                                                  .resolveWith(
                                                                      getColorGray)
                                                              : MaterialStateProperty
                                                                  .resolveWith(
                                                                      getColorGray),
                                      cells: [
                                        DataCell(SizedBox(
                                            width: 60,
                                            child: Text(
                                              '${rowData1[0][0]['table'][index]['key']}',
                                              style: ThemeText.tableTextText,
                                            )))
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: dataBody(sort, context),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 30,
                top: 5,
                child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                        width: 60,
                        height: 30,
                        color: MyColors.whiteColor,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.add),
                        ))),
              )
            ],
          );
  }

  Widget dataBody(bool sort, BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: MyColors.whiteColor),
      child: DataTable(
        columnSpacing: 10,
        dataRowHeight: 35,
        headingRowHeight: 35,
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: _buildColumnsSummary(),
        rows: List.generate(rowData1[0][0]['table'].length, (index) {
          return DataRow(
            color: index == 0
                ? MaterialStateProperty.resolveWith(getColorHeader)
                : index == 1
                    ? MaterialStateProperty.resolveWith(getColor)
                    : index == 2
                        ? MaterialStateProperty.resolveWith(getColorGray)
                        : index == 3
                            ? MaterialStateProperty.resolveWith(getColorHeader)
                            : index == 4
                                ? MaterialStateProperty.resolveWith(getColor)
                                : index == 5
                                    ? MaterialStateProperty.resolveWith(
                                        getColorGray)
                                    : MaterialStateProperty.resolveWith(
                                        getColorGray),
            cells: [
              DataCell(SizedBox(
                height: 100,
                width: 300,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: rowData1.length,
                    itemBuilder: (context, inde) {
                      // print("$index ${rowData1[2]}");
                      return Center(
                        child: SizedBox(
                            width: 60,
                            child: Text(
                              '${rowData1[inde][0]['table'][index]['data'][0]['cy_retailing_sum']}',
                              style: ThemeText.tableTextText,
                            )),
                      );
                    }),
              )),

            ],
          );
        }),
      ),
    );
  }

  List<DataColumn> _buildColumnsSummary() {
    return [
      DataColumn(
        label: SizedBox(
          height: 100,
          width: 300,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: rowData1.length,
              itemBuilder: (context, inde) {
                return Center(
                  child: SizedBox(
                      width: 60,
                      child: Text(
                        '${rowData1[inde][0]['filter_key']}',
                        style: ThemeText.tableTextText,
                      )),
                );
              }),
        ),
        numeric: true,
        tooltip: 'Name of user',
      ),
    ];
  }
}
