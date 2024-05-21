class StoreGPBaseModel {
  final DgpCompliance? dgpCompliance;

  StoreGPBaseModel({
    this.dgpCompliance,
  });

  factory StoreGPBaseModel.fromJson(Map<String, dynamic> json) =>
      StoreGPBaseModel(
        dgpCompliance: json["dgpCompliance"] == null
            ? null
            : DgpCompliance.fromJson(json["dgpCompliance"]),
      );

  Map<String, dynamic> toJson() => {
        "dgpCompliance": dgpCompliance?.toJson(),
      };
}

class DgpCompliance {
  final String? gpTarget;
  final String? gpP1M;
  final String? gpP3M;
  final String? gpP3MPer;

  DgpCompliance({
    this.gpTarget,
    this.gpP1M,
    this.gpP3M,
    this.gpP3MPer,
  });

  factory DgpCompliance.fromJson(Map<String, dynamic> json) => DgpCompliance(
        gpTarget: json["gpTarget"],
        gpP1M: json["gpP1M"],
        gpP3M: json["gpP3M"],
        gpP3MPer: json["gpP3M_per"],
      );

  Map<String, dynamic> toJson() => {
        "gpTarget": gpTarget,
        "gpP1M": gpP1M,
        "gpP3M": gpP3M,
        "gpP3M_per": gpP3MPer,
      };
}
