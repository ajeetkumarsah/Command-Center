import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:command_centre/utils/colors/colors.dart';
import 'package:command_centre/utils/style/text_style.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:command_centre/mobile_dashboard/utils/png_files.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:command_centre/mobile_dashboard/bindings/home_binding.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_loader.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_shimmer.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';
import 'package:command_centre/mobile_dashboard/views/summary/widgets/menu_bottomsheet.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_selection_controller.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/widgets/pop_up_window.dart';
import 'package:command_centre/mobile_dashboard/views/store_fingertips/store_fingertips_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeBinding().dependencies();
  runApp(GetMaterialApp(
    home: const OnboardingScreen(),
    getPages: AppPages.routes,
    // debugShowCheckedModeBanner: false,
  ));
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  bool isMapVisible = false;
  bool isDropDownVisible = true;
  bool visible = false;
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  final Key key = GlobalKey();

  ValueNotifier<bool> activateCollectGetGeoPointsToDraw = ValueNotifier(false);
  ValueNotifier<bool> activateDrawRoad = ValueNotifier(false);

  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(true);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(true);

  ValueNotifier<List<GeoPoint>> roadPoints = ValueNotifier([]);
  ValueNotifier<bool> isTracking = ValueNotifier(false);
  List<MapDataModel> locations = [];
  late AlignOnUpdate _alignPositionOnUpdate;
  late final StreamController<double?> _alignPositionStreamController;

  @override
  void initState() {
    super.initState();
    _alignPositionOnUpdate = AlignOnUpdate.always;
    _alignPositionStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    _alignPositionStreamController.close();
    super.dispose();
  }

  void onChangePage() {
    debugPrint("Active Index ===> $activeIndex");
    if (activeIndex < 1) {
      _activeIndex++;
    } else if (activeIndex == 2) {
      Future.delayed(const Duration(seconds: 2))
          .then((value) => Get.toNamed(AppPages.STORE_FINGERTIPS_SCREEN));
    }
    setState(() {});
  }

  void onChangePageIndex(int value) {
    // Future.delayed(const Duration(seconds: 2))
    //     .then((value) => Get.toNamed(AppPages.STORE_FINGERTIPS_SCREEN));
    if (activeIndex < 1) {
      if (value < 1) {
        _activeIndex = value;
      } else {
        _activeIndex++;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<StepperData> stepperData = [
      StepperData(
        title: StepperText(
          "Get Started ",
          textStyle: GoogleFonts.ptSans(
            color: _activeIndex > 0 ? AppColors.primary : AppColors.green,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconWidget: GestureDetector(
          onTap: () => onChangePageIndex(0),
          child: Container(
            padding: EdgeInsets.all(_activeIndex == 0 ? 6 : 2),
            decoration: BoxDecoration(
              color: _activeIndex > 0 ? AppColors.primary : AppColors.green,
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: activeIndex == 0
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.check_rounded,
                    color: AppColors.white,
                  ),
          ),
        ),
      ),
      StepperData(
        title: StepperText("Select Store & Distributor"),
        // subtitle: StepperText("Your order is being prepared"),
        iconWidget: GestureDetector(
          onTap: () => onChangePageIndex(1),
          child: Container(
            padding: EdgeInsets.all(activeIndex == 1 ? 6 : 2),
            decoration: BoxDecoration(
              color: activeIndex > 1
                  ? AppColors.primary
                  : activeIndex == 1
                      ? AppColors.green
                      : Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: activeIndex == 1
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : activeIndex > 1
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                      )
                    : Center(
                        child: Text(
                          '2',
                          style: GoogleFonts.ptSansCaption(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
          ),
        ),
      ),
      StepperData(
        title: StepperText("Dashboard"),
        iconWidget: GestureDetector(
          onTap: () => onChangePageIndex(2),
          child: Container(
            padding: EdgeInsets.all(activeIndex == 2 ? 6 : 2),
            decoration: BoxDecoration(
                color: activeIndex > 2
                    ? AppColors.primary
                    : activeIndex == 2
                        ? AppColors.green
                        : Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: activeIndex == 2
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  )
                : activeIndex > 2
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                      )
                    : Center(
                        child: Text(
                          '3',
                          style: GoogleFonts.ptSansCaption(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
          ),
        ),
      ),
    ];
    return GetBuilder<StoreSelectionController>(
      init: StoreSelectionController(storeRepo: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  margin: const EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  height: activeIndex == 0 ? 220 : 280,
                  //activeIndex == 1 ? 280 :220,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: AppColors.storeBgColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Image.asset("assets/png/Group 35.png",
                                  height: 31),
                            ),
                          ),
                          GetBuilder<HomeController>(
                            init: HomeController(homeRepo: Get.find()),
                            initState: (_) {},
                            builder: (ctlr) {
                              return IconButton(
                                onPressed: () => Get.bottomSheet(
                                  MenuBottomsheet(
                                      version: ctlr.appVersion,
                                      isBusiness: false),
                                  isScrollControlled: true,
                                ),
                                icon: const Icon(
                                  Icons.menu_rounded,
                                  color: AppColors.black,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Image.asset("assets/png/Rectangle 426.png"),
                      const SizedBox(height: 30),
                      AnotherStepper(
                        stepperList: stepperData,
                        stepperDirection: Axis.horizontal,
                        inverted: true,
                        iconWidth: 30,
                        iconHeight: 30,
                        activeIndex: activeIndex,
                        activeBarColor: AppColors.green,
                        barThickness: 5,
                      ),
                      const SizedBox(height: 20),
                      activeIndex == 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, bottom: 20),
                              child: Container(
                                height: 40,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: MyColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x66000000),
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            ctlr.setisSelectedManually = false;
                                            setState(() {});
                                          },
                                          child: Container(
                                              height: 40,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color:
                                                    ctlr.isSelectedManually ==
                                                            false
                                                        ? MyColors.primary
                                                        : MyColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Search Manually",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color:
                                                          ctlr.isSelectedManually ==
                                                                  false
                                                              ? MyColors
                                                                  .whiteColor
                                                              : MyColors
                                                                  .primary,
                                                      fontFamily: fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () async {
                                            ctlr.setisSelectedManually = true;

                                            // _alignPositionOnUpdate = AlignOnUpdate.always;
                                            // _alignPositionStreamController = StreamController<double?>();
                                            setState(() {});
                                          },
                                          child: Container(
                                              height: 40,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color:
                                                    ctlr.isSelectedManually ==
                                                            true
                                                        ? MyColors.primary
                                                        : MyColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Find on Map",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color:
                                                          ctlr.isSelectedManually ==
                                                                  true
                                                              ? MyColors
                                                                  .whiteColor
                                                              : MyColors
                                                                  .primary,
                                                      fontFamily: fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                Visibility(
                  visible: activeIndex != 1,
                  child: Image.asset(
                    PngFiles.mapView,
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                ),
                Visibility(
                  visible: activeIndex == 1 && !ctlr.isSelectedManually,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isDistributorLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                value: ctlr.selectedDistributor,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                hint: Text(
                                  'Distributor Name',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                items: ctlr.distributors.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (dis) =>
                                    ctlr.onChangeDistributor(dis),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isBranchLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                value: ctlr.selectedBranch,
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                hint: Text(
                                  'Branch Location',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                items: ctlr.branches.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) => ctlr.onChangeBranch(v!),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isChannelLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                value: ctlr.selectedChannel,
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                hint: Text(
                                  'Channel',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                items: ctlr.channels.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) => ctlr.onChannelChange(v!),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: ctlr.isStoreLoading
                            ? CustomShimmer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(12),
                              )
                            : DropdownButtonFormField<String>(
                                value: ctlr.selectedStore,
                                menuMaxHeight: 300,
                                dropdownColor: AppColors.primaryDark,
                                hint: Text(
                                  'Store',
                                  style: GoogleFonts.ptSans(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.white,
                                ),
                                items: ctlr.store.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: AppColors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (v) => ctlr.onStoreChange(v!),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ctlr.isSelectedManually == false
                    ? activeIndex != 2
                        ? GestureDetector(
                            onTap: () {
                              if (activeIndex >= 1) {
                                if (ctlr.selectedDistributor != null &&
                                    ctlr.selectedBranch != null &&
                                    ctlr.selectedChannel != null) {
                                  //store ctlr

                                  Get.offAll(
                                    StoreFingertipsScreen(
                                      selectedDistributor:
                                          ctlr.selectedDistributor ?? '',
                                      selectedChannel:
                                          ctlr.selectedChannel ?? '',
                                      selectedBranch: ctlr.selectedBranch ?? '',
                                      selectedStore: ctlr.selectedStore ?? '',
                                    ),
                                  );
                                } else {
                                  showCustomSnackBar(
                                      'Please Select the required fields.');
                                }
                              } else {
                                onChangePage();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.3),
                                    offset: const Offset(4, 4),
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(6),
                              child: ctlr.isLoading
                                  ? const SizedBox(
                                      height: 38,
                                      width: 38,
                                      child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: CustomLoader(),
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/png/Icon Artwork.png",
                                      fit: BoxFit.cover,
                                      height: 38,
                                      width: 38,
                                    ),
                            ),
                          )
                        : const SizedBox()
                    : Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.66,
                                  width: double.infinity,
                                  child: ctlr.markers.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                      : FlutterMap(
                                          // mapController: ,
                                          options: MapOptions(
                                            initialZoom: 15.0,
                                            initialCenter: LatLng(
                                                ctlr.lat ?? 26.8678668,
                                                ctlr.lang ?? 81.0073842),
                                            onTap: (_, __) =>
                                                _popupLayerController
                                                    .hideAllPopups(),
                                            onPositionChanged:
                                                (MapPosition position,
                                                    bool hasGesture) {
                                              if (hasGesture &&
                                                  _alignPositionOnUpdate !=
                                                      AlignOnUpdate.never) {
                                                setState(
                                                  () => _alignPositionOnUpdate =
                                                      AlignOnUpdate.never,
                                                );
                                              }
                                            },
                                          ),
                                          children: [
                                            TileLayer(
                                              urlTemplate:
                                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            ),
                                            CurrentLocationLayer(
                                              alignPositionStream:
                                                  _alignPositionStreamController
                                                      .stream,
                                              alignPositionOnUpdate:
                                                  _alignPositionOnUpdate,
                                              style: const LocationMarkerStyle(
                                                marker: DefaultLocationMarker(
                                                  child: Icon(
                                                    Icons.navigation,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                ),
                                                markerSize: Size(20, 20),
                                                // markerDirection: MarkerDirection.heading,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: FloatingActionButton(
                                                    backgroundColor:
                                                        Colors.black,
                                                    onPressed: () {
                                                      setState(
                                                        () =>
                                                            _alignPositionOnUpdate =
                                                                AlignOnUpdate
                                                                    .always,
                                                      );
                                                      _alignPositionStreamController
                                                          .add(18);
                                                    },
                                                    child: const Icon(
                                                      Icons.my_location,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            PopupMarkerLayer(
                                              options: PopupMarkerLayerOptions(
                                                popupController:
                                                    _popupLayerController,
                                                markers: ctlr.markers,
                                                popupDisplayOptions:
                                                    PopupDisplayOptions(builder:
                                                        (BuildContext context,
                                                            Marker marker) {
                                                  String storeName =
                                                      ctlr.findStoreName(
                                                          marker.point);
                                                  return ExamplePopup(
                                                    marker: marker,
                                                    storeName: storeName,
                                                  );
                                                }),
                                                selectedMarkerBuilder:
                                                    (context, marker) =>
                                                        const Icon(
                                                  Icons.location_on,
                                                  size: 40,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              Visibility(
                                  visible: visible,
                                  child: Container(
                                    height: 10,
                                    width: 200,
                                    color: Colors.grey,
                                  )),

                              // Positioned(
                              //   bottom: 10,
                              //   left: 10,
                              //   child: ValueListenableBuilder<bool>(
                              //     valueListenable: visibilityZoomNotifierActivation,
                              //     builder: (ctx, visibility, child) {
                              //       return Visibility(
                              //         visible: visibility,
                              //         child: child!,
                              //       );
                              //     },
                              //     child: ValueListenableBuilder<bool>(
                              //       valueListenable: zoomNotifierActivation,
                              //       builder: (ctx, isVisible, child) {
                              //         return AnimatedOpacity(
                              //           opacity: isVisible ? 1.0 : 0.0,
                              //           onEnd: () {
                              //             visibilityZoomNotifierActivation.value = isVisible;
                              //           },
                              //           duration: const Duration(milliseconds: 500),
                              //           child: child,
                              //         );
                              //       },
                              //       child: Column(
                              //         children: [
                              //           ElevatedButton(
                              //             child: const Icon(Icons.add),
                              //             onPressed: () async {
                              //               // controller.zoomIn();
                              //             },
                              //           ),
                              //           // SizedBox(
                              //           //   height: 5,
                              //           // ),
                              //           ElevatedButton(
                              //             child: const Icon(Icons.remove),
                              //             onPressed: () async {
                              //               // controller.zoomOut();
                              //             },
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MapDataModel {
  final String latitude;
  final String longitude;

  MapDataModel({required this.latitude, required this.longitude});

  factory MapDataModel.fromJson(Map<String, dynamic> json) {
    return MapDataModel(
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }
}
