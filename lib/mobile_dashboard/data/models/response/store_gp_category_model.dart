class StoreGPCategoryModel {
  final String? categoryName;
  final int? goldenPointsSumCycm;
  final int? goldenPointsSumCyp3M;
  final int? goldenPointsTargetSumCycm;
  final int? goldenPointsSumPycm;
  final int? goldenPointsSumPyp3M;
  final int? goldenPointsTargetSumPycm;
  final bool? targetAchievedP1M;
  final String? gpP1M;
  final bool? targetAchievedP3M;
  final String? gpP3M;

  StoreGPCategoryModel({
    this.categoryName,
    this.goldenPointsSumCycm,
    this.goldenPointsSumCyp3M,
    this.goldenPointsTargetSumCycm,
    this.goldenPointsSumPycm,
    this.goldenPointsSumPyp3M,
    this.goldenPointsTargetSumPycm,
    this.targetAchievedP1M,
    this.gpP1M,
    this.targetAchievedP3M,
    this.gpP3M,
  });

  factory StoreGPCategoryModel.fromJson(Map<String, dynamic> json) =>
      StoreGPCategoryModel(
        categoryName: json["CategoryName"],
        goldenPointsSumCycm: json["Golden_Points_Sum_CYCM"],
        goldenPointsSumCyp3M: json["Golden_Points_Sum_CYP3M"],
        goldenPointsTargetSumCycm: json["Golden_Points_Target_Sum_CYCM"],
        goldenPointsSumPycm: json["Golden_Points_Sum_PYCM"],
        goldenPointsSumPyp3M: json["Golden_Points_Sum_PYP3M"],
        goldenPointsTargetSumPycm: json["Golden_Points_Target_Sum_PYCM"],
        targetAchievedP1M: json["targetAchievedP1M"],
        gpP1M: json["gp_p1m"],
        targetAchievedP3M: json["targetAchievedP3M"],
        gpP3M: json["gp_p3m"],
      );

  Map<String, dynamic> toJson() => {
        "CategoryName": categoryName,
        "Golden_Points_Sum_CYCM": goldenPointsSumCycm,
        "Golden_Points_Sum_CYP3M": goldenPointsSumCyp3M,
        "Golden_Points_Target_Sum_CYCM": goldenPointsTargetSumCycm,
        "Golden_Points_Sum_PYCM": goldenPointsSumPycm,
        "Golden_Points_Sum_PYP3M": goldenPointsSumPyp3M,
        "Golden_Points_Target_Sum_PYCM": goldenPointsTargetSumPycm,
        "targetAchievedP1M": targetAchievedP1M,
        "gp_p1m": gpP1M,
        "targetAchievedP3M": targetAchievedP3M,
        "gp_p3m": gpP3M,
      };
}
