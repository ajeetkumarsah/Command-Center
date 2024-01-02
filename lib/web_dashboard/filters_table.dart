import 'package:command_centre/helper/app_urls.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/const/const_array.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DependentDropdowns extends StatefulWidget {
  @override
  _DependentDropdownsState createState() => _DependentDropdownsState();
}

class _DependentDropdownsState extends State<DependentDropdowns> {
  List<String> channelFilter = [];
  List<String> selectedArrayItems = [];
  List<dynamic> filteredItemsChannel = [];

  Future<List<String>> postRequestChannel(context) async {
    var url =
        '$BASE_URL/api/appData/channelFilter/category';

    var body = json.encode({"table": "fb", "date": "Jun-2023"});
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    if (parsedJson['successful'] == true) {
      List<String> categories = List<String>.from(parsedJson['data']);
      setState(() {
        channelFilter = categories;
      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return channelFilter;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postRequestChannel(context);
    // filteredItemsChannel = channelFilter;
  }

  void filterItemsSite(String query) {
    List<dynamic> tempList = [];
    if (query.isNotEmpty) {
      for (var item in channelFilter) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      }
    } else {
      tempList = channelFilter;
    }
    setState(() {
      filteredItemsChannel = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependent Dropdowns'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Padding(
            //   padding:
            //       const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            //   child: SizedBox(
            //       height: 28,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: TextField(
            //           onChanged: (value) {
            //             filterItemsSite(value);
            //           },
            //           decoration: const InputDecoration(
            //             hintText: 'Search...',
            //           ),
            //         ),
            //       )),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 5),
                child: ListView.builder(
                  itemCount: channelFilter.length,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // Toggle the selection state of the item
                                if (selectedArrayItems
                                    .contains(channelFilter[index])) {
                                  selectedArrayItems
                                      .remove(channelFilter[index]);
                                } else {
                                  selectedArrayItems.add(channelFilter[index]);
                                }

                                print(selectedArrayItems);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                top: 5,
                                bottom: 4,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: selectedArrayItems
                                              .contains(channelFilter[index])
                                          ? Colors.blue
                                          : MyColors.transparent,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2)),
                                      border: Border.all(
                                        color: selectedArrayItems
                                                .contains(channelFilter[index])
                                            ? Colors.blue
                                            : MyColors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: selectedArrayItems
                                            .contains(channelFilter[index])
                                        ? const Icon(
                                            Icons.check,
                                            color: MyColors.whiteColor,
                                            size: 13,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      channelFilter[index],
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xff344C65),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
