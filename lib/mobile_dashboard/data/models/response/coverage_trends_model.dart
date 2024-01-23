import 'package:command_centre/mobile_dashboard/data/models/response/fb_trends_model.dart';

class CoverageTrendsModel {
  final double? yMin;
  final double? yMax;
  final double? yRange;
  final double? yInterval;
  final List<CoverageTrendsDataModel>? data;
  final List<YAxisData>? yAxisData;
  final List<YAxisData>? yAxisDataPer;
  final double? yPerMin;
  final double? yPerMax;
  final double? yPerInterval;

  CoverageTrendsModel({
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

  factory CoverageTrendsModel.fromJson(Map<String, dynamic> json) =>
      CoverageTrendsModel(
        yMin: json["yMin"]?.toDouble() ?? 0,
        yMax: json["yMax"]?.toDouble() ?? 1,
        yRange: json["yRange"]?.toDouble() ?? 1,
        yInterval: json["yInterval"]?.toDouble() ?? 1,
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

// class CoverageTrendsDataModel {
//   final int? billedSum;
//   final int? coverageSum;
//   final int? proSum;
//   final int? targetSum;
//   final int? ccSum;
//   final int? ccTargetSum;
//   final String? calendarMonth;
//   final String? billingPer;
//   final String? productivityPer;
//   final String? ccPer;
//   final double? index;

//   CoverageTrendsDataModel({
//     this.billedSum,
//     this.coverageSum,
//     this.proSum,
//     this.targetSum,
//     this.ccSum,
//     this.ccTargetSum,
//     this.calendarMonth,
//     this.billingPer,
//     this.productivityPer,
//     this.ccPer,
//     this.index,
//   });

//   factory CoverageTrendsDataModel.fromJson(Map<String, dynamic> json) =>
//       CoverageTrendsDataModel(
//         billedSum: json["billed_sum"],
//         coverageSum: json["coverage_sum"],
//         proSum: json["pro_sum"],
//         targetSum: json["target_sum"],
//         ccSum: json["cc_sum"],
//         ccTargetSum: json["cc_target_sum"],
//         calendarMonth: json["Calendar Month"],
//         billingPer: json["billing_per"],
//         productivityPer: json["productivity_per"],
//         ccPer: json["cc_per"],
//         index: json["index"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "billed_sum": billedSum,
//         "coverage_sum": coverageSum,
//         "pro_sum": proSum,
//         "target_sum": targetSum,
//         "cc_sum": ccSum,
//         "cc_target_sum": ccTargetSum,
//         "Calendar Month": calendarMonth,
//         "billing_per": billingPer,
//         "productivity_per": productivityPer,
//         "cc_per": ccPer,
//       };
// }

class CoverageTrendsDataModel {
  final String? monthYear;
  final int? billingSumCycm;
  final int? coverageSumCycm;
  final int? proSumCycm;
  final int? targetSumCycm;
  final int? ccSumCycm;
  final int? ccTargetSumCycm;
  final int? billedSum;
  final String? billedSumRv;
  final int? coverageSum;
  final String? coverageSumRv;
  final int? proSum;
  final String? proSumRv;
  final int? targetSum;
  final String? targetSumRv;
  final int? ccSum;
  final String? ccSumRv;
  final int? ccTargetSum;
  final String? ccTargetSumRv;
  final String? billingPer;
  final String? productivityPer;
  final String? ccPer;
  final int? index;

  CoverageTrendsDataModel({
    this.monthYear,
    this.billingSumCycm,
    this.coverageSumCycm,
    this.proSumCycm,
    this.targetSumCycm,
    this.ccSumCycm,
    this.ccTargetSumCycm,
    this.billedSum,
    this.billedSumRv,
    this.coverageSum,
    this.coverageSumRv,
    this.proSum,
    this.proSumRv,
    this.targetSum,
    this.targetSumRv,
    this.ccSum,
    this.ccSumRv,
    this.ccTargetSum,
    this.ccTargetSumRv,
    this.billingPer,
    this.productivityPer,
    this.ccPer,
    this.index,
  });

  factory CoverageTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      CoverageTrendsDataModel(
        monthYear: json["MonthYear"],
        billingSumCycm: json["Billing_Sum_CYCM"],
        coverageSumCycm: json["Coverage_Sum_CYCM"],
        proSumCycm: json["Pro_Sum_CYCM"],
        targetSumCycm: json["Target_Sum_CYCM"],
        ccSumCycm: json["CC_Sum_CYCM"],
        ccTargetSumCycm: json["CC_Target_Sum_CYCM"],
        billedSum: json["billed_sum"],
        billedSumRv: json["billed_sum_rv"],
        coverageSum: json["coverage_sum"],
        coverageSumRv: json["coverage_sum_rv"],
        proSum: json["pro_sum"],
        proSumRv: json["pro_sum_rv"],
        targetSum: json["target_sum"],
        targetSumRv: json["target_sum_rv"],
        ccSum: json["cc_sum"],
        ccSumRv: json["cc_sum_rv"],
        ccTargetSum: json["cc_target_sum"],
        ccTargetSumRv: json["cc_target_sum_rv"],
        billingPer: json["billing_per"],
        productivityPer: json["productivity_per"],
        ccPer: json["cc_per"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "MonthYear": monthYear,
        "Billing_Sum_CYCM": billingSumCycm,
        "Coverage_Sum_CYCM": coverageSumCycm,
        "Pro_Sum_CYCM": proSumCycm,
        "Target_Sum_CYCM": targetSumCycm,
        "CC_Sum_CYCM": ccSumCycm,
        "CC_Target_Sum_CYCM": ccTargetSumCycm,
        "billed_sum": billedSum,
        "billed_sum_rv": billedSumRv,
        "coverage_sum": coverageSum,
        "coverage_sum_rv": coverageSumRv,
        "pro_sum": proSum,
        "pro_sum_rv": proSumRv,
        "target_sum": targetSum,
        "target_sum_rv": targetSumRv,
        "cc_sum": ccSum,
        "cc_sum_rv": ccSumRv,
        "cc_target_sum": ccTargetSum,
        "cc_target_sum_rv": ccTargetSumRv,
        "billing_per": billingPer,
        "productivity_per": productivityPer,
        "cc_per": ccPer,
        "index": index,
      };
}
