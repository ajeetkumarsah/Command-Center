class StoreFBCategoryModel {
  final String? brandName;
  final String? fbPointsAchieved;
  final String? fbTarget;
  final bool? targetAchieved;

  StoreFBCategoryModel({
    this.brandName,
    this.fbPointsAchieved,
    this.fbTarget,
    this.targetAchieved,
  });

  factory StoreFBCategoryModel.fromJson(Map<String, dynamic> json) =>
      StoreFBCategoryModel(
        brandName: json["BrandName"],
        fbPointsAchieved: json["FB Points achieved"],
        fbTarget: json["FB Target"],
        targetAchieved: json["targetAchieved"],
      );

  Map<String, dynamic> toJson() => {
        "BrandName": brandName,
        "FB Points achieved": fbPointsAchieved,
        "FB Target": fbTarget,
        "targetAchieved": targetAchieved,
      };
}
