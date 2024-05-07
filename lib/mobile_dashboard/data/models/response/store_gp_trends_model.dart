class StoreGPTrendsModel {
  final int? yMin;
  final int? yMax;
  final int? yRange;
  final int? yInterval;
  final List<YAxisDataModel> yAxisData;
  final List<GPTrendsDataModel> data;

  StoreGPTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    required this.yAxisData,
    required this.data,
  });

  factory StoreGPTrendsModel.fromJson(Map<String, dynamic> json) =>
      StoreGPTrendsModel(
        yMin: json["yMin"],
        yMax: json["yMax"],
        yRange: json["yRange"],
        yInterval: json["yInterval"],
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisDataModel>.from(
                json["y_axis_data"]!.map((x) => YAxisDataModel.fromJson(x))),
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
        "y_axis_data": List<dynamic>.from(yAxisData.map((x) => x.toJson())),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GPTrendsDataModel {
  final String? monthYear;
  final String? goldenPointsGapFilledP3M;
  final String? goldenPointsTarget;
  final int? index;
  final String? barPer;

  GPTrendsDataModel({
    this.monthYear,
    this.goldenPointsGapFilledP3M,
    this.goldenPointsTarget,
    this.index,
    this.barPer,
  });

  factory GPTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      GPTrendsDataModel(
        monthYear: json["MonthYear"],
        goldenPointsGapFilledP3M: json["Golden Points Gap Filled - P3M"],
        goldenPointsTarget: json["Golden Points Target"],
        index: json["index"],
        barPer: json["bar_per"],
      );

  Map<String, dynamic> toJson() => {
        "MonthYear": monthYear,
        "Golden Points Gap Filled - P3M": goldenPointsGapFilledP3M,
        "Golden Points Target": goldenPointsTarget,
        "index": index,
        "bar_per": barPer,
      };
}

class YAxisDataModel {
  final String? yAbs;

  YAxisDataModel({
    this.yAbs,
  });

  factory YAxisDataModel.fromJson(Map<String, dynamic> json) => YAxisDataModel(
        yAbs: json["y_abs"],
      );

  Map<String, dynamic> toJson() => {
        "y_abs": yAbs,
      };
}
