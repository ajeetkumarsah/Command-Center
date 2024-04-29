import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_repo.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_home_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_intro_model.dart';

class StoreController extends GetxController {
  final StoreRepo storeRepo;
  StoreController({required this.storeRepo});
  //
  bool _isLoading = false,
      _salesTableShowMore = false,
      _dashboeardShowmore = false;
  bool get isLoading => _isLoading;
  bool get salesTableShowMore => _salesTableShowMore;
  bool get dashboeardShowmore => _dashboeardShowmore;

  //

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  //
  StoreIntroModel? _storeIntroModel;
  StoreIntroModel? get storeIntroModel => _storeIntroModel;

  //Store home page model
  StoreHomeModel? _storeHomeModel;
  StoreHomeModel? get storeHomeModel => _storeHomeModel;

  //Strings
  String? _selectedStore;
  String? get selectedStore => _selectedStore;

  @override
  void onInit() {
    super.onInit();
  }

  void onChangeStore(String store) {
    _selectedStore = store;
    update();
  }

  void onTabChange(int index) {
    debugPrint('===>Selecte Index=>$index');
    _selectedTab = index;
    update();
  }

  void onSalesTableShowMore() {
    _salesTableShowMore = !_salesTableShowMore;
    update();
  }

  void onDashboardTableShowMore() {
    _dashboeardShowmore = !_dashboeardShowmore;
    update();
  }

  String getYear() {
    return storeRepo.getYear();
  }

  String getMonth() {
    return storeRepo.getMonth();
  }

  String getStore() {
    return storeRepo.getStore();
  }

  String getFBTarget() {
    return storeRepo.getFBTarget();
  }

  String getFBAchieved() {
    return storeRepo.getFBAchieved();
  }

  Future<bool> saveStore(String store) async {
    return await storeRepo.saveStore(store);
  }

  Future<bool> saveFBTarget(String target) async {
    return await storeRepo.saveFBTarget(target);
  }

  Future<bool> saveFBAchieved(String achieved) async {
    return await storeRepo.saveFBAchieved(achieved);
  }

  // Future<ResponseModel> postStoreData() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _isLoading = true;
  //     update();
  //   });
  //   Response response = await storeRepo.postStoreData({
  //     "date": "Aug-$selectedYear",
  //     "distributor": selectedDistributor ?? '',
  //     "branch": selectedBranch ?? '',
  //     "store": selectedChannel ?? '',
  //   });
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     if (response.body["status"].toString().toLowerCase() == 'true') {
  //       final data = response.body["data"];
  //       if (data != null && data.isNotEmpty) {
  //         //
  //         _storeIntroModel = StoreIntroModel.fromJson(data);
  //         if (_storeIntroModel != null) {
  //           //
  //           saveStore(selectedChannel ?? '');
  //           saveFBTarget(_storeIntroModel?.fbTarget ?? '');
  //           saveFBAchieved(_storeIntroModel?.fbAchieved ?? '');
  //         }
  //       }
  //       responseModel = ResponseModel(true, 'Success');
  //     } else {
  //       // showCustomSnackBar(response.body["message"] ?? '');
  //       responseModel = ResponseModel(false, 'Something went wrong');
  //     }
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText ?? "");
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  Future<ResponseModel> getHomeData(
      {required String distributor,
      required String branch,
      required String channel,
      required String store}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;

      update();
    });
    Response response = await storeRepo.postStoreHomeData({
      "date": "Apr-2024",
      "distributor": distributor, // "A.M. AGENCIES",
      "branch": branch, //"Jammu",
      "channel": channel,
      "store": store, // "VERMA GEN STORE"
    });
    onChangeStore(store);

    debugPrint('===>Slected Store $store');
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          //
          _storeHomeModel = StoreHomeModel.fromJson(data);
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
