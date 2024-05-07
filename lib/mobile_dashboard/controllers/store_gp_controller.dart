import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_gp_repo.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_gp_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_fb_category_model.dart';

class StoreGPController extends GetxController {
  final StoreGPRepo storeGPRepo;
  StoreGPController({required this.storeGPRepo});
  //
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //
  StoreGPTrendsModel? _storeGPTrendsModel;
  StoreGPTrendsModel? get storeGPTrendsModel => _storeGPTrendsModel;

  //Strings
  String? _selectedStore;
  String? get selectedStore => _selectedStore;

  //List
  List<StoreFBCategoryModel> storeFBCategoryModel = [];

  @override
  void onInit() {
    super.onInit();
  }

  String getYear() {
    return storeGPRepo.getYear();
  }

  String getMonth() {
    return storeGPRepo.getMonth();
  }

  String getStore() {
    return storeGPRepo.getStore();
  }

  Future<bool> saveStore(String store) async {
    return await storeGPRepo.saveStore(store);
  }

  Future<ResponseModel> getGPData(
      {String type = 'category',
      required String distributor,
      required String branch,
      required String channel,
      required String store}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;
      update();
    });
    Response response = await storeGPRepo.postGPData({
      "type": type,
      "date": "Apr-2024",
      "distributor": "AMAZON DISTRIBUTORS Pvt.LTD.",
      "branch": "HUBLI",
      "store": "Viney Cosmatics"
    });

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          //
          if (type.toLowerCase().startsWith('category')) {
            //fb category data
            storeFBCategoryModel = List<StoreFBCategoryModel>.from(
                data.map((x) => StoreFBCategoryModel.fromJson(x)));
          } else if (type.toLowerCase().startsWith('trend')) {
            //fb trends data
            _storeGPTrendsModel = StoreGPTrendsModel.fromJson(data);
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
    _isLoading = false;
    update();
    return responseModel;
  }
}
