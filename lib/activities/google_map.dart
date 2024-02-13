// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class Googlemap extends StatefulWidget {
//   const Googlemap({super.key});
//
//   @override
//   State<Googlemap> createState() => _GooglemapState();
// }
//
// class _GooglemapState extends State<Googlemap> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(19.1135806, 72.7762186);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: 300,
//           child: GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 11.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
