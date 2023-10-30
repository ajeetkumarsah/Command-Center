import 'dart:js_util';

import 'package:flutter/material.dart';

class TransportationProvider extends ChangeNotifier {
  String? _selectedGraph;
  String? _selectedFilterIndexName;
  String? selectedFilter;

  List<dynamic>? _catFilter = [];
  List<dynamic>? _sourceFilter = [];
  List<dynamic>? _destinationFilter = [];
  List<dynamic>? _vehicleFilter = [];
  List<dynamic>? _sbfFilter = [];
  String? _movementFilter = '';

  List<dynamic> _graphDataList = [] ;

  String? _filterDate = '';

  bool _load = false;
  bool _graphLoad = false;

  late bool _graphVisible = false;

  String? get selectedGraph => this._selectedGraph;
  String? get selectedFilterIndexName => this._selectedFilterIndexName;

  List<dynamic>? get catFilter => this._catFilter;
  List<dynamic>? get sourceFilter => this._sourceFilter;
  List<dynamic>? get destinationFilter => this._destinationFilter;
  List<dynamic>? get vehicleFilter => this._vehicleFilter;
  List<dynamic>? get sbfFilter => this._sbfFilter;
  String? get movementFilter => this._movementFilter;
  String? get filterDate => this._filterDate;

  List<dynamic>? get graphDataList => this._graphDataList;

  bool get graphVisible => this._graphVisible;
  bool get load => this._load;
  bool get graphLoad => this._graphLoad;

  void setSelectedGraph(value) {
    _selectedGraph = value;
    print(_selectedGraph);
    notifyListeners();
  }

  void setSelectedFilterIndexName(value) {
    _selectedFilterIndexName = value;
    print(_selectedFilterIndexName);
    notifyListeners();
  }

  void setGraphVisible(value) {
    _graphVisible = value;
    print(_graphVisible);
  notifyListeners();
  }

  void setCatFilter(value){
    _catFilter = value;
    notifyListeners();
  }

  void setSourceFilter(value){
    _sourceFilter = value;
    notifyListeners();
  }

  void setDestinationFilter(value){
    _destinationFilter = value;
    notifyListeners();
  }

  void setVehicleFilter(value){
    _vehicleFilter = value;
    notifyListeners();
  }

  void setSbfFilter(value){
    _sbfFilter = value;
    notifyListeners();
  }

  void setMovementFilter(value){
    if(value == "Both"){
      _movementFilter = '';
    }else{
      _movementFilter = value;
    }
    notifyListeners();
  }

   void setFilterDate(value){
    _filterDate = value;
    notifyListeners();
   }

   void setLoad(value){
    _load = value;
    notifyListeners();
   }

  void setGraphLoad(value){
    _graphLoad = value;
    notifyListeners();
  }

   void setGraphDataList(value){
    _graphDataList = value;
    notifyListeners();
   }

  void setDefault(){
    selectedFilter = '';
    _selectedGraph = '';
    _filterDate = '';
    _selectedFilterIndexName = '';
    _sbfFilter = [];
    _vehicleFilter = [];
    _destinationFilter = [];
    _sourceFilter = [];
    _catFilter = [];
    _graphVisible = false;
  }

}
