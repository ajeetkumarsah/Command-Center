import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_repo.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_intro_model.dart';

class StoreSelectionController extends GetxController {
  final StoreRepo storeRepo;
  StoreSelectionController({required this.storeRepo});
  //
  bool _isLoading = false,
      _isDistributorLoading = false,
      _isBranchLoading = false,
      _isChannelLoading = false;
  bool get isLoading => _isLoading;
  bool get isDistributorLoading => _isDistributorLoading;
  bool get isBranchLoading => _isBranchLoading;
  bool get isChannelLoading => _isChannelLoading;
  //

  String? _selectedBranch;
  String? get selectedBranch => _selectedBranch;
  String? _selectedDistributor;
  String? get selectedDistributor => _selectedDistributor;
  String? _selectedChannel;
  String? get selectedChannel => _selectedChannel;

  String? _selectedMonth = 'Dec';
  String? get selectedMonth => _selectedMonth;
  String? _selectedYear = '2023';
  String? get selectedYear => _selectedYear;

  List<String> distributors = [], branches = [], channels = [];

  //
  StoreIntroModel? _storeIntroModel;
  StoreIntroModel? get storeIntroModel => _storeIntroModel;

  @override
  void onInit() {
    super.onInit();
    initData();
    getAllFilters('');
    // getAllFilters('', type: 'branch');
  }

  void initData() {
    if (getMonth().trim().isNotEmpty) {
      _selectedMonth = getMonth();
    }
    if (getYear().trim().isNotEmpty) {
      _selectedYear = getYear();
    }
    update();
  }

  String getYear() {
    return storeRepo.getYear();
  }

  String getMonth() {
    return storeRepo.getMonth();
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

  Future<ResponseModel> getAllFilters(String query,
      {String type = 'distributor'}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (type.contains('distributor')) {
        _isDistributorLoading = true;
      } else if (type.contains('branch')) {
        _isBranchLoading = true;
      } else if (type.contains('store')) {
        _isChannelLoading = true;
      }
      update();
    });
    Response response = await storeRepo.getFilters({
      "storeFilter": {
        "name": query,
        "type": type,
        if (selectedDistributor != null &&
            selectedDistributor!.isNotEmpty &&
            type.contains('branch'))
          'distributor': selectedDistributor,
        if (selectedBranch != null && type.contains('store'))
          'branch': selectedBranch
      }
    });

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          if (type.contains('distributor')) {
            distributors = List<String>.from(data!.map((x) => x));
          } else if (type.contains('branch')) {
            branches = List<String>.from(data!.map((x) => x));
          } else if (type.contains('store')) {
            channels = List<String>.from(data!.map((x) => x));
          }
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    if (type.contains('distributor')) {
      _isDistributorLoading = false;
    } else if (type.contains('branch')) {
      _isBranchLoading = false;
    } else if (type.contains('store')) {
      _isChannelLoading = false;
    }
    update();
    return responseModel;
  }

  void onChangeBranch(String value) {
    _selectedBranch = value;
    getAllFilters('', type: 'store');
    update();
  }

  void onChangeDistributor(String? value) {
    _selectedDistributor = value;
    getAllFilters('', type: 'branch');
    update();
  }

  void onChannelChange(String? value) {
    _selectedChannel = value;

    update();
  }

  void clearChannel() {
    _selectedChannel = null;
    update();
  }

  Future<ResponseModel> postStoreData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;
      update();
    });
    Response response = await storeRepo.postStoreData({
      "date": "Aug-$selectedYear",
      "distributor": selectedDistributor ?? '',
      "branch": selectedBranch ?? '',
      "store": selectedChannel ?? '',
    });
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          //
          _storeIntroModel = StoreIntroModel.fromJson(data);
          if (_storeIntroModel != null) {
            //
            saveStore(selectedChannel ?? '');
            saveFBTarget(_storeIntroModel?.fbTarget ?? '');
            saveFBAchieved(_storeIntroModel?.fbAchieved ?? '');
          }
        }
        responseModel = ResponseModel(true, 'Success');
      } else {
        // showCustomSnackBar(response.body["message"] ?? '');
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
      responseModel = ResponseModel(false, response.statusText ?? "");
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
