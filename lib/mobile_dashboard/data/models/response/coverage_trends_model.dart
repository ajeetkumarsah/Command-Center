class CoverageTrendsModel {
  final int? yMin;
  final int? yMax;
  final int? yRange;
  final int? yInterval;
  final List<CoverageTrendsDataModel>? data;

  CoverageTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.data,
  });

  factory CoverageTrendsModel.fromJson(Map<String, dynamic> json) =>
      CoverageTrendsModel(
        yMin: json["yMin"],
        yMax: json["yMax"],
        yRange: json["yRange"],
        yInterval: json["yInterval"],
        data: json["data"] == null
            ? []
            : List<CoverageTrendsDataModel>.from(
                json["data"]!.map((x) => CoverageTrendsDataModel.fromJson(x))),
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

class CoverageTrendsDataModel {
  final int? billedSum;
  final int? coverageSum;
  final int? proSum;
  final int? targetSum;
  final int? ccSum;
  final int? ccTargetSum;
  final String? calendarMonth;
  final String? billingPer;
  final String? productivityPer;
  final String? ccPer;

  CoverageTrendsDataModel({
    this.billedSum,
    this.coverageSum,
    this.proSum,
    this.targetSum,
    this.ccSum,
    this.ccTargetSum,
    this.calendarMonth,
    this.billingPer,
    this.productivityPer,
    this.ccPer,
  });

  factory CoverageTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      CoverageTrendsDataModel(
        billedSum: json["billed_sum"],
        coverageSum: json["coverage_sum"],
        proSum: json["pro_sum"],
        targetSum: json["target_sum"],
        ccSum: json["cc_sum"],
        ccTargetSum: json["cc_target_sum"],
        calendarMonth: json["Calendar Month"],
        billingPer: json["billing_per"],
        productivityPer: json["productivity_per"],
        ccPer: json["cc_per"],
      );

  Map<String, dynamic> toJson() => {
        "billed_sum": billedSum,
        "coverage_sum": coverageSum,
        "pro_sum": proSum,
        "target_sum": targetSum,
        "cc_sum": ccSum,
        "cc_target_sum": ccTargetSum,
        "Calendar Month": calendarMonth,
        "billing_per": billingPer,
        "productivity_per": productivityPer,
        "cc_per": ccPer,
      };
}
