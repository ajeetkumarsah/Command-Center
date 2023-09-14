import 'dart:convert';
import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:command_centre/utils/const/const_variable.dart';
import 'package:command_centre/utils/sharedpreferences/sharedpreferences_utils.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class DivisionWebSheet extends StatefulWidget {
  final List list;
  final List divisionList;
  final List clusterList;
  final List siteList;
  final List branchList;
  final String elName;
  final int selectedGeo;
  final Function() onTap;
  final Function() onApplyPressed;

  const DivisionWebSheet(
      {Key? key,
      required this.onTap,
      required this.list,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo,
      required this.clusterList,
      required this.onApplyPressed,
      required this.elName})
      : super(key: key);

  @override
  State<DivisionWebSheet> createState() => _DivisionWebSheetState();
}

class _DivisionWebSheetState extends State<DivisionWebSheet> {
  int current_index = 0;
  int _selected = 0;
  int selectedArrayItemAllIndia = -1;
  int selectedArrayItemCluster = -1;
  int selectedArrayItemSite = -1;
  int selectedArrayItemDivision = -1;
  int selectedArrayItem = -1;
  List<String> items = ['All India', 'Division', 'Cluster', 'Site'];

  List<dynamic> filteredItems = [];
  List<dynamic> filteredItemsSite = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = widget.clusterList;
    filteredItemsSite = widget.siteList;
  }

  void filterItems(String query) {
    List<dynamic> tempList = [];
    if (query.isNotEmpty) {
      widget.clusterList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      });
    } else {
      tempList = widget.clusterList;
    }
    setState(() {
      filteredItems = tempList;
    });
  }

  void filterItemsSite(String query) {
    List<dynamic> tempList = [];
    if (query.isNotEmpty) {
      widget.siteList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      });
    } else {
      tempList = widget.siteList;
    }
    setState(() {
      filteredItemsSite = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    return Stack(
      children: [
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Container(
                height: 36,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Add Another Geo',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: MyColors.textHeaderColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: widget.onTap,
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffEFF3F7),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(20.0),
                            // ),
                          ),
                          child: ListView.builder(
                              itemCount: items.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                    color: index == _selected
                                        ? Colors.white
                                        : null,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selected = index;
                                          sheetProvider.division = items[index];
                                          if (widget.elName == 'Retailing') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webRetailingDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webRetailingDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Coverage') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webCoverageDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webCoverageDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Golden Points') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webGPDivision', allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webGPDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Focus Brand') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webFBDivision', allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webFBDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Distribution') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webDistributionDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webDistributionDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Productivity') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webProductivityDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webProductivityDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Call Compliance') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webCallComplianceDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webCallComplianceDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Shipment') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webShipmentDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webShipmentDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else if (widget.elName ==
                                              'Inventory') {
                                            if (items[index] == 'All India') {
                                              SharedPreferencesUtils.setString(
                                                  'webInventoryDivision',
                                                  allIndia);
                                            } else {
                                              SharedPreferencesUtils.setString(
                                                  'webInventoryDivision',
                                                  (items[index]).toLowerCase());
                                            }
                                          } else {
                                            SharedPreferencesUtils.setString(
                                                'webInventoryDivision',
                                                allIndia);
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              items[index],
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontFamily: fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Color(0xff344C65)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.only(
                            //   topRight: Radius.circular(20.0),
                            // ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 0, bottom: 0),
                                child: items[_selected] == 'All India' ||
                                        items[_selected] == 'Division'
                                    ? Container()
                                    : SizedBox(
                                        height: 28,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            onChanged: (value) {
                                              if (items[_selected] ==
                                                  'Cluster') {
                                                filterItems(value);
                                              } else {
                                                filterItemsSite(value);
                                              }
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Search...',
                                            ),
                                          ),
                                        )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 30.0, top: 5),
                                  child: ListView.builder(
                                      itemCount: _selected == 0
                                          ? ConstArray().allIndia.length
                                          : _selected == 1
                                              ? widget.divisionList.length
                                              : _selected == 2
                                                  ? filteredItems.length
                                                  : _selected == 3
                                                      ? filteredItemsSite.length
                                                      : widget
                                                          .branchList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedArrayItemAllIndia == index ||
                                                        selectedArrayItemDivision ==
                                                            index ||
                                                        selectedArrayItemCluster ==
                                                            index ||
                                                        selectedArrayItemSite ==
                                                            index) {
                                                      selectedArrayItemAllIndia =
                                                          -1;
                                                      selectedArrayItemCluster =
                                                          -1;
                                                      selectedArrayItemSite =
                                                          -1;
                                                      selectedArrayItemDivision =
                                                          -1;
                                                    } else {
                                                      _selected == 0
                                                          ? selectedArrayItemAllIndia =
                                                              index
                                                          : _selected == 1
                                                              ? selectedArrayItemDivision =
                                                                  index
                                                              : _selected == 2
                                                                  ? selectedArrayItemCluster =
                                                                      index
                                                                  : _selected ==
                                                                          3
                                                                      ? selectedArrayItemSite =
                                                                          index
                                                                      : selectedArrayItem =
                                                                          index;
                                                    }

                                                    if (widget.elName ==
                                                        'Retailing') {
                                                      SharedPreferencesUtils.setString(
                                                          'webRetailingSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Coverage') {
                                                      SharedPreferencesUtils.setString(
                                                          'webCoverageSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Golden Points') {
                                                      SharedPreferencesUtils.setString(
                                                          'webGPSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Focus Brand') {
                                                      SharedPreferencesUtils.setString(
                                                          'webFBSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Distribution') {
                                                      SharedPreferencesUtils.setString(
                                                          'webDistributionSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Productivity') {
                                                      SharedPreferencesUtils.setString(
                                                          'webProductivitySite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Call Compliance') {
                                                      SharedPreferencesUtils.setString(
                                                          'webCallComplianceSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Shipment') {
                                                      SharedPreferencesUtils.setString(
                                                          'webShipmentSite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else if (widget.elName ==
                                                        'Inventory') {
                                                      SharedPreferencesUtils.setString(
                                                          'webInventorySite',
                                                          _selected == 0
                                                              ? allIndia
                                                              : _selected == 1
                                                                  ? widget.divisionList[index]
                                                                  : _selected == 2
                                                                      ? filteredItems[index]
                                                                      : _selected == 3
                                                                          ? filteredItemsSite[index]
                                                                          : widget.branchList[index]);
                                                    } else {
                                                      SharedPreferencesUtils
                                                          .setString(
                                                              'webInventorySite',
                                                              allIndia);
                                                    }
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          top: 5,
                                                          bottom: 4),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          height: 15,
                                                          width: 15,
                                                          decoration: BoxDecoration(
                                                              color: _selected == 0
                                                                  ? selectedArrayItemAllIndia == index
                                                                      ? Colors.blue
                                                                      : MyColors.transparent
                                                                  : _selected == 1
                                                                      ? selectedArrayItemDivision == index
                                                                          ? Colors.blue
                                                                          : MyColors.transparent
                                                                      : _selected == 2
                                                                          ? selectedArrayItemCluster == index
                                                                              ? Colors.blue
                                                                              : MyColors.transparent
                                                                          : _selected == 3
                                                                              ? selectedArrayItemSite == index
                                                                                  ? Colors.blue
                                                                                  : MyColors.transparent
                                                                              : MyColors.grey,
                                                              borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                              border: Border.all(
                                                                  color: _selected == 0
                                                                      ? selectedArrayItemAllIndia == index
                                                                          ? Colors.blue
                                                                          : MyColors.grey
                                                                      : _selected == 1
                                                                          ? selectedArrayItemDivision == index
                                                                              ? Colors.blue
                                                                              : MyColors.grey
                                                                          : _selected == 2
                                                                              ? selectedArrayItemCluster == index
                                                                                  ? Colors.blue
                                                                                  : MyColors.grey
                                                                              : _selected == 3
                                                                                  ? selectedArrayItemSite == index
                                                                                      ? Colors.blue
                                                                                      : MyColors.grey
                                                                                  : MyColors.grey,
                                                                  // width: selectedArrayItem == index ? 0 : 1)
                                                                  width: 1)),
                                                          child: _selected == 0
                                                              ? selectedArrayItemAllIndia == index
                                                                  ? const Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: MyColors
                                                                          .whiteColor,
                                                                      size: 13,
                                                                    )
                                                                  : null
                                                              : _selected == 1
                                                                  ? selectedArrayItemDivision == index
                                                                      ? const Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              MyColors.whiteColor,
                                                                          size:
                                                                              13,
                                                                        )
                                                                      : null
                                                                  : _selected == 2
                                                                      ? selectedArrayItemCluster == index
                                                                          ? const Icon(
                                                                              Icons.check,
                                                                              color: MyColors.whiteColor,
                                                                              size: 13,
                                                                            )
                                                                          : null
                                                                      : _selected == 3
                                                                          ? selectedArrayItemSite == index
                                                                              ? const Icon(
                                                                                  Icons.check,
                                                                                  color: MyColors.whiteColor,
                                                                                  size: 13,
                                                                                )
                                                                              : null
                                                                          : null),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          _selected == 0
                                                              ? ConstArray()
                                                                      .allIndia[
                                                                  index]
                                                              : _selected == 1
                                                                  ? widget.divisionList[
                                                                      index]
                                                                  : _selected ==
                                                                          2
                                                                      ? filteredItems[
                                                                          index]
                                                                      : _selected ==
                                                                              3
                                                                          ? filteredItemsSite[
                                                                              index]
                                                                          : widget
                                                                              .branchList[index],
                                                          maxLines: 2,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  fontFamily,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff344C65)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  const Expanded(
                      child: TextButton(
                          onPressed: null,
                          child: Text(
                            "Clear",
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff778898),
                                fontSize: 14),
                          ))),
                  Expanded(
                      child: TextButton(
                          onPressed: widget.onApplyPressed,
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w400,
                                color: MyColors.showMoreColor,
                                fontSize: 14),
                          )))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
