class StoreFBTrendsModel {
  final int? yMin;
  final int? yMax;
  final int? yRange;
  final double? yInterval;
  final List<YAxisDataModel>? yAxisData;
  final List<FBTrendsModel>? data;

  StoreFBTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.yAxisData,
    this.data,
  });

  factory StoreFBTrendsModel.fromJson(Map<String, dynamic> json) =>
      StoreFBTrendsModel(
        yMin: json["yMin"],
        yMax: json["yMax"],
        yRange: json["yRange"],
        yInterval: json["yInterval"]?.toDouble(),
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisDataModel>.from(
                json["y_axis_data"]!.map((x) => YAxisDataModel.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<FBTrendsModel>.from(
                json["data"]!.map((x) => FBTrendsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "yMin": yMin,
        "yMax": yMax,
        "yRange": yRange,
        "yInterval": yInterval,
        "y_axis_data": yAxisData == null
            ? []
            : List<dynamic>.from(yAxisData!.map((x) => x.toJson())),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FBTrendsModel {
  final String? monthYear;
  final String? fbPointsAchieved;
  final String? fbTarget;
  final int? index;

  FBTrendsModel({
    this.monthYear,
    this.fbPointsAchieved,
    this.fbTarget,
    this.index,
  });

  factory FBTrendsModel.fromJson(Map<String, dynamic> json) => FBTrendsModel(
        monthYear: json["MonthYear"],
        fbPointsAchieved: json["FB Points achieved"],
        fbTarget: json["FB Target"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "MonthYear": monthYear,
        "FB Points achieved": fbPointsAchieved,
        "FB Target": fbTarget,
        "index": index,
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
