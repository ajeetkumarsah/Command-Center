import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/sheet_provider.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/const/const_array.dart';
import '../../../../utils/sharedpreferences/sharedpreferences_utils.dart';
import '../../../../utils/style/text_style.dart';

class MonthWebSheet extends StatefulWidget {
  final String elName;
  final Function() onApplyPressed;

  const MonthWebSheet(
      {Key? key, required this.elName, required this.onApplyPressed})
      : super(key: key);

  @override
  State<MonthWebSheet> createState() => _MonthWebSheetState();
}

class _MonthWebSheetState extends State<MonthWebSheet> {
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
                            yearSelect = items[_selected];
                            return Container(
                                color: index == _selected ? Colors.white : null,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selected = index;
                                      sheetProvider.division = items[index];
                                      // if (widget.elName == 'Retailing') {
                                        SharedPreferencesUtils.setString(
                                            'webDefaultYear',
                                            (items[index]).toLowerCase());
                                      // } else if (widget.elName == 'Coverage') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webCoverageYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName ==
                                      // //     'Golden Points') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webGPYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName ==
                                      // //     'Focus Brand') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webFBYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName ==
                                      // //     'Distribution') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webDistributionYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName ==
                                      // //     'Productivity') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webProductivityYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName ==
                                      // //     'Call Compliance') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webCallComplianceYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName == 'Shipment') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webShipmentYear',
                                      //       (items[index]).toLowerCase());
                                      // // } else if (widget.elName == 'Inventory') {
                                      //   SharedPreferencesUtils.setString(
                                      //       'webInventoryYear',
                                      //       (items[index]).toLowerCase());
                                      // } else {}
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
                                                  if (selectedArrayItem == index) {
                                                    // If the tapped item is already selected, deselect it.
                                                    selectedArrayItem = -1;
                                                  } else {
                                                    // Otherwise, select the new item.
                                                    selectedArrayItem = index;
                                                  }
                                                  // selectedArrayItem = index;
                                                  // if (widget.elName ==
                                                  //     'Retailing') {
                                                    SharedPreferencesUtils
                                                        .setString(
                                                        'webDefaultMonth',
                                                        ConstArray()
                                                            .month[
                                                        index]);
                                                  // } else if (widget
                                                  //     .elName ==
                                                  //     'Coverage') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webCoverageMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Golden Points') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webGPMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Focus Brand') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webFBMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Distribution') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webDistributionMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Productivity') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webProductivityMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Call Compliance') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webCallComplianceMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Shipment') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webShipmentMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // // } else if (widget
                                                  // //     .elName ==
                                                  // //     'Inventory') {
                                                  //   SharedPreferencesUtils
                                                  //       .setString(
                                                  //       'webInventoryMonth',
                                                  //       ConstArray()
                                                  //           .month[
                                                  //       index]);
                                                  // } else {}
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
                                                        color: selectedArrayItem == index
                                                            ? Colors.blue
                                                            : MyColors
                                                            .transparent,
                                                          borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                          border: Border.all(
                                                              color: selectedArrayItem == index
                                                                  ? MyColors
                                                                      .primary
                                                                  : MyColors
                                                                      .textColor,
                                                              width: selectedArrayItem == index?0:1)),
                                                      child: selectedArrayItem == index ?const Icon(Icons.check, color: MyColors.whiteColor,size: 13,):null,
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
                          // onPressed: (){
                          //   sheetProvider.isDefaultMonth = !sheetProvider.isDefaultMonth;
                          // },
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
