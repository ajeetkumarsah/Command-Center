import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/colors.dart';
import '../sharedpreferences/sharedpreferences_utils.dart';

class CustumAppBar extends StatelessWidget {
  final String title;

  const CustumAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedDivision = SharedPreferencesUtils.getString('division')??'';
    var selectedSite = SharedPreferencesUtils.getString('site')??'';
    var selectedMonth = SharedPreferencesUtils.getString('fullMonth')??'';
    return SafeArea(
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(title, style: ThemeText.appBarTitleText),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Image(
              image: const AssetImage('assets/images/app_bar/header.png',),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 22),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0x90EFF3F7),
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                width: 0.1, color: MyColors.whiteColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             Text(
                              selectedDivision,
                              style: ThemeText.divisionText,
                            ),
                            Container(
                              width: 0.5,
                              color: MyColors.dividerColor,
                            ),
                             Text(
                              selectedSite,
                              style: ThemeText.divisionText,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0x90EFF3F7),
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                              width: 0.1, color: MyColors.whiteColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              selectedMonth,
                              style: ThemeText.divisionText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        backgroundColor: MyColors.transparent,
      ),
    );
  }
}
