import 'dart:convert';

import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/utils/const/const_variable.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../model/data_table_model.dart';
import '../../colors/colors.dart';
import '../../const/const_array.dart';

class RetailingChannel extends StatefulWidget {
  const RetailingChannel({Key? key}) : super(key: key);

  @override
  State<RetailingChannel> createState() => _RetailingChannelState();
}

class _RetailingChannelState extends State<RetailingChannel> {

  List<dynamic> flattenedList = [];
  List<dynamic> dataListRetailingChannel = [];

  List<dynamic> updatedList = [];
  int selectedArrayItemAllIndia = -1;
  int selectedArrayItemCluster = -1;
  int selectedArrayItemSite = -1;
  int selectedArrayItemDivision = -1;
  int selectedArrayItem = -1;

  Future<http.Response> postRequest(context) async {
    var url = '$BASE_URL/api/appData/mtdRetailingTable';

    var body = json.encode({
      "name": "channel",
      "type": "channel",
      "query": updatedList.isEmpty
          ? updatedList = [
        {"date": "Jun-2023", "allIndia": "allIndia", "channel": []}
      ]
          : updatedList
    });
    print("Body Channel Table $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        dataListRetailingChannel = jsonDecode(response.body);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return response;
  }

  Color getColor(Set<MaterialState> states) {
    return const Color(0x257992D2);
  }

  Color getColorHeader(Set<MaterialState> states) {
    return const Color(0x387992D2);
  }

  Color getColorGray(Set<MaterialState> states) {
    return const Color(0x157992D2);
  }

  late bool sort;
  late bool checkedValue;
  bool _myBool = false;
  int _selected = 0;
  var isExpanded = false;
  List<bool> _checkedItems = List<bool>.generate(5, (index) => false);
  List<String> items = ['Category', 'Brand', 'Brand form', 'Sub-brand form'];
  late List<DataTableModel> rowDataChannel;

  @override
  void initState() {
    rowDataChannel = DataTableModel.getRowsDataChannel();
    postRequest(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dataListRetailingChannel.isEmpty?Center(child: CircularProgressIndicator()): Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            // here for close state
            colorScheme: const ColorScheme.light(
              primary: MyColors.expandedTitle,
            ), // here for open state in replacement of deprecated accentColor
            dividerColor:
                Colors.transparent, // if you want to remove the border
          ),
          child: ExpansionTile(
            shape: const Border(),
            collapsedBackgroundColor: Colors.white,
            // backgroundColor: Colors.red,
            trailing: isExpanded
                ? const Icon(
                    Icons.keyboard_double_arrow_up_sharp,
                    color: MyColors.primary,
                  )
                : const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                    color: MyColors.primary,
                  ),
            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Retailing by Channel",
                style: ThemeText.categoryHeaderText,
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() => isExpanded = expanded);
            },
            children: <Widget>[
              Container(
                height: 300,
                margin: const EdgeInsets.only(bottom: 6.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffE2E6E9),
                      blurRadius: 15.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: Row(children: [
                      SizedBox(
                        // width: 90,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: MyColors.whiteColor),
                          child: DataTable(
                            columnSpacing: 0,
                            dataRowHeight: 40,
                            headingRowHeight: 45,
                            columns: [
                              DataColumn(
                                label: SizedBox(
                                    width: 75,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter
                                                          setState /*You can rename this!*/) {
                                                return Stack(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color(
                                                                    0xffEFF3F7),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            15),
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            4,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                index) {
                                                                              SharedPreferencesUtils.setString('mobileChannelDivision', items[_selected].toLowerCase());
                                                                          return Container(
                                                                            height:
                                                                                45,
                                                                            color: index == _selected
                                                                                ? Colors.white
                                                                                : null,
                                                                            child:
                                                                                ListTile(
                                                                              // contentPadding: EdgeInsets.symmetric(vertical: -10),
                                                                              // tileColor: index == _selected ?Colors.yellowAccent:Colors.red,
                                                                              title: Padding(
                                                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                                                child: Text(
                                                                                  items[index],
                                                                                  style: ThemeText.searchText,
                                                                                ),
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  _selected = index;
                                                                                  print('Send email $index, $_selected');
                                                                                  SharedPreferencesUtils.setString('mobileChannelDivision', items[index].toLowerCase());
                                                                                });
                                                                              },
                                                                            ),
                                                                          );
                                                                        }),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 4,
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                    child:
                                                                        TextField(
                                                                      decoration: InputDecoration(
                                                                          prefixIcon: Icon(
                                                                            Icons.search,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                          // border: ,
                                                                          hintText: 'Search',
                                                                          hintStyle: ThemeText.searchHintText),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(bottom: 30.0, top: 5),
                                                                      child: ListView.builder(
                                                                          itemCount: _selected == 0
                                                                              ? ConstArray().categoryNewList.length
                                                                              : _selected == 1
                                                                              ? ConstArray().brandNewList.length
                                                                              : _selected == 2
                                                                              ? ConstArray().brandformNewList.length
                                                                              : ConstArray().subBFNewList.length,
                                                                          itemBuilder:
                                                                              (BuildContext context, index) {

                                                                            return Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        // if (selectedArrayItemAllIndia == index || selectedArrayItemDivision == index || selectedArrayItemCluster == index || selectedArrayItemSite == index) {
                                                                                        //   selectedArrayItemAllIndia = -1;
                                                                                        //   selectedArrayItemCluster = -1;
                                                                                        //   selectedArrayItemSite = -1;
                                                                                        //   selectedArrayItemDivision = -1;
                                                                                        // } else {
                                                                                        _selected == 0
                                                                                            ? selectedArrayItemAllIndia =
                                                                                            index
                                                                                            : _selected == 1
                                                                                            ? selectedArrayItemDivision =
                                                                                            index
                                                                                            : _selected == 2
                                                                                            ? selectedArrayItemCluster =
                                                                                            index
                                                                                            : _selected == 3
                                                                                            ? selectedArrayItemSite =
                                                                                            index
                                                                                            : selectedArrayItem =
                                                                                            index;
                                                                                        // }

                                                                                        SharedPreferencesUtils.setString(
                                                                                            'ChannelSite',
                                                                                            _selected == 0
                                                                                                ? ConstArray().categoryNewList[index]
                                                                                                : _selected == 1
                                                                                                ? ConstArray().brandNewList[index]
                                                                                                : _selected == 2
                                                                                                ? ConstArray().brandformNewList[index]
                                                                                                : _selected == 3
                                                                                                ? ConstArray().subBFNewList[index]
                                                                                                : allIndia);

                                                                                        SharedPreferencesUtils.setString(
                                                                                            'mobileChannelSite',
                                                                                            _selected == 0
                                                                                                ? ConstArray().categoryNewList[index]
                                                                                                : _selected == 1
                                                                                                ? ConstArray().brandNewList[index]
                                                                                                : _selected == 2
                                                                                                ? ConstArray().brandformNewList[index]
                                                                                                : _selected == 3
                                                                                                ? ConstArray().subBFNewList[index]
                                                                                                : allIndia);


                                                                                      });
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding:
                                                                                      const EdgeInsets.only(
                                                                                          left: 20,
                                                                                          top: 5,
                                                                                          bottom: 4),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Container(
                                                                                              height: 15,
                                                                                              width: 15,
                                                                                              decoration: BoxDecoration(
                                                                                                  color: _selected == 0
                                                                                                      ? selectedArrayItemAllIndia == index
                                                                                                      ? Colors.blue
                                                                                                      : MyColors.transparent
                                                                                                      : _selected == 1
                                                                                                      ? selectedArrayItemDivision == index
                                                                                                      ? Colors.blue
                                                                                                      : MyColors.transparent
                                                                                                      : _selected == 2
                                                                                                      ? selectedArrayItemCluster == index
                                                                                                      ? Colors.blue
                                                                                                      : MyColors.transparent
                                                                                                      : _selected == 3
                                                                                                      ? selectedArrayItemSite == index
                                                                                                      ? Colors.blue
                                                                                                      : MyColors.transparent
                                                                                                      : MyColors.grey,
                                                                                                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                                                                  border: Border.all(
                                                                                                      color: _selected == 0
                                                                                                          ? selectedArrayItemAllIndia == index
                                                                                                          ? Colors.blue
                                                                                                          : MyColors.grey
                                                                                                          : _selected == 1
                                                                                                          ? selectedArrayItemDivision == index
                                                                                                          ? Colors.blue
                                                                                                          : MyColors.grey
                                                                                                          : _selected == 2
                                                                                                          ? selectedArrayItemCluster == index
                                                                                                          ? Colors.blue
                                                                                                          : MyColors.grey
                                                                                                          : _selected == 3
                                                                                                          ? selectedArrayItemSite == index
                                                                                                          ? Colors.blue
                                                                                                          : MyColors.grey
                                                                                                          : MyColors.grey,
                                                                                                      // width: selectedArrayItem == index ? 0 : 1)
                                                                                                      width: 1)),
                                                                                              child: _selected == 0
                                                                                                  ? selectedArrayItemAllIndia == index
                                                                                                  ? const Icon(
                                                                                                Icons
                                                                                                    .check,
                                                                                                color: MyColors
                                                                                                    .whiteColor,
                                                                                                size: 13,
                                                                                              )
                                                                                                  : null
                                                                                                  : _selected == 1
                                                                                                  ? selectedArrayItemDivision == index
                                                                                                  ? const Icon(
                                                                                                Icons
                                                                                                    .check,
                                                                                                color:
                                                                                                MyColors.whiteColor,
                                                                                                size:
                                                                                                13,
                                                                                              )
                                                                                                  : null
                                                                                                  : _selected == 2
                                                                                                  ? selectedArrayItemCluster == index
                                                                                                  ? const Icon(
                                                                                                Icons.check,
                                                                                                color: MyColors.whiteColor,
                                                                                                size: 13,
                                                                                              )
                                                                                                  : null
                                                                                                  : _selected == 3
                                                                                                  ? selectedArrayItemSite == index
                                                                                                  ? const Icon(
                                                                                                Icons.check,
                                                                                                color: MyColors.whiteColor,
                                                                                                size: 13,
                                                                                              )
                                                                                                  : null
                                                                                                  : null),
                                                                                          const SizedBox(
                                                                                            width: 8,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              _selected == 0
                                                                                                  ? ConstArray()
                                                                                                  .categoryNewList[
                                                                                              index]
                                                                                                  : _selected == 1
                                                                                                  ? ConstArray().brandNewList[
                                                                                              index]
                                                                                                  : _selected ==
                                                                                                  2
                                                                                                  ? ConstArray().brandformNewList[
                                                                                              index]
                                                                                                  : _selected ==
                                                                                                  3
                                                                                                  ? ConstArray().subBFNewList[
                                                                                              index]
                                                                                                  : allIndia,
                                                                                              maxLines: 2,
                                                                                              style: const TextStyle(
                                                                                                  fontFamily:
                                                                                                  fontFamily,
                                                                                                  fontWeight:
                                                                                                  FontWeight
                                                                                                      .w500,
                                                                                                  fontSize: 14,
                                                                                                  color: Color(
                                                                                                      0xff344C65)),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            );
                                                                          }),
                                                                    ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   height: 35,
                                                                  //   child: Transform
                                                                  //       .scale(
                                                                  //     scale:
                                                                  //         0.9,
                                                                  //     child:
                                                                  //         Row(
                                                                  //       children: [
                                                                  //         Checkbox(
                                                                  //           value:
                                                                  //               _myBool,
                                                                  //           checkColor:
                                                                  //               Colors.white,
                                                                  //           activeColor:
                                                                  //               MyColors.primary,
                                                                  //           shape:
                                                                  //               const RoundedRectangleBorder(
                                                                  //             borderRadius: BorderRadius.all(
                                                                  //               Radius.circular(5.0),
                                                                  //             ),
                                                                  //           ),
                                                                  //           onChanged:
                                                                  //               (isChecked) {
                                                                  //             setState(() {
                                                                  //               _myBool = isChecked ?? false;
                                                                  //             });
                                                                  //           },
                                                                  //         ),
                                                                  //         const Text(
                                                                  //           "Select all",
                                                                  //           style:
                                                                  //               ThemeText.sellectAllText,
                                                                  //         )
                                                                  //       ],
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                  // Expanded(
                                                                  //   child:
                                                                  //       Padding(
                                                                  //     padding: const EdgeInsets
                                                                  //         .only(
                                                                  //         top:
                                                                  //             0.0),
                                                                  //     child:
                                                                  //
                                                                  //     // ListView.builder(
                                                                  //         itemCount: _selected == 0
                                                                  //             ? ConstArray().categoryNewList.length
                                                                  //             : _selected == 1
                                                                  //                 ? ConstArray().brandNewList.length
                                                                  //                 : _selected == 2
                                                                  //                     ? ConstArray().brandformNewList.length
                                                                  //                     : ConstArray().subBFNewList.length,
                                                                  //     //     itemBuilder: (BuildContext context, index) {
                                                                  //     //       return SizedBox(
                                                                  //     //         height: 35,
                                                                  //     //         // child: Transform.scale(
                                                                  //     //         //   scale: 0.9,
                                                                  //     //         //   child: Row(
                                                                  //     //         //     children: [
                                                                  //     //               // Checkbox(
                                                                  //     //               //   value: _checkedItems[index],
                                                                  //     //               //   checkColor: Colors.white,
                                                                  //     //               //   activeColor: MyColors.primary,
                                                                  //     //               //   shape: const RoundedRectangleBorder(
                                                                  //     //               //     borderRadius: BorderRadius.all(
                                                                  //     //               //       Radius.circular(5.0),
                                                                  //     //               //     ),
                                                                  //     //               //   ),
                                                                  //     //               //   onChanged: (isChecked) {
                                                                  //     //               //     setState(() {
                                                                  //     //               //       _checkedItems[index] = isChecked ?? false;
                                                                  //     //               //     });
                                                                  //     //               //   },
                                                                  //     //               // ),
                                                                  //     //               // Text(
                                                                  //     //               //   _selected == 0
                                                                  //     //               //       ? ConstArray().categoryNewList[index]
                                                                  //     //               //       : _selected == 1
                                                                  //     //               //           ? ConstArray().brandNewList[index]
                                                                  //     //               //           : _selected == 2
                                                                  //     //               //               ? ConstArray().brandformNewList[index]
                                                                  //     //               //               : ConstArray().subBFNewList[index],
                                                                  //     //               //   style: ThemeText.sellectAllText,
                                                                  //     //               // )
                                                                  //     //           //   ],
                                                                  //     //           // ),
                                                                  //     //         // ),
                                                                  //     //       );
                                                                  //     //     }),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      bottom: 0,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop(true);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Cancel",
                                                                          style:
                                                                              ThemeText.sheetCancelText,
                                                                        ))),
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          print(SharedPreferencesUtils.getString('mobileChannelDivision'));
                                                                          print(SharedPreferencesUtils.getString('mobileChannelSite'));
                                                                          // Navigator.of(context)
                                                                          //     .pop(true);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Apply Filters",
                                                                          style:
                                                                              ThemeText.sheetallFilterText,
                                                                        )))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                            });
                                      },
                                      child: const Row(
                                        children: [
                                          Text('Channels',
                                              style: ThemeText.categoryText),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.edit_outlined,
                                              size: 15,
                                              color: Color(0xff576DFF))
                                        ],
                                      ),
                                    )),
                                numeric: true,
                                tooltip: 'Channels',
                              ),
                            ],
                            rows: List.generate(
                                dataListRetailingChannel[0][0]['table'][0]['data'].length, (index) {
                              return DataRow(
                              color:  index % 2 == 0
                                    ? MaterialStateProperty.resolveWith(getColorHeader)
                                    :
                                MaterialStateProperty.resolveWith(
                                    getColorGray),
                                cells: [
                                  DataCell(SizedBox(
                                      width: 60,
                                      child: Text(
                                        '${dataListRetailingChannel[0][0]['table'][0]['data'][index]['channel']}',
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
                          child: dataBodyChannel(),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataBodyChannel() {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: MyColors.whiteColor),
      child: DataTable(
        columnSpacing: 10,
        dataRowHeight: 40,
        headingRowHeight: 45,
        // sortAscending: sort,
        sortColumnIndex: 0,
        columns: _buildColumns(),
        rows: List.generate(dataListRetailingChannel[0][0]['table'][0]['data'].length, (index) {
          // final item = dataListRetailingChannel[0][0]['table'][0]['data'];
          return DataRow(
            color:
            index % 2 == 0
                ? MaterialStateProperty.resolveWith(getColorHeader)
                :
            // index == 5
            //         ?
            //   MaterialStateProperty.resolveWith(getColorHeader)
                    // : index == 6
                    //     ? MaterialStateProperty.resolveWith(getColorHeader)
                    //     : index == 1
                    //         ? MaterialStateProperty.resolveWith(getColor)
                    //         : index == 3
                    //             ? MaterialStateProperty.resolveWith(getColor)
                                MaterialStateProperty.resolveWith(
                                    getColorGray),
            cells: [
              DataCell(
                SizedBox(
                    width: 60,
                    child: Text(
                      '${dataListRetailingChannel[0][0]['table'][0]['data'][index]['IYA']}',
                      textAlign: TextAlign.center,
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 60,
                    child: Text(
                      '${dataListRetailingChannel[0][0]['table'][0]['data'][index]['cy_retailing_sum']}',
                      textAlign: TextAlign.center,
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 60,
                    child: Text(
                      '${dataListRetailingChannel[0][0]['table'][0]['data'][index]['py_retailing_sum']}',
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      const DataColumn(
        label: SizedBox(
            width: 60,
            child: Text(
              'IYA',
              textAlign: TextAlign.center,
              style: ThemeText.tableHeaderText,
            )),
        numeric: true,
        tooltip: 'IYA',
      ),
      const DataColumn(
          label: SizedBox(
              width: 60,
              child: Text('CY',
                  textAlign: TextAlign.center,
                  style: ThemeText.tableHeaderText)),
          numeric: true,
          tooltip: 'CY'),
      const DataColumn(
          label: SizedBox(
              width: 60,
              child: Text('PY',
                  textAlign: TextAlign.center,
                  style: ThemeText.tableHeaderText)),
          numeric: true,
          tooltip: 'PY'),
    ];
  }
}
