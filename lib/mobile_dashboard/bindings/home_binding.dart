import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
import 'package:command_centre/mobile_dashboard/data/repository/auth_repo.dart';
import 'package:command_centre/mobile_dashboard/data/repository/home_repo.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_repo.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_gp_repo.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_fb_repo.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_gp_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_fb_controller.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_selection_repo.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_selection_controller.dart';

class HomeBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
//SharedPreferences
    Get.lazyPut(() => sharedPreferences);
//Api Client
    Get.lazyPut<ApiClient>(
        () => ApiClient(sharedPreferences: sharedPreferences));
//Repo
    Get.lazyPut<AuthRepo>(() =>
        AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.put<AuthRepo>(
        AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));

    Get.lazyPut<HomeRepo>(() =>
        HomeRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.put<HomeRepo>(
        HomeRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.lazyPut<StoreRepo>(
        () => StoreRepo(
            sharedPreferences: sharedPreferences, apiClient: Get.find()),
        fenix: true);
    Get.lazyPut<StoreFBRepo>(
        () => StoreFBRepo(
            sharedPreferences: sharedPreferences, apiClient: Get.find()),
        fenix: true);
    Get.lazyPut<StoreGPRepo>(
        () => StoreGPRepo(
            sharedPreferences: sharedPreferences, apiClient: Get.find()),
        fenix: true);
    Get.lazyPut<StoreSelectionRepo>(
        () => StoreSelectionRepo(
            sharedPreferences: sharedPreferences, apiClient: Get.find()),
        fenix: true);
//Controllers
    Get.lazyPut<HomeController>(() => HomeController(homeRepo: Get.find()));
    // Get.put<HomeController>(HomeController(homeRepo: Get.find()));
    Get.lazyPut<StoreSelectionController>(
        () => StoreSelectionController(storeRepo: Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(authRepo: Get.find()));
    Get.lazyPut<StoreController>(() => StoreController(storeRepo: Get.find()));
    Get.lazyPut<StoreFBController>(
        () => StoreFBController(storeFBRepo: Get.find()));
    Get.lazyPut<StoreGPController>(
        () => StoreGPController(storeGPRepo: Get.find()));
  }
}
