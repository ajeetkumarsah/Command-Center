import 'package:command_centre/mobile_dashboard/data/models/response/map_data_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/data/repository/store_repo.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/response_model.dart';
import 'package:command_centre/mobile_dashboard/data/models/response/store_intro_model.dart';
import 'package:latlong2/latlong.dart';

class StoreSelectionController extends GetxController {
  final StoreRepo storeRepo;
  StoreSelectionController({required this.storeRepo});
  //
  bool _isLoading = false,
      _isDistributorLoading = false,
      _isBranchLoading = false,
      _isChannelLoading = false,
      _isMapLoading = false,
      _isStoreLoading = false,
      setisSelectedManually = false;
     // _isSelectedManually = false;

  bool get isLoading => _isLoading;
  bool get isDistributorLoading => _isDistributorLoading;
  bool get isBranchLoading => _isBranchLoading;
  bool get isChannelLoading => _isChannelLoading;
  bool get isStoreLoading => _isStoreLoading;
  bool get isMapLoading => _isMapLoading;
  bool get isSelectedManually => setisSelectedManually;
  // bool get isSelectedManually => _isSelectedManually;
  //

  String? _selectedBranch;
  String? get selectedBranch => _selectedBranch;
  String? _selectedDistributor;
  String? get selectedDistributor => _selectedDistributor;
  String? _selectedChannel;
  String? get selectedChannel => _selectedChannel;
  String? _selectedStore;
  String? get selectedStore => _selectedStore;

  String? _selectedMonth = 'Dec';
  String? get selectedMonth => _selectedMonth;
  String? _selectedYear = '2023';
  String? get selectedYear => _selectedYear;
  String title = '';

  double? _lat;
  double? get lat => _lat;
  double? _lang;
  double? get lang => _lang;

  List<String> distributors = [], branches = [], channels = [], store = [];
  List<MapDataModel> locations = [];

  //
  List<StoreIntroModel> _storeIntroModel = [];
  List<StoreIntroModel> get storeIntroModel => _storeIntroModel;

  MapDataModel? _mapDataModel;
  MapDataModel? get mapDataModel => _mapDataModel;

  List<Marker> markers = [];
  late LatLng _center;
  late Position currentLocation;

