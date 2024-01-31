import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/summary_types.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';


class ChannelFilterBottomsheet extends StatefulWidget {
  final String tabType;
  final bool isTrends;
  const ChannelFilterBottomsheet(
      {super.key, this.isTrends = false, required this.tabType});

  @override
  State<ChannelFilterBottomsheet> createState() =>
      _ChannelFilterBottomsheetState();
}

class _ChannelFilterBottomsheetState extends State<ChannelFilterBottomsheet> {
  Function eq = const ListEquality().equals;
  List<String> channels = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5'
  ];
  String _selectedChannel = 'Level 1';
  String get selectedChannel => _selectedChannel;

  void onChangeFilter(String value) {
    _selectedChannel = value;
    setState(() {});
  }

  bool isFirst = true;
  void initCall(HomeController ctlr) {
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ctlr.selectedChannel == 'attr1') {
          onChangeFilter('Level 1');
          ctlr.onChangeChannel('Level 1', widget.tabType);
        } else {
          onChangeFilter(ctlr.selectedChannel);
          ctlr.onChangeChannel(ctlr.selectedChannel, widget.tabType);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        initCall(ctlr);
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
                                  color: e == _selectedChannel
                                      ? AppColors.white
                                      : null,
                                  child: ListTile(
                                    onTap: () {
                                      onChangeFilter(e);
                                      ctlr.onChangeChannel(e, widget.tabType);
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
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: .9,
                                          child: Checkbox(
                                            value: SummaryTypes
                                                        .retailing.type ==
                                                    widget.tabType
                                                ? eq(
                                                    ctlr
                                                        .selectedRetailingChannelFilter,
                                                    ctlr.channelFilter)
                                                : SummaryTypes.coverage.type ==
                                                        widget.tabType
                                                    ? eq(
                                                        ctlr
                                                            .selectedCoverageChannelFilter,
                                                        ctlr.channelFilter)
                                                    : SummaryTypes.gp.type ==
                                                            widget.tabType
                                                        ? eq(
                                                            ctlr.channelFilter,
                                                            ctlr
                                                                .selectedGPChannelFilter)
                                                        : SummaryTypes
                                                                    .fb.type ==
                                                                widget.tabType
                                                            ? eq(
                                                                ctlr.selectedFBChannelFilter,
                                                                ctlr.channelFilter)
                                                            : false,
                                            onChanged: (v) =>
                                                ctlr.onChangeChannelAllSelect(
                                                    widget.tabType,
                                                    _selectedChannel),
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
                                                  value: SummaryTypes
                                                              .retailing.type ==
                                                          widget.tabType
                                                      ? ctlr
                                                          .selectedRetailingChannelFilter
                                                          .contains(e)
                                                      : SummaryTypes.coverage
                                                                  .type ==
                                                              widget.tabType
                                                          ? ctlr
                                                              .selectedCoverageChannelFilter
                                                              .contains(e)
                                                          : SummaryTypes.gp
                                                                      .type ==
                                                                  widget.tabType
                                                              ? ctlr
                                                                  .selectedGPChannelFilter
                                                                  .contains(e)
                                                              : SummaryTypes.fb
                                                                          .type ==
                                                                      widget
                                                                          .tabType
                                                                  ? ctlr
                                                                      .selectedFBChannelFilter
                                                                      .contains(
                                                                          e)
                                                                  : false,
                                                  onChanged: (v) =>
                                                      ctlr.onChangeChannelValue(
                                                          e,
                                                          widget.tabType,
                                                          _selectedChannel),
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
                      onPressed: SummaryTypes.retailing.type == widget.tabType
                          ? ctlr.selectedRetailingChannelFilter.isNotEmpty
                              ? () => onApplyFilter(ctlr)
                              : null
                          : SummaryTypes.coverage.type == widget.tabType
                              ? ctlr.selectedCoverageChannelFilter.isNotEmpty
                                  ? () => onApplyFilter(ctlr)
                                  : null
                              : SummaryTypes.gp.type == widget.tabType
                                  ? ctlr.selectedGPChannelFilter.isNotEmpty
                                      ? () => onApplyFilter(ctlr)
                                      : null
                                  : SummaryTypes.fb.type == widget.tabType
                                      ? ctlr.selectedFBChannelFilter.isNotEmpty
                                          ? () => onApplyFilter(ctlr)
                                          : null
                                      : () => onApplyFilter(ctlr),
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Apply Changes',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: SummaryTypes.retailing.type == widget.tabType
                              ? ctlr.selectedRetailingChannelFilter.isNotEmpty
                                  ? AppColors.primary
                                  : Colors.grey
                              : SummaryTypes.coverage.type == widget.tabType
                                  ? ctlr.selectedCoverageChannelFilter
                                          .isNotEmpty
                                      ? AppColors.primary
                                      : Colors.grey
                                  : SummaryTypes.gp.type == widget.tabType
                                      ? ctlr.selectedGPChannelFilter.isNotEmpty
                                          ? AppColors.primary
                                          : Colors.grey
                                      : SummaryTypes.fb.type == widget.tabType
                                          ? ctlr.selectedFBChannelFilter
                                                  .isNotEmpty
                                              ? AppColors.primary
                                              : Colors.grey
                                          : Colors.grey,
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

  void onApplyFilter(HomeController ctlr) {
    // ctlr.onChangeChannel(_selectedChannel);
    ctlr.onChangeChannel1(_selectedChannel, tabType: widget.tabType);
    // ctlr.onChangeChannelValue(
    //     _selectedChannelValue, widget.tabType);
    if (widget.isTrends) {
      ctlr.onApplyMultiFilter('trends', 'geo', tabType: widget.tabType);
    } else {
      ctlr.onApplyMultiFilter('geo', 'channel', tabType: widget.tabType);
    }
    Navigator.pop(context);
  }
}
