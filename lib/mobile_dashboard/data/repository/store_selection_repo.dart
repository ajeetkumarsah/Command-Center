import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
// ignore_for_file: no_leading_underscores_for_local_identifiers

class StoreSelectionRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  StoreSelectionRepo(
      {required this.sharedPreferences, required this.apiClient});

  //set user token :b

  Future<Response> getFilters(Map<String, dynamic> body) async {
    return await apiClient
        .postData(AppConstants.CHANNELLIST, body, headers: {});
  }

  Future<Response> postStoreData(Map<String, dynamic> body) async {
    return await apiClient
        .postData(AppConstants.CHANNELLIST, body, headers: {});
  }

  Future<Response> postStoreHomeData(Map<String, dynamic> body) async {
    return await apiClient
        .postData(AppConstants.STORE_HOMEPAGE, body, headers: {});
  }
}
