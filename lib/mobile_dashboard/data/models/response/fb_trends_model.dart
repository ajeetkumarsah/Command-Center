class FBTrendsModel {
  final double? yMin;
  final double? yMax;
  final double? yRange;
  final double? yInterval;
  final List<FBTrendsDataModel>? data;
  final double? yPerMin;
  final double? yPerMax;
  final double? yPerInterval;
  final List<YAxisData>? yAxisDataPer;

  final List<YAxisData>? yAxisData;

  FBTrendsModel({
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

  factory FBTrendsModel.fromJson(Map<String, dynamic> json) => FBTrendsModel(
        yMin: json["yMin"].toDouble(),
        yMax: json["yMax"].toDouble(),
        yRange: json["yRange"].toDouble(),
        yInterval: json["yInterval"].toDouble(),
        yPerMin: json["yPerMin"]?.toDouble() ?? 0,
        yPerMax: json["yPerMax"]?.toDouble() ?? 1,
        yPerInterval: json["yPerInterval"]?.toDouble() ?? 1,
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data"]!.map((x) => YAxisData.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<FBTrendsDataModel>.from(
                json["data"]!.map((x) => FBTrendsDataModel.fromJson(x))),
        yAxisDataPer: json["y_axis_data_per"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data_per"]!.map((x) => YAxisData.fromJson(x))),
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

class FBTrendsDataModel {
  final String? fbAchieveSum;
  final String? fbTargetSum;
  final String? fbTargetBaseSum;
  final String? calendarMonth;
  final String? fb;

  final String? fbAchieveSumRv;
  final String? fbTargetSumRv;
  final String? fbTargetBaseSumRv;
  final double? index;

  final String? fbAchievedSum;

  FBTrendsDataModel({
    this.fbAchieveSum,
    this.fbTargetSum,
    this.fbTargetBaseSum,
    this.calendarMonth,
    this.fb,
    this.fbAchieveSumRv,
    this.fbTargetSumRv,
    this.fbTargetBaseSumRv,
    this.index,
    this.fbAchievedSum,
  });

  factory FBTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      FBTrendsDataModel(
        fbAchievedSum: json["fb_achieved_sum"].toString(),
        fbAchieveSum: json["fb_achieve_sum"],
        fbTargetSum: json["fb_target_sum"],
        fbTargetBaseSum: json["fb_target_base_sum"],
        calendarMonth: json["Calendar Month"],
        fb: json["FB %"].toString(),
        fbAchieveSumRv: json["fb_achieve_sum_rv"].toString(),
        fbTargetSumRv: json["fb_target_sum_rv"].toString(),
        fbTargetBaseSumRv: json["fb_target_base_sum_rv"].toString(),
        index: json["index"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "fb_achieve_sum": fbAchieveSum,
        "fb_target_sum": fbTargetSum,
        "fb_target_base_sum": fbTargetBaseSum,
        "Calendar Month": calendarMonth,
        "FB %": fb,
      };
}

class YAxisData {
  final double? yAbs;
  final String? yRv;

  YAxisData({
    this.yAbs,
    this.yRv,
  });

  factory YAxisData.fromJson(Map<String, dynamic> json) => YAxisData(
        yAbs: json["y_abs"]?.toDouble(),
        yRv: json["y_rv"],
      );

  Map<String, dynamic> toJson() => {
        "y_abs": yAbs,
        "y_rv": yRv,
      };
}
