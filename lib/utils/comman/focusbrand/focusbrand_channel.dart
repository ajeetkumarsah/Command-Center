import 'package:flutter/material.dart';

import '../../../model/data_table_model.dart';
import '../../colors/colors.dart';
import '../../const/const_array.dart';
import '../../style/text_style.dart';

class FocusBrandChannel extends StatefulWidget {
  const FocusBrandChannel({Key? key}) : super(key: key);

  @override
  State<FocusBrandChannel> createState() => _FocusBrandChannelState();
}

class _FocusBrandChannelState extends State<FocusBrandChannel> {
  List<bool> _checkedItems = List<bool>.generate(5, (index) => false);
  int _selected = 0;
  bool _myBool = false;
  var isExpanded = false;
  List<String> items = ['Category', 'Brand', 'Brand form', 'Sub-brand form'];
  late List<DataTableModel> rowDataChannel;

  Color getColor(Set<MaterialState> states) {
    return const Color(0x257992D2);
  }
  Color getColorHeader(Set<MaterialState> states) {
    return const Color(0x387992D2);
  }

  Color getColorGray(Set<MaterialState> states) {
    return const Color(0x157992D2);
  }
  @override
  void initState() {
    rowDataChannel = DataTableModel.getRowsDataChannel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Theme(
          data: Theme.of(context).copyWith(// here for close state
            colorScheme: const ColorScheme.light(
              primary: MyColors.expandedTitle,
            ), // here for open state in replacement of deprecated accentColor
            dividerColor: Colors.transparent, // if you want to remove the border
          ),
          child: ExpansionTile(
            shape: const Border(),
            collapsedBackgroundColor: Colors.white,
            // backgroundColor: Colors.red,
            trailing: isExpanded? const Icon(Icons.keyboard_double_arrow_up_sharp, color: MyColors.primary,): const Icon(Icons.keyboard_double_arrow_down_sharp, color: MyColors.primary,),

            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Focus Brand by Channel",
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
                    padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                    child: Row(children: [
                      SizedBox(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              dividerColor: MyColors.whiteColor
                          ),
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
                                                      CrossAxisAlignment.start,
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
                                                                    top: 15),
                                                                child: ListView
                                                                    .builder(
                                                                    itemCount:
                                                                    4,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                    context,
                                                                        index) {
                                                                      return Container(
                                                                        height:
                                                                        45,
                                                                        color: index ==
                                                                            _selected
                                                                            ? Colors.white
                                                                            : null,
                                                                        child:
                                                                        ListTile(
                                                                          title:
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets.only(bottom: 8.0),
                                                                            child:
                                                                            Text(
                                                                              items[index],
                                                                              style: ThemeText.searchText,
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              _selected = index;
                                                                              print('Send email $index, $_selected');
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
                                                                color: Colors.white,
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
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                        left:
                                                                        20,
                                                                        right:
                                                                        20,
                                                                        top: 10,
                                                                        bottom:
                                                                        10),
                                                                    child:
                                                                    TextField(
                                                                      decoration:
                                                                      InputDecoration(
                                                                          prefixIcon:
                                                                          Icon(
                                                                            Icons.search,
                                                                            size:
                                                                            18,
                                                                          ),
                                                                          // border: ,
                                                                          hintText:
                                                                          'Search',
                                                                          hintStyle:
                                                                          ThemeText.searchHintText),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 35,
                                                                    child: Transform
                                                                        .scale(
                                                                      scale: 0.9,
                                                                      child: Row(
                                                                        children: [
                                                                          Checkbox(
                                                                            value:
                                                                            _myBool,
                                                                            checkColor:
                                                                            Colors.white,
                                                                            activeColor:
                                                                            MyColors.primary,
                                                                            shape:
                                                                            const RoundedRectangleBorder(
                                                                              borderRadius:
                                                                              BorderRadius.all(
                                                                                Radius.circular(5.0),
                                                                              ),
                                                                            ),
                                                                            onChanged:
                                                                                (isChecked) {
                                                                              setState(
                                                                                      () {
                                                                                    _myBool =
                                                                                        isChecked ?? false;
                                                                                  });
                                                                            },
                                                                          ),
                                                                          const Text(
                                                                            "Select all",
                                                                            style: ThemeText.sellectAllText,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top: 0.0),
                                                                      child: ListView.builder(
                                                                          itemCount: _selected == 0
                                                                              ? ConstArray().category.length
                                                                              : _selected == 1
                                                                              ? ConstArray().brand.length
                                                                              : _selected == 2
                                                                              ? ConstArray().brandform.length
                                                                              : ConstArray().subBrand.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return SizedBox(
                                                                              height:
                                                                              35,
                                                                              child:
                                                                              Transform.scale(
                                                                                scale:
                                                                                0.9,
                                                                                child:
                                                                                Row(
                                                                                  children: [
                                                                                    Checkbox(
                                                                                      value: _checkedItems[index],
                                                                                      checkColor: Colors.white,
                                                                                      activeColor: MyColors.primary,
                                                                                      shape: const RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.all(
                                                                                          Radius.circular(5.0),
                                                                                        ),
                                                                                      ),
                                                                                      onChanged: (isChecked) {
                                                                                        setState(() {
                                                                                          _checkedItems[index] = isChecked ?? false;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    Text(
                                                                                      _selected == 0
                                                                                          ? ConstArray().category[index]
                                                                                          : _selected == 1
                                                                                          ? ConstArray().brand[index]
                                                                                          : _selected == 2
                                                                                          ? ConstArray().brandform[index]
                                                                                          : ConstArray().subBrand[index],
                                                                                      style: ThemeText.sellectAllText,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }),
                                                                    ),
                                                                  ),
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
                                                                child: TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(
                                                                          context)
                                                                          .pop(
                                                                          true);
                                                                    },
                                                                    child:
                                                                    const Text(
                                                                      "Cancel",
                                                                      style: ThemeText.sheetCancelText,
                                                                    ))),
                                                            Expanded(
                                                                child: TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(
                                                                          context)
                                                                          .pop(
                                                                          true);
                                                                    },
                                                                    child:
                                                                    const Text(
                                                                      "Apply Filters",
                                                                      style: ThemeText.sheetallFilterText,
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
                                      child: Row(
                                        children: const [
                                          Text(
                                            'Channels',
                                            style: ThemeText.categoryText,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.edit_outlined,
                                              size: 15, color: Color(0xff576DFF))
                                        ],
                                      ),
                                    )),
                                numeric: true,
                                tooltip: 'Channels',
                              ),
                            ],
                            rows: List.generate(rowDataChannel.length, (index) {
                              final item = rowDataChannel[index];
                              return DataRow(
                                color: index == 0 ?MaterialStateProperty.resolveWith(
                                    getColorHeader)
                                    :
                                index == 5 ?MaterialStateProperty.resolveWith(
                                    getColorHeader)
                                    :
                                index == 6 ?MaterialStateProperty.resolveWith(
                                    getColorHeader)
                                    :
                                index == 1 ?MaterialStateProperty.resolveWith(
                                    getColor)
                                    :
                                index == 3 ?MaterialStateProperty.resolveWith(
                                    getColor)
                                    :
                                MaterialStateProperty.resolveWith(
                                    getColorGray),
                                cells: [
                                  DataCell(SizedBox(
                                      width: 70, child: Text('${item.name}')))
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
      data: Theme.of(context).copyWith(
          dividerColor: MyColors.whiteColor
      ),
      child: DataTable(
        columnSpacing: 10,
        dataRowHeight: 40,
        headingRowHeight: 45,
        sortColumnIndex: 0,
        columns: _buildColumns(),
        rows: List.generate(rowDataChannel.length, (index) {
          final item = rowDataChannel[index];
          return DataRow(
            color: index == 0 ?MaterialStateProperty.resolveWith(
                getColorHeader)
                :
            index == 5 ?MaterialStateProperty.resolveWith(
                getColorHeader)
                :
            index == 6 ?MaterialStateProperty.resolveWith(
                getColorHeader)
                :
            index == 1 ?MaterialStateProperty.resolveWith(
                getColor)
                :
            index == 3 ?MaterialStateProperty.resolveWith(
                getColor)
                :
            MaterialStateProperty.resolveWith(
                getColorGray),
            cells: [
              DataCell(
                SizedBox(
                    width: 60,
                    child: Text(
                      item.divi1,
                      textAlign: TextAlign.center,
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 60,
                    child: Text(
                      item.age,
                      textAlign: TextAlign.center,
                    )),
              ),
              DataCell(
                SizedBox(
                    width: 60,
                    child: Text(
                      item.role,
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
              'GP Actual',
              textAlign: TextAlign.center,
              style: ThemeText.tableHeaderText,
            )),
        numeric: true,
        tooltip: 'GP Actual',
      ),
      const DataColumn(
          label: SizedBox(
              width: 60,
              child: Text('GP OPP',
                  textAlign: TextAlign.center, style: ThemeText.tableHeaderText)),
          numeric: true,
          tooltip: 'GP OPP'),
      const DataColumn(
          label: SizedBox(
              width: 60,
              child: Text('GP COMP',
                  textAlign: TextAlign.center, style: ThemeText.tableHeaderText)),
          numeric: true,
          tooltip: 'GP COMP'),
    ];
  }
}
