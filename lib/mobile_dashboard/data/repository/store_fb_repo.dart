import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
// ignore_for_file: no_leading_underscores_for_local_identifiers

class StoreFBRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  StoreFBRepo({required this.sharedPreferences, required this.apiClient});

  //set user token :b
  Future<bool> saveUserId(String id) async {
    return await sharedPreferences.setString(AppConstants.USER_ID, id);
  }

  Future<bool> saveStore(String id) async {
    return await sharedPreferences.setString(AppConstants.STORE, id);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  String getStore() {
    return sharedPreferences.getString(AppConstants.STORE) ?? "";
  }

  String getGeo() {
    return sharedPreferences.getString(AppConstants.DEFAULT_GEO) ?? '';
  }

  String getYear() {
    return sharedPreferences.getString(AppConstants.YEAR) ?? '';
  }

  String getMonth() {
    return sharedPreferences.getString(AppConstants.MONTH) ?? '';
  }

  String getGeoValue() {
    return sharedPreferences.getString(AppConstants.DEFAULT_GEO_VALUE) ?? '';
  }

  String getFBAchieved() {
    return sharedPreferences.getString(AppConstants.FB_ACHIEVED) ?? "";
  }

  String getFBTarget() {
    return sharedPreferences.getString(AppConstants.FB_TARGET) ?? "";
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.ACCESS_TOKEN);
    sharedPreferences.clear();
    apiClient.token = null;
    return true;
  }

////APIs calling

  Future<Response> postFBData(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.STORE_FB, body, headers: {});
  }
}
