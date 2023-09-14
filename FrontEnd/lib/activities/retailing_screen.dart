import 'package:command_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/data_table_model.dart';
import '../utils/comman/app_bar.dart';
import '../utils/comman/graph_container.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../utils/comman/retailing_table/retailing_category.dart';
import '../utils/comman/retailing_table/retailing_channel.dart';
import '../utils/comman/retailing_table/retailing_table.dart';
import '../utils/comman/retailing_table/retailing_trends.dart';
import '../utils/const/const_array.dart';
import '../utils/const/header_text.dart';

const double width = 110.0;
const double height = 50.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class RetailingScreen extends StatefulWidget {
  const RetailingScreen({Key? key}) : super(key: key);

  @override
  State<RetailingScreen> createState() => _RetailingScreenState();
}

class _RetailingScreenState extends State<RetailingScreen> {
  late List<DataTableModel> rowData;
  late bool sort = true;

  late double xAlign;
  late Color loginColor;
  late Color signInColor;
  List<ChartData>? chartData;

  var isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    rowData = DataTableModel.getRowsData();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MyColors.textColor
    ));
    final size = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: MyColors.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: CustumAppBar(title: 'Retailing'),
      ),
      body: SingleChildScrollView(

        child: SafeArea(
          child: Stack(
            children: [
              // Container(
              //   height: size.height,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/app_bar/background.png'),
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(title: "Retailing Summary"),
                  RetailingTable(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  ListTile(
                                    title: const Text('This is a Division sheet'),
                                    onTap: () {
                                    },
                                  ),
                                ],
                              );
                            });
                        // _openModalForAddColumn(context);
                      },
                      rowData: rowData,
                      sort: sort),
                  const RetailingCategory(),
                  const RetailingChannel(),
                  RetailingTrends(
                    isExpanded: isExpanded,
                    onExpansionChanged: (bool expanded) {
                      setState(() => isExpanded = expanded);
                    },
                    xAlign: xAlign,
                    onTap: () {
                      setState(() {
                        xAlign = loginAlign;
                        loginColor = selectedColor;
                        signInColor = normalColor;
                      });
                    },
                    loginColor: loginColor,
                    signInColor: signInColor,
                    onTapSign: () {
                      setState(() {
                        xAlign = signInAlign;
                        signInColor = selectedColor;

                        loginColor = normalColor;
                      });
                    },
                  )
                ],
              )
            ] ,
          ),
        ),
      ),
    );
  }
}

/// Private class for storing the stacked line 100 chart.
class ChartData {
  ChartData(this.x, this.father, this.mother, this.son, this.daughter);

  final String x;
  final num father;
  final num mother;
  final num son;
  final num daughter;
}

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}
