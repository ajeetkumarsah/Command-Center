import 'dart:convert';

import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/supply_chain/custom_widget/percentage_widget.dart';
import 'package:command_centre/web_dashboard/supply_chain/pages/avg.dart';
import 'package:command_centre/web_dashboard/supply_chain/pages/totalCostIncurred.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_dashboard.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:command_centre/web_dashboard/utils/logout/logout_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../helper/app_urls.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../../../utils/style/text_style.dart';
import '../../utils/summary_utils/morning_container.dart';

class DrawerWidgetSupplyChain extends StatefulWidget {
  final int indexNew;
  final List<dynamic> menuData;
  final Function() onClick;

  const DrawerWidgetSupplyChain({super.key, required this.indexNew, required this.onClick, required this.menuData});

  @override
  State<DrawerWidgetSupplyChain> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidgetSupplyChain> {
  int selectedIndex = 0;
  bool visible = false;
  List<dynamic> graphData = [];
  bool homeToggle = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.indexNew;
  }

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
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<TransportationProvider>(context);
    return Container(
      width: 270,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(1, 1),
          colors: <Color>[
            const Color(0xffFFFFFF).withOpacity(0.40),
            const Color(0xffFFFFFF).withOpacity(0.232),
            const Color(0xffFFFFFF).withOpacity(0.0),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
        ),
        border: Border.all(width: 0.4, color: MyColors.deselectColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 31, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                height: 64,
                width: size.width,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  border: Border.all(width: 0.4, color: MyColors.deselectColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Good morning!',
                            style: TextStyle(color: MyColors.textColor, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            SharedPreferencesUtils.getString('userName') ?? 'Demo',
                            style: const TextStyle(color: MyColors.textColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: fontFamily),
                          ),
                        ],
                      ),
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColors.deselectColor,

                            // border: Border.all(width: 0.4, color: MyColors.deselectColor),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: MyColors.whiteColor,
                            size: 30,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        selectedIndex = -1;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SupplyChainDashBoard(),
                        ),
                      );
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.home_filled, color: homeToggle ? MyColors.iconColorBlue : Colors.black,)),
                  ),
                  const SizedBox(width: 40,),
                  const Text('Overview', style: TextStyle(fontFamily: fontFamily,
                      fontSize: 18),
                    textAlign: TextAlign.center,)
                ],
              ),
            ),
            Expanded(
              child: widget.menuData.isEmpty
                  ? const Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()))
                  : ListView.separated(
                      separatorBuilder: (context, index) => Container(),
                      itemCount: widget.menuData[0]['menuData'].length - 1,
                      itemBuilder: (BuildContext context, index) {
                        index = index + 1;
                        return InkWell(
                          onTap: () async{
                            setState(() {
                              homeToggle = false;
                              selectedIndex = index;
                              selectedIndex == 1
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const AvgLandingPAge(),
                                      ),
                                    )
                                  : selectedIndex == 2
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => const TotalCostLAndingPage(),
                                          ),
                                        )
                                      //         : selectedIndex == 2
                                      //             ? Navigator.of(context).pushNamed('/cndsummary')
                                      //             : selectedIndex == 3
                                      //                 ? Navigator.of(context).pushNamed('/gpsummary')
                                      //                 : selectedIndex == 4
                                      //                     ? Navigator.of(context).pushNamed('/fbsummary')
                                      //                     : selectedIndex == 5
                                      //                         ? Navigator.of(context).pushNamed('/ccsummary')
                                      //                         : selectedIndex == 5
                                      //                             ? Navigator.of(context).pushNamed('/ccsummary')
                                      //                             : selectedIndex == 7
                                      //                                 ? _showLogoutPopup(context)
                                      : Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SupplyChainDashBoard(),
                                ),
                              );
                            });
                            provider.setGraphLoad(true);
                            String? val = widget.menuData[0]['menuData'][index]['title'];
                            provider.setSelectedGraph(val);
                            await postRequest(context);
                            setState(() {

                            });
                            provider.setGraphVisible(false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              // height: 90,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: selectedIndex == index ? MyColors.whiteColor : const Color(0xffFFFFFF).withOpacity(0.45),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: selectedIndex == index
                                    ? [
                                        const BoxShadow(
                                          color: Colors.black12, //(x,y)
                                          offset: Offset(-2.0, 3.0),
                                          blurRadius: 8.0,
                                        ),
                                      ]
                                    : const [
                                        BoxShadow(
                                          color: Colors.black12, //(x,y)
                                          blurRadius: 8.0,
                                        ),
                                      ],
                              ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20, left: 14, bottom: 20),
                                    child:
                                    // Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(left: 16),
                                    //             child: Text(
                                    //               widget.menuData[0]['menuData'][index]['title'],
                                    //               textAlign: TextAlign.left,
                                    //               style: TextStyle(
                                    //                   color: MyColors.textColor,
                                    //                   fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                    //                   fontFamily: fontFamily,
                                    //                   fontSize: 18),
                                    //             ),
                                    //           ),
                                    //           Padding(
                                    //             padding: const EdgeInsets.only(top: 12, left: 14),
                                    //             child: Row(
                                    //               children: [
                                    //                 provider.load
                                    //                     ? Container(height: 20, width: 20, child: const CircularProgressIndicator())
                                    //                     : Text(
                                    //                         '${widget.menuData[0]['menuData'][index]['num']}',
                                    //                         style: TextStyle(
                                    //                           fontSize: 40,
                                    //                           fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                    //                           color: const Color(0xffF10000),
                                    //                           fontFamily: fontFamily,
                                    //                         ),
                                    //                       ),
                                    //                 const Icon(
                                    //                   Icons.arrow_drop_down,
                                    //                   color: Color(0xffF10000),
                                    //                   size: 40,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           )
                                    //         ],
                                    //       )
                                        ( index > 0 && index < 5)
                                            ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 16, right: 12),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            widget.menuData[0]['menuData'][index]['title'],
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                                color: selectedIndex == index ? MyColors.textColor : MyColors.textColor,
                                                                fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                fontSize: 18,
                                                                fontFamily: fontFamily),
                                                          ),
                                                        ),
                                                        Consumer<TransportationProvider>(
                                                          builder: (context, provider, child) {
                                                            return InkWell(
                                                                onTap: () async {
                                                                  provider.setGraphLoad(true);
                                                                  setState(() {});
                                                                  String? val = widget.menuData[0]['menuData'][index]['title'];
                                                                  provider.setSelectedGraph(val);
                                                                  provider.setGraphVisible(true);
                                                                  await postRequest(context);
                                                                  provider.setGraphLoad(false);
                                                                },
                                                                child: const Icon(Icons.trending_up_sharp));
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        provider.load
                                                            ? Container(height: 20, width: 20, child: const CircularProgressIndicator())
                                                            : Text(
                                                                '${widget.menuData[0]['menuData'][index]['num']}',
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                    fontSize: 40,
                                                                    fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                    fontFamily: fontFamily),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left: 14, right: 14, top: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        PercentageWid(title: 'PM',percentage: "2%",check: true),
                                                        PercentageWid(title: 'PFY',percentage: "2%",check: false),
                                                        PercentageWid(title: 'PQ',percentage: "2%",check: true),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : index == 5
                                                ? Padding(
                                                    padding: const EdgeInsets.only(left: 16, right: 12),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          widget.menuData[0]['menuData'][index]['title'],
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            color: MyColors.textColor,
                                                            fontFamily: fontFamily,
                                                            fontSize: 18,
                                                            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              provider.load
                                                                  ? Container(height: 20, width: 20, child: const CircularProgressIndicator())
                                                                  : Text(
                                                                      '${widget.menuData[0]['menuData'][index]['num']['expected']}',
                                                                      style: TextStyle(
                                                                          fontSize: 40,
                                                                          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                          fontFamily: fontFamily),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Expected',
                                                          style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: fontFamily),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              provider.load
                                                                  ? Container(height: 20, width: 20, child: const CircularProgressIndicator())
                                                                  : Text(
                                                                      '${widget.menuData[0]['menuData'][index]['num']['actual']}',
                                                                      style: TextStyle(
                                                                          fontSize: 40,
                                                                          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                          fontFamily: fontFamily),
                                                                    ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${widget.menuData[0]['menuData'][index]['percentage']}',
                                                                    style: const TextStyle(
                                                                        color: Color(0xff00C108), fontFamily: fontFamily, fontSize: 18),
                                                                  ),
                                                                  const Icon(
                                                                    Icons.arrow_drop_up,
                                                                    color: Color(0xff00C108),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Actual',
                                                          style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: fontFamily),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const Text(
                                                    'No Data',
                                                  ),
                                  )),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }
}

class RoutePaths {
  static const String home = '/';
  static const String about = '/about';
  static const String contact = '/contact';
}
