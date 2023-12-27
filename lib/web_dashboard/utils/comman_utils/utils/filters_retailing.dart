import 'package:command_centre/provider/sheet_provider.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/http_call.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/comman/header_title_matrics.dart';
import '../../../../utils/style/text_style.dart';
import '../../summary_utils/dropdown_widget.dart';

class FiltersRetailing extends StatefulWidget {
  final List clusterCount;
  final Function(String?) onChangedFilter;
  final Function(String?) onChangedFilterBrand;
  final Function(String?) onChangedFilterMonth;
  final List<String> selectedItemValueChannel;
  final List<String> selectedItemValueChannelMonth;
  final List<String> selectedItemValueChannelBrand;
  final Function() categoryApply;
  final Function() onRemoveFilter;
  final Function() onRemoveFilterCategory;
  final String fbFilter;
  final String selectedMonth;
  final String selectedMonthList;
  final Function() onTapMonthFilter;
  final String selectedCategoryList;
  final List<String> selectedItemValueCategory;
  final List<String> selectedItemValueBrand;
  final List<String> selectedItemValueBrandForm;
  final List<String> selectedItemValueBrandFromGroup;

  const FiltersRetailing(
      {Key? key,
      required this.clusterCount,
      required this.onChangedFilter,
      required this.selectedItemValueChannel,
      required this.onChangedFilterMonth,
      required this.selectedItemValueChannelMonth,
      required this.onChangedFilterBrand,
      required this.selectedItemValueChannelBrand,
      required this.categoryApply,
      required this.fbFilter,
      required this.selectedMonth,
      required this.onRemoveFilter,
      required this.selectedMonthList,
      required this.onTapMonthFilter, required this.onRemoveFilterCategory, required this.selectedCategoryList, required this.selectedItemValueCategory, required this.selectedItemValueBrand, required this.selectedItemValueBrandForm, required this.selectedItemValueBrandFromGroup})
      : super(key: key);

  @override
  State<FiltersRetailing> createState() => _FiltersRetailingState();
}

class _FiltersRetailingState extends State<FiltersRetailing> {
  bool checked = false;
  String? selectedValue;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedCategory;
  String? selectedBrand;
  String? selectedSBF;
  String? selectedSBFG;
  String selectedAllCategory = '';
  List arrayFilters = ['Channel'];
  List<String> selectedItemValueGeography = [];
  List<String> selectedItemValueCategory = [];
  List arrayGeography = ['Division', 'Cluster', 'Site'];
  List arrayChannel = [
    'Channel Filter',
  ];
  List arrayMonth = [
    'Month Filter',
  ];
  List arrayCategoryFilter = [
    'Brand Filter',
  ];

  List arrayCategory = ['Category'];

  // List arrayCategory = ['Category', 'Brand', 'Brand form'];

