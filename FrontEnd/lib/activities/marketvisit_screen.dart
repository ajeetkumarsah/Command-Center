import 'package:command_centre/activities/purpose_screen.dart';
import 'package:command_centre/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../utils/colors/colors.dart';
import '../utils/comman/login_appbar.dart';
import '../utils/comman/widget/login_header_subtitle.dart';
import '../utils/comman/widget/login_header_widget.dart';
import '../utils/style/text_style.dart';

class MarketVisit extends StatefulWidget {
  const MarketVisit({Key? key}) : super(key: key);

  @override
  State<MarketVisit> createState() => _MarketVisitState();
}

class _MarketVisitState extends State<MarketVisit> {
  int selectedContainerIndex = 0;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginAppBar(),
            const Padding(
              padding: EdgeInsets.only(
                  left: margin, right: margin, bottom: 10, top: 80),
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginHeaderWidget(
                  title: "Let's set you up!",
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: margin, right: margin, bottom: 2),
                child: LoginHeaderSubtitle(
                  subtitle:
                  " Choose location to generate the data for",
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: margin, right: margin, bottom: 35),
                child: LoginHeaderSubtitle(
                  subtitle:
                  " Market Visit",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 10),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Select Branch',
                  labelStyle: TextStyle(
                      fontSize: 16
                    ,fontWeight: FontWeight.w400,
                          color: MyColors.textSubTitleColor,
                          letterSpacing: 1
                          ,fontFamily: fontFamily,

                  ),
                    border: InputBorder.none,
                  // border: InputBorder(borderSide: BorderSide(color: MyColors.radialGradient1)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.grayBorder)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                  contentPadding: EdgeInsets.only(left: 10, right: 5,),
                ),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonHideUnderline(

                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selectedValue,
                        items: [
                          const DropdownMenuItem(
                            value: "",
                            child: Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 16
                                ,fontWeight: FontWeight.w400,
                                color: MyColors.textSubTitleColor,
                                letterSpacing: 1
                                ,fontFamily: fontFamily,
                              ),
                            ),
                          ),
                          ...[
                            'Branch A',
                            'Branch B',
                            'Branch C',
                            'Branch D'
                          ].map<DropdownMenuItem<String>>((data) {
                            return DropdownMenuItem(
                              value: data,
                              child: Text(
                                data,
                              ),
                            );
                          }).toList(),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23, top: 50),
              child: SizedBox(
                height: 56,
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.home);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                      shape: const StadiumBorder(),
                      backgroundColor: MyColors.toggletextColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Get Started', style: TextStyle(fontWeight: FontWeight.w700,fontFamily: fontFamily, fontSize: 18, letterSpacing: 0.6)),
                      const SizedBox(
                        width: 5,
                      ),
                      selectedContainerIndex == 0
                          ? Container()
                          : const Icon(
                        Icons.arrow_forward,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Go Back",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: MyColors.showMoreColor,
                      fontFamily: fontFamily,
                    ),

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
