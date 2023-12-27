import 'package:command_centre/helper/app_urls.dart';
import 'package:flutter/material.dart';
import '../../../activities/coverage_screen.dart';
import '../../../model/data_table_model.dart';
import '../../colors/colors.dart';
import '../../const/const_array.dart';
import '../../sharedpreferences/sharedpreferences_utils.dart';
import '../../style/text_style.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'coverage_utils/coverage_chennel_sheet.dart';

class CityData1 {
  // final int id;
  final String city;
  final Map<String, dynamic> data;

  CityData1( this.city, this.data);

  factory CityData1.fromJson(Map<String, dynamic> json) {
    return CityData1(
      // json['id'] as int,
      json['channel'] as String,
      Map<String, dynamic>.from(json['data']),
    );
  }
}

class CoverageChannel extends StatefulWidget {
  final List rowData;
  final List rowsItems;
  final List itemCount;
  final List divisionCount;
  final List siteCount;
  final List branchCount;
  final List channelCount;

  final List<CityData1> data;
  const CoverageChannel({Key? key, required this.rowData, required this.rowsItems, required this.data, required this.itemCount, required this.divisionCount, required this.siteCount, required this.branchCount, required this.channelCount}) : super(key: key);

  @override
  State<CoverageChannel> createState() => _CoverageChannelState();
}

class _CoverageChannelState extends State<CoverageChannel> {
  List<bool> _checkedItems = List<bool>.generate(5, (index) => false);
  int _selected = 0;
  bool _myBool = false;
  var isExpanded = false;
  List<String> items = ['Category', 'Brand', 'Brand form', 'Sub-brand form'];
  late List<DataTableModel> rowDataChannel;
  List rowsItems = ['Billing', 'Coverage', 'Productive Calls'];
  String selectedDivision = '';

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
    fetchDataa();
  }


  List<Map<String, dynamic>> cityData = [];
    bool isLoding = false;
  Future<void> fetchDataa() async {
    var geoDivision =
        "${SharedPreferencesUtils.getString('coverageChannelD')??''}=${SharedPreferencesUtils.getString('coverageChannelDS')??''}";
    // var geoSite =
    //     "${SharedPreferencesUtils.getString('coverageChannelS')}=${SharedPreferencesUtils.getString('coverageChannelSS')}";
    // var geoCluster =
    //     "${SharedPreferencesUtils.getString('coverageChannelC')}=${SharedPreferencesUtils.getString('coverageChannelCS')}";
    var selectedDivision = SharedPreferencesUtils.getString('division') ?? '';
    var selectedSite = SharedPreferencesUtils.getString('site') ?? '';
    var selectedMonth = SharedPreferencesUtils.getString('fullMonth') ?? '';


    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/5b70ffc7-2ef5-4403-af72-74f7df7d5ffc'));
        // '$BASE_URL/api/appData/CBPByChannelData?$geoDivision&date=May-2023&${(selectedDivision).toLowerCase()}=$selectedSite'));
    if (response.statusCode == 200) {
      setState(() {
        isLoding = true;
      });

      final data = json.decode(response.body) as List<dynamic>;
      setState(() {

        cityData = data.map<Map<String, dynamic>>((item) => item as Map<String, dynamic>).toList();
        isLoding = false;
      });
    }
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
                "Coverage by Channel",
                style: ThemeText.categoryHeaderText,
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() => isExpanded = expanded);
            },
            children: <Widget>[
              isLoding == true?const Center(child: CircularProgressIndicator()):  Container(
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
                    child:  Padding(
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
                                columns: [
                                  DataColumn(
                                    label: InkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder: (BuildContext
                                              context,
                                                  StateSetter setState /*You can rename this!*/) {
                                                return CoverageChannelSheet(
                                                  list: widget.itemCount,
                                                  divisionList: widget.divisionCount,
                                                  siteList: widget.siteCount,
                                                  branchList: widget.branchCount,
                                                  selectedGeo: selectedDivision == 'Division'
                                                      ? 0
                                                      : selectedDivision == 'Cluster'
                                                      ? 1
                                                      : selectedDivision == 'Site'
                                                      ? 2
                                                      : selectedDivision == 'Branch'
                                                      ? 3
                                                      : 0,
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      fetchDataa();
                                                    });
                                                  }, channelList: widget.channelCount, onChannelTap: () {
                                                  // setState(() async {
                                                  //   Navigator.pop(context);
                                                  //   await fetchDataa();
                                                  // });
                                                },
                                                );
                                              });
                                            }).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: SizedBox(
                                          width: 60,
                                          child: Text(
                                            'Channel',
                                            textAlign: TextAlign.start,
                                            style: ThemeText.tableHeaderText,
                                          )),
                                    ),
                                    numeric: true,
                                    tooltip: 'Channel',
                                  ),
                                ],
                                rows: cityData.map<DataRow>((item) {
                                  return DataRow(
                                    color:
                                      MaterialStateColor.resolveWith((states) => getColorGray(states)),
                                    cells: <DataCell>[
                                      DataCell(Text(item['channel'], textAlign: TextAlign.center,)),
                                    ],
                                  );
                                }).toList()
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
                                columns: const <DataColumn>[
                                  DataColumn(label: Text('Billing',textAlign: TextAlign.start,)),
                                  DataColumn(label: Text('Coverage',textAlign: TextAlign.start,)),
                                  DataColumn(label: Text('Productive Calls',textAlign: TextAlign.start,)),
                                ],
                                rows: cityData.map<DataRow>((item) {
                                  return DataRow(
                                      color:
                                      MaterialStateColor.resolveWith((states) => getColorGray(states)),
                                    cells: <DataCell>[
                                      DataCell(Text(item['data']['Billing'].toString(),textAlign: TextAlign.start,)),
                                      DataCell(Text(item['data']['Coverage'].toString(),textAlign: TextAlign.start,)),
                                      DataCell(Text(item['data']['Productive Calls'].toString(),textAlign: TextAlign.start,)),
                                    ],
                                  );
                                }).toList(),
                              ),

                            ),
                          ),
                        ),
                      ]),
                    ),

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
            color:index == 0 ?MaterialStateProperty.resolveWith(
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

