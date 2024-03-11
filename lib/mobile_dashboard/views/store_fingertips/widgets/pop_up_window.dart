import 'package:command_centre/mobile_dashboard/controllers/store_selection_controller.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class ExamplePopup extends StatefulWidget {
  final Marker marker;
  final String storeName;

  const ExamplePopup(
      {super.key, required this.marker, required this.storeName});

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreSelectionController>(
        init: StoreSelectionController(storeRepo: Get.find()),
        builder: (ctlr) {
      return Card(
        child: InkWell(
          onTap: () {
            ctlr.title = widget.storeName;
            // Future.delayed(const Duration(seconds: 2)).then(
            //         (value) =>
                    Get.offAndToNamed(AppPages.STORE_FINGERTIPS_SCREEN);
            // );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _cardDescription(context),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue),
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'RTR Name',
              style: TextStyle(fontSize: 12.0),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.storeName,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          ],
        ),
      ),
    );
  }
}
