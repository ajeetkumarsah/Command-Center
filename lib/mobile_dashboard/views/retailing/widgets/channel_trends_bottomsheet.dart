import 'package:command_centre/mobile_dashboard/services/analytics_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/summary_types.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';

class ChannelTrendsFilterBottomsheet extends StatefulWidget {
  final String tabType;
  final String type;
  const ChannelTrendsFilterBottomsheet(
      {super.key, required this.tabType, required this.type});

  @override
  State<ChannelTrendsFilterBottomsheet> createState() =>
      _ChannelTrendsFilterBottomsheetState();
}

class _ChannelTrendsFilterBottomsheetState
    extends State<ChannelTrendsFilterBottomsheet> {
  String _selectedTrendsChannel = 'Level 1', _selectedChannelValue = '';
  String get selectedTrendsChannel => _selectedTrendsChannel;
  String get selectedChannelValue => _selectedChannelValue;
  void onChangeFilter(String value) {
    _selectedTrendsChannel = value;
    setState(() {});
  }

  void onChangeFilterValue(String value) {
    _selectedChannelValue = value;
    setState(() {});
  }

  bool isFirst = true;
  void initCall({required HomeController ctlr}) {
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctlr.onChangeTrendsChannel1(ctlr.selectedChannel,
            tabType: widget.tabType);
        if (ctlr.selectedChannel == 'attr1') {
          onChangeFilter('Level 1');
          onChangeFilterValue(ctlr.selectedTrendsChannelValue);
        } else {
          onChangeFilter(ctlr.selectedChannel);
          onChangeFilterValue(ctlr.selectedTrendsChannelValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> channels = [
      'Level 1',
      'Level 2',
      'Level 3',
      'Level 4',
      'Level 5'
    ];
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        initCall(ctlr: ctlr);
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
                                  color: e == selectedTrendsChannel
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () {
                                      onChangeFilter(e);
                                      ctlr.onChangeTrendsChannel1(e,
                                          tabType: widget.tabType);
                                    },
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
                            SizedBox(
                              height: 250,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...ctlr.channelTrendsFilter
                                        .map(
                                          (e) => Row(
                                            children: [
                                              Transform.scale(
                                                scale: .9,
                                                child: Checkbox(
                                                  value: e.toLowerCase() ==
                                                      _selectedChannelValue
                                                          .toLowerCase(),
                                                  onChanged: (v) =>
                                                      onChangeFilterValue(e),
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
                        FirebaseAnalytics.instance.logEvent(name: 'deep_dive_selected_channel', parameters: {"message": 'Added Selected Channel ${ctlr.getUserName()}'});
                        ctlr.onChangeChannel(
                            _selectedTrendsChannel, widget.tabType);
                        ctlr.onTrendsFilterSelect(widget.type, widget.tabType);
                        ctlr.onChangeTrendsChannelValue(
                            _selectedChannelValue, widget.tabType);
                        ctlr.onChangeChannel1(_selectedTrendsChannel);
                        ctlr.onApplyMultiFilter(
                          'trends',
                          widget.tabType == SummaryTypes.coverage.type
                              ? 'trends'
                              : 'geo',
                          tabType: widget.tabType,
                          subType: 'trends',
                        );

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
