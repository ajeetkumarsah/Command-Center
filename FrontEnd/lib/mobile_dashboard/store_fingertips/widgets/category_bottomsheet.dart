import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';

class StoreCategoryBottomsheet extends StatelessWidget {
  const StoreCategoryBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(storeRepo: Get.find()),
      builder: (ctlr) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: AppColors.bgLight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Category',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 300),
              ],
            ),
          ),
        );
      },
    );
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
        borderRadius: isTop
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
