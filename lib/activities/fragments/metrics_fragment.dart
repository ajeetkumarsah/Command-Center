import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';
import '../../utils/comman/header_title_matrics.dart';
import '../../utils/style/text_style.dart';

class MetricsFragment extends StatelessWidget {
  const MetricsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.width - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    List<String> widgetList = [
      'Distribution',
      'Productivity',
      'Call Compliance',
      'Shipment',
      'Inventory'
    ];

    final listActive = [
      "Retailing",
      "Coverage",
      "Golden Points",
      "Focus Brand"
    ];

    List<String> storeList = [
      '# Stores Dist',
      '# Productivity',
      '# Call Compliance',
      '# Shipment',
      ' #Inventory'
    ];
    return Stack(
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
        // Container(
        //   height: 130,
        //   decoration: const BoxDecoration(
        //    color: Colors.brown
        //   ),
        // ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SizedBox(
              width: size.width,
              height: size.height + 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      "All Metrics",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: MyColors.textColor,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: GridView.count(
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      cacheExtent: 0.0,
                      childAspectRatio: (itemWidth / itemHeight),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: widgetList.map((String value) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.all(1.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeaderTitleMetrics(
                                    onPressed: () {},
                                    title: value,
                                    icon: Icons.arrow_outward_outlined,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: MyColors.textColor,
                                        fontFamily: fontFamily,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, left: 15),
                                    child: Text(
                                      "11.90",
                                      style: ThemeText.coverageDataText,
                                    ),
                                  ),
                                ],
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 30,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Shown in Summary',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w400,
                            color: MyColors.textHeaderColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              height: 56,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: index == 3 ? 0 : 1,
                                      color: MyColors.sheetDivider),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        listActive[index],
                                        style: const TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: MyColors.textHeaderColor),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.arrow_outward_outlined,
                                          color: MyColors.toggletextColor,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
