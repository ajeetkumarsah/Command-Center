import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class ChannelFilterBottomsheet extends StatelessWidget {
  final String tabType;
  final bool isTrends;
  const ChannelFilterBottomsheet(
      {super.key, this.isTrends = false, required this.tabType});

  @override
  Widget build(BuildContext context) {
    List<String> channels = ['Channel'];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Select Channel',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * .4,
                      color: AppColors.blueLight.withOpacity(.25),
                      child: Column(
                        children: [
                          ...channels
                              .map(
                                (e) => Container(
                                  color: e == ctlr.selectedChannel
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () => ctlr.onChangeChannel(e),
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -3),
                                    title: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TextFormField(
                            //   decoration: const InputDecoration(
                            //     hintText: 'Search ',
                            //     prefixIcon: Icon(
                            //       Icons.search,
                            //       color: Colors.grey,
                            //     ),
                            //     border: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //         width: .5,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //         width: .5,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //         width: .5,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 250,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: .9,
                                          child: Checkbox(
                                            value: listEquals(
                                                ctlr.selectedChannelFilter,
                                                ctlr.channelFilter),
                                            onChanged: (v) =>
                                                ctlr.onChangeChannelAllSelect(),
                                          ),
                                        ),
                                        const Flexible(
                                          child: Text('Select All'),
                                        )
                                      ],
                                    ),
                                    ...ctlr.channelFilter
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Transform.scale(
                                                scale: .9,
                                                child: Checkbox(
                                                  value: ctlr
                                                      .selectedChannelFilter
                                                      .contains(e),
                                                  onChanged: (v) => ctlr
                                                      .onChangeChannelValue(e),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(e),
                                              )
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Clear',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (isTrends) {
                          ctlr.onApplyMultiFilter('trends', 'geo',
                              tabType: tabType);
                        } else {
                          ctlr.onApplyMultiFilter('geo', 'channel',
                              tabType: tabType);
                        }
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Apply Changes',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
