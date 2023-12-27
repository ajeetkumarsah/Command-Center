import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/sheet_provider.dart';
import '../../colors/colors.dart';
import '../../const/const_array.dart';
import '../../const/const_variable.dart';
import '../../sharedpreferences/sharedpreferences_utils.dart';
import '../../style/text_style.dart';
import 'package:command_centre/helper/global/global.dart' as globals;

class DivisionSheet extends StatefulWidget {
  final List list;
  final List divisionList;
  final List siteList;
  final List clusterList;
  final List branchList;
  final int selectedGeo;
  final Function() onApplyClick;

  const DivisionSheet(
      {Key? key,
      required this.list,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo, required this.clusterList,
      required this.onApplyClick})
      : super(key: key);

  @override
  State<DivisionSheet> createState() => _DivisionSheetState();
}

class _DivisionSheetState extends State<DivisionSheet> {
  int current_index = 1;
  int _selected = 0;
  List newItems = [];
  List<String> items = ['All India', 'Division', 'Cluster', 'Site'];
  List<bool> _checkedItems = List<bool>.generate(1000, (index) => false);
  List<bool> _checkedItems1 = [];
  List<bool> _checkedItems2 = [];
  List<bool> _checkedItems3 = [];
  List<bool> _checkedItems4 = [];
  int selectedArrayItemAllIndia = -1;
  int selectedArrayItemCluster = -1;
  int selectedArrayItemSite = -1;
  int selectedArrayItemDivision = -1;
  int selectedArrayItem = -1;
  bool _myBool = false;
  List<bool> isSelected = List<bool>.generate(10000, (index) => false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkedItems = List<bool>.generate(1000, (index) => false);
    setState(() {
      _selected = widget.selectedGeo;
    });

  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              Container(
                height: 56,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Select Geography',
                        style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: MyColors.textHeaderColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffEFF3F7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                            ),
                          ),
                          child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, index) {
                                SharedPreferencesUtils.setString(
                                    'division', items[_selected]);
                                SharedPreferencesUtils.setString(
                                    'mobileDivision', items[_selected].toLowerCase());
                                return Container(
                                  height: 45,
                                  color:
                                      index == _selected ? Colors.white : null,
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 8.0),
                                      child: Text(
                                        items[index],
                                        style: ThemeText.sheetText,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selected = index;
                                        sheetProvider.division = items[index];
                                        SharedPreferencesUtils.setString(
                                            'division', items[index]);
                                        SharedPreferencesUtils.setString(
                                            'mobileDivision', items[index].toLowerCase());
                                      });
                                    },
                                  ),
                                );
                              }),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 0, bottom: 10),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(
                                          Icons.search,
                                        ),
                                      ),
                                      // border: ,
                                      hintText: 'Search',
                                      hintStyle: ThemeText.searchHintText),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0, top: 5),
                                  child: ListView.builder(
                                      itemCount: _selected == 0
                                          ? ConstArray().allIndia.length
                                          : _selected == 1
                                          ? widget.divisionList.length
                                          : _selected == 2
                                          ? widget.clusterList.length
                                          : _selected == 3
                                          ? widget.siteList.length
                                          : widget
                                          .branchList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                            // SharedPreferencesUtils.setString(
                                            //     'site',
                                            //     _selected == 0
                                            //         ? allIndia
                                            //         : _selected == 1
                                            //         ? widget.divisionList[0]
                                            //         : _selected == 2
                                            //         ? widget.list[0]
                                            //         : _selected == 3
                                            //         ? widget.siteList[0]
                                            //         : widget.branchList[0]);
                                            //
                                            // SharedPreferencesUtils.setString(
                                            //     'mobileSite',
                                            //     _selected == 0
                                            //         ? allIndia
                                            //         : _selected == 1
                                            //         ? widget.divisionList[0]
                                            //         : _selected == 2
                                            //         ? widget.list[0]
                                            //         : _selected == 3
                                            //         ? widget.siteList[0]
                                            //         : widget.branchList[0]);

                                            return Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // if (selectedArrayItemAllIndia == index || selectedArrayItemDivision == index || selectedArrayItemCluster == index || selectedArrayItemSite == index) {
                                                    //   selectedArrayItemAllIndia = -1;
                                                    //   selectedArrayItemCluster = -1;
                                                    //   selectedArrayItemSite = -1;
                                                    //   selectedArrayItemDivision = -1;
                                                    // } else {
                                                      _selected == 0
                                                          ? selectedArrayItemAllIndia =
                                                          index
                                                          : _selected == 1
                                                          ? selectedArrayItemDivision =
                                                          index
                                                          : _selected == 2
                                                          ? selectedArrayItemCluster =
                                                          index
                                                          : _selected == 3
                                                          ? selectedArrayItemSite =
                                                          index
                                                          : selectedArrayItem =
                                                          index;
                                                    // }

                                                    SharedPreferencesUtils.setString(
                                                        'site',
                                                        _selected == 0
                                                            ? allIndia
                                                            : _selected == 1
                                                            ? widget.divisionList[index]
                                                            : _selected == 2
                                                            ? widget.clusterList[index]
                                                            : _selected == 3
                                                            ? widget.siteList[index]
                                                            : widget.branchList[index]);

                                                    SharedPreferencesUtils.setString(
                                                        'mobileSite',
                                                        _selected == 0
                                                            ? allIndia
                                                            : _selected == 1
                                                            ? widget.divisionList[index]
                                                            : _selected == 2
                                                            ? widget.clusterList[index]
                                                            : _selected == 3
                                                            ? widget.siteList[index]
                                                            : widget.branchList[index]);


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
                                                              ? widget.clusterList[
                                                          index]
                                                              : _selected ==
                                                              3
                                                              ? widget.siteList[
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
                              // Expanded(
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(top: 0.0),
                              //     child: ListView.builder(
                              //         itemCount: _selected == 0
                              //             ? ConstArray().allIndia.length
                              //             : _selected == 1
                              //                 ? widget.divisionList.length
                              //                 : _selected == 2
                              //                     ? widget.list.length
                              //                     : _selected == 3
                              //                         ? widget.siteList.length
                              //                         : widget
                              //                             .branchList.length,
                              //         itemBuilder:
                              //             (BuildContext context, index) {
                              //           return Padding(
                              //             padding: const EdgeInsets.only(
                              //                 left: 20, top: 7),
                              //             child: InkWell(
                              //               onTap: () {
                              //                 setState(() {
                              //                   isSelected[index] =
                              //                       !isSelected[index];
                              //                 });
                              //               },
                              //               child: SizedBox(
                              //                 height: 35,
                              //                 child: Transform.scale(
                              //                   scale: 0.9,
                              //                   child: Row(
                              //                     children: [
                              //                       Checkbox(
                              //                         value:
                              //                             _checkedItems[index],
                              //                         checkColor: Colors.white,
                              //                         activeColor:
                              //                             MyColors.primary,
                              //                         shape:
                              //                             const RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius.all(
                              //                             Radius.circular(5.0),
                              //                           ),
                              //                         ),
                              //                         onChanged: (isChecked) {
                              //                           setState(() {
                              //                             _checkedItems[index] =
                              //                                 isChecked ??
                              //                                     false;
                              //                             SharedPreferencesUtils.setString(
                              //                                 'site',
                              //                                 _selected == 0
                              //                                     ? allIndia
                              //                                     : _selected == 1
                              //                                         ? widget.divisionList[index]
                              //                                         : _selected == 2
                              //                                             ? widget.list[index]
                              //                                             : _selected == 3
                              //                                                 ? widget.siteList[index]
                              //                                                 : widget.branchList[index]);
                              //                             sheetProvider
                              //                                 .state = _selected ==
                              //                                     0
                              //                                 ? ConstArray()
                              //                                         .allIndia[
                              //                                     index]
                              //                                 : _selected == 1
                              //                                     ? widget.divisionList[
                              //                                         index]
                              //                                     : _selected ==
                              //                                             2
                              //                                         ? widget.list[
                              //                                             index]
                              //                                         : _selected ==
                              //                                                 3
                              //                                             ? widget.siteList[
                              //                                                 index]
                              //                                             : widget
                              //                                                 .branchList[index];
                              //                           });
                              //                         },
                              //                       ),
                              //                       Text(
                              //                         _selected == 0
                              //                             ? ConstArray()
                              //                                 .allIndia[index]
                              //                             : _selected == 1
                              //                                 ? widget.divisionList[
                              //                                     index]
                              //                                 : _selected == 2
                              //                                     ? widget.list[
                              //                                         index]
                              //                                     : _selected ==
                              //                                             3
                              //                                         ? widget.siteList[
                              //                                             index]
                              //                                         : widget.branchList[
                              //                                             index],
                              //                         style:
                              //                             ThemeText.sheetText,
                              //                       )
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         }),
                              //   ),
                              // ),
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
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          "Clear",
                          style: ThemeText.sheetCancelText,
                        ))),
                Expanded(
                    child: TextButton(
                        onPressed: widget.onApplyClick,
                        child: const Text(
                          "Apply Filters",
                          style: ThemeText.sheetallFilterText,
                        )))
              ],
            ),
          ),
        )
      ],
    );
  }
}
