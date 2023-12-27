import 'dart:async';

import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/comman/market_visit/getstartedIntro.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PromptToManuallyScreen extends StatefulWidget {
  const PromptToManuallyScreen({super.key});

  @override
  State<PromptToManuallyScreen> createState() => _PromptToManuallyScreenState();
}

class _PromptToManuallyScreenState extends State<PromptToManuallyScreen>
    with SingleTickerProviderStateMixin {
  bool _inArrow = false;
  bool _outArrow = false;
  bool _flag = false;
  late TabController _tabController;
  String selectedValue = "Distributor Name";
  String selectedValue1 = "Branch Location";
  String selectedValue2 = "Channel";
  bool isSelectedManually = false;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Distributor Name",
          child: Text("Distributor Name")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Branch Location",
          child: Text("Branch Location")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Channel", child: Text("Channel")),
      const DropdownMenuItem(value: "Canada", child: Text("Canada")),
      const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
      const DropdownMenuItem(value: "England", child: Text("England")),
    ];
    return menuItems;
  }

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(19.1135806, 72.7762186);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _inArrow = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff587DDD),
                  Color(0xff69B9D7),
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffF2F6FD),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x66000000),
                        offset: Offset(0.0, 0.5), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Image.asset("assets/icon/storeicon.png"),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 11, left: 25, right: 25),
                          child: Container(
                            height: 2,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: MyColors.primary,
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xffD9D9D9),
                                  MyColors.primary,
                                  MyColors.primary,
                                  Color(0xffD9D9D9),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GetStaredIntroWidget(
                                color: Color(0xffCCCDD2),
                                title: 'Get Started',
                                icon: Icons.flag,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: GetStaredIntroWidget(
                                  color: Color(0xff1ACA8E),
                                  title: 'Select Store \n& Distributor',
                                  icon: Icons.storefront,
                                ),
                              ),
                              GetStaredIntroWidget(
                                color: Color(0xffCCCDD2),
                                title: 'Dashboard',
                                icon: Icons.insert_chart_outlined,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: Container(
                            height: 40,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x66000000),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: (){
                                        isSelectedManually = false;
                                        print("1");
                                        setState(() {});
                                      },
                                      child: Container(
                                          height: 40,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color:isSelectedManually ==false? MyColors.primary:MyColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Search Manually",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: isSelectedManually ==false? MyColors.whiteColor:MyColors.primary,
                                                  fontFamily: fontFamily,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: (){
                                        isSelectedManually = true;
                                        setState(() {});
                                        print("2");
                                      },
                                      child: Container(
                                          height: 40,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: isSelectedManually ==true? MyColors.primary:MyColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Find on Map",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: isSelectedManually ==true? MyColors.whiteColor:MyColors.primary,
                                                  fontFamily: fontFamily,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 30.0, right: 30),
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MyColors.whiteColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: DropdownButton(
                      iconDisabledColor: MyColors.whiteColor,
                      iconEnabledColor: MyColors.whiteColor,
                      underline: Container(
                        color: MyColors.whiteColor,
                      ),
                      style: const TextStyle(color: MyColors.whiteColor),
                      value: selectedValue,
                      items: dropdownItems,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 30.0, right: 30),
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MyColors.whiteColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: DropdownButton(
                      iconDisabledColor: MyColors.whiteColor,
                      iconEnabledColor: MyColors.whiteColor,
                      underline: Container(
                        color: MyColors.whiteColor,
                      ),
                      style: const TextStyle(color: MyColors.whiteColor),
                      value: selectedValue1,
                      items: dropdownItems1,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 30.0, right: 30),
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MyColors.whiteColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: DropdownButton(
                      iconDisabledColor: MyColors.whiteColor,
                      iconEnabledColor: MyColors.whiteColor,
                      underline: Container(
                        color: MyColors.whiteColor,
                      ),
                      style: const TextStyle(color: MyColors.whiteColor),
                      value: selectedValue2,
                      items: dropdownItems2,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                isSelectedManually == true?  Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 30),
                  child: Container(
                    height: 40,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Select Store Below',
                        maxLines: 2,
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ):Container(),
              isSelectedManually == true?
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                    ),
                  ),
                )
                  :
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          left: _inArrow
                              ? !_outArrow
                              ? 0.0
                              : 50
                              : -50.0,
                          // Hide the arrow by moving it outside the screen
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // _outArrow = !_outArrow;
                                _flag = !_flag;
                                // _onIntroEnd(context);
                              });
                              // Navigator.pushReplacementNamed(
                              //     context, RoutesName.pglogin);
                            },
                            child: Container(
                              width: _inArrow
                                  ? !_outArrow
                                  ? 70
                                  : 0
                                  : 0,
                              height: _inArrow
                                  ? !_outArrow
                                  ? 70
                                  : 0
                                  : 0,
                              decoration: BoxDecoration(
                                color: _flag
                                    ? const Color(0xffEBEDF0)
                                    : Colors.white,
                                // Customize the background color
                                shape: BoxShape.circle,
                              ),
                              child: Opacity(
                                opacity: _inArrow
                                    ? !_outArrow
                                    ? 1.0
                                    : 0.0
                                    : 0.0,
                                // Show/hide the arrow
                                // child: const Icon(
                                //   Icons.arrow_forward,
                                //   color: MyColors.primary,
                                //   size: 39,
                                // ),
                                child: Image.asset(
                                  'assets/icon/arrow_left.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
