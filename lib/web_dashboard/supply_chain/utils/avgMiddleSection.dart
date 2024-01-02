import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/supply_chain/custom_widget/line_chart.dart';
import 'package:command_centre/web_dashboard/supply_chain/helper/colors.dart';
import 'package:command_centre/web_dashboard/supply_chain/helper/data.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/colors.dart';

class AvgDivision extends StatefulWidget {
  const AvgDivision({super.key});

  @override
  State<AvgDivision> createState() => _AvgDivisionState();
}

class _AvgDivisionState extends State<AvgDivision> {
  double totalCategoryAvg = 0.0;
  double totalSourceAvg = 0.0;

  @override
  Widget build(BuildContext context) {
    // totalCategoryAvg = 0;
    // totalSourceAvg = 0;
    var size = MediaQuery.of(context).size;
    final provider = Provider.of<TransportationProvider>(context);
    return SizedBox(
      width: size.width - 574,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: size.width / 4.5,
                  height: size.height / 2.5,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Category-Wise Data',
                          style: TextStyle( fontWeight: FontWeight.bold, fontFamily: fontFamily),
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
                                child: Container(
                                  // contentPadding: EdgeInsets.only(bottom: 0.0),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Category', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 14),),
                                      Text('Avg \$/SU', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 14),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 170,
                                child: ListView.builder(
                                  itemCount: categoryData.length,
                                  itemBuilder: (context, index) {
                                    totalCategoryAvg = totalCategoryAvg + categoryData[index]['value'];
                                    return Container(
                                      height: 30,
                                      child:Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                              color: index % 2 == 0
                                                  ? MySupplyColors.table1Color
                                                  : MySupplyColors.tableColor,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 12, top: 5,bottom: 5),
                                                  child: Container(
                                                      width: 80,
                                                      child: Text(
                                                        categoryData[index]['title'],
                                                        maxLines: 1,
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(fontFamily: fontFamily,
                                                            fontSize: 13),
                                                      )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 12, top: 5,bottom: 5),
                                                  child: Text(
                                                    categoryData[index]['value'].toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(fontFamily: fontFamily,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 2,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Total', style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),),
                                      Text('$totalCategoryAvg', style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),),
                                    ],
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
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: (size.width - 586) - (size.width / 4.5),
                  height: size.height / 2.5,
                  child: Stack(children: [
                    const Positioned(
                        right: 15,
                        top: 5,
                        child: InkWell(
                          child: Icon(Icons.compare_arrows_rounded),
                        )),
                    SizedBox(
                      height: 100,
                      width: ((MediaQuery.of(context).size.width - 574) -
                          (MediaQuery.of(context).size.width - 574) / 3),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Monthly Data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,),
                            ),
                          ),
                          Container(
                            height: 0.5,
                            color: MyColors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24,top: 12),
                            child: Row(
                              children: [
                                Container(
                                  height: 12,
                                  width: 12,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 5,),
                                const Text('% Change', style: TextStyle(color: MyColors.grey),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: LineChartSample(),
                        ))
                  ]),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: size.width / 4.5,
                  height: size.height / 2.8,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Source',
                          style: TextStyle( fontWeight: FontWeight.bold, fontFamily: fontFamily),
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3.3,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
                                  child: Container(
                                    // contentPadding: EdgeInsets.only(bottom: 0.0),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Source', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 14),),
                                        Text('Avg \$/SU', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount: categoryData.length,
                                    itemBuilder: (context, index) {
                                      totalSourceAvg = totalSourceAvg + categoryData[index]['value'];
                                      return Container(
                                        height: 30,
                                        child:Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20.0),
                                                color: index % 2 == 0
                                                    ? MySupplyColors.table1Color
                                                    : MySupplyColors.tableColor,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12, top: 5,bottom: 5),
                                                    child: Container(
                                                        width: 80,
                                                        child: Text(
                                                          categoryData[index]['title'],
                                                          maxLines: 1,
                                                          textAlign: TextAlign.left,
                                                          style: const TextStyle(fontFamily: fontFamily,
                                                              fontSize: 13),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 12, top: 5,bottom: 5),
                                                    child: Text(
                                                      categoryData[index]['value'].toString(),
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(fontFamily: fontFamily,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 2,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Total', style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),),
                                        Text('$totalSourceAvg', style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.bold),),
                                      ],
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
              )
            ],
          )
        ],
      ),
    );
  }
}
