import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../provider/sheet_provider.dart';
import '../../../colors/colors.dart';
import '../../../const/const_array.dart';
import '../../../sharedpreferences/sharedpreferences_utils.dart';
import '../../../style/text_style.dart';
import 'package:command_centre/helper/global/global.dart' as globals;

class CoverageSummarySheet extends StatefulWidget {
  final List list;
  final List divisionList;
  final List siteList;
  final List branchList;
  final int selectedGeo;
  final Function() onPressed;

  const CoverageSummarySheet(
      {Key? key,
      required this.list,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo, required this.onPressed})
      : super(key: key);

  @override
  State<CoverageSummarySheet> createState() => _CoverageSummarySheetState();
}

class _CoverageSummarySheetState extends State<CoverageSummarySheet> {
  int current_index = 1;
  int _selected = 0;
  List newItems = [];
  List<String> items = ['Division', 'Cluster', 'Site'];
  List<bool> _checkedItems = List<bool>.generate(1000, (index) => false);
  List<bool> _checkedItems1 = List<bool>.generate(1000, (index) => false);
  List<bool> _checkedItems2 = List<bool>.generate(1000, (index) => false);
  List<bool> isSelected = List<bool>.generate(10000, (index) => false);
  List<bool> isSelected1 = List<bool>.generate(10000, (index) => false);
  List<bool> isSelected2 = List<bool>.generate(10000, (index) => false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkedItems = List<bool>.generate(1000, (index) => false);
    setState(() {
      _selected = widget.selectedGeo;
    });}

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
                                return Container(
                                  height: 45,
                                  color:
                                      index == _selected ? Colors.white : null,
                                  child: ListTile(
                                    selected: isSelected[index],
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
                                        isSelected[index] = !isSelected[index];
                                        _selected = index;
                                        print("Here ${isSelected[index]}");
                                        // sheetProvider.division = items[index];
                                        if(_selected == 0){
                                          SharedPreferencesUtils.setString(
                                              'coverageGeoD', items[index].toLowerCase());
                                        }else if (_selected == 1){
                                          SharedPreferencesUtils.setString(
                                              'coverageGeoC', items[index].toLowerCase());
                                        }else if (_selected == 2){
                                          SharedPreferencesUtils.setString(
                                              'coverageGeoS', items[index].toLowerCase());
                                        }

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
                              _selected == 0
                              ?Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: ListView.builder(
                                      itemCount: widget.divisionList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 7),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isSelected[index] =
                                                    !isSelected[index];
                                              });
                                            },
                                            child: SizedBox(
                                              height: 35,
                                              child: Transform.scale(
                                                scale: 0.9,
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                      value:
                                                          _checkedItems[index],
                                                      checkColor: Colors.white,
                                                      activeColor:
                                                          MyColors.primary,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                      ),
                                                      onChanged: (isChecked) {
                                                        setState(() {
                                                          _checkedItems[index] =
                                                              isChecked ??
                                                                  false;

                                                          if(_selected == 0){
                                                            SharedPreferencesUtils.setString("coverageGeoDS", widget.divisionList[index]);
                                                          }else if (_selected == 1){
                                                            SharedPreferencesUtils.setString("coverageGeoCS", widget.list[index]);
                                                          }else if (_selected == 2){
                                                            SharedPreferencesUtils.setString("coverageGeoSS", widget.siteList[index]);
                                                          }

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      widget.divisionList[
                                                                  index]
                                                             ,
                                                      style:
                                                          ThemeText.sheetText,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ):_selected ==1?
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: ListView.builder(
                                      itemCount:widget.list.length
                                         ,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 7),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isSelected1[index] =
                                                !isSelected1[index];
                                              });
                                            },
                                            child: SizedBox(
                                              height: 35,
                                              child: Transform.scale(
                                                scale: 0.9,
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                      value:
                                                      _checkedItems1[index],
                                                      checkColor: Colors.white,
                                                      activeColor:
                                                      MyColors.primary,
                                                      shape:
                                                      const RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                      ),
                                                      onChanged: (isChecked) {
                                                        setState(() {
                                                          _checkedItems1[index] =
                                                              isChecked ??
                                                                  false;

                                                          // if(_selected == 0){
                                                          //   SharedPreferencesUtils.setString("coverageGeoDS", widget.divisionList[index]);
                                                          // }else if (_selected == 1){
                                                            SharedPreferencesUtils.setString("coverageGeoCS", widget.list[index]);
                                                          // }else if (_selected == 2){
                                                          //   SharedPreferencesUtils.setString("coverageGeoSS", widget.siteList[index]);
                                                          // }

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                     widget.list[
                                                      index]
                                                          ,
                                                      style:
                                                      ThemeText.sheetText,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ):_selected == 2?
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: ListView.builder(
                                      itemCount:  widget.siteList.length
                                          ,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 7),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isSelected2[index] =
                                                !isSelected2[index];
                                              });
                                            },
                                            child: SizedBox(
                                              height: 35,
                                              child: Transform.scale(
                                                scale: 0.9,
                                                child: Row(
                                                  children: [
                                                    Checkbox(
                                                      value:
                                                      _checkedItems2[index],
                                                      checkColor: Colors.white,
                                                      activeColor:
                                                      MyColors.primary,
                                                      shape:
                                                      const RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                      ),
                                                      onChanged: (isChecked) {
                                                        setState(() {
                                                          _checkedItems2[index] =
                                                              isChecked ??
                                                                  false;

                                                          // if(_selected == 0){
                                                          //   SharedPreferencesUtils.setString("coverageGeoDS", widget.divisionList[index]);
                                                          // }else if (_selected == 1){
                                                          //   SharedPreferencesUtils.setString("coverageGeoCS", widget.list[index]);
                                                          // }else if (_selected == 2){
                                                            SharedPreferencesUtils.setString("coverageGeoSS", widget.siteList[index]);
                                                          // }

                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                       widget.siteList[
                                                      index]
                                                          ,
                                                      style:
                                                      ThemeText.sheetText,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ):Container()
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
                        onPressed: widget.onPressed,
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
