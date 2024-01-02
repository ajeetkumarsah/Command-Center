import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:command_centre/mobile_dashboard/data/api/api_client.dart';
import 'package:command_centre/mobile_dashboard/data/repository/auth_repo.dart';
import 'package:command_centre/mobile_dashboard/data/repository/home_repo.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_repo.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_controller.dart';
import 'package:command_centre/mobile_dashboard/controllers/store_selection_controller.dart';


class HomeBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    Get.lazyPut(() => sharedPreferences);
    //Api Client
    Get.lazyPut(() => ApiClient(sharedPreferences: sharedPreferences));
//Repo
    Get.lazyPut(() =>
        AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.lazyPut(() =>
        HomeRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.lazyPut(() =>
        StoreRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));

    Get.put(
        AuthRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.put(
        HomeRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
    Get.put(
        StoreRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));

    //
    Get.lazyPut<HomeController>(() => HomeController(homeRepo: Get.find()));
    Get.lazyPut<StoreSelectionController>(
        () => StoreSelectionController(storeRepo: Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(authRepo: Get.find()));
    Get.lazyPut<StoreController>(() => StoreController(storeRepo: Get.find()));
  }
}
