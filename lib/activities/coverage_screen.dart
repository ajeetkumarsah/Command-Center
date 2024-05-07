import '../utils/colors/colors.dart';
import '../utils/comman/app_bar.dart';
import 'package:flutter/material.dart';
import '../model/data_table_model.dart';
import '../utils/const/header_text.dart';
import '../utils/comman/coverage/coverage_channel.dart';
import '../utils/comman/coverage/coverage_category.dart';
import 'package:command_centre/activities/retailing_screen.dart';
import 'package:command_centre/utils/comman/coverage/coverage_table.dart';
import 'package:command_centre/utils/comman/coverage/coverage_trends.dart';
import '../utils/comman/coverage/coverage_utils/coverage_table_sheet.dart';



class CityData {
  final int id;
  final String city;
  final Map<String, dynamic> data;

  CityData(this.id, this.city, this.data);

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      json['id'] as int,
      json['city'] as String,
      Map<String, dynamic>.from(json['data']),
    );
  }
}

class CoverageScreen extends StatefulWidget {
  final List itemCount;
  final List divisionCount;
  final List siteCount;
  final List branchCount;
  final List channelCount;

  const CoverageScreen(
      {Key? key,
      required this.itemCount,
      required this.divisionCount,
      required this.siteCount,
      required this.branchCount,
      required this.channelCount})
      : super(key: key);

  @override
  State<CoverageScreen> createState() => _CoverageScreenState();
}

class _CoverageScreenState extends State<CoverageScreen> {
  late List<DataTableModel> rowData;
  late bool sort = true;

  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  List<ChartData>? chartData;
  var isExpanded = false;
  List rowsItems = [ 'Coverage', 'Productive Calls'];
  String selectedDivision = '';

  @override
  void initState() {
    // TODO: implement initState
    rowData = DataTableModel.getRowsDataCoverage();
    // fetchCoverageSummary(context);
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;

    super.initState();
  }

  List<CityData> data = [];
  List<CityData1> dataa = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: CustumAppBar(title: 'Coverage'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_bar/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(title: "Coverage Summary | CM"),
                  CoverageTable(
                    sort: sort,
                    onTap: () {},
                    rowData: rowData,
                    data: data,
                    rowsItems: rowsItems,
                    onTapAdd: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (BuildContext
                                    context,
                                StateSetter setState /*You can rename this!*/) {
                              return CoverageSummarySheet(
                                list: widget.itemCount,
                                divisionList: widget.divisionCount,
                                siteList: widget.siteCount,
                                branchList: widget.branchCount,
                                selectedGeo:
                                    selectedDivision == 'Channel' ? 0 : 0,
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              );
                            });
                          }).then((value) {
                        setState(() {});
                      });
                    },
                  ),
                  const CoverageCategory(),
                  CoverageChannel(
                    rowData: rowData,
                    data: dataa,
                    rowsItems: rowsItems,
                    itemCount: widget.itemCount,
                    divisionCount: widget.divisionCount,
                    siteCount: widget.siteCount,
                    branchCount: widget.branchCount,
                    channelCount: widget.channelCount,
                  ),
                  CoverageTrends(
                    isExpanded: isExpanded,
                    onExpansionChanged: (bool expanded) {
                      setState(() => isExpanded = expanded);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
