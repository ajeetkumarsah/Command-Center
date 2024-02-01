import 'dart:convert';

import 'package:command_centre/activities/retailing_screen.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/supply_chain/custom_widget/line_chart.dart';
import 'package:command_centre/web_dashboard/supply_chain/custom_widget/percentage_widget.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../helper/app_urls.dart';
import '../../../utils/const/const_array.dart';
import '../../utils/comman_utils/bar_chart.dart';

class SupplyChainDiv extends StatefulWidget {
  final List<dynamic> matrixCardDataList;

  const SupplyChainDiv({Key? key, required this.matrixCardDataList}) : super(key: key);

  @override
  State<SupplyChainDiv> createState() => _SupplyChainDivState();
}

class _SupplyChainDivState extends State<SupplyChainDiv> {
  List arrayBarData = [
    {
      'title': 'Fabric care',
      'width': 24,
      'percentage': 21,
      'change': true,
      'check': false,
    },
    {
      'title': 'Baby care',
      'width': 18,
      'percentage': 14,
      'change': true,
      'check': false,
    },
    {
      'title': 'Feminine Care',
      'width': 21,
      'percentage': 0,
      'change': false,
      'check': false,
    },
    {
      'title': 'Hair care',
      'width': 16,
      'percentage': 9,
      'change': true,
      'check': true,
    },
    {
      'title': 'Health care',
      'width': 15,
      'percentage': 0,
      'change': false,
      'check': true,
    },
    {
      'title': 'Shave care',
      'width': 14,
      'percentage': 10,
      'change': true,
      'check': false,
    },
    {
      'title': 'Oral care',
      'width': 11,
      'percentage': 26,
      'change': true,
      'check': true,
    },
    {
      'title': 'Home care',
      'width': 4,
      'percentage': 14,
      'change': true,
      'check': true,
    },
    {
      'title': 'Skin & Personal',
      'width': 4,
      'percentage': 0,
      'change': false,
      'check': true,
    },
    {
      'title': 'Appliances',
      'width': 3,
      'percentage': 33,
      'change': true,
      'check': true,
    }
  ];

  List summary = [
    {
      'title': 'MSU Shipped',
      'value': 234,
    },
    {'title': 'Cost Incured', 'value': "12L"},
    {'title': '\$/SU', 'value': 0.36},
    {'title': 'XYZ value', 'value': 0.36},
    {'title': 'XYZ value', 'value': 0.36}
  ];

  late int selectedGraphIndex = -1;
  bool val = false;
  List<dynamic> graphData = [];