  @override
  void onInit() {
    super.onInit();
    initData();

    getAllFilters('');
    mapStoreData();
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
      } else if (type.contains('channel')) {
        _isChannelLoading = true;
      }else if (type.contains('storeWithFilter')) {
        _isStoreLoading = true;
      }
      update();
    });
    Response response = await storeRepo.getFilters({
        "endPoint": type,
      if (selectedDistributor != null &&
          selectedDistributor!.isNotEmpty &&
          type.contains('branch'))
        "query": {
          "distributor": selectedDistributor
        },

      if (selectedBranch != null && type.contains('channel'))
        "query": {
          "distributor": selectedDistributor,
          "branch": selectedBranch
        },

      if (selectedChannel != null && type.contains('storeWithFilter'))
        "query": {
          "distributor": selectedDistributor,
          "branch": selectedBranch,
          "channel": selectedChannel,
        }


      // "storeFilter": {
      //   "name": query,
      //   "type": type,
      //   if (selectedDistributor != null &&
      //       selectedDistributor!.isNotEmpty &&
      //       type.contains('branch'))
      //     'distributor': selectedDistributor,
      //   if (selectedBranch != null && type.contains('storeWithFilter'))
      //     'branch': selectedBranch
      // }
    });

    ResponseModel responseModel;
    debugPrint('====> Channel List ');
    if (response.statusCode == 200) {

      if (response.body["successful"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          if (type.contains('distributor')) {
            distributors = List<String>.from(data!.map((x) => x));
          } else if (type.contains('branch')) {
            branches = List<String>.from(data!.map((x) => x));
          } else if (type.contains('channel')) {
            channels = List<String>.from(data!.map((x) => x.toString()));
          }else if (type.contains('storeWithFilter')) {
            store = List<String>.from(data!.map((x) => x['storeName'].toString()).toList());
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
    } else if (type.contains('channel')) {
      _isChannelLoading = false;
    }else if (type.contains('storeWithFilter')) {
      _isStoreLoading = false;
    }
    update();
    return responseModel;
  }

  void onChangeBranch(String value) {
    _selectedBranch = value;
    _selectedChannel = null;
    _selectedStore = null;
    getAllFilters('', type: 'channel');
    update();
  }

  void onChangeDistributor(String? value) {
    _selectedDistributor = value;
    _selectedBranch = null;
    _selectedChannel = null;
    _selectedStore = null;
    getAllFilters('', type: 'branch');
    update();
  }

  void onChannelChange(String? value) {
    _selectedChannel = value;
    _selectedStore = null;
    getAllFilters('', type: 'storeWithFilter');
    update();
  }

  void onStoreChange(String? value) {
    _selectedStore = value;
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
    Response response = await storeRepo.postStoreData(
        {
          "endPoint": "storeWithFilter",
          "query": {
            "distributor": selectedDistributor ?? '',
            "branch": selectedBranch ?? '',
            "channel": selectedChannel ?? ''
          }
        }
    //     {
    //   "date": "Aug-$selectedYear",
    //   "distributor": selectedDistributor ?? '',
    //   "branch": selectedBranch ?? '',
    //   "channel": selectedChannel ?? '',
    // }
    );
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          //
          _storeIntroModel = List<StoreIntroModel>.from(data!.map((x) => StoreIntroModel.fromJson(x)));
          // if (_storeIntroModel.isNotEmpty) {
          //   //
          //   // saveStore(selectedChannel ?? '');
          //   // saveFBTarget(_storeIntroModel?.Lat ?? '');
          //   // saveFBAchieved(_storeIntroModel?.Long ?? '');
          // }
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

  Future<ResponseModel> mapStoreData() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position.latitude.runtimeType);
    print(position.longitude.runtimeType);
    _lat = position.latitude;
    _lang = position.longitude;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isMapLoading = true;
      update();
    });

    Response response = await storeRepo.getFilters({
      "endPoint": "store",
      "query": {"lat": "${position.latitude}", "long": "${position.longitude}"}
    });

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (response.body["successful"].toString().toLowerCase() == 'true') {
        final data = response.body["data"];
        if (data != null && data.isNotEmpty) {
          locations.clear();
          for (var item in data) {
            locations.add(MapDataModel.fromJson(item));
          }
          debugPrint('=====> locations $locations');
          responseModel = ResponseModel(true, 'Success');
          await fetchStoreData(); // Call fetchStoreData here
        } else {
          responseModel = ResponseModel(false, 'No data found');
        }
      } else {
        responseModel = ResponseModel(false, 'Something went wrong');
      }
    } else if (response.statusCode == 401) {
      Get.offAndToNamed(AppPages.FED_AUTH_LOGIN_TEST);
      responseModel = ResponseModel(false, response.statusText ?? "");
    } else {
      responseModel = ResponseModel(false, response.statusText ?? "");
    }

    _isMapLoading = false;
    update();
    return responseModel;
  }

  Future<void> fetchStoreData() async {
    markers = locations.map((location) {
      return Marker(
        point: LatLng(double.parse(location.lat!), double.parse(location.long!)),
        width: 40,
        height: 40,
        alignment: Alignment.topCenter,
        child: const Icon(Icons.location_on, size: 40),
      );
    }).toList();
    // Update the UI using setState or similar method if needed
  }

  String findStoreName(LatLng position) {
    // Iterate through the store data to find the store name corresponding to the position
    for (var store in locations) {
      if (store.lat == position.latitude.toString() &&
          store.long == position.longitude.toString()) {
        return store.storeName!;
      }
    }
    return 'Store Name Not Found';
  }

}
