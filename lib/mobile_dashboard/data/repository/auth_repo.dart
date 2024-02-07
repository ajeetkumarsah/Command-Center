import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
// ignore_for_file: no_leading_underscores_for_local_identifiers


class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<String> saveDeviceToken() async {
    String _deviceToken = '';

    debugPrint('--------Device Token---------- $_deviceToken');
    return _deviceToken;
  }

  // bool isNotificationActive() {
  //   return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  // }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    // apiClient.updateHeader(token, null);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool> saveUserXToken(String xToken) async {
    String _token = '';
    if (xToken.isNotEmpty) {
      _token = xToken;
    } else {
      _token = sharedPreferences.getString(AppConstants.ACCESS_TOKEN) ?? '';
    }
    return await sharedPreferences.setString(AppConstants.ACCESS_TOKEN, _token);
  }

  Future<bool> updateToken(String token) async {
    apiClient.token = token;
    // apiClient.updateHeader(token, null);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool> savePurpose(String purpose) async {
    return await sharedPreferences.setString(
        AppConstants.USER_PURPOSE, purpose);
  }

  Future<bool> saveGeo(String geo, String geoValue) async {
    await sharedPreferences.setString(AppConstants.DEFAULT_GEO_VALUE, geoValue);
    return await sharedPreferences.setString(AppConstants.DEFAULT_GEO, geo);
  }

  //set user token :b
  Future<bool> saveUserId(String id) async {
    return await sharedPreferences.setString(AppConstants.USER_ID, id);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  String getPingCode() {
    return sharedPreferences.getString(AppConstants.PING_CODE) ?? "";
  }

  bool getSeen() {
    return sharedPreferences.getBool(AppConstants.SEEN) ?? false;
  }

  String getGeo() {
    return sharedPreferences.getString(AppConstants.DEFAULT_GEO) ?? '';
  }

  String getGeoValue() {
    return sharedPreferences.getString(AppConstants.DEFAULT_GEO_VALUE) ?? '';
  }

  String getAccessToken() {
    return sharedPreferences.getString(AppConstants.ACCESS_TOKEN) ?? "";
  }

  //get user token :b
  String getUserId() {
    return sharedPreferences.getString(AppConstants.USER_ID) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.ACCESS_TOKEN);
    sharedPreferences.clear();
    apiClient.token = null;
    return true;
  }

  String getImage() {
    return sharedPreferences.getString(AppConstants.USER_IMAGE) ?? "";
  }

  String getName() {
    return sharedPreferences.getString(AppConstants.USER_NAME) ?? "";
  }

////APIs calling
  // Future<Response> registration({required Map<String, dynamic> body}) async {
  //   return await apiClient.postData(AppConstants.REGISTER_URI, body);
  // }

  Future<Response> getFilters(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.FILTERS, body, headers: {});
  }
}
