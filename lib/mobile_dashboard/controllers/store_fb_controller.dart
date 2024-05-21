import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_fb_repo.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_fb_trends_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_fb_category_model.dart';

class StoreFBController extends GetxController {
  final StoreFBRepo storeFBRepo;
  StoreFBController({required this.storeFBRepo});
  //
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //
  StoreFBTrendsModel? _storeFBTrendsModel;
  StoreFBTrendsModel? get storeFBTrendsModel => _storeFBTrendsModel;

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
    return storeFBRepo.getYear();
  }

  String getMonth() {
    return storeFBRepo.getMonth();
  }

  String getStore() {
    return storeFBRepo.getStore();
  }

  Future<bool> saveStore(String store) async {
    return await storeFBRepo.saveStore(store);
  }

  String getFBTarget() {
    return storeFBRepo.getFBTarget();
  }

  String getFBAchieved() {
    return storeFBRepo.getFBAchieved();
  }

  Future<ResponseModel> getFBData(
      {String type = 'category',
      required String distributor,
      required String branch,
      required String channel,
      required String store}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = true;
      update();
    });

    Response response = await storeFBRepo.postFBData({
      "type": type,
      "date": "Apr-2024",
      "distributor": "AMAZON DISTRIBUTORS Pvt.LTD.",
      "branch": "HUBLI",
      "store": "Viney Cosmatics"
    });

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["status"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          //
          if (type.toLowerCase().startsWith('category')) {
            //fb category data
            debugPrint('===>FB category Data$data');
            storeFBCategoryModel = List<StoreFBCategoryModel>.from(
                data.map((x) => StoreFBCategoryModel.fromJson(x)));
          } else if (type.toLowerCase().startsWith('trend')) {
            //fb trends data
            debugPrint('===>FB Trends Data$data');
            _storeFBTrendsModel = StoreFBTrendsModel.fromJson(data);
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
