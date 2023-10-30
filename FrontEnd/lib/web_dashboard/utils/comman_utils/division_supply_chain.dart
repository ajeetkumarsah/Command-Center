import 'dart:convert';

import 'package:command_centre/activities/retailing_screen.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/supply_chain/custom_widget/line_chart.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:command_centre/web_dashboard/utils/comman_utils/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../helper/app_urls.dart';

class SupplyChainDiv extends StatefulWidget{
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
    }, {
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

  List summary =[
    {
      'title' : 'MSU Shipped',
      'value': 234,
    },
    {
    'title' : 'Cost Incured',
    'value': "12L"
    },
    {
    'title' : '\$/SU',
    'value': 0.36
    },
    {
    'title' : 'XYZ value',
    'value': 0.36
    },
    {
    'title' : 'XYZ value',
    'value': 0.36
    }
  ];


  late int selectedGraphIndex = -1;
  bool val = false;
  List<dynamic> graphData = [];

  Future<http.Response> postRequest(context) async {

    final provider = Provider.of<TransportationProvider>(context, listen: false);
    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/webData/lineGraph';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "date": ["2023-Aug"],
      "category": [],
      "subBrandForm": [],
      "destinationCity": [],
      "sourceCity": [],
      "movement": [],
      "vehicleType": [],
      "name": provider.selectedGraph,
      "physicalYear": ""
    });
    print("Body Retailing Tab 1 $body");
    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        graphData = jsonDecode(response.body);
        print('data : $graphData');
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
    var size = MediaQuery
        .of(context)
        .size;

    List<DraggableGridItem> draggableCardList = List.generate(widget.matrixCardDataList.length,
            (index) {
          List<dynamic> item = widget.matrixCardDataList;
          // print(item);
          // return DraggableGridItem(child: Text('data'));
          return DraggableGridItem(
            isDraggable: true,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 3,
              child: SizedBox(
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
                                child: Text('${item[index]['title']}'),
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
                                    child: Icon(Icons.info_outline_rounded, size: 16,),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () async{
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
                                    child: Icon(Icons.trending_up_sharp, color: selectedGraphIndex == index? MyColors.iconColorBlue : MyColors.grey,),
                                  ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                    Container(height: 0.5, color: Colors.grey,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: provider.load ? const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator()) : Text('${item[index]['num']}', style: const TextStyle(fontFamily: fontFamily, fontSize: 30),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Row(children: [
                            Tooltip(
                              message: "Against last month",
                              child: Text(
                                '${item[index]['percentage']}',
                                style: TextStyle(fontFamily: fontFamily, fontSize: 20,
                                  color: item[index]['check'] ? const Color(0xff00C108) : const Color(0xffF10000),),
                              ),
                            ),
                            Icon(item[index]['check'] ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: item[index]['check'] ? const Color(0xff00C108) : const Color(
                                0xffF10000),)
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only( top: 6,bottom: 12),
                  child:  Container(
                    
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [BoxShadow(
                        blurRadius: 2,
                        color: MyColors.grey
                      )
                      ]
                    ),
                    width: (MediaQuery.of(context).size.width - 574) / 3,
                    child: ExpansionTile(
                      onExpansionChanged: (value){
                        setState(() {
                          val = !val;
                        });
                      },
                      title: const Text('Last Month Summary', textAlign: TextAlign.center,),
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
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                          childAspectRatio: 1/.17
                                        ),
                                        itemCount: summary.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text('${summary[index]['title']} : ${summary[index]['value']}', style: const TextStyle(fontSize: 16,
                                            fontFamily: fontFamily),),
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
                  height:val? size.height / 2 : size.height - 270,
                  width: (MediaQuery.of(context).size.width - 574) / 3,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Net Saving %', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  Text('2%', style: TextStyle(fontSize: 18, color: MyColors.iconColorRed, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_drop_up, color: MyColors.iconColorRed, size: 28,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3,bottom: 12),
                        child: Container(height: 0.5,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),),
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
                            const Text('YTD   69 \$/SU',textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 14),),

                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
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
              width: ((MediaQuery.of(context).size.width - 574) - (MediaQuery.of(context).size.width - 574) / 3),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 12
                      ),
                      child: SizedBox(
                        height: size.height,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        child: DraggableGridViewBuilder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2/1,
                          ),
                          isOnlyLongPress: true,
                          dragCompletion: (List<DraggableGridItem> list,
                              int beforeIndex, int afterIndex) {},
                          children:  draggableCardList,
                          dragPlaceHolder:
                              (List<DraggableGridItem> list, int index) {
                            return PlaceHolderWidget(
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          },
                          dragFeedback:
                              (List<DraggableGridItem> list, int index) {
                            return SizedBox(
                              width: 300,
                              child: list[index].child,
                            );
                          },
                        ),
                      ),
                    ),
                  ),


                  Consumer<TransportationProvider>(
                    builder: (context, provider, child) {
                      return Visibility(
                        visible: provider.graphVisible,
                        child: Expanded(child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 12,right: 12),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),

                            height: size.height / 2,
                            width: ((MediaQuery.of(context).size.width - 574) - (MediaQuery.of(context).size.width - 574) / 3),
                            child:  Stack(children: [
                              Positioned(
                                right: 10,
                                  top: 5,
                                  child: InkWell(
                                    onTap: (){
                                      provider.setGraphVisible(false);
                                    },
                                      child: const Icon(Icons.close, color: MyColors.iconColorRed,))),
                              SizedBox(
                                height: 100,
                                width: ((MediaQuery.of(context).size.width - 574) - (MediaQuery.of(context).size.width - 574) / 3),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${provider.selectedGraph}',textAlign: TextAlign.center,style: const TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),),
                                    ),
                                    Container(height: 0.5,
                                      color: MyColors.grey,),
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
                              provider.graphLoad ? Center(child: const CircularProgressIndicator()) : const Padding(
                                padding: EdgeInsets.only(top: 60),
                                child: LineChartSample(),
                              )]),
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
