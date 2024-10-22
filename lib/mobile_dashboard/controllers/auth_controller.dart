import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:command_centre/mobile_dashboard/utils/app_constants.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/utils/global.dart' as globals;
import 'package:command_centre/mobile_dashboard/data/repository/auth_repo.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/config_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/filters_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false, _isFilterLoading = false;

  bool get isLoading => _isLoading;
  bool get isFilterLoading => _isFilterLoading;
//Models
  FiltersModel? _filtersModel;
  FiltersModel? get filtersModel => _filtersModel;
  ConfigModel? _configModel;
  ConfigModel? get configModel => _configModel;

  //String
  String _selectedGeo = 'All India';
  String get selectedGeo => _selectedGeo;
  String _selectedGeoValue = 'All India';
  String get selectedGeoValue => _selectedGeoValue;

  @override
  void onInit() {
    super.onInit();
    getConfig();
  }

//
  // Future<ResponseModel> registration() async {
  //   _isLoading = true;
  //   update();
  //   await getLocation();
  //   _body.clear();
  //   _body = {

  //   };
  //   Response response = await authRepo.getData (body: _body);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     debugPrint('${response.bodyString}');
  //     if (response.body["success"].toString().toLowerCase() == 'true') {
  //       showCustomSnackBar(response.body["message"] ?? '', isError: false);
  //       responseModel = ResponseModel(true, response.body["message"]);
  //     } else {
  //       showCustomSnackBar(response.body["message"] ?? '');
  //       responseModel = ResponseModel(false, response.body["message"]);
  //     }
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText ?? "");
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  Future<void> updateToken(String token) async {
    await authRepo.updateToken(token);
  }

  Future<void> updateUserName(String name) async {
    await authRepo.saveUserName(name);
  }

  Future<void> updateUserEmail(String email) async {
    await authRepo.saveUserEmail(email);
  }

  Future<void> updateUID(String uid) async {
    await authRepo.saveUserUID(uid);
  }

  Future<void> saveToken(String token, String xToken) async {
    await authRepo.saveUserToken(token);
    await authRepo.saveUserAccessToken(xToken);
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  Future<String> getUserToken() async {
    return authRepo.getUserToken();
  }

  bool getDateFilterCheck() {
    return authRepo.getDateFilterCheck();
  }

  Future<String> getUserAccessToken() async {
    return authRepo.getUserAccessToken();
  }

  Future<String> getUserName() async {
    return authRepo.getUserName();
  }

  Future<String> getUserEmail() async {
    return authRepo.getUserEmail();
  }

  Future<String> getUID() async {
    return authRepo.getUID();
  }

  Future<String> getPingCode() async {
    return authRepo.getPingCode();
  }

  Future<bool> savePurpose(String purpose) async {
    return await authRepo.savePurpose(purpose);
  }

  Future<bool> saveGeo(String geo, String geoValue) async {
    return await authRepo.saveGeo(geo, geoValue);
  }

  Future<bool> getSeen() async {
    return authRepo.getSeen();
  }

  Future<String> getGeo() async {
    return authRepo.getGeo();
  }

  Future<String> getGeoValue() async {
    return authRepo.getGeoValue();
  }

  Future<String> getAccessToken() async {
    return authRepo.getAccessToken();
  }

  void onChangeGeo(String geo, String geoValue) {
    _selectedGeo = geo;
    _selectedGeoValue = geoValue;
    saveGeo(geo, geoValue);
    Get.put<HomeController>(HomeController(homeRepo: Get.find()))
        .onChangeGeo(geo, geoValue);
    update();
  }

  Future<ResponseModel> getAllFilters({String filter = '2023'}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    Response response = await authRepo.getFilters({"filter": filter});
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          _filtersModel = FiltersModel.fromJson(data[0]);
          if (_filtersModel != null) {
            _filtersModel?.district.removeWhere(
                (element) => element == 'Sri Lanka' || element == 'Nepal');
            _filtersModel?.site.removeWhere((element) =>
                element == 'Bhutan' ||
                element == 'Test Faridabad' ||
                element == 'TEST DEHRADUN' ||
                element == 'Test Bhopal' ||
                element == 'Sri Lanka' ||
                element == 'Nepal');
          }
          // List<String>.from(data[0]!.map((x) => x));
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      // logout();
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getConfig() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;
      update();
    });
    Response response =
        await authRepo.getConfig({"appVersion": true, "inventory": false});
    ResponseModel responseModel;
    debugPrint(' Config API response===> ${response.body}');
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null) {
          debugPrint('API response===> $data');
          _configModel = ConfigModel.fromJson(data);
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> postPersonaSelected() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFilterLoading = true;
      update();
    });
    var stopWatch = Stopwatch();
    stopWatch.reset();
    stopWatch.start();
    Logger().log(
        Level.debug, '===> Persona Start: ${stopWatch.elapsed.toString()}');
    SharedPreferences session = await SharedPreferences.getInstance();

    Map<String, dynamic> _body = {
      "endPoint": "appPersona",
      "query": {
        "uid": session.getString(AppConstants.UID),
        "token": globals.FCMToken,
        "persona": "Sales Team",
        "geo": "allIndia",
        "module": "Business Overview",
        "env": AppConstants.ENV
      }
    };
    debugPrint("=====> Persona Body :$_body");
    Response response = await authRepo.getPersonaSelect(_body);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        // final data = response.body["data"];
        // if (data != null) {
        //   monthFilters = List<String>.from(data!.map((x) => x));
        // }
        debugPrint('Persona ================= Success');
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        debugPrint('Persona ================= Something went wrong');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.statusText ?? "");
      if (globals.navigate) {
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    //Api Calling Response time
    Logger()
        .log(Level.debug, '===> Persona End : ${stopWatch.elapsed.toString()}');
    stopWatch.stop();
    stopWatch.reset();
    //
    _isFilterLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getUserProfile(String? code) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;
      update();
    });
    debugPrint(' User data API response===> ${AppConstants.FED_AUTH_TOKEN}');
    http.Response response;
    response = await http.post(
      Uri.parse(AppConstants.FED_AUTH_TOKEN),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'PF=gAvY5cL83UUST7sxealWO2',
      },
      body: {
        "code": code,
        'client_id': AppConstants.CLIENT_ID,
        'grant_type': 'authorization_code',
        'redirect_uri': AppConstants.REDIRECT_URI,
        'client_secret': AppConstants.CLIENT_SECRET,
        'scope': 'openid profile',
      },
    );

    ResponseModel responseModel;
    debugPrint(' User data API response===> ${response.body}');
    if (response.statusCode == 200) {
      FirebaseCrashlytics.instance.log("Login : Token Verified");
      FirebaseAnalytics.instance.logEvent(
          name: 'employee_auth',
          parameters: <String, dynamic>{'response': 200});
      debugPrint('===>User Profile data: ${response.body}');
      var resBody = json.decode(response.body);
      String? accessToken = resBody['access_token'] ?? '';
      // saveToken('', resBody['access_token'] ?? '');

      if (accessToken != null) {
        // showCustomSnackBar(accessToken);
        getEmployeeData(accessToken);
      } else {
        Get.offAndToNamed(AppPages.somethingWentWrong);
      }
      responseModel = ResponseModel(true, 'Success');
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.body);
      if (globals.navigate) {
        Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
        globals.navigate = false;
      }
    } else {
      responseModel = ResponseModel(false, response.body);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getEmployeeData(String accessToken) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;
      update();
    });
    debugPrint(
        ' Starting Employee Data===> url ${AppConstants.BASE_URL + AppConstants.EMPLOYEE_AUTH}');
    http.Response response;
    response = await http.post(
      Uri.parse(AppConstants.BASE_URL + AppConstants.EMPLOYEE_AUTH),
      headers: {
        'Accept': 'application/json',
        'X_AUTH_TOKEN': accessToken,
        'Authorization': 'Bearer $accessToken',
        'Ocp-Apim-Trace': true.toString(),
        'Ocp-Apim-Subscription-Key': AppConstants.SUBSCRIPTION_KEY,
        "grant_type": "refresh_token",
      },
      body: {'access_token': accessToken},
    );
    // Response response = await authRepo
    //     .getEmployeeAuth({'access_token': accessToken}, token: accessToken);
    ResponseModel responseModel;
    debugPrint(
        ' Employee data API response===>Status : ${response.statusCode} ${response.body}');
    if (response.statusCode == 200) {
      FirebaseCrashlytics.instance.log("Login : User Verified");
      var resBody = json.decode(response.body);
      saveToken(resBody['token'], accessToken);
      updateUserName(resBody['user']['first_name']);
      updateUserEmail(resBody['user']['email']);
      updateUID(resBody['user']['id']);
      globals.token = await getUserToken();
      globals.name = await getUserName();
      globals.email = await getUserEmail();
      globals.uId = await getUID();
      var geo = await getGeo();
      var geoValue = await getGeoValue();
      debugPrint('===>Before Token check');
      getAllFilters();
      if (geo.trim().isNotEmpty && geoValue.trim().isNotEmpty) {
        debugPrint('===>After Token check');
        Get.offAndToNamed(AppPages.INITIAL);
      } else {
        Get.offAndToNamed(AppPages.businessOnboarding);
      }
      responseModel = ResponseModel(false, 'Something went wrong');
    } else if (response.statusCode == 401) {
      responseModel = ResponseModel(false, response.body);
      Get.offAndToNamed(AppPages.somethingWentWrong);
    } else {
      responseModel = ResponseModel(false, response.body);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
