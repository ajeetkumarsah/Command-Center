import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/logout/logout_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/colors.dart';
import '../summary_utils/morning_container.dart';

class DrawerAlerts extends StatefulWidget {
  final int indexNew;

  const DrawerAlerts({super.key, required this.indexNew});

  @override
  State<DrawerAlerts> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerAlerts> {
  int selectedIndex = 0;

  List arrayAlerts = [
    {
      'date': '28 Sept, 2023',
      'massage':
          'Freight Cost Alert: This month\'s cost compared to last year same month (+X%), last fiscal year average (+Y%), and last quarter average (+Z%)',
      'check': true
    },
    {'date': '25 Sept, 2023', 'massage': 'Avg truck cost in lane A-B in increased by 20% from last month', 'check': true},
    {
      'date': '20 Sept, 2023',
      'massage':
          'Freight Cost Alert: This month\'s cost compared to last year same month (+X%), last fiscal year average (+Y%), and last quarter average (+Z%)',
      'check': true
    },
    {'date': '10 Sept, 2023', 'massage': 'Avg truck cost in lane A-B in increased by 20% from last month', 'check': true},
    {
      'date': '28 Sept, 2023',
      'massage': 'Spot placements are 10% of overall truck placements',
      'check': false,
    },
    {
      'date': '28 Sept, 2023',
      'massage': 'Avg truck cost in lane A-B in increased by 20% from last month',
      'check': false,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.indexNew;
  }

  void _handleLogout() {
    // Perform logout action
    print('Logged out');
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Container(
        color: Colors.white.withOpacity(0.2), // Set the desired background color and opacity
        child: Center(
          child: LogoutPopup(onLogout: _handleLogout),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 31, bottom: 24),
      child: Column(
        children: [
          Container(
            width: 250,
            height: size.height,
            decoration: BoxDecoration(
              color: MyColors.toggleColorWhite,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 3.0), //(x,y)
                  blurRadius: 8.0,
                ),
              ],
              border: Border.all(width: 0.4, color: MyColors.deselectColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'ALERTS',
                        style: TextStyle(color: Colors.red, fontFamily: fontFamily),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1.5,
                  color: Colors.grey,
                ),
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "CRITICAL",
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>  Container(),
                      itemCount: arrayAlerts.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              arrayAlerts[index]['check'] = false;
                            });
                          },
                          child: arrayAlerts[index]['check']
                              ? Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                  child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: MyColors.alertColorPrimary,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(arrayAlerts[index]['date']),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          arrayAlerts[index]['check'] = false;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.arrow_circle_down_sharp,
                                                        color: Color(0xff475DEF),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                        child: InkWell(
                                                          onTap: (){
                                                            setState(() {
                                                              arrayAlerts.removeAt(index);
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 18,
                                                            color: Colors.red,
                                                          ),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(arrayAlerts[index]['massage'], style: TextStyle(fontSize: 18),),
                                          )
                                        ],
                                      )),
                                )
                              : const SizedBox(),
                        );
                      }),
                ),
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "NON CRITICAL",
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Container(),
                      itemCount: arrayAlerts.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {},
                          child: arrayAlerts[index]['check'] != true
                              ? Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                  child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: MyColors.alertColorSecondary,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(arrayAlerts[index]['date']),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          arrayAlerts[index]['check'] = true;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.arrow_circle_up_sharp,
                                                        color: Color(0xff475DEF),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                        child: InkWell(
                                                          onTap: (){
                                                            setState(() {
                                                              arrayAlerts.removeAt(index);
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 18,
                                                            color: Colors.red,
                                                          ),
                                                        )),


                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(arrayAlerts[index]['massage'], style: TextStyle(fontSize: 18),),
                                          )
                                        ],
                                      )),
                                )
                              : const SizedBox(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
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
