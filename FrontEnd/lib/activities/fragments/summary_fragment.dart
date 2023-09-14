import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/http_call.dart';
import '../../model/all_metrics.dart';
import '../../model/app_data.dart';
import '../../utils/comman/bottom_sheet/drawer_sheet.dart';
import '../../utils/comman/circulatr_container.dart';
import '../../utils/comman/container_shape.dart';
import '../../utils/comman/coverage_container.dart';
import '../../utils/comman/home_page/division_dropdown.dart';
import '../../utils/comman/home_page/header_container.dart';
import '../../utils/comman/home_page/get_all_metrics_data.dart';
import '../../utils/comman/new_cards.dart';
import '../dgpcompliance_screen.dart';
import '../focasbrand_screen.dart';

class SummaryFragment extends StatelessWidget {
  final bool myBool;
  final int selected;
  final Function() onTap;
  final Function() onTapMonth;
  final Function() onTapBO;
  final Function() onTapMV;
  final Function() onTapPer;
  final Function() onCrossTap;
  final List itemCount;
  final List divisionCount;
  final List siteCount;
  final List branchCount;
  final List channelCount;

  final Color colorBO;
  final Color colorMV;
  final bool switchValue;
  final Function(bool)? onChanged;
  final String division;
  final String state;
  final String month;
  final List<AllMetrics> includedData;
  final List<AllMetrics> metricData;
  final List<AllMetrics> allMetrics;

