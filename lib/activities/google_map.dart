import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:flutter_map_marker_cluster_example/drawer.dart';
import 'package:latlong2/latlong.dart' ;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../mobile_dashboard/views/store_fingertips/onboarding_screen.dart';

class ClusteringPage extends StatefulWidget {
  static const String route = 'clusteringPage';

  const ClusteringPage({super.key});

  @override
  State<ClusteringPage> createState() => _ClusteringPageState();
}

class _ClusteringPageState extends State<ClusteringPage> {
  final PopupController _popupController = PopupController();

   List<Marker> markers = [];
  late int pointIndex;
  List<LatLng> points = [
    const LatLng(51.5, -0.09),
    const LatLng(49.8566, 3.3522),
  ];

  List<MapDataModel> locations = [];

  Future<void> mapStoreData() async {
    final response = await http.get(Uri.parse('https://run.mocky.io/v3/70163f07-d32f-4ac0-afce-82b7f28f0c12'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<Marker> newMarkers = [];
      for (var item in data) {
        final MapDataModel mapData = MapDataModel.fromJson(item);
        newMarkers.add(
          Marker(
            point: LatLng(mapData.latitude as double, mapData.longitude as double),
             child: Icon(Icons.location_on, color: Colors.red),
          ),
        );
      }
      setState(() {
        markers = newMarkers;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  void initState() {
    pointIndex = 0;

    super.initState();
    // mapStoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clustering Page'),
      ),
      body: PopupScope(
        popupController: _popupController,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: points[0],
            initialZoom: 5,
            maxZoom: 15,
            onTap: (_, __) => _popupController.hideAllPopups(),
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                spiderfyCircleRadius: 80,
                spiderfySpiralDistanceMultiplier: 2,
                circleSpiralSwitchover: 12,
                maxClusterRadius: 120,
                rotate: true,
                size: const Size(40, 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                maxZoom: 15,
                markers: markers,
                polygonOptions: const PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                popupOptions: PopupOptions(
                    popupSnap: PopupSnap.markerTop,
                    popupController: _popupController,
                    popupBuilder: (_, marker) => Container(
                      width: 200,
                      height: 100,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () => debugPrint('Popup tap!'),
                        child: const Text(
                          'Container popup for marker',
                        ),
                      ),
                    )),
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}