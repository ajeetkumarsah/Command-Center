import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
// ignore_for_file: no_leading_underscores_for_local_identifiers


class HomeRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  HomeRepo({required this.sharedPreferences, required this.apiClient});

  //get user token :b
  String getUserId() {
    return sharedPreferences.getString(AppConstants.USER_ID) ?? "";
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  String getAccessToken() {
    return sharedPreferences.getString(AppConstants.ACCESS_TOKEN) ?? "";
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.NAME) ?? "";
  }

  String getPersonalizedMoreMetrics() {
    return sharedPreferences.getString(AppConstants.PERSONLIZED_MORE) ?? "";
  }

  String getPersonalizedActiveMetrics() {
    return sharedPreferences.getString(AppConstants.PERSONLIZED_ACTIVE) ?? "";
  }

  Future<bool> savePersonalizedActiveMetrics(String active) async {
    return await sharedPreferences.setString(
        AppConstants.PERSONLIZED_ACTIVE, active);
  }

  Future<bool> savePersonalizedMoreMetrics(String more) async {
    return await sharedPreferences.setString(
        AppConstants.PERSONLIZED_MORE, more);
  }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    // apiClient.updateHeader(token, null);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool> saveUserSeen(bool hasSeen) async {
    return await sharedPreferences.setBool(AppConstants.SEEN, hasSeen);
  }

  Future<bool> saveYear(String year) async {
    return await sharedPreferences.setString(AppConstants.YEAR, year);
  }

  Future<bool> saveMonth(String month) async {
    return await sharedPreferences.setString(AppConstants.MONTH, month);
  }

  Future<bool> savePurpose(String purpose) async {
    return await sharedPreferences.setString(
        AppConstants.USER_PURPOSE, purpose);
  }

  Future<bool> saveGeo(String geo) async {
    return await sharedPreferences.setString(AppConstants.DEFAULT_GEO, geo);
  }

  Future<bool> saveGeoValue(String geoValue) async {
    return await sharedPreferences.setString(
        AppConstants.DEFAULT_GEO_VALUE, geoValue);
  }

  // for retailing
  Future<bool> setRetailing(bool retailing) async {
    return await sharedPreferences.setBool(AppConstants.RETAILING, retailing);
  }

  // for Coverage
  Future<bool> setCoverage(bool coverage) async {
    return await sharedPreferences.setBool(AppConstants.COVERAGE, coverage);
  }

  // for Golden Points
  Future<bool> setGoldenPoints(bool goldenPoints) async {
    return await sharedPreferences.setBool(
        AppConstants.GOLDEN_POINTS, goldenPoints);
  }

  // for Focus Brand
  Future<bool> setFocusBrand(bool focusBrand) async {
    return await sharedPreferences.setBool(
        AppConstants.FOCUS_BRAND, focusBrand);
  }

//get bools

  // for retailing
  Future<bool> getRetailing() async {
    return sharedPreferences.getBool(AppConstants.RETAILING) ?? true;
  }

  // for Coverage
  Future<bool> getCoverage() async {
    return sharedPreferences.getBool(AppConstants.COVERAGE) ?? true;
  }

  Future<bool> getGoldenPoints() async {
    return sharedPreferences.getBool(AppConstants.GOLDEN_POINTS) ?? true;
  }

  String getYear() {
    return sharedPreferences.getString(AppConstants.YEAR) ?? '';
  }

  String getMonth() {
    return sharedPreferences.getString(AppConstants.MONTH) ?? '';
  }

  String getGeo() {
    return sharedPreferences.getString(AppConstants.DEFAULT_GEO) ?? '';
  }

  bool getPersona() {
    return sharedPreferences.getBool(AppConstants.PERSONA) ?? false;
  }

  String getGeoValue() {
    return sharedPreferences.getString(AppConstants.DEFAULT_GEO_VALUE) ?? '';
  }

  bool getFocusBrand() {
    return sharedPreferences.getBool(AppConstants.FOCUS_BRAND) ?? true;
  }

  Future<bool> saveUserXToken(String accessToken) async {
    String _token = '';
    if (accessToken.isNotEmpty) {
      _token = accessToken;
    } else {
      _token = sharedPreferences.getString(AppConstants.ACCESS_TOKEN) ?? '';
    }
    return await sharedPreferences.setString(AppConstants.ACCESS_TOKEN, _token);
  }

//clearData
  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.clear();
    apiClient.token = null;
    return true;
  }
// API Calling

  Future<Response> getSummaryData(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.SUMMARY, body, headers: {});
  }

  Future<Response> getRetailingData(Map<String, dynamic> body) async {
    return await apiClient
        .postData(AppConstants.RETAILING_DATA, body, headers: {});
  }

  Future<Response> getCoverageData(Map<String, dynamic> body) async {
    return await apiClient
        .postData(AppConstants.COVERAGE_DATA, body, headers: {});
  }

  Future<Response> getGPData(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.GP_DATA, body, headers: {});
  }

  Future<Response> getFocusBrandData(Map<String, dynamic> body) async {
    return await apiClient
        .postData(AppConstants.FOCUS_BRAND_DATA, body, headers: {});
  }

  Future<Response> getFilters(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.FILTERS, body, headers: {});
  }

  Future<Response> getMonthFilter(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.FILTERS, body, headers: {});
  }

  Future<Response> getFeedback(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.CHANNELLIST, body, headers: {});
  }

  Future<Response> postBug(Map<String, String> body, List<MultipartBody> multipartBody) async {
    return await apiClient.postMultipartData(AppConstants.CHANNELLIST,  body, multipartBody,  headers: {});
  }
}
