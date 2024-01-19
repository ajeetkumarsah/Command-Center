class FBTrendsModel {
  final double? yMin;
  final double? yMax;
  final double? yRange;
  final double? yInterval;
  final List<FBTrendsDataModel>? data;

  final List<YAxisData>? yAxisData;

  FBTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.data,
    this.yAxisData,
  });

  factory FBTrendsModel.fromJson(Map<String, dynamic> json) => FBTrendsModel(
        yMin: json["yMin"].toDouble(),
        yMax: json["yMax"].toDouble(),
        yRange: json["yRange"].toDouble(),
        yInterval: json["yInterval"].toDouble(),
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data"]!.map((x) => YAxisData.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<FBTrendsDataModel>.from(
                json["data"]!.map((x) => FBTrendsDataModel.fromJson(x))),
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
        fb: json["FB %"],
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