  Future<http.Response> postRequest(context) async {
    var year = DateTime.now().year;
    var month = ConstArray().month[DateTime.now().month - 1];

    final provider = Provider.of<TransportationProvider>(context, listen: false);
    var url = '$BASE_URL/api/webData/lineGraph';
    // var url = 'https://run.mocky.io/v3/23bca95e-6e4a-445e-bc26-4a3182187821';

    var body = json.encode({
      "date": provider.filterDate.isEmpty ? ["${year}-${month}"] : provider.filterDate,
      "category": [],
      "subBrandForm": [],
      "destinationCity": [],
      "sourceCity": [],
      "movement": [],
      "vehicleType": [],
      "name": provider.selectedGraph,
      "physicalYear": ""
    });

    var response =
        await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        graphData = jsonDecode(response.body);

        provider.setGraphDataList(graphData);
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransportationProvider>(context);
    var size = MediaQuery.of(context).size;


    List<DraggableGridItem> draggableCardList =
        List.generate(widget.matrixCardDataList.length-2, (index) {
          index = index + 2;
      List<dynamic> item = widget.matrixCardDataList;

      // return DraggableGridItem(child: Text('data'));
      return DraggableGridItem(
        isDraggable: true,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: item[index]['title'] == 'Avg VFR'
              ? SizedBox(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          // LinearProgressIndicator(),
                          // BarChart(),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            width: 80,
                            height: 6,
                            child: LinearProgressIndicator(
                              value: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 12),
                            child: provider.load
                                ? const SizedBox(
                                    width: 15, height: 15, child: CircularProgressIndicator())
                                : Text(
                                    '${item[index]['num']}%',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: MediaQuery.of(context).size.width / 60),
                                  ),
                          ),
                          const PercentageWid(
                            percentage: '2%',
                            check: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 80,
                            height: 6,
                            child: LinearProgressIndicator(
                              value: 50,
                            ),
                          ),
                          // _bargraph(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 12),
                            child: provider.load
                                ? const SizedBox(
                                    width: 15, height: 15, child: CircularProgressIndicator())
                                : Text(
                                    '${item[index]['num']}',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: MediaQuery.of(context).size.width / 60),
                                  ),
                          ),
                          const PercentageWid(
                            percentage: '2%',
                            check: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 80,
                            height: 6,
                            child: LinearProgressIndicator(
                              value: 50,
                            ),
                          ),
                          // _bargraph(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 12),
                            child: provider.load
                                ? const SizedBox(
                                    width: 10, height: 15, child: CircularProgressIndicator())
                                : Text(
                                    '${item[index]['num']}',
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: MediaQuery.of(context).size.width / 60),
                                  ),
                          ),
                          const PercentageWid(
                            percentage: '2%',
                            check: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              : item[index]['title'] == 'Avg MSU/Truck' ||
                      item[index]['title'] == 'Avg Volume/SU' ||
                      item[index]['title'] == 'KM/MSU' ||
                      item[index]['title'] == 'Avg Wt/SU'
                  ? SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, left: 12, bottom: 6),
                                      child: Text(
                                        '${item[index]['title']}',
                                        style:
                                            const TextStyle(fontFamily: fontFamily, fontSize: 13),
                                      ),
                                    ),
                                    Tooltip(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontFamily,
                                          fontSize: 12,
                                        ),
                                        message: '${item[index]['message']}',
                                        padding: const EdgeInsets.all(10),
                                        preferBelow: true,
                                        verticalOffset: 20,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 4, top: 3),
                                          child: Icon(
                                            Icons.info_outline_rounded,
                                            size: 16,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        provider.setGraphLoad(true);
                                        setState(() {});
                                        provider.setSelectedGraph(item[index]['title']);
                                        provider.setGraphVisible(true);
                                        selectedGraphIndex = index;
                                        // provider.se
                                        await postRequest(context);
                                        provider.setGraphLoad(false);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.trending_up_sharp,
                                          color: selectedGraphIndex == index
                                              ? MyColors.iconColorBlue
                                              : MyColors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 12),
                                child: provider.load
                                    ? const SizedBox(
                                        width: 15, height: 15, child: CircularProgressIndicator())
                                    : Text(
                                        '${item[index]['num']}',
                                        style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: MediaQuery.of(context).size.width / 60),
                                      ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PercentageWid(percentage: '2%', check: true, title: 'PM'),
                                PercentageWid(percentage: '2%', check: false, title: 'PFY'),
                                PercentageWid(percentage: '2%', check: true, title: 'PQ'),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, left: 12, bottom: 6),
                                      child: Text(
                                        '${item[index]['title']}',
                                        style:
                                            const TextStyle(fontFamily: fontFamily, fontSize: 13),
                                      ),
                                    ),
                                    Tooltip(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontFamily,
                                          fontSize: 12,
                                        ),
                                        message: '${item[index]['message']}',
                                        padding: const EdgeInsets.all(10),
                                        preferBelow: true,
                                        verticalOffset: 20,
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 4, top: 3),
                                          child: Icon(
                                            Icons.info_outline_rounded,
                                            size: 16,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        provider.setGraphLoad(true);
                                        setState(() {});
                                        provider.setSelectedGraph(item[index]['title']);
                                        provider.setGraphVisible(true);
                                        selectedGraphIndex = index;
                                        // provider.se
                                        await postRequest(context);
                                        provider.setGraphLoad(false);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.trending_up_sharp,
                                          color: selectedGraphIndex == index
                                              ? MyColors.iconColorBlue
                                              : MyColors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 12),
                                child: provider.load
                                    ? const SizedBox(
                                        width: 15, height: 15, child: CircularProgressIndicator())
                                    : Text(
                                        '${item[index]['num']}',
                                        style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: MediaQuery.of(context).size.width / 60),
                                      ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8, left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PercentageWid(
                                    percentage: '2%', check: true, title: 'Against Last month'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 12),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [BoxShadow(blurRadius: 2, color: MyColors.grey)]),
                    width: (MediaQuery.of(context).size.width - 574) / 3,
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        setState(() {
                          val = !val;
                        });
                      },
                      title: const Text(
                        'Last Month Summary',
                        textAlign: TextAlign.center,
                      ),
                      children: <Widget>[
                        Builder(
                          builder: (BuildContext context) {
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    height: 0.5,
                                    color: MyColors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      height: 80,
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2, childAspectRatio: 1 / .17),
                                        itemCount: summary.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              '${summary[index]['title']} : ${summary[index]['value']}',
                                              style: const TextStyle(
                                                  fontSize: 16, fontFamily: fontFamily),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: val ? size.height / 2.1 : size.height - 270,
                  width: (MediaQuery.of(context).size.width - 574) / 3,
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                        child: SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' Act \$/SU',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text('2%',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: MyColors.iconColorRed,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.arrow_drop_up,
                                    color: MyColors.iconColorRed,
                                    size: 28,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 12),
                        child: Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              color: MyColors.barColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'YTD   0.18 \$/SU',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 320,
                          child: ListView.builder(
                              itemCount: arrayBarData.length,
                              itemBuilder: (context, index) {
                                return BarChart(
                                    width: arrayBarData[index]['width'],
                                    title: arrayBarData[index]['title'],
                                    categoryWiseNum: arrayBarData[index]['width'],
                                    percentage: arrayBarData[index]['percentage'],
                                    change: arrayBarData[index]['change'],
                                    check: arrayBarData[index]['check']);
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: ((MediaQuery.of(context).size.width - 574) -
                  (MediaQuery.of(context).size.width - 574) / 3.12),
              child: Column(
                children: [
                  Container(
                    width: ((MediaQuery.of(context).size.width - 574) -
                        (MediaQuery.of(context).size.width - 574) / 3.12),
                    height: provider.graphVisible ? size.height / 3 : size.height - 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24, bottom: 6, top: 0),
                                child: Container(
                                  width: ((MediaQuery.of(context).size.width - 574) -
                                          (MediaQuery.of(context).size.width - 574) / 3.12) /
                                      3.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 5, spreadRadius: .3, color: Colors.grey)
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 8, left: 12, bottom: 6),
                                                  child: Text(
                                                    '${widget.matrixCardDataList[0]['title']}',
                                                    style: const TextStyle(
                                                        fontFamily: fontFamily, fontSize: 13),
                                                  ),
                                                ),
                                                Tooltip(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: fontFamily,
                                                      fontSize: 12,
                                                    ),
                                                    message:
                                                        '${widget.matrixCardDataList[0]['message']}',
                                                    padding: EdgeInsets.all(10),
                                                    preferBelow: true,
                                                    verticalOffset: 20,
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(left: 4, top: 3),
                                                      child: Icon(
                                                        Icons.info_outline_rounded,
                                                        size: 16,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    provider.setGraphLoad(true);
                                                    setState(() {});
                                                    provider.setSelectedGraph(
                                                        widget.matrixCardDataList[0]['title']);
                                                    provider.setGraphVisible(true);
                                                    // provider.se
                                                    await postRequest(context);
                                                    provider.setGraphLoad(false);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Icon(
                                                      Icons.trending_up_sharp,
                                                      color: selectedGraphIndex == 0
                                                          ? MyColors.iconColorBlue
                                                          : MyColors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8, left: 12),
                                            child: provider.load
                                                ? const SizedBox(
                                                    width: 15,
                                                    height: 15,
                                                    child: CircularProgressIndicator())
                                                : Text(
                                                    '${widget.matrixCardDataList[0]['num']}',
                                                    style: TextStyle(
                                                        fontFamily: fontFamily,
                                                        fontSize:
                                                            MediaQuery.of(context).size.width / 60),
                                                  ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8, left: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            PercentageWid(
                                                percentage: '2%', check: true, title: 'PM'),
                                            PercentageWid(
                                                percentage: '2%', check: false, title: 'PFY'),
                                            PercentageWid(
                                                percentage: '2%', check: true, title: 'PQ'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                    width: ((MediaQuery.of(context).size.width - 574) -
                                            (MediaQuery.of(context).size.width - 574) / 3.12) /
                                        1.6,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 5, spreadRadius: .3, color: Colors.grey)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12, top: 3),
                                          child: Row(
                                            children: [
                                              // LinearProgressIndicator(),
                                              // BarChart(),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30)),
                                                width: 200,
                                                height: 6,
                                                child: const LinearProgressIndicator(
                                                  value: 50,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, left: 12),
                                                child: provider.load
                                                    ? const SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child: CircularProgressIndicator())
                                                    : Text(
                                                        '${widget.matrixCardDataList[1]['num']}%',
                                                        style: TextStyle(
                                                            fontFamily: fontFamily,
                                                            fontSize:
                                                                MediaQuery.of(context).size.width /
                                                                    60),
                                                      ),
                                              ),
                                              const PercentageWid(
                                                percentage: '2%',
                                                check: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 200,
                                                height: 6,
                                                child: LinearProgressIndicator(
                                                  value: 50,
                                                ),
                                              ),
                                              // _bargraph(),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, left: 12),
                                                child: provider.load
                                                    ? const SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child: CircularProgressIndicator())
                                                    : Text(
                                                        '${widget.matrixCardDataList[1]['num']}%',
                                                        style: TextStyle(
                                                            fontFamily: fontFamily,
                                                            fontSize:
                                                                MediaQuery.of(context).size.width /
                                                                    60),
                                                      ),
                                              ),
                                              const PercentageWid(
                                                percentage: '2%',
                                                check: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 200,
                                                height: 6,
                                                child: LinearProgressIndicator(
                                                  value: 50,
                                                ),
                                              ),
                                              // _bargraph(),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, left: 12),
                                                child: provider.load
                                                    ? const SizedBox(
                                                        width: 10,
                                                        height: 15,
                                                        child: CircularProgressIndicator())
                                                    : Text(
                                                        '${widget.matrixCardDataList[1]['num']}%',
                                                        style: TextStyle(
                                                            fontFamily: fontFamily,
                                                            fontSize:
                                                                MediaQuery.of(context).size.width /
                                                                    60),
                                                      ),
                                              ),
                                              const PercentageWid(
                                                percentage: '2%',
                                                check: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                          Container(
                            width: ((MediaQuery.of(context).size.width - 574) -
                                (MediaQuery.of(context).size.width - 574) / 3),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(children: [
                                SizedBox(
                                  height: size.height,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: DraggableGridViewBuilder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 2 / 1.4,
                                    ),
                                    isOnlyLongPress: true,
                                    dragCompletion: (List<DraggableGridItem> list,
                                        int beforeIndex, int afterIndex) {},
                                    children: draggableCardList,
                                    dragPlaceHolder:
                                        (List<DraggableGridItem> list, int index) {
                                      return PlaceHolderWidget(
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                    dragFeedback: (List<DraggableGridItem> list, int index) {
                                      return SizedBox(
                                        width: 300,
                                        child: list[index].child,
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<TransportationProvider>(
                    builder: (context, provider, child) {
                      return Visibility(
                        visible: provider.graphVisible,
                        child: Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 12, right: 0),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            height: size.height / 1,
                            width: ((MediaQuery.of(context).size.width - 574) -
                                (MediaQuery.of(context).size.width - 574) / 3),
                            child: Stack(children: [
                              Positioned(
                                  right: 10,
                                  top: 5,
                                  child: InkWell(
                                      onTap: () {
                                        selectedGraphIndex = -1;
                                        provider.setGraphVisible(false);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: MyColors.iconColorRed,
                                      ))),
                              SizedBox(
                                height: 100,
                                width: ((MediaQuery.of(context).size.width - 574) -
                                    (MediaQuery.of(context).size.width - 574) / 3),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${provider.selectedGraph}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: fontFamily,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      height: 0.5,
                                      color: MyColors.grey,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 24,top: 12),
                                    //   child: Row(
                                    //     children: [
                                    //       Container(
                                    //         height: 15,
                                    //         width: 15,
                                    //         color: Colors.blue,
                                    //       ),
                                    //       const SizedBox(width: 10,),
                                    //       const Text('% Change', style: TextStyle(color: MyColors.grey),)
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              provider.graphLoad
                                  ? const Center(child: CircularProgressIndicator())
                                  : const Padding(
                                      padding: EdgeInsets.only(top: 60),
                                      child: LineChartSample(),
                                    )
                            ]),
                          ),
                        )),
                      );
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
