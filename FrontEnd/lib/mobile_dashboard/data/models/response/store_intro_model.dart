class StoreIntroModel {
  final String? fbAchieved;
  final String? fbTarget;
  final String? fb;

  StoreIntroModel({
    this.fbAchieved,
    this.fbTarget,
    this.fb,
  });

  factory StoreIntroModel.fromJson(Map<String, dynamic> json) =>
      StoreIntroModel(
        fbAchieved: json["fbAchieved"],
        fbTarget: json["fbTarget"],
        fb: json["FB %"],
      );

  Map<String, dynamic> toJson() => {
        "fbAchieved": fbAchieved,
        "fbTarget": fbTarget,
        "FB %": fb,
      };
}