  List<DropdownMenuItem<String>> _dropDownItem() {
    print("Here ${widget.clusterCount}");
    // List<String> ddl = widget.clusterCount;
    List<String> ddl = [
      "Select..",
      "null",
      "Nepal",
      "HR",
      "MH.GJ.GA.NAG",
      "TN",
      "NE",
      "RJ.MP.CG",
      "KL",
      "PUN.HP.JK.UK",
      "WB.OR",
      "MUM.PUNE",
      "DL.NCR",
      "KA",
      "AP.TL",
      "UP.BR.JH",
      "Sri Lanka"
    ];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropDownItemIndexfirst() {
    List<String> ddl = [
      "Select..",
      "CONVENIENCE",
      "MINIMARKET",
      "Cash&Carry",
      "eCommerce",
      "Hyper",
      "Large A Beauty",
      "Large A Pharmacy",
      "Large A Traditional",
      "Large B Pharmacy",
      "Large B Traditional",
      "Medium Beauty",
      "Medium Pharmacy",
      "Medium Traditional",
      "MM 1",
      "MM 2",
      "New Beauty",
      "New Pharmacy",
      "New Traditional",
      "Other",
      "Other Non Retail - DTC",
      "Semi WS Beauty",
      "Semi WS Pharmacy",
      "Semi WS Traditional",
      "Semi WS Beauty & Pharmacy",
      "Small A Beauty",
      "Small A Pharmacy",
      "Small A Traditional",
      "Small B Traditional",
      "Small C Traditional",
      "Small D Pharmacy",
      "Small D Traditional",
      "Speciality",
      "Super",
      "Unknown",
      "WS Feeder Beauty",
      "WS Beauty & Pharmacy",
      "WS Feeder Pharmacy",
      "WS Feeder Traditional",
      "WS Non-Feeder Beauty",
      "WS Non-Feeder Pharmacy",
      "WS Non-Feeder Traditional",
      "WS Traditional"
    ];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
              ),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropDownMonthIndex() {
    final bosData = Provider.of<SheetProvider>(context, listen: false);
    List<String> ddl = [
      widget.selectedMonth,
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
              ),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropDownItemCategory() {
    List<String> ddl = ConstArray().categoryFilter;
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
              ),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropDownItemBrand() {
    List<String> ddl = ConstArray().brandFilter;
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 10),
                maxLines: 2,
              ),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropDownItemSBF() {
    List<String> ddl = ConstArray().sbf;
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 9),
                maxLines: 2,
              ),
            ))
        .toList();
  }

  List<DropdownMenuItem<String>> _dropDownItemSBFG() {
    List<String> ddl = ConstArray().sbfg;
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 4),
                maxLines: 2,
              ),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    selectedAllCategory = widget.selectedCategoryList;
    print(selectedAllCategory);
    print(widget.selectedCategoryList);
  }

  @override
  Widget build(BuildContext context) {
    final sheetProvider = Provider.of<SheetProvider>(context);
    final size = MediaQuery.of(context).size;
    for (int j = 0; j < 100; j++) {
      selectedItemValueGeography.add("Select..");
      selectedItemValueCategory.add("Select..");
      widget.selectedItemValueChannel.add("Select..");
      widget.selectedItemValueCategory.add("Select..");
      widget.selectedItemValueBrand.add("Select..");
      widget.selectedItemValueBrandForm.add("Select..");
      widget.selectedItemValueBrandFromGroup.add("Select..");
    }
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: checked ? 30 : 250,
        height: size.height,
        decoration: BoxDecoration(
          color: const Color(0xE6EFF3F7),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
          border: Border.all(width: 0.4, color: MyColors.deselectColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding:
              checked ? const EdgeInsets.all(5) : const EdgeInsets.all(0.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            decoration: const BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                HeaderTitleMetrics(
                                  onPressed: () {},
                                  title: 'Month Filter',
                                  icon: Icons.edit,
                                ),
                                GestureDetector(
                                  onTap: widget.onTapMonthFilter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10, right: 15),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyColors.grayBorder),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(widget.selectedMonthList ??
                                          'Select a month'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 180,
                          child: ListView.builder(
                              itemCount: arrayFilters.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.whiteColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        HeaderTitleMetrics(
                                          onPressed: () {},
                                          title: arrayFilters[index],
                                          icon: Icons.edit,
                                        ),
                                        widget.fbFilter == "FB"
                                            ? widget.selectedItemValueChannel[
                                                        0] ==
                                                    'Select..'
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15,
                                                            top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          widget.selectedItemValueChannel[
                                                              0],
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
                                                        const Spacer(),
                                                        InkWell(
                                                            onTap: widget
                                                                .onRemoveFilter,
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 16,
                                                              color: MyColors
                                                                  .primary,
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                            : Container(),
                                        SizedBox(
                                          height: 100,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: arrayChannel.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return DropDownWidget(
                                                selectedValue: index == 0
                                                    ? widget
                                                        .selectedItemValueChannel[
                                                            i]
                                                        .toString()
                                                    : index == 1
                                                        ? selectedItemValueCategory[
                                                                i]
                                                            .toString()
                                                        : selectedItemValueGeography[
                                                                i]
                                                            .toString(),
                                                onChanged:
                                                    widget.onChangedFilter,
                                                title: index == 0
                                                    ? arrayChannel[i]
                                                    : index == 1
                                                        ? arrayGeography[i]
                                                        : arrayCategory[i],
                                                dropDownItem: index == 0 &&
                                                        i == 1
                                                    ? _dropDownItem()
                                                    : _dropDownItemIndexfirst(),
                                                secondIndex: 1,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        widget.fbFilter == "FB"
                            ?
                    Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                HeaderTitleMetrics(
                                  onPressed: () {},
                                  title: arrayCategory[0],
                                  icon: Icons.edit,
                                ),
                                widget.selectedItemValueCategory[
                                0] ==
                                    'Select..'
                                    ? Container()
                                    :
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.selectedItemValueCategory[
                                        0],
                                        style: const TextStyle(
                                            fontFamily: fontFamily,
                                            fontWeight:
                                            FontWeight.w500,
                                            fontSize: 14,
                                            color:
                                            Color(0xff344C65)),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                          onTap:
                                          widget.onRemoveFilterCategory,
                                          child: const Icon(
                                            Icons.close,
                                            size: 16,
                                            color: MyColors.primary,
                                          ))
                                    ],
                                  ),
                                ),
                                DropDownWidget(
                                  selectedValue: widget.selectedItemValueCategory[0],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCategory = newValue!;
                                      selectedAllCategory = newValue;
                                      widget.selectedItemValueCategory[0] = newValue;
                                      print(selectedAllCategory);
                                      print(selectedCategory);
                                      sheetProvider
                                          .selectedCategoryFilter =
                                          newValue;
                                      sheetProvider
                                          .selectedCategoryFilterbr = '';
                                      sheetProvider
                                          .selectedCategoryFiltersbf = '';
                                      sheetProvider
                                          .selectedCategoryFiltersbfg = '';
                                    });
                                  },
                                  title: 'Category Filter',
                                  dropDownItem: _dropDownItemCategory(),
                                  secondIndex: 1,
                                ),
                                DropDownWidget(
                                  selectedValue: widget.selectedItemValueBrand[0],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedBrand = newValue!;
                                      selectedAllCategory = newValue;
                                      print(selectedAllCategory);
                                      print(selectedBrand);
                                      // widget.selectedItemValueCategory[0] = newValue;
                                      widget.selectedItemValueBrand[0] = newValue;
                                      sheetProvider
                                          .selectedCategoryFilterbr =
                                          newValue;
                                      sheetProvider
                                          .selectedCategoryFilter = '';
                                      sheetProvider
                                          .selectedCategoryFiltersbf = '';
                                      sheetProvider
                                          .selectedCategoryFiltersbfg = '';
                                    });
                                  },
                                  title: 'Brand Filter',
                                  dropDownItem: _dropDownItemBrand(),
                                  secondIndex: 1,
                                ),
                                DropDownWidget(
                                  selectedValue: widget.selectedItemValueBrandForm[0],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedSBF = newValue!;
                                      selectedAllCategory = newValue;
                                      print(selectedAllCategory);
                                      print(selectedSBF);
                                      // widget.selectedItemValueCategory[0] = newValue;
                                      widget.selectedItemValueBrandForm[0] = newValue;
                                      sheetProvider
                                          .selectedCategoryFiltersbf =
                                          newValue;
                                      sheetProvider
                                          .selectedCategoryFilter = '';
                                      sheetProvider
                                          .selectedCategoryFilterbr = '';
                                      sheetProvider
                                          .selectedCategoryFiltersbfg = '';
                                    });
                                  },
                                  title: 'BrandForm Filter',
                                  dropDownItem: _dropDownItemSBF(),
                                  secondIndex: 1,
                                ),
                                // DropDownWidget(
                                //   selectedValue: widget.selectedItemValueBrandFromGroup[0],
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       selectedSBFG = newValue!;
                                //       selectedAllCategory = newValue;
                                //       widget.selectedItemValueCategory[0] = newValue;
                                //       widget.selectedItemValueBrandFromGroup[0] = newValue;
                                //       sheetProvider
                                //           .selectedCategoryFiltersbfg =
                                //           newValue;
                                //       sheetProvider
                                //           .selectedCategoryFilter = '';
                                //       sheetProvider
                                //           .selectedCategoryFilterbr = '';
                                //       sheetProvider
                                //           .selectedCategoryFiltersbf = '';
                                //     });
                                //   },
                                //   title: 'SBF Group',
                                //   dropDownItem: _dropDownItemSBFG(),
                                //   secondIndex: 1,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Container(
                                      height: 40,
                                      width: size.width / 2,
                                      child: ElevatedButton(
                                        onPressed: widget.categoryApply,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            MyColors.toggletextColor,
                                            elevation: 0,
                                            shape: const StadiumBorder()),
                                        child: const Text(
                                          'Apply',
                                          style: TextStyle(
                                              letterSpacing: 0.8,
                                              fontSize: 14,
                                              fontFamily: fontFamily,
                                              fontWeight:
                                              FontWeight.w700),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF3F7),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checked
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                checked = !checked;
                              });
                            },
                            child: const Icon(
                              Icons.filter_alt_outlined,
                              size: 20,
                              color: MyColors.toggletextColor,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  checked = !checked;
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.double_arrow,
                                    size: 20,
                                    color: MyColors.toggletextColor,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8),
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Filters',
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: 14,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Container(
                      height: 1,
                      color: MyColors.dividerColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
