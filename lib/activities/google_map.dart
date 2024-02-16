import 'dart:async';
import 'dart:math';

import 'package:command_centre/mobile_dashboard/bindings/home_binding.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeBinding().dependencies();
  runApp(GetMaterialApp(
    home: OldMainExample(),
    getPages: AppPages.routes,
    // debugShowCheckedModeBanner: false,
  ));
}

class OldMainExample extends StatefulWidget {
  OldMainExample({Key? key}) : super(key: key);

  @override
  _MainExampleState createState() => _MainExampleState();
}

class _MainExampleState extends State<OldMainExample>
    with TickerProviderStateMixin {
  late MapController controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Key mapGlobalkey = UniqueKey();
  ValueNotifier<GeoPoint?> centerMap = ValueNotifier(null);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> beginDrawRoad = ValueNotifier(false);
  List<GeoPoint> pointsRoad = [];
  Timer? timer;
  int x = 0;
  late AnimationController animationController;
  late Animation<double> animation =
      Tween<double>(begin: 0, end: 2 * pi).animate(animationController);
  final ValueNotifier<int> mapRotate = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    controller = MapController.withPosition(
      initPosition: GeoPoint(
        latitude: 47.4358055,
        longitude: 8.4737324,
      ),
    );
    // controller.addObserver(this as OSMMixinObserver);
    scaffoldKey = GlobalKey<ScaffoldState>();
    controller.listenerMapLongTapping.addListener(() async {
      if (controller.listenerMapLongTapping.value != null) {
        print(controller.listenerMapLongTapping.value);
        final randNum = Random.secure().nextInt(100).toString();
        print(randNum);
        await controller
            .changeLocation(controller.listenerMapLongTapping.value!);
      }
    });
    controller.listenerMapSingleTapping.addListener(() async {
      if (controller.listenerMapSingleTapping.value != null) {
        print(controller.listenerMapSingleTapping.value);
        if (beginDrawRoad.value) {
          pointsRoad.add(controller.listenerMapSingleTapping.value!);
          await controller.addMarker(
            controller.listenerMapSingleTapping.value!,
            markerIcon: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.amber,
                size: 48,
              ),
            ),
          );
          // if (pointsRoad.length >= 2 && showFab.value) {
          //   // roadActionBt(context);
          // }
        } else if (lastGeoPoint.value != null) {
          await controller.changeLocationMarker(
            oldLocation: lastGeoPoint.value!,
            newLocation: controller.listenerMapSingleTapping.value!,
          );
          lastGeoPoint.value = controller.listenerMapSingleTapping.value;
        } else {
          await controller.addMarker(
            controller.listenerMapSingleTapping.value!,
            markerIcon: const MarkerIcon(
              icon: Icon(
                Icons.person_pin,
                color: Colors.red,
                size: 48,
              ),
            ),
            iconAnchor: IconAnchor(
              anchor: Anchor.top,
            ),
          );
          lastGeoPoint.value = controller.listenerMapSingleTapping.value;
        }
      }
    });
    controller.listenerRegionIsChanging.addListener(() async {
      if (controller.listenerRegionIsChanging.value != null) {
        print(controller.listenerRegionIsChanging.value);
        centerMap.value = controller.listenerRegionIsChanging.value!.center;
      }
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('OSM'),
      ),
      body: Stack(
        children: [
          SizedBox(
            child: OSMFlutter(
              controller: controller,
              osmOption: OSMOption(
                enableRotationByGesture: true,
                zoomOption: const ZoomOption(
                  initZoom: 8,
                  minZoomLevel: 3,
                  maxZoomLevel: 15,
                  stepZoom: 1.0,
                ),
                // userLocationMarker: UserLocationMaker(
                //     personMarker: MarkerIcon(
                //       iconWidget: SizedBox(
                //         width: 32,
                //         height: 64,
                //         child: Image.asset(
                //           "asset/directionIcon.png",
                //           scale: .3,
                //         ),
                //       ),
                //     ),
                //     directionArrowMarker: MarkerIcon(
                //       iconWidget: SizedBox(
                //         width: 32,
                //         height: 64,
                //         child: Image.asset(
                //           "asset/directionIcon.png",
                //           scale: .3,
                //         ),
                //       ),
                //     )),
                staticPoints: [
                  StaticPositionGeoPoint(
                    "line 1",
                    const MarkerIcon(
                      icon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.green,
                        size: 32,
                      ),
                    ),
                    [
                      GeoPoint(
                        latitude: 47.4333594,
                        longitude: 8.4680184,
                      ),
                      GeoPoint(
                        latitude: 47.4317782,
                        longitude: 8.4716146,
                      ),
                    ],
                  ),
                ],
                roadConfiguration: const RoadOption(
                  roadColor: Colors.blueAccent,
                ),
                markerOption: MarkerOption(
                  defaultMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.home,
                      color: Colors.orange,
                      size: 32,
                    ),
                  ),
                  advancedPickerMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.location_searching,
                      color: Colors.green,
                      size: 56,
                    ),
                  ),
                ),
                showContributorBadgeForOSM: true,
                showDefaultInfoWindow: false,
              ),
              mapIsLoading: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Map is Loading.."),
                  ],
                ),
              ),
              onMapIsReady: (isReady) {
                if (isReady) {
                  print("map is ready");
                }
              },
              onLocationChanged: (myLocation) {
                print('user location :$myLocation');
              },
                onGeoPointClicked: (geoPoint) async {
                  // Get the context of the widget tree
                  final contextOverlay = context;

                  // Create an OverlayEntry
                  OverlayEntry overlayEntry;
                  overlayEntry = OverlayEntry(
                    builder: (context) {
                      // Calculate the position for your custom widget
                      final RenderBox renderBox = contextOverlay.findRenderObject() as RenderBox;
                      final markerOffset = renderBox.localToGlobal(Offset.zero);

                      // Calculate the position for your custom widget
                      final double top = markerOffset.dy - 100; // Adjust the vertical offset as needed
                      final double left = markerOffset.dx - 100; // Adjust the horizontal offset as needed

                      // Return your custom widget positioned on top of the marker
                      return Positioned(
                        top: top,
                        left: left,
                        child: Container(height: 40,width: 100,), // Replace YourCustomWidget with your widget
                      );
                    },
                  );

                  // Insert the overlay entry
                  Overlay.of(contextOverlay)!.insert(overlayEntry);

                  // Optionally, remove the overlay entry after a certain duration
                  Future.delayed(Duration(seconds: 5), () {
                    overlayEntry.remove();
                  });
                },

            ),
          ),
        ],
      ),
    );
  }
}
