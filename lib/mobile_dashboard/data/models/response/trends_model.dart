import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';

class TrendsModel {
  final double? yMin;
  final double? yMax;
  final double? yRange;
  final double? yInterval;
  final double? yPerMin;
  final double? yPerMax;
  final double? yPerInterval;
  final List<TrendsDataModel>? data;
  final List<YAxisData>? yAxisData;
  final List<YAxisData>? yAxisDataPer;

  TrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.yPerMin,
    this.yPerMax,
    this.yPerInterval,
    this.data,
    this.yAxisData,
    this.yAxisDataPer,
  });

  factory TrendsModel.fromJson(Map<String, dynamic> json) => TrendsModel(
        yMin: json["yMin"]?.toDouble() ?? 0,
        yMax: json["yMax"]?.toDouble() ?? 1,
        yRange: json["yRange"]?.toDouble() ?? 1,
        yInterval: json["yInterval"]?.toDouble() ?? 1,
        yPerMin: json["yPerMin"]?.toDouble() ?? 0,
        yPerMax: json["yPerMax"]?.toDouble() ?? 1,
        yPerInterval: json["yPerInterval"]?.toDouble() ?? 1,
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data"]!.map((x) => YAxisData.fromJson(x))),
        yAxisDataPer: json["y_axis_data_per"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data_per"]!.map((x) => YAxisData.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<TrendsDataModel>.from(
                json["data"]!.map((x) => TrendsDataModel.fromJson(x))),
      );
}

class TrendsDataModel {
  final String? month;
  final String? cyRt;
  final String? pyRt;
  final String? iya;
  final String? productivityPer;
  final String? billingPer;
  final String? ccPer;
  final String? cyRtRv;
  final String? pyRtRv;
  final int? index;

  TrendsDataModel({
    this.month,
    this.cyRt,
    this.pyRt,
    this.iya,
    this.productivityPer,
    this.billingPer,
    this.ccPer,
    this.cyRtRv,
    this.pyRtRv,
    this.index,
  });

  factory TrendsDataModel.fromJson(Map<String, dynamic> json) =>
      TrendsDataModel(
        month: json["month"]?.toString(),
        cyRt: json["cy_rt"]?.toString(),
        pyRt: json["py_rt"]?.toString(),
        iya: json["IYA"]?.toString(),
        productivityPer: json["productivity_per"]?.toString(),
        billingPer: json["billing_per"]?.toString(),
        ccPer: json["cc_per"]?.toString(),
        cyRtRv: json["cy_rt_rv"]?.toString(),
        pyRtRv: json["py_rt_rv"]?.toString(),
        index: json["index"],
      );
}
