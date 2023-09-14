import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/sheet_provider.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/const/const_array.dart';
import '../../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../../../../utils/style/text_style.dart';

class CoverageMonthWebSheet extends StatefulWidget {
  final String elName;
  final Function() onApplyPressed;

  const CoverageMonthWebSheet(
      {Key? key, required this.elName, required this.onApplyPressed})
      : super(key: key);

  @override
  State<CoverageMonthWebSheet> createState() => _CoverageMonthWebSheetState();
}

class _CoverageMonthWebSheetState extends State<CoverageMonthWebSheet> {
  int current_index = 0;
  int _selected = 0;
  int selectedArrayItem = -1;
  String yearSelect = '';
  List<String> items = ['2023', '2022', '2021', '2020', '2019'];
  final List<bool> _checkedItems =
      List<bool>.generate(ConstArray().month.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);

    return Stack(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffEFF3F7),
                      ),
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, index) {
                            SharedPreferencesUtils.setString(
                                'webCoverageYear',
                                (items[_selected]).toLowerCase());
                            yearSelect = items[_selected];
                            return Container(
                                color: index == _selected ? Colors.white : null,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected = index;
                                      sheetProvider.division = items[index];
                                      SharedPreferencesUtils.setString(
                                          'webCoverageYear',
                                          (items[index]).toLowerCase());
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
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 35),
                              child: ListView.builder(
                                  itemCount: ConstArray().month.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (selectedArrayItem ==
                                                      index) {
                                                    // If the tapped item is already selected, deselect it.
                                                    selectedArrayItem = -1;
                                                  } else {
                                                    // Otherwise, select the new item.
                                                    selectedArrayItem = index;
                                                  }
                                                  // selectedArrayItem = index;

                                                  SharedPreferencesUtils
                                                      .setString(
                                                          'webCoverageMonth',
                                                          ConstArray()
                                                              .month[index]);
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
                                                          color: selectedArrayItem ==
                                                                  index
                                                              ? Colors.blue
                                                              : MyColors
                                                                  .transparent,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          2)),
                                                          border: Border.all(
                                                              color: selectedArrayItem ==
                                                                      index
                                                                  ? MyColors
                                                                      .primary
                                                                  : MyColors
                                                                      .textColor,
                                                              width:
                                                                  selectedArrayItem ==
                                                                          index
                                                                      ? 0
                                                                      : 1)),
                                                      child:
                                                          selectedArrayItem ==
                                                                  index
                                                              ? const Icon(
                                                                  Icons.check,
                                                                  color: MyColors
                                                                      .whiteColor,
                                                                  size: 13,
                                                                )
                                                              : null,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      ConstArray()
                                                          .monthFull[index],
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              fontFamily,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xff344C65)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
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
                        // onPressed: (){},
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
        )
      ],
    );
  }
}
