class FBTrendsModel {
  final int? yMin;
  final int? yMax;
  final int? yRange;
  final int? yInterval;
  final List<FBTrendsDataModel>? data;

  FBTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.data,
  });

  factory FBTrendsModel.fromJson(Map<String, dynamic> json) => FBTrendsModel(
        yMin: json["yMin"],
        yMax: json["yMax"],
        yRange: json["yRange"],
        yInterval: json["yInterval"],
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
  });

  factory FBTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      FBTrendsDataModel(
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