  const SummaryFragment(
      {Key? key,
      required this.myBool,
      required this.selected,
      required this.onTap,
      required this.onTapMonth,
      required this.onTapBO,
      required this.onTapMV,
      required this.colorBO,
      required this.colorMV,
      required this.switchValue,
      required this.onChanged,
      required this.division,
      required this.state,
      required this.month,
      required this.includedData,
      required this.metricData,
      required this.allMetrics,
      required this.onTapPer,
      required this.onCrossTap,
      required this.itemCount,
      required this.divisionCount,
      required this.siteCount,
      required this.branchCount,
      required this.channelCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Future<DataModel> myFuture;

    Future<DataModel> _fetchData() async {
      return await fetchMtdRetailing(context);
    }

    myFuture = _fetchData();
    final size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/app_bar/homebackground.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: size.height / 2.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_bar/rec383.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: size.height / 2.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_bar/group9.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: size.height / 2.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_bar/rec384.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Container(
            height: size.height / 2.88,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: const [0, 0.5],
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: HeaderContainer(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context,
                                      StateSetter
                                          setState /*You can rename this!*/) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: DrawerSheet(
                                    onTapBO: onTapBO,
                                    onTapMV: onTapMV,
                                    colorBO: colorBO,
                                    colorMV: colorMV,
                                  ),
                                );
                              });
                            });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DivisionDropDown(
                    onTap: onTap,
                    onTapMonth: onTapMonth,
                    division: division,
                    state: state,
                    month: month,
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  FutureBuilder<DataModel>(
                    future: myFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final appData = snapshot.data;
                        return Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: includedData.length,
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final include = includedData[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child:
                                        include.name == "Retailing"
                                            ? ContainerShape(
                                                cmIya: appData!
                                                    .mtdRetailing!.cmIya!,
                                                cmSalience: appData
                                                    .mtdRetailing!.cmSaliance!,
                                                cmSellout: appData
                                                    .mtdRetailing!.cmSellout!,
                                                tgtiya: appData
                                                    .mtdRetailing!.tgtIya!,
                                                tgtSalience: appData
                                                    .mtdRetailing!.tgtSaliance!,
                                                tgtSellout: appData
                                                    .mtdRetailing!.tgtSellout!)
                                            : include.name == "Coverage"
                                                ? CoverageContainer(
                                                    cmCoverage: appData!
                                                        .coverage!.cmCoverage!,
                                                    billingPercentage: appData
                                                        .coverage!.billing!,
                                                    title: 'Coverage',
                                                    divisionCount:
                                                        divisionCount,
                                                    siteCount: siteCount,
                                                    branchCount: branchCount,
                                                    itemCount: itemCount,
                                                    channelCount: channelCount,
                                                  )
                                                : include.name ==
                                                        "Golden Points"
                                                    ? CircularContainer(
                                                        title:
                                                            'DGP Compliance - ',
                                                        perTitle: 'DGP Comp.',
                                                        salience:
                                                            'GP Abs (in M)',
                                                        sellout: 'GP IYA',
                                                        dgpCom: appData!
                                                            .dgpCompliance!
                                                            .gpAchievememt!,
                                                        // dgpCom: appData.dgpCompliance.dgpCompliance,
                                                        actual: appData
                                                            .dgpCompliance!
                                                            .gpAbs!,
                                                        opportunity: appData
                                                            .dgpCompliance!
                                                            .gpIYA!,
                                                        // opportunity: appData.dgpCompliance.gpOpportunity,
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const DGPComplianceScreen()));
                                                        },
                                                        subTitle: 'P3M',
                                                      )
                                                    : include.name ==
                                                            "Focus Brand"
                                                        ? CircularContainer(
                                                            title:
                                                                'Focus Brand - ',
                                                            perTitle:
                                                                'FB Achieve.',
                                                            salience:
                                                                'FB Actual (in M)',
                                                            sellout: '',
                                                            dgpCom: appData!
                                                                .focusBrand!
                                                                .fbAchievement!,
                                                            actual: appData
                                                                .focusBrand!
                                                                .fbActual!,
                                                            opportunity: "-1",
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const FocusBrandScreen()));
                                                            },
                                                            subTitle: 'CM',
                                                          )
                                                        : include.name ==
                                                                "Productivity"
                                                            ? CoverageContainer(
                                                                cmCoverage: appData!
                                                                    .productivity!
                                                                    .productivityCurrentMonth!,
                                                                billingPercentage: appData
                                                                    .productivity!
                                                                    .productivityPreviousMonth!,
                                                                title:
                                                                    'Productivity',
                                                                divisionCount:
                                                                    divisionCount,
                                                                siteCount:
                                                                    siteCount,
                                                                branchCount:
                                                                    branchCount,
                                                                itemCount:
                                                                    itemCount,
                                                                channelCount:
                                                                    channelCount,
                                                              )
                                                            : include.name ==
                                                                    "Call Compliance"
                                                                ? CoverageContainer(
                                                                    cmCoverage: appData!
                                                                        .callCompliance!
                                                                        .ccCurrentMonth!,
                                                                    billingPercentage: appData
                                                                        .callCompliance!
                                                                        .ccPreviousMonth!,
                                                                    title:
                                                                        'Call Compliance',
                                                                    divisionCount:
                                                                        divisionCount,
                                                                    siteCount:
                                                                        siteCount,
                                                                    branchCount:
                                                                        branchCount,
                                                                    itemCount:
                                                                        itemCount,
                                                                    channelCount: [
                                                                      channelCount
                                                                    ],
                                                                  )
                                                                : include.name ==
                                                                        "Shipment"
                                                                    ? CoverageContainer(
                                                                        cmCoverage:
                                                                            "${appData!.shipment!.shipmentActual!}",
                                                                        billingPercentage:
                                                                            "${appData.shipment!.shipmentIYA!}",
                                                                        title:
                                                                            'Shipment',
                                                                        divisionCount:
                                                                            divisionCount,
                                                                        siteCount:
                                                                            siteCount,
                                                                        branchCount:
                                                                            branchCount,
                                                                        itemCount:
                                                                            itemCount,
                                                                        channelCount:
                                                                            channelCount,
                                                                      )
                                                                    : include.name ==
                                                                            "Inventory"
                                                                        ? CoverageContainer(
                                                                            cmCoverage:
                                                                                "${appData!.inventory!.inventoryIYA!}",
                                                                            billingPercentage:
                                                                                "${appData.inventory!.inventoryActual!}",
                                                                            title:
                                                                                'Inventory',
                                                                            divisionCount:
                                                                                divisionCount,
                                                                            siteCount:
                                                                                siteCount,
                                                                            branchCount:
                                                                                branchCount,
                                                                            itemCount:
                                                                                itemCount,
                                                                            channelCount:
                                                                                channelCount,
                                                                          )
                                                                        : include.name ==
                                                                                "Billing"
                                                                            ? CoverageContainer(
                                                                                cmCoverage: "${appData!.inventory!.inventoryIYA!}",
                                                                                billingPercentage: "${appData.inventory!.inventoryActual!}",
                                                                                title: 'Billing',
                                                                                divisionCount: divisionCount,
                                                                                siteCount: siteCount,
                                                                                branchCount: branchCount,
                                                                                itemCount: itemCount,
                                                                                channelCount: channelCount,
                                                                              )
                                                                            : include.name == "BT%"? const NewCardsForSales(title: 'BT% ', subTitle: '12.8',):
                                                                              include.name == "NOS (MM)"? const NewCardsForSales(title: 'NOS (MM) ', subTitle: '1654',):
                                                                              include.name == "MSE%"? const NewCardsForSales(title: 'MSE% ', subTitle: '13.1',):
                                                                              include.name == "CTS%"? const NewCardsForSales(title: 'CTS% ', subTitle: '7.2',):
                                                                              include.name == "SD%"? const NewCardsForSales(title: 'SD% ', subTitle: '12.3',):
                                                                              include.name == "SRA%"? const NewCardsForSales(title: 'SRA% ', subTitle: '12.2',):
                                                                              include.name == "TDC%"? const NewCardsForSales(title: 'TDC% ', subTitle: '7.6',):
                                                                              include.name == "GOS%"? const NewCardsForSales(title: 'GOS% ', subTitle: '15.5',):
                                                                              include.name == "GM%"? const NewCardsForSales(title: 'GM% ', subTitle: '38.6',):
                                                                              NewCardsForSales(title: "${include.name} ", subTitle: '0.0',)

                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, bottom: 120),
                                  child: InkWell(
                                    onTap: () {
                                      personalizeBottomSheet(
                                          context,
                                          includedData,
                                          metricData,
                                          allMetrics,
                                          onTapPer,
                                          onCrossTap);
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: MyColors.whiteColor,
                                        borderRadius: BorderRadius.circular(40),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffE1E7EC),
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.settings,
                                              color: MyColors.showMoreColor,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Personalize',
                                              style: TextStyle(
                                                  fontFamily: fontFamily,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      MyColors.showMoreColor),
                                            )
                                          ],
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
                    },
                  )

                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 0, bottom: 120),
                  //   child: InkWell(
                  //     onTap: () {
                  //       personalizeBottomSheet(
                  //           context,
                  //           includedData,
                  //           metricData,
                  //           allMetrics,
                  //           onTapPer,
                  //           onCrossTap);
                  //     },
                  //     child: Container(
                  //       height: 32,
                  //       width: 120,
                  //       decoration: BoxDecoration(
                  //         color: MyColors.whiteColor,
                  //         borderRadius: BorderRadius.circular(40),
                  //         boxShadow: const [
                  //           BoxShadow(
                  //             color: Color(0xffE1E7EC),
                  //             offset: Offset(0.0, 1.0), //(x,y)
                  //             blurRadius: 1.0,
                  //           ),
                  //         ],
                  //       ),
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(5.0),
                  //         child: Row(
                  //           mainAxisAlignment:
                  //           MainAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.settings,
                  //               color: MyColors.showMoreColor,
                  //               size: 20,
                  //             ),
                  //             SizedBox(
                  //               width: 5,
                  //             ),
                  //             Text(
                  //               'Personalize',
                  //               style: TextStyle(
                  //                   fontFamily: fontFamily,
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.w400,
                  //                   color:
                  //                   MyColors.showMoreColor),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
