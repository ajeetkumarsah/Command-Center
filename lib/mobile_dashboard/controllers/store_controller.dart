import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_repo.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_intro_model.dart';

class StoreController extends GetxController {
  final StoreRepo storeRepo;
  StoreController({required this.storeRepo});
  //
  bool _isLoading = false, _salesTableShowMore = false;
  bool get isLoading => _isLoading;
  bool get salesTableShowMore => _salesTableShowMore;

  //

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  //
  StoreIntroModel? _storeIntroModel;
  StoreIntroModel? get storeIntroModel => _storeIntroModel;

  @override
  void onInit() {
    super.onInit();
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
}
