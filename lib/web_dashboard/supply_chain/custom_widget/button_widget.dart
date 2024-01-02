import 'package:command_centre/utils/style/text_style.dart';
import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.height = 34,
    this.width = 120,
    this.onTap,
    this.child,
  });

  final double? height;
  final double? width;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: size == 1728? 150: width,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Colors.black12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  final SelectedDropdownindex;
  final Function() onFilterClick;

  const MenuWidget({super.key, this.width, required this.list, required this.onFilterClick, this.SelectedDropdownindex});

  final double? width;
  final List<dynamic>? list;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int selectedIndex = 0;

  bool selectAll = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransportationProvider>(context);
    print(searchController.text);
    List<dynamic>? filteredList = widget.list?.where((item) => item.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    List<dynamic> selectedCategoryIndices = provider.catFilter;
    List<dynamic> selectedSourceIndices = provider.sourceFilter;
    List<dynamic> selectedDestinationIndices = provider.destinationFilter;
    List<dynamic> selectedVehicleIndices = provider.vehicleFilter;
    List<dynamic> selectedSbfIndices = provider.sbfFilter;
    return Container(
      width: 200,
      height: 300,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: const [BoxShadow(blurRadius: 3, color: MyColors.grey, offset: Offset(1, 1))],
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.5,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Container(
        width: 200,
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 2),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent), // Set the line color here
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onChanged: (value) {
                  // print(value);
                  setState(() {
                    // Filter the list based on the search query
                    // Reset selected indices and "Select All" when searching
                    // selectedCategoryIndices.clear();
                    // selectedSourceIndices.clear();
                    // selectedDestinationIndices.clear();
                    // selectedVehicleIndices.clear();
                    // selectedSbfIndices.clear();
                    selectAll = false;
                  });
                },
              ),
            ),
            Container(
              height: 0.5,
              color: const Color(0xffBBBBBB),
            ),
            filteredList!.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: (filteredList?.length ?? 0) + 1, // +1 for "Select All" option
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // "Select All" option
                          return Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectAll = !selectAll;
                                  if (widget.SelectedDropdownindex == 1) {
                                    if (selectAll) {
                                      selectedCategoryIndices = List.generate(filteredList!.length, (index) => filteredList[index]);
                                    } else {
                                      selectedCategoryIndices.clear();
                                    }
                                    provider.setCatFilter(selectedCategoryIndices);
                                  }
                                  if (widget.SelectedDropdownindex == 2) {
                                    if (selectAll) {
                                      selectedSourceIndices = List.generate(filteredList!.length, (index) => filteredList[index]);
                                    } else {
                                      selectedSourceIndices.clear();
                                    }
                                    provider.setSourceFilter(selectedSourceIndices);
                                  }
                                  if (widget.SelectedDropdownindex == 3) {
                                    if (selectAll) {
                                      selectedDestinationIndices = List.generate(filteredList!.length, (index) => filteredList[index]);
                                    } else {
                                      selectedDestinationIndices.clear();
                                    }
                                    provider.setDestinationFilter(selectedDestinationIndices);
                                  }
                                  if (widget.SelectedDropdownindex == 4) {
                                    if (selectAll) {
                                      selectedVehicleIndices = List.generate(filteredList!.length, (index) => filteredList[index]);
                                    } else {
                                      selectedVehicleIndices.clear();
                                    }
                                    provider.setVehicleFilter(selectedVehicleIndices);
                                  }
                                  if (widget.SelectedDropdownindex == 5) {
                                    if (selectAll) {
                                      selectedSbfIndices = List.generate(filteredList!.length, (index) => filteredList[index]);
                                    } else {
                                      selectedSbfIndices.clear();
                                    }
                                    provider.setSbfFilter(selectedSbfIndices);
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: selectAll ? const Color(0xff475DEF) : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xff475DEF),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Select All',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontFamily,
                                      color: selectAll ? const Color(0xff475DEF) : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Regular list item
                          final actualIndex = filteredList[index-1];
                          // print("HERE $filteredList");
                          // print("HERE $actualIndex");
                          return Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectAll = false;
                                  if (widget.SelectedDropdownindex == 1) {
                                    if (selectedCategoryIndices.contains(actualIndex)) {
                                      selectedCategoryIndices.remove(actualIndex);
                                    } else {
                                      selectedCategoryIndices.add(actualIndex);
                                    }
                                    print(selectedCategoryIndices);
                                    provider.setCatFilter(selectedCategoryIndices);
                                    print(provider.catFilter);
                                  }

                                  if (widget.SelectedDropdownindex == 2) {
                                    if (selectedSourceIndices.contains(actualIndex)) {
                                      selectedSourceIndices.remove(actualIndex);
                                    } else {
                                      selectedSourceIndices.add(actualIndex);
                                    }
                                    provider.setSourceFilter(selectedSourceIndices);
                                  }

                                  if (widget.SelectedDropdownindex == 3) {
                                    if (selectedDestinationIndices.contains(actualIndex)) {
                                      selectedDestinationIndices.remove(actualIndex);
                                    } else {
                                      selectedDestinationIndices.add(actualIndex);
                                    }
                                    provider.setDestinationFilter(selectedDestinationIndices);
                                  }

                                  if (widget.SelectedDropdownindex == 4) {
                                    if (selectedVehicleIndices.contains(actualIndex)) {
                                      selectedVehicleIndices.remove(actualIndex);
                                    } else {
                                      selectedVehicleIndices.add(actualIndex);
                                    }
                                    provider.setVehicleFilter(selectedVehicleIndices);
                                  }

                                  if (widget.SelectedDropdownindex == 5) {
                                    if (selectedSbfIndices.contains(actualIndex)) {
                                      selectedSbfIndices.remove(actualIndex);
                                    } else {
                                      selectedSbfIndices.add(actualIndex);
                                    }
                                    provider.setSbfFilter(selectedSbfIndices);
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: widget.SelectedDropdownindex == 1
                                          ? selectedCategoryIndices.contains(actualIndex)
                                              ? Color(0xff475DEF)
                                              : Colors.white
                                          : widget.SelectedDropdownindex == 2
                                              ? selectedSourceIndices.contains(actualIndex)
                                                  ? Color(0xff475DEF)
                                                  : Colors.white
                                              : widget.SelectedDropdownindex == 3
                                                  ? selectedDestinationIndices.contains(actualIndex)
                                                      ? Color(0xff475DEF)
                                                      : Colors.white
                                                  : widget.SelectedDropdownindex == 4
                                                      ? selectedVehicleIndices.contains(actualIndex)
                                                          ? Color(0xff475DEF)
                                                          : Colors.white
                                                      : widget.SelectedDropdownindex == 5
                                                          ? selectedSbfIndices.contains(actualIndex)
                                                              ? Color(0xff475DEF)
                                                              : Colors.white
                                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      border: Border.all(
                                        color: const Color(0xff475DEF),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 120.0,
                                    child: Text(
                                      filteredList[index-1],
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      softWrap: false,
                                      style: const TextStyle(fontFamily: fontFamily),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(
                onPressed: widget.onFilterClick,
                child: const Text('Apply'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
