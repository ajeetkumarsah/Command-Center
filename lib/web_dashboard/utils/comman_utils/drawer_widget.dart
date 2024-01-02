import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/web_dashboard/utils/logout/logout_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/colors.dart';
import '../summary_utils/morning_container.dart';

class DrawerWidget extends StatefulWidget {
  final int indexNew;

  const DrawerWidget({super.key, required this.indexNew});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int selectedIndex = 0;
  List arrayDrawer = [
    'Summary',
    'Retailing',
    'Coverage & Distribution',
    'Golden Points',
    'Focus Brand',
    'Call Compliance',
    'Productivity',
    'Logout'
    // 'Inventory',
    // 'Shipment',
    // 'Trends',
    // 'Templates',
    // 'View Abbreviations',
    // 'View Definitions'
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
      padding: const EdgeInsets.only(left: 15, top: 15, bottom: 0, right: 15),
      child: Container(
        width: 250,
        height: size.height,
        decoration: BoxDecoration(
          color: const Color(0xE6EFF3F7),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
          border: Border.all(width: 0.4, color: MyColors.deselectColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MorningContainer(),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => index == 6
                        ? const Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      child: Divider(
                          height: 1, color: MyColors.deselectColor),
                    )
                        : Container(),
                    itemCount: arrayDrawer.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            sheetProvider.isLoadedPage = false;
                            selectedIndex = index;
                            selectedIndex == 0
                                ? Navigator.of(context)
                                .pushNamed('/summary')
                                : selectedIndex == 1
                                ? Navigator.of(context)
                                .pushNamed('/retailingsummary')
                                : selectedIndex == 2
                                ? Navigator.of(context)
                                .pushNamed('/cndsummary')
                                : selectedIndex == 3
                                ? Navigator.of(context)
                                .pushNamed('/gpsummary')
                                : selectedIndex == 4
                                ? Navigator.of(context)
                                .pushNamed('/fbsummary')
                                : selectedIndex == 5
                                ? Navigator.of(context)
                                .pushNamed(
                                '/ccsummary')
                                : selectedIndex == 5
                                ? Navigator.of(context)
                                .pushNamed(
                                '/ccsummary')
                                : selectedIndex == 7
                                ? _showLogoutPopup(
                                context)
                                : Navigator.of(
                                context)
                                .pushNamed(
                                '/commonsummary');
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 40,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? MyColors.toggletextColor
                                  : MyColors.transparent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        arrayDrawer[index],
                                        style: TextStyle(
                                            color: selectedIndex == index
                                                ? MyColors.whiteColor
                                                : arrayDrawer[index] == "Logout"
                                                ? Colors.red
                                                : MyColors.textColor),
                                      ),
                                    ))),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
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

