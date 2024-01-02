import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/comman/header_title_matrics.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/utils/summary_utils/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterByOrder extends StatefulWidget {
  const FilterByOrder({super.key});

  @override
  State<FilterByOrder> createState() => _FilterByOrderState();
}

class _FilterByOrderState extends State<FilterByOrder> {
  bool checked = false;
  String? selectedValue0;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  List<String> channelFilter = [];
  List<String> categoryFilter = [];
  List<String> brandFilter = [];
  List<String> brandFormFilter = [];
  List<String> subBrandFormFilter = [];

  Future<List<String>> postRequestChannel(context) async {
    var url =
        '$BASE_URL/api/appData/channelFilter/category';

    var body = json.encode({"table": "fb", "date": "Jun-2023"});
    print("Body Filter Category $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      setState(() {
        channelFilter = categories;
      });

      print("Channel Response => $categories");
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return channelFilter;
  }

  Future<List<String>> postRequest(context, String? value2) async {
    var url =
        '$BASE_URL/api/appData/categoryFilter/channel';

    var body =
    json.encode({"table": "fb", "date": "Jun-2023", "channel": value2});
    print("Body Filter Category $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      categoryFilter = categories;
      print(categories);
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return categoryFilter;
  }

  Future<List<String>> fetchData2(context, String? value0, String? value1) async {
    var url =
        '$BASE_URL/api/appData/brandFilter/channel';

    var body = json.encode({
      "table": "fb",
      "date": "Jun-2023",
      "channel": value0,
      "category": value1
    });
    print("Body Filter Brand $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      setState(() {
        brandFilter = categories;
      });

      print(categories);
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return brandFilter;
  }

  Future<List<String>> fetchData3(context,
      String? value0, String? value2, String? value21) async {
    var url =
        '$BASE_URL/api/appData/brandFormFilter/channel';

    var body = json.encode({
      "table": "fb",
      "date": "Jun-2023",
      "channel": value0,
      "category": value2,
      "brand": value21
    });
    print("Body Filter Brand $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      setState(() {
        brandFormFilter = categories;
      });

      print(categories);
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return brandFormFilter;
  }

  Future<List<String>> fetchData4(context,
      String? value0, String? value3, String? value31, String? value32) async {
    var url =
        '$BASE_URL/api/appData/subBrandFormFilter/channel';

    var body = json.encode({
      "table": "fb",
      "date": "Jun-2023",
      "channel": value0,
      "category": value3,
      "brand": value31,
      "brandForm": value32
    });
    print("Body Filter Brand $body");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      setState(() {
        subBrandFormFilter = categories;
      });

      print(categories);
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return subBrandFormFilter;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postRequestChannel(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(

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
                            // HeaderTitleMetrics(
                            //   onPressed: () {},
                            //   title: 'Month Filter',
                            //   icon: Icons.edit,
                            // ),
                            GestureDetector(
                              onTap: (){},
                              // onTap: widget.onTapMonthFilter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 10, right: 15, bottom: 15),
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
                                  child: Text('month'),
                                  // child: Text(widget.selectedMonthList ?? 'Select a month'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Selected Item: $selectedValue0 / $selectedValue1',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 15.0),
                        DropDownWidget(
                          title: 'Channel',
                          selectedValue: selectedValue0,
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedValue0 = newValue;
                              selectedValue1 = null;
                              selectedValue2 = null;
                              selectedValue3 = null;
                              selectedValue4 = null;
                            });
                            await postRequest(context,
                                selectedValue0);
                            setState(() {});
                          },
                          dropDownItem: channelFilter.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Container(width: 100, child: Text(item, maxLines: 2, style: const TextStyle(fontFamily: fontFamily),)),
                            );
                          }).toList(),
                          secondIndex: 0,
                        ),
                        const SizedBox(height: 20.0),
                        DropDownWidget(
                          title: 'Category',
                          selectedValue: selectedValue1,
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedValue1 =
                                  newValue;
                              selectedValue2 = null;
                              selectedValue3 = null;
                              selectedValue4 = null;
                            });
                            await fetchData2(context, selectedValue0, selectedValue1);
                            setState(() {});
                          },
                          dropDownItem: categoryFilter.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          secondIndex: 0,
                        ),
                        const SizedBox(height: 20.0),
                        DropDownWidget(
                          title: 'Brand',
                          selectedValue: selectedValue2,
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedValue2 = newValue;
                              selectedValue3 = null;
                              selectedValue4 = null;
                            });
                            await fetchData3(context,
                                selectedValue0, selectedValue1, selectedValue2);
                            setState(() {});
                          },
                          dropDownItem: brandFilter.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          secondIndex: 0,
                        ),
                        const SizedBox(height: 20.0),
                        DropDownWidget(
                          title: 'BrandForm',
                          selectedValue: selectedValue3,
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedValue3 =
                                  newValue;
                              selectedValue4 = null;
                            });
                            await fetchData4(context, selectedValue0, selectedValue1,
                                selectedValue2, selectedValue3);
                            setState(() {});
                          },
                          dropDownItem: brandFormFilter.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          secondIndex: 0,
                        ),
                        const SizedBox(height: 20.0),
                        DropDownWidget(
                          selectedValue: selectedValue4,
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedValue4 =
                                  newValue; // Update selectedValue0 with the new value
                            });
                          },
                          title: 'Sub BrandForm',
                          dropDownItem: subBrandFormFilter.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          secondIndex: 0,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ],
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
