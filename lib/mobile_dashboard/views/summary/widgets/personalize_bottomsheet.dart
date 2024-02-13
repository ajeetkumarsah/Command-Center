import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/data/models/body/personalized_body.dart';


class PersonalizeBottomsheet extends StatefulWidget {
  const PersonalizeBottomsheet({super.key});

  @override
  State<PersonalizeBottomsheet> createState() => _PersonalizeBottomsheetState();
}

class _PersonalizeBottomsheetState extends State<PersonalizeBottomsheet> {
  final controller =
      Get.put<HomeController>(HomeController(homeRepo: Get.find()));
  List<DragAndDropList> lists = [];
  List<String> activeMetrics = [
        'Retailing',
        'Coverage',
        'Golden Points',
        'Focus Brand'
      ],
      moreMetrics = ['Shipment (TBD)']; //'Inventory'
  List<PesonalizedHeaderBody> allLists(List<String> includedMetrics,
          List<String> moreMet, Function(bool, String, bool) onChange) =>
      [
        PesonalizedHeaderBody(
          header: 'Included Metrics',
          items: [
            ...includedMetrics
                .map(
                  (item) => PersonalizedBody(
                    title: item,
                    value: true,
                    onChanged: (v) => onChange(v, item, true),
                  ),
                )
                .toList(),
          ],
        ),
        PesonalizedHeaderBody(
          header: 'More Metrics',
          items: [
            ...moreMet
                .map(
                  (item) => PersonalizedBody(
                    title: item,
                    value: false,
                    onChanged: (v) => onChange(v, item, false),
                  ),
                )
                .toList(),
          ],
        ),
      ];
  @override
  void initState() {
    super.initState();
    getPersonalizedData();
    lists = allLists(activeMetrics, moreMetrics, onItemChange)
        .map(buildList)
        .toList();
  }

  void getPersonalizedData() {
    String activeJson = controller.getPersonalizedActiveMetrics();
    String moreJson = controller.getPersonalizedMoreMetrics();
    debugPrint('==>Active Data:$activeJson  ==>More Data:$moreJson');
    if (activeJson.trim().isNotEmpty) {
      activeMetrics = List<String>.from(json.decode(activeJson));
    }
    if (moreJson.trim().isNotEmpty) {
      moreMetrics = List<String>.from(json.decode(moreJson));
    }
    setState(() {});
  }

  void onItemChange(bool value, String title, bool isActive) {
    debugPrint('===>Onchage : $value :=> $title  $isActive');
    if (isActive) {
      activeMetrics.remove(title);
      moreMetrics.add(title);
    } else {
      moreMetrics.remove(title);
      activeMetrics.add(title);
    }
    controller.onSavePersonalizedData(active: activeMetrics, more: moreMetrics);
    lists = allLists(activeMetrics, moreMetrics, onItemChange)
        .map(buildList)
        .toList();
    controller.getPersonalizedData();
    setState(() {});
  }

  DragAndDropList buildList(PesonalizedHeaderBody list) => DragAndDropList(
        header: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Text(
            list.header,
            style: GoogleFonts.ptSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        canDrag: false,
        children: list.items
            .asMap()
            .map(
              (index, item) => MapEntry(
                index,
                DragAndDropItem(
                  child: metricsCard(
                    title: item.title,
                    onChanged: item.onChanged,
                    isTop: index == 0,
                    switchValue: item.value,
                    isBottom: (list.items.length - 1) == index,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: AppColors.bgLight,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Personalize',
                        style: GoogleFonts.ptSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'What you\'d like to see on your main screen?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DragAndDropLists(
                    listDividerOnLastChild: false,
                    lastItemTargetHeight: 0,
                    removeTopPadding: true,
                    disableScrolling: true,
                    itemGhost: const SizedBox(),
                    addLastItemTargetHeightToTop: false,
                    contentsWhenEmpty: const SizedBox(
                      height: 50,
                      child: Center(
                        child: SizedBox(),
                      ),
                    ),
                    listPadding: const EdgeInsets.symmetric(vertical: 4),
                    listInnerDecoration:
                        const BoxDecoration(color: Colors.transparent),
                    children: lists,
                    itemDivider: const Divider(
                      thickness: 2,
                      height: 2,
                      color: AppColors.bgLight,
                    ),
                    itemDecorationWhileDragging: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    onItemReorder: onReorderListItem,
                    onListReorder: onReorderList,
                  ),
                  // const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onReorderListItem(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
      debugPrint('===>list Index $oldListIndex Item Index $oldItemIndex');
      if (oldListIndex == 0) {
        //from active metrics
        onItemChange(true, activeMetrics[oldItemIndex], true);
      } else if (oldListIndex == 1) {
        //from more metrics
        onItemChange(false, moreMetrics[oldItemIndex], false);
      }
    });
  }

  void onReorderList(int oldListIndex, int newListIndex) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);

      lists.insert(newListIndex, movedList);
    });
  }

  Widget metricsCard({
    required String title,
    bool isTop = false,
    bool isBottom = false,
    void Function(bool)? onChanged,
    bool switchValue = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: isTop && isBottom
            ? BorderRadius.circular(20)
            : isTop
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                : isBottom
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : null,
        color: AppColors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.toc),
        title: Text(
          title,
          style: GoogleFonts.ptSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Transform.scale(
          scale: 0.9,
          child: CupertinoSwitch(
            activeColor: AppColors.green,
            value: switchValue,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
