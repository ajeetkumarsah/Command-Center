import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/sheet_provider.dart';
import '../../colors/colors.dart';
import '../../const/const_array.dart';
import '../../sharedpreferences/sharedpreferences_utils.dart';
import '../../style/text_style.dart';

class MonthSheet extends StatefulWidget {
  const MonthSheet({Key? key}) : super(key: key);

  @override
  State<MonthSheet> createState() => _MonthSheetState();
}

class _MonthSheetState extends State<MonthSheet> {
  int current_index = 0;
  int _selected = 0;
  String yearSelect = '';
  List<String> items = ['2023', '2022', '2021', '2020', '2019'];
  final List<bool> _checkedItems =
      List<bool>.generate(ConstArray().month.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 56,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: MyColors.sheetDivider),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Select Month',
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

                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(20.0),
                          // ),
                        ),
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, index) {
                              yearSelect = items[_selected];
                              return Container(
                                height: 45,
                                color: index == _selected ? Colors.white : null,
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      items[index],
                                      style: ThemeText.sheetText,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selected = index;
                                      print('Send email $index, $_selected');
                                    });
                                  },
                                ),
                              );
                            }),
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
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 50),
                                  child: ListView.builder(
                                      itemCount: ConstArray().month.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return SizedBox(
                                          height: 35,
                                          child: Transform.scale(
                                            scale: 0.9,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value: _checkedItems[index],
                                                  checkColor: Colors.white,
                                                  activeColor: MyColors.primary,
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
                                                          isChecked ?? false;
                                                      print(_checkedItems);
                                                      sheetProvider.month =
                                                          "${ConstArray().month[index]}-$yearSelect";
                                                      sheetProvider
                                                              .selectedMonth =
                                                          "${ConstArray().month[index]}'${yearSelect.substring(2)}";

                                                      SharedPreferencesUtils
                                                          .setString('month',
                                                              "${ConstArray().month[index]}'${yearSelect.substring(2)}");
                                                      SharedPreferencesUtils
                                                          .setString(
                                                              'fullMonth',
                                                              "${ConstArray().month[index]}-$yearSelect");
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  ConstArray().monthFull[index],
                                                  style: ThemeText.sheetText,
                                                )
                                              ],
                                            ),
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
          ],
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
                        onPressed: () {
                          // if(){
                          print(sheetProvider.month);
                          print(yearSelect.substring(2));
                          // }

                          Navigator.of(context).pop(true);
                        },
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
