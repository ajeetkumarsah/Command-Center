import 'dart:ui';
import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:text_3d/text_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../retailing/widgets/geography_bottomsheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../retailing/widgets/select_month_bottomsheet.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:command_centre/mobile_dashboard/utils/date_converter.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/utils/global.dart' as globals;
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/menu_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_card.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/retailing_graph_widget.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/retailing_table_widget.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/personalize_bottomsheet.dart';

// ignore_for_file: depend_on_referenced_packages
class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isFirst = true;

  final ScrollController sScrollController = ScrollController();

  late TutorialCoachMark tutorialCoachMark;
  final HomeController homeCtlr = Get.put(HomeController(homeRepo: Get.find()));
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  // GlobalKey keyButton5 = GlobalKey();

  @override
  void initState() {
    getInitValues();
    getBanner();
    initGuide();
    super.initState();
  }

  autoRefreshData(HomeController ctlr) {
    if (globals.autoRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ctlr.getSummaryData(isAutoRefresh: true);
      });
      globals.autoRefresh = false;
      debugPrint('===>AutoData is Refreshing  ${globals.autoRefresh}');
    }
  }

  String addSpaceBeforeCapitals(String input) {
    // Use a regular expression to replace each capital letter (except the first one
    // if it is capital) with a space followed by the capital letter itself.
    return input.replaceAllMapped(
        RegExp(r'(?<!^)([A-Z])'), (Match match) => ' ${match.group(0)}');
  }

  void getInitValues() {
    FirebaseCrashlytics.instance.log("Summary Started");
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await homeCtlr.getInitValues();
      });
    }
  }

  void initGuide() {
    bool userGuide = homeCtlr.getUserGuide();
    if (!userGuide) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
      homeCtlr.saveUserGuide(true);
    }
  }

  Future<void> getBanner() async {
    var firestore = FirebaseFirestore.instance;
    var querySnap = await firestore.collection("data_refresh").get();
    if (querySnap.docs[0]['showPopup'] ?? false) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(querySnap.docs[0]['popupTitle'] ?? ''),
          content: Text(querySnap.docs[0]['popupSubtitle'] ?? ''),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'Okay',
                style: GoogleFonts.ptSansCaption(fontSize: 12),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      initState: (_) {
        // initCall();
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   controller.getInitValues();
        // });
      },
      builder: (ctlr) {
        // initCall(ctlr);
        return RefreshIndicator(
          onRefresh: () => ctlr.getSummaryData(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PngFiles.homeBg),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: sScrollController,
              child: Column(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("auto_data_refresh")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data?.docs.first.data() != null &&
                          snapshot.data?.docs.first.data()['refresh_data'] !=
                              null &&
                          snapshot.data?.docs.first.data()['refresh_data']) {
                        debugPrint('===>Data refresh');
                        autoRefreshData(ctlr);
                      }
                      return const SizedBox();
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("data_refresh")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: snapshot.data?.docs.first.data() != null &&
                                snapshot.data?.docs.first
                                        .data()['isRefreshing'] !=
                                    null &&
                                snapshot.data?.docs.first.data()['isRefreshing']
                            ? AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 12),
                                    LoadingAnimationWidget.fallingDot(
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: Marquee(
                                        text: snapshot.data?.docs.first
                                                .data()['title'] ??
                                            'D-1 Data Undergoing Refresh...',
                                        style: GoogleFonts.ptSansCaption(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.primary,
                                        ),
                                        scrollAxis: Axis.horizontal,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        blankSpace: 100,
                                        velocity: 100.0,
                                        pauseAfterRound:
                                            const Duration(seconds: 1),
                                        startPadding: 100.0,
                                        accelerationDuration:
                                            const Duration(seconds: 1),
                                        accelerationCurve: Curves.linear,
                                        decelerationDuration:
                                            const Duration(milliseconds: 500),
                                        decelerationCurve: Curves.easeOut,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : snapshot.data?.docs.first.data()['lastUpdated'] !=
                                    null
                                ? Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    // decoration: BoxDecoration(
                                    //   gradient: LinearGradient(
                                    //     begin: Alignment.topCenter,
                                    //     end: Alignment.bottomCenter,
                                    //     colors: [
                                    //       AppColors.primary.withOpacity(.4),
                                    //       AppColors.primary.withOpacity(.3),
                                    //     ],
                                    //   ),
                                    // ),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Complete Data Upto ${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(snapshot.data?.docs.first.data()['lastUpdated']) ?? 1610268500000))}',
                                            style: GoogleFonts.ptSans(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(height: 30),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hello, ',
                                      style: GoogleFonts.ptSans(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: addSpaceBeforeCapitals(
                                          ctlr.getUserName()),
                                      style: GoogleFonts.ptSans(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Here\'s the Business Summary',
                                style: GoogleFonts.ptSans(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.bottomSheet(
                            MenuBottomsheet(version: ctlr.appVersion),
                            isScrollControlled: true,
                          ),
                          // () => Get.to(const UpdateScreen()),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            key: keyButton,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: ctlr.isSummaryPageLoading
                                        ? () {
                                            showCustomSnackBar(
                                                'Please wait data is loading! ',
                                                isError: false,
                                                isBlack: true);
                                          }
                                        : () => Get.bottomSheet(
                                              const GeographyBottomsheet(
                                                tabType: 'All',
                                                isLoadRetailing: true,
                                                isSummary: true,
                                              ),
                                              isScrollControlled: true,
                                            ),
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              ctlr.selectedGeo,
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            color: AppColors.black,
                                            size: 26,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 56, width: 1, color: Colors.grey),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: ctlr.isSummaryPageLoading
                                        ? () {
                                            showCustomSnackBar(
                                                'Please wait data is loading! ',
                                                isError: false,
                                                isBlack: true);
                                          }
                                        : () => Get.bottomSheet(
                                              const GeographyBottomsheet(
                                                tabType: 'All',
                                                isLoadRetailing: true,
                                                isSummary: true,
                                              ),
                                              isScrollControlled: true,
                                            ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              ctlr.selectedGeoValue,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: ctlr.isSummaryPageLoading
                                ? () {
                                    showCustomSnackBar(
                                        'Please wait data is loading! ',
                                        isError: false,
                                        isBlack: true);
                                  }
                                : () => Get.bottomSheet(
                                      const SelectMonthBottomsheet(
                                        tabType: 'All',
                                        isLoadRetailing: true,
                                        isSummary: true,
                                      ),
                                      isScrollControlled: true,
                                    ),
                            child: Container(
                              key: keyButton1,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.white,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      ctlr.selectedMonth != null
                                          ? '${ctlr.selectedMonth}'
                                          : '',
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.ptSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.black,
                                    size: 26,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (ctlr.activeMetrics.contains('Retailing'))
                    ctlr.isSummaryPageLoading || ctlr.isDirectIndirectLoading
                        ? CustomShimmer(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 24, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Retailing ',
                                isDataFound: ctlr.isSummaryDirect
                                    ? ctlr.summaryData.first.mtdRetailing?.ind
                                            ?.dataFound ??
                                        false
                                    : ctlr.summaryData.first.mtdRetailing
                                            ?.indDir?.dataFound ??
                                        false,
                                secondTitle: '',
                                secondWidget: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: ThreeDText(
                                        text: 'Retailing',
                                        textStyle: GoogleFonts.ptSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                        ),
                                        depth: 2,
                                        style: ThreeDStyle.inset,
                                        angle: pi / 6,
                                        perspectiveDepth: 10,
                                      ),
                                      // Text(
                                      //   'Retailing',
                                      //   style: GoogleFonts.ptSans(
                                      //     fontSize: 18,
                                      //     fontWeight: FontWeight.w700,
                                      //     color: AppColors.white,
                                      //   ),
                                      // ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 0, left: 12, right: 4),
                                      decoration: BoxDecoration(
                                          // color: AppColors.white,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.contentColorCyan
                                                  .withOpacity(.4),
                                              AppColors.contentColorBlue
                                                  .withOpacity(.4),
                                            ],
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.lightGrey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                ctlr.onChangeSummaryDI(true),
                                            child: Container(
                                              key: keyButton2,
                                              decoration: BoxDecoration(
                                                color: ctlr.isSummaryDirect
                                                    ? AppColors.white
                                                    : Colors.transparent,
                                                gradient: !ctlr.isSummaryDirect
                                                    ? const LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          AppColors
                                                              .contentColorCyan,
                                                          AppColors
                                                              .contentColorBlue,
                                                        ],
                                                      )
                                                    : null,
                                                boxShadow: ctlr.isSummaryDirect
                                                    ? [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(.5),
                                                          blurRadius: 2.0,
                                                          spreadRadius: 0.0,
                                                          offset: const Offset(
                                                              2.0, 2.0),
                                                        ),
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(.2),
                                                          blurRadius: 2.0,
                                                          spreadRadius: 0.0,
                                                          offset: const Offset(
                                                              -2.0, -2.0),
                                                        ),
                                                      ]
                                                    : null,
                                                border: Border.all(
                                                  width: 1,
                                                  color: ctlr.isSummaryDirect
                                                      ? AppColors.white
                                                      : Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4),
                                              child: Text(
                                                'Distributor',
                                                style:
                                                    GoogleFonts.ptSansCaption(
                                                  color: ctlr.isSummaryDirect
                                                      ? AppColors.primary
                                                      : Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (ctlr.selectedGeo == 'All India')
                                            GestureDetector(
                                              onTap: () =>
                                                  ctlr.onChangeSummaryDI(false),
                                              child: Container(
                                                key: keyButton3,
                                                decoration: BoxDecoration(
                                                  color: ctlr.isSummaryDirect
                                                      ? Colors.transparent
                                                      : AppColors.white,
                                                  gradient: ctlr.isSummaryDirect
                                                      ? const LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            AppColors
                                                                .contentColorCyan,
                                                            AppColors
                                                                .contentColorBlue,
                                                          ],
                                                        )
                                                      : null,
                                                  boxShadow: !ctlr
                                                          .isSummaryDirect
                                                      ? [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .5),
                                                            blurRadius: 2.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                const Offset(
                                                                    2.0, 2.0),
                                                          ),
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .2),
                                                            blurRadius: 2.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                const Offset(
                                                                    -2.0, -2.0),
                                                          ),
                                                        ]
                                                      : null,
                                                  border: ctlr.isSummaryDirect
                                                      ? null
                                                      : Border.all(
                                                          width: 1,
                                                          color: !ctlr
                                                                  .isSummaryDirect
                                                              ? AppColors.white
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                child: Text(
                                                  'Total Retailing',
                                                  style:
                                                      GoogleFonts.ptSansCaption(
                                                    color: !ctlr.isSummaryDirect
                                                        ? AppColors.primary
                                                        : Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                showKey: keyButton4,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.RETAILING_SCREEN),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                ctlr.isSummaryDirect
                                                    ? 'Sellout CY  \n(in ${ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Lk') ?? false ? 'Lk' : ''})'
                                                    : 'Sellout CY   \n(in ${ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Lk') ?? false ? 'Lk' : ''})',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      ctlr.isSummaryDirect
                                                          ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmSellout}'
                                                          : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmSellout}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        if (ctlr.isSummaryDirect
                                            ? (ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.ind
                                                        ?.cmPySellout !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .ind!
                                                    .cmPySellout!
                                                    .isNotEmpty)
                                            : ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.indDir
                                                        ?.cmPySellout !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .indDir!
                                                    .cmPySellout!
                                                    .isNotEmpty)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  ctlr.isSummaryDirect
                                                      ? 'Sellout PY \n (in ${ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout?.contains('Lk') ?? false ? 'Lk' : ''})'
                                                      : 'Sellout PY  \n(in ${ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout?.contains('Cr') ?? false ? 'Cr' : ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout?.contains('Lk') ?? false ? 'Lk' : ''})',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        ctlr.isSummaryDirect
                                                            ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.ind?.cmPySellout}'
                                                            : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout?.contains('Cr') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout?.replaceAll('Cr', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout?.contains('Lk') ?? false ? ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout?.replaceAll('Lk', '') : ctlr.summaryData.first.mtdRetailing?.indDir?.cmPySellout}',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        if (ctlr.isSummaryDirect
                                            ? (ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.ind
                                                        ?.cmIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .ind!
                                                    .cmIya!
                                                    .isNotEmpty)
                                            : ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.indDir
                                                        ?.cmIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .indDir!
                                                    .cmIya!
                                                    .isNotEmpty)
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${ctlr.selectedMonth?.substring(0, 3)}${ctlr.selectedMonth?.substring(6, 8)} \nIYA',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        ctlr.isSummaryDirect
                                                            ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cmIya}'
                                                            : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cmIya}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        if (ctlr.isSummaryDirect
                                            ? (ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.ind
                                                        ?.fyIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .ind!
                                                    .fyIya!
                                                    .isNotEmpty)
                                            : ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.indDir
                                                        ?.fyIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .indDir!
                                                    .fyIya!
                                                    .isNotEmpty)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${DateConverter().returnMonth(DateTime.now()).substring(0, 3).toLowerCase() == ctlr.selectedMonth?.substring(0, 3).toLowerCase() ? 'P3M' : 'FYTD'} \nIYA',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        ctlr.isSummaryDirect
                                                            ? '${ctlr.summaryData.first.mtdRetailing?.ind?.fyIya}'
                                                            : '${ctlr.summaryData.first.mtdRetailing?.indDir?.fyIya}',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        if (ctlr.isSummaryDirect
                                            ? (ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.ind
                                                        ?.cyP3MIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .ind!
                                                    .cyP3MIya!
                                                    .isNotEmpty)
                                            : ctlr
                                                        .summaryData
                                                        .first
                                                        .mtdRetailing
                                                        ?.indDir
                                                        ?.cyP3MIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .mtdRetailing!
                                                    .indDir!
                                                    .cyP3MIya!
                                                    .isNotEmpty)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${DateConverter().returnMonth(DateTime.now()).substring(0, 3).toLowerCase() == ctlr.selectedMonth?.substring(0, 3).toLowerCase() ? 'P3M' : 'FYTD'} \nIYA',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        ctlr.isSummaryDirect
                                                            ? '${ctlr.summaryData.first.mtdRetailing?.ind?.cyP3MIya}'
                                                            : '${ctlr.summaryData.first.mtdRetailing?.indDir?.cyP3MIya}',
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.channel !=
                                          null)
                                    Container(
                                      height: .5,
                                      width: double.infinity,
                                      color: AppColors.borderColor,
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.channel !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Flexible(
                                            child: Text(
                                              'Channel-Wise',
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.channel !=
                                          null)
                                    RetailingTableWidget(
                                      dataList: ctlr.isSummaryDirect
                                          ? ctlr.summaryData.first.mtdRetailing
                                                  ?.ind?.channel ??
                                              []
                                          : ctlr.summaryData.first.mtdRetailing
                                                  ?.indDir?.channel ??
                                              [],
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    Container(
                                      height: .5,
                                      width: double.infinity,
                                      color: AppColors.borderColor,
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Flexible(
                                            child: Text(
                                              'Trends Analysis',
                                              style: GoogleFonts.ptSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 12),
                                      child: Row(
                                        children: [
                                          Container(
                                            // height: 26,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.lightGrey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      ctlr.onChannelSalesChange(
                                                          true),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    decoration: BoxDecoration(
                                                      color: ctlr.channelSales
                                                          ? AppColors.white
                                                          : AppColors.white,
                                                      gradient:
                                                          ctlr.channelSales
                                                              ? LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    AppColors
                                                                        .contentColorCyan
                                                                        .withOpacity(
                                                                            .7),
                                                                    AppColors
                                                                        .contentColorBlue
                                                                        .withOpacity(
                                                                            .7),
                                                                    // AppColors.contentColorCyan.withOpacity(.6),
                                                                  ],
                                                                )
                                                              : null,
                                                      boxShadow: ctlr
                                                              .channelSales
                                                          ? [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .3),
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset:
                                                                    const Offset(
                                                                        2.0,
                                                                        2.0),
                                                              ),
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .2),
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset:
                                                                    const Offset(
                                                                        -2.0,
                                                                        -2.0),
                                                              ),
                                                            ]
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    child: Text(
                                                      'Sales Value',
                                                      style: GoogleFonts
                                                          .ptSansCaption(
                                                        color: ctlr.channelSales
                                                            ? Colors.white
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      ctlr.onChannelSalesChange(
                                                          false),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ctlr.channelSales
                                                          ? AppColors.white
                                                          : AppColors.primary,
                                                      gradient:
                                                          !ctlr.channelSales
                                                              ? LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  colors: [
                                                                    AppColors
                                                                        .contentColorCyan
                                                                        .withOpacity(
                                                                            .7),
                                                                    AppColors
                                                                        .contentColorBlue
                                                                        .withOpacity(
                                                                            .7),
                                                                    // AppColors.contentColorCyan.withOpacity(.6),
                                                                  ],
                                                                )
                                                              : null,
                                                      boxShadow: !ctlr
                                                              .channelSales
                                                          ? [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .5),
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset:
                                                                    const Offset(
                                                                        2.0,
                                                                        2.0),
                                                              ),
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .2),
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset:
                                                                    const Offset(
                                                                        -2.0,
                                                                        -2.0),
                                                              ),
                                                            ]
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    child: Text(
                                                      '  IYA  ',
                                                      style: GoogleFonts
                                                          .ptSansCaption(
                                                        color:
                                                            !ctlr.channelSales
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    const SizedBox(height: 12),
                                  if (ctlr.getPersona() &&
                                      ctlr.summaryData.first.mtdRetailing?.ind
                                              ?.trends !=
                                          null)
                                    RetailingGraphWidget(
                                      yAxisData: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yAxisData ??
                                                  []
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yAxisDataPer ??
                                                  []
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yAxisData ??
                                                  []
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yAxisDataPer ??
                                                  [],
                                      minValue: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yMin ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yPerMin ??
                                                  0.0
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yMin ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yPerMin ??
                                                  0.0,
                                      maxValue: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yMax ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yPerMax ??
                                                  0.0
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yMax ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yPerMax ??
                                                  0.0,
                                      interval: ctlr.isSummaryDirect
                                          ? ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yInterval ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.ind
                                                      ?.yPerInterval ??
                                                  0.0
                                          : ctlr.channelSales
                                              ? ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yInterval ??
                                                  0.0
                                              : ctlr
                                                      .summaryData
                                                      .first
                                                      .mtdRetailing
                                                      ?.indDir
                                                      ?.yPerInterval ??
                                                  0.0,
                                      trendsData: ctlr.isSummaryDirect
                                          ? ctlr.summaryData.first.mtdRetailing
                                                  ?.ind?.trends ??
                                              []
                                          : ctlr.summaryData.first.mtdRetailing
                                                  ?.indDir?.trends ??
                                              [],
                                      salesValue: ctlr.channelSales,
                                    ),
                                ],
                              )
                            : const SizedBox(),
                  if (ctlr.activeMetrics
                      .contains('Coverage')) //ctlr.showCoverage)
                    ctlr.isSummaryPageLoading
                        ? CustomShimmer(
                            height: 260,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 16, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Coverage ',
                                top: 12,
                                isDataFound:
                                    ctlr.summaryData.first.coverage?.dataFound,
                                secondTitle: '',
                                bottomInside: 8,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.COVERAGE_SCREEN),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Coverage (in ${ctlr.summaryData.first.coverage?.cmCoverage?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.coverage?.cmCoverage?.contains('M') ?? false ? 'M' : 'M'})',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.coverage?.cmCoverage?.contains('MM') ?? false ? ctlr.summaryData.first.coverage?.cmCoverage?.replaceAll('MM', '') : ctlr.summaryData.first.coverage?.cmCoverage?.contains('M') ?? false ? ctlr.summaryData.first.coverage?.cmCoverage?.replaceAll('M', '') : ctlr.summaryData.first.coverage?.cmCoverage}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Call Hit Rate %',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.coverage?.ccCurrentMonth}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: Column(
                                        //     children: [
                                        //       // Text(
                                        //       //   '${ctlr.selectedMonth?.substring(0, 3)}${ctlr.selectedMonth?.substring(6, 8)} Billing %',
                                        //       //   style: GoogleFonts.ptSans(
                                        //       //     fontSize: 16,
                                        //       //     fontWeight: FontWeight.w400,
                                        //       //   ),
                                        //       // ),
                                        //       Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Flexible(
                                        //             child: Text(
                                        //               '${ctlr.summaryData.first.coverage?.billing?.contains('') ?? false ? ctlr.summaryData.first.coverage?.billing?.replaceAll('%', '') : ctlr.summaryData.first.coverage?.billing}',
                                        //               style: GoogleFonts.ptSans(
                                        //                 fontSize: 40,
                                        //                 fontWeight:
                                        //                     FontWeight.w400,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Expanded(
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.center,
                                        //     children: [
                                        //       Text(
                                        //         'Call Hit Rate %',
                                        //         style: GoogleFonts.ptSans(
                                        //           fontSize: 16,
                                        //           fontWeight: FontWeight.w400,
                                        //         ),
                                        //       ),
                                        //       Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Flexible(
                                        //             child: Text(
                                        //               '${ctlr.summaryData.first.coverage?.ccCurrentMonth}',
                                        //               style: GoogleFonts.ptSans(
                                        //                 fontSize: 40,
                                        //                 fontWeight:
                                        //                     FontWeight.w400,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Productivity %',
                                                style: GoogleFonts.ptSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${ctlr.summaryData.first.productivity?.productivityCurrentMonth}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                  if (ctlr.activeMetrics
                      .contains('Golden Points')) //ctlr.showGoldenPoints)
                    ctlr.isSummaryPageLoading
                        ? CustomShimmer(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 16, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Golden Points',
                                secondTitle: '', //P3M
                                top: 12,
                                isDataFound: ctlr
                                    .summaryData.first.dgpCompliance?.dataFound,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.GOLDEN_POINT_SCREEN),
                                bottomInside: 8,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment: ((ctlr
                                                          .summaryData
                                                          .first
                                                          .dgpCompliance
                                                          ?.gpAbs !=
                                                      null &&
                                                  ctlr
                                                      .summaryData
                                                      .first
                                                      .dgpCompliance!
                                                      .gpAbs!
                                                      .isNotEmpty) ||
                                              (ctlr
                                                          .summaryData
                                                          .first
                                                          .dgpCompliance
                                                          ?.gpIya !=
                                                      null &&
                                                  ctlr
                                                      .summaryData
                                                      .first
                                                      .dgpCompliance!
                                                      .gpIya!
                                                      .isNotEmpty))
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if ((ctlr.summaryData.first
                                                        .dgpCompliance?.gpAbs !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .dgpCompliance!
                                                    .gpAbs!
                                                    .isNotEmpty) ||
                                            (ctlr.summaryData.first
                                                        .dgpCompliance?.gpIya !=
                                                    null &&
                                                ctlr
                                                    .summaryData
                                                    .first
                                                    .dgpCompliance!
                                                    .gpIya!
                                                    .isNotEmpty))
                                          Column(
                                            children: [
                                              if (ctlr
                                                          .summaryData
                                                          .first
                                                          .dgpCompliance
                                                          ?.gpAbs !=
                                                      null &&
                                                  ctlr
                                                      .summaryData
                                                      .first
                                                      .dgpCompliance!
                                                      .gpAbs!
                                                      .isNotEmpty)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'GP P3M (in ${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? 'MM' : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? 'M' : 'M'})',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('MM') ?? false ? ctlr.summaryData.first.dgpCompliance?.gpAbs?.replaceAll('MM', '') : ctlr.summaryData.first.dgpCompliance?.gpAbs?.contains('M') ?? false ? ctlr.summaryData.first.dgpCompliance?.gpAbs?.replaceAll('M', '') : ctlr.summaryData.first.dgpCompliance?.gpAbs}',
                                                      style: GoogleFonts.ptSans(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              const SizedBox(height: 16),
                                              if (ctlr
                                                          .summaryData
                                                          .first
                                                          .dgpCompliance
                                                          ?.gpIya !=
                                                      null &&
                                                  ctlr
                                                      .summaryData
                                                      .first
                                                      .dgpCompliance!
                                                      .gpIya!
                                                      .isNotEmpty)
                                                Column(
                                                  children: [
                                                    Text(
                                                      'GP P3M IYA',
                                                      style: GoogleFonts
                                                          .ptSansCaption(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${ctlr.summaryData.first.dgpCompliance?.gpIya}',
                                                      style: GoogleFonts
                                                          .ptSansCaption(
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        CircularPercentIndicator(
                                          radius: 50.0,
                                          lineWidth: 12.0,
                                          percent: double.tryParse(ctlr
                                                      .summaryData
                                                      .first
                                                      .dgpCompliance
                                                      ?.progressBarGpAchieved ??
                                                  '0.0') ??
                                              0.0,
                                          header: const Text('GP Ach %'),
                                          center: Text(
                                              "${ctlr.summaryData.first.dgpCompliance?.gpAchievememt}%"),
                                          backgroundColor:
                                              const Color(0xffD9D9D9),
                                          animation: true,
                                          curve: Curves.easeInBack,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          linearGradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              AppColors.contentColorCyan
                                                  .withOpacity(.6),
                                              AppColors.contentColorBlue
                                                  .withOpacity(.6),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                  if (ctlr.activeMetrics
                      .contains('Focus Brand')) //ctlr.showFocusBrand)
                    ctlr.isSummaryPageLoading
                        ? CustomShimmer(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(22),
                            margin: const EdgeInsets.only(
                                top: 16, left: 12, right: 12, bottom: 8),
                          )
                        : ctlr.summaryData.isNotEmpty
                            ? PersonalizeCard(
                                title: 'Focus Brand',
                                secondTitle: '',
                                isDataFound: ctlr
                                    .summaryData.first.focusBrand?.dataFound,
                                top: 12,
                                onPressedShowMore: () =>
                                    Get.toNamed(AppPages.FOCUS_BRAND_SCREEN),
                                bottomInside: 8,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'FB Actual (in ${(ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false) ? 'MM' : (ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false) ? 'M' : 'M'})',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${(ctlr.summaryData.first.focusBrand?.fbActual?.contains('MM') ?? false) ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('MM', '') : (ctlr.summaryData.first.focusBrand?.fbActual?.contains('M') ?? false) ? ctlr.summaryData.first.focusBrand?.fbActual?.replaceAll('M', '') : ctlr.summaryData.first.focusBrand?.fbActual}',
                                                  style: GoogleFonts.ptSans(
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                        CircularPercentIndicator(
                                          radius: 50.0,
                                          lineWidth: 12.0,
                                          percent: double.tryParse(ctlr
                                                      .summaryData
                                                      .first
                                                      .focusBrand
                                                      ?.progressBarFbAchievement ??
                                                  '0.0') ??
                                              0.0,
                                          header: const Text('FB Ach %'),
                                          center: Text(
                                              "${ctlr.summaryData.first.focusBrand?.fbAchievement}%"),
                                          backgroundColor:
                                              const Color(0xffD9D9D9),
                                          animation: true,
                                          curve: Curves.easeInBack,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          linearGradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              AppColors.contentColorCyan
                                                  .withOpacity(.6),
                                              AppColors.contentColorBlue
                                                  .withOpacity(.6),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                  if (ctlr.summaryData.isEmpty && !ctlr.isSummaryPageLoading)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.lightGrey.withOpacity(.3),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Lottie.asset(
                              'assets/json/nodata.json',
                              // width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .2,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            'No data found!',
                            style: GoogleFonts.ptSansCaption(
                              fontSize: 16,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            const PersonalizeBottomsheet(),
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          // key: keyButton5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.settings,
                                color: AppColors.primary,
                              ),
                              Text(
                                '  Personalize',
                                style: GoogleFonts.ptSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: AppColors.primary,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        sScrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      },
      onClickTarget: (target) {
        if (target.identify == 'Target 3') {
          sScrollController.animateTo(
            600,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        }
        // else if (target.identify == 'Target 4') {
        //   sScrollController.animateTo(
        //     (sScrollController.position.maxScrollExtent + 300),
        //     duration: const Duration(milliseconds: 300),
        //     curve: Curves.fastOutSlowIn,
        //   );
        // }
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        if (target.identify == 'Target 3') {
          sScrollController.animateTo(
            600,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        }
        // else if (target.identify == 'Target 4') {
        //   sScrollController.animateTo(
        //     (sScrollController.position.maxScrollExtent + 300),
        //     duration: const Duration(milliseconds: 300),
        //     curve: Curves.fastOutSlowIn,
        //   );
        // }
      },
      onClickOverlay: (target) {
        if (target.identify == 'Target 3') {
          sScrollController.animateTo(
            600,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        }
        // else if (target.identify == 'Target 4') {
        //   sScrollController.animateTo(
        //     (sScrollController.position.maxScrollExtent + 300),
        //     duration: const Duration(milliseconds: 300),
        //     curve: Curves.fastOutSlowIn,
        //   );
        // }
      },
      onSkip: () {
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton,
        color: AppColors.primary,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60),
                  Text(
                    "Geography Filter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "You can change the Geography by clicking on this filter button.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton1,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        color: AppColors.primary,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return GetBuilder<HomeController>(
                init: HomeController(homeRepo: Get.find()),
                builder: (ctlr) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 60),
                      Text(
                        "Month Filter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "You can change the selected month by clicking on this button.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: keyButton2,
        color: AppColors.primary,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return GetBuilder<HomeController>(
                init: HomeController(homeRepo: Get.find()),
                builder: (ctlr) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 160),
                      Text(
                        "Distributor ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Distributor comprises of only those Retailing which are done by distributors.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: keyButton3,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        color: AppColors.primary,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return GetBuilder<HomeController>(
                init: HomeController(homeRepo: Get.find()),
                builder: (ctlr) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 160),
                      Text(
                        "Total Retailing",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Total Retailing comprises total retailing including Distributor as well as Non-Distributor Retailing.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: keyButton4,
        shape: ShapeLightFocus.RRect,
        radius: 5,
        color: AppColors.primary,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return GetBuilder<HomeController>(
                init: HomeController(homeRepo: Get.find()),
                builder: (ctlr) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 60),
                      Text(
                        "Show More",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "You can check the deepdives data by clicking on the show more button.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
    // targets.add(
    //   TargetFocus(
    //     identify: "Target 5",
    //     keyTarget: keyButton5,
    //     shape: ShapeLightFocus.RRect,
    //     radius: 5,
    //     color: AppColors.primary,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.top,
    //         builder: (context, controller) {
    //           return const Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               SizedBox(height: 160),
    //               Text(
    //                 "Personalize",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.white,
    //                     fontSize: 20.0),
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(top: 10.0),
    //                 child: Text(
    //                   "You can personalize your Summary page by clicking on this button.",
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               ),
    //               SizedBox(height: 160),
    //             ],
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return targets;
  }
}
