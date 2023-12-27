// import 'dart:convert';
//
// import 'package:command_centre/helper/app_urls.dart';
// import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
//
// class ApiSet{
//   Future<http.Response> postRequest(context, List<dynamic> date, List<dynamic> category, List<dynamic> subBrand, List<dynamic> destination,
//       List<dynamic> source, String movement, List<dynamic> vehicleType) async {
//     final provider = Provider.of<TransportationProvider>(context, listen: false);
//
//
//     // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
//     var url = '$BASE_URL/api/webData/transportation';
//     // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
//
//     var body = json.encode({
//       "date": date,
//       "category": category,
//       "subBrandForm": subBrand,
//       "destinationCity": destination,
//       "sourceCity": source,
//       "movement": movement,
//       "vehicleType": vehicleType,
//       "physicalYear": ""
//     });
//     print("Body Retailing Tab 1 $body");
//     var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
//     if (response.statusCode == 200) {
//       setState(() {
//         matrixCardDataList = jsonDecode(response.body);
//         provider.setMasterData(matrixCardDataList);
//         // print('data : $matrixCardDataList');
//       });
//     } else {
//       var snackBar = SnackBar(content: Text(response.body));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     return response;
//   }
//
//   Future<http.Response> categoryDropdownList(context) async {
//     final filterData = Provider.of<TransportationProvider>(context, listen: false);
//     // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
//     var url = '$BASE_URL/api/appData/supply/categoryFilter';
//     // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
//
//     var body = json.encode({
//       "destination": filterData.destinationFilter,
//       "category": [],
//       "subBrandForm": filterData.sbfFilter,
//       "sourceCity": filterData.sourceFilter,
//       "vehicleType": filterData.vehicleFilter,
//       "movement": ''
//     });
//     // print("Body Retailing Tab 1 $body");
//     var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
//     if (response.statusCode == 200) {
//       setState(() {
//         filterCategoryDataList = jsonDecode(response.body);
//         print('data : $filterCategoryDataList');
//       });
//     } else {
//       var snackBar = SnackBar(content: Text(response.body));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     return response;
//   }
//
//   Future<http.Response> destinationDropdownList(context) async {
//     final filterData = Provider.of<TransportationProvider>(context, listen: false);
//     // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
//     var url = '$BASE_URL/api/appData/supply/destinationFilter';
//     // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
//
//     var body = json.encode({
//       "destination": [],
//       "category": filterData.catFilter,
//       "subBrandForm": filterData.sbfFilter,
//       "sourceCity": filterData.sourceFilter,
//       "vehicleType": filterData.vehicleFilter,
//       "movement": ''
//     });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
//     if (response.statusCode == 200) {
//       setState(() {
//         filterDestinationDataList = jsonDecode(response.body);
//         print('data : $filterDestinationDataList');
//       });
//     } else {
//       var snackBar = SnackBar(content: Text(response.body));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     return response;
//   }
//
//   Future<http.Response> sourceDropdownList(context) async {
//     final filterData = Provider.of<TransportationProvider>(context, listen: false);
//
//     // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
//     var url = '$BASE_URL/api/appData/supply/sourceCityFilter';
//     // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
//
//     var body = json.encode({
//       "destination": filterData.destinationFilter,
//       "category": filterData.catFilter,
//       "subBrandForm": filterData.sbfFilter,
//       "sourceCity": [],
//       "vehicleType": filterData.vehicleFilter,
//       "movement": ''
//     });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
//     if (response.statusCode == 200) {
//       setState(() {
//         filterSourceList = jsonDecode(response.body);
//         print('data : $filterSourceList');
//       });
//     } else {
//       var snackBar = SnackBar(content: Text(response.body));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     return response;
//   }
//
//   Future<http.Response> sbfDropdownList(context) async {
//     final filterData = Provider.of<TransportationProvider>(context, listen: false);
//
//     // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
//     var url = '$BASE_URL/api/appData/supply/sbfFilter';
//     // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
//
//     var body = json.encode({
//       "destination": filterData.destinationFilter,
//       "category": filterData.catFilter,
//       "subBrandForm": [],
//       "sourceCity": filterData.sourceFilter,
//       "vehicleType": filterData.vehicleFilter,
//       "movement": ''
//     });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
//     if (response.statusCode == 200) {
//       setState(() {
//         filterSbfDataList = jsonDecode(response.body);
//         print('data : $filterSbfDataList');
//       });
//     } else {
//       var snackBar = SnackBar(content: Text(response.body));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     return response;
//   }
//
//   Future<http.Response> vehicleDropdownList(context) async {
//     final filterData = Provider.of<TransportationProvider>(context, listen: false);
//
//     // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
//     var url = '$BASE_URL/api/appData/supply/vehicleTypeFilter';
//     // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';
//
//     var body = json.encode({
//       "destination": filterData.destinationFilter,
//       "category": filterData.catFilter,
//       "subBrandForm": filterData.sbfFilter,
//       "sourceCity": filterData.sourceFilter,
//       "vehicleType": [],
//       "movement": ''
//     });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
//     if (response.statusCode == 200) {
//       setState(() {
//         filterVehicleDataList = jsonDecode(response.body);
//         print('data : $filterVehicleDataList');
//       });
//     } else {
//       var snackBar = SnackBar(content: Text(response.body));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//
//     return response;
//   }
// }