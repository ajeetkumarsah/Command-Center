import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';

class GPTrendsModel {
  final double? yMin;
  final double? yMax;
  final double? yRange;
  final double? yPerMin;
  final double? yPerMax;
  final double? yPerInterval;
  final double? yInterval;
  final List<GPTrendsDataModel>? data;
  final List<YAxisData>? yAxisData;
  final List<YAxisData>? yAxisDataPer;

  GPTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.data,
    this.yAxisData,
    this.yPerMin,
    this.yPerMax,
    this.yPerInterval,
    this.yAxisDataPer,
  });

  factory GPTrendsModel.fromJson(Map<String, dynamic> json) => GPTrendsModel(
        yMin: json["yMin"]?.toDouble(),
        yMax: json["yMax"]?.toDouble(),
        yRange: json["yRange"]?.toDouble(),
        yInterval: json["yInterval"]?.toDouble(),
        yPerMin: json["yPerMin"]?.toDouble() ?? 0,
        yPerMax: json["yPerMax"]?.toDouble() ?? 1,
        yPerInterval: json["yPerInterval"]?.toDouble() ?? 1,
        yAxisDataPer: json["y_axis_data_per"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data_per"]!.map((x) => YAxisData.fromJson(x))),
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data"]!.map((x) => YAxisData.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<GPTrendsDataModel>.from(
                json["data"]!.map((x) => GPTrendsDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "yMin": yMin,
        "yMax": yMax,
        "yRange": yRange,
        "yInterval": yInterval,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GPTrendsDataModel {
  final String? month;
  final String? cyGp;
  final String? pyGp;
  final String? gpIya;
  final String? cyGpRv;
  final String? pyGpRv;
  final int? index;

  GPTrendsDataModel({
    this.month,
    this.cyGp,
    this.pyGp,
    this.gpIya,
    this.cyGpRv,
    this.pyGpRv,
    this.index,
  });

  factory GPTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      GPTrendsDataModel(
        month: json["month"],
        cyGp: json["CY GP"]?.toString(),
        pyGp: json["PY GP"].toString(),
        gpIya: json["IYA"],
        cyGpRv: json["CY GP RV"].toString(),
        pyGpRv: json["PY GP RV"].toString(),
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "CY GP": cyGp,
        "PY GP": pyGp,
        "GP IYA": gpIya,
      };
}
