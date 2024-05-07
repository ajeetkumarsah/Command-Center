class StoreHomeModel {
  final StoreMtdRetailing? mtdRetailing;
  final StoreDgpCompliance? dgpCompliance;
  final StoreFocusBrand? focusBrand;
  final StoreCoverage? coverage;

  StoreHomeModel({
    this.mtdRetailing,
    this.dgpCompliance,
    this.focusBrand,
    this.coverage,
  });

  factory StoreHomeModel.fromJson(Map<String, dynamic> json) => StoreHomeModel(
        mtdRetailing: json["mtdRetailing"] == null
            ? null
            : StoreMtdRetailing.fromJson(json["mtdRetailing"]),
        dgpCompliance: json["dgpCompliance"] == null
            ? null
            : StoreDgpCompliance.fromJson(json["dgpCompliance"]),
        focusBrand: json["focusBrand"] == null
            ? null
            : StoreFocusBrand.fromJson(json["focusBrand"]),
        coverage: json["coverage"] == null
            ? null
            : StoreCoverage.fromJson(json["coverage"]),
      );

  Map<String, dynamic> toJson() => {
        "mtdRetailing": mtdRetailing?.toJson(),
        "dgpCompliance": dgpCompliance?.toJson(),
        "focusBrand": focusBrand?.toJson(),
        "coverage": coverage?.toJson(),
      };
}

class StoreCoverage {
  final String? billing;
  final String? coverage;
  final String? targetCalls;
  final String? productivity;
  final String? callCompliance;

  final String? billingPer;

  final String? coveragePer;

  final String? targetCallsPer;

  final String? productivityPer;

  final String? callCompliancePer;

  StoreCoverage({
    this.billing,
    this.billingPer,
    this.coverage,
    this.coveragePer,
    this.targetCalls,
    this.targetCallsPer,
    this.productivity,
    this.productivityPer,
    this.callCompliance,
    this.callCompliancePer,
  });

  factory StoreCoverage.fromJson(Map<String, dynamic> json) => StoreCoverage(
        billing: json["billing"],
        billingPer: json["billing_per"],
        coverage: json["coverage"],
        coveragePer: json["coverage_per"],
        targetCalls: json["targetCalls"],
        targetCallsPer: json["targetCalls_per"],
        productivity: json["productivity"],
        productivityPer: json["productivity_per"],
        callCompliance: json["callCompliance"],
        callCompliancePer: json["callCompliance_per"],
      );

  Map<String, dynamic> toJson() => {
        "billing": billing,
        "billing_per": billingPer,
        "coverage": coverage,
        "coverage_per": coveragePer,
        "targetCalls": targetCalls,
        "targetCalls_per": targetCallsPer,
        "productivity": productivity,
        "productivity_per": productivityPer,
        "callCompliance": callCompliance,
        "callCompliance_per": callCompliancePer,
      };
}

class StoreDgpCompliance {
  final String? gpTarget;
  final String? gpTargetPer;
  final String? gpP1M;
  final String? gpP1MPer;
  final String? gpP3M;
  final String? gpP3MPer;
  StoreDgpCompliance({
    this.gpTarget,
    this.gpTargetPer,
    this.gpP1M,
    this.gpP1MPer,
    this.gpP3M,
    this.gpP3MPer,
  });

  factory StoreDgpCompliance.fromJson(Map<String, dynamic> json) =>
      StoreDgpCompliance(
        gpTarget: json["gpTarget"],
        gpTargetPer: json["gpTarget_per"],
        gpP1M: json["gpP1M"],
        gpP1MPer: json["gpP1M_per"],
        gpP3M: json["gpP3M"],
        gpP3MPer: json["gpP3M_per"],
      );

  Map<String, dynamic> toJson() => {
        "gpTarget": gpTarget,
        "gpTarget_per": gpTargetPer,
        "gpP1M": gpP1M,
        "gpP1M_per": gpP1MPer,
        "gpP3M": gpP3M,
        "gpP3M_per": gpP3MPer,
      };
}

class StoreFocusBrand {
  final String? fbAchieved;
  final String? fbTarget;
  final String? fbPer;

  StoreFocusBrand({
    this.fbAchieved,
    this.fbTarget,
    this.fbPer,
  });

  factory StoreFocusBrand.fromJson(Map<String, dynamic> json) =>
      StoreFocusBrand(
        fbAchieved: json["fbAchieved"],
        fbTarget: json["fbTarget"],
        fbPer: json["fb_per"],
      );

  Map<String, dynamic> toJson() => {
        "fbAchieved": fbAchieved,
        "fbTarget": fbTarget,
        "fb_per": fbPer,
      };
}

class StoreMtdRetailing {
  final String? retailing;
  final String? retailingPer;
  final List<List<String>>? channel;

  StoreMtdRetailing({
    this.retailing,
    this.retailingPer,
    this.channel,
  });

  factory StoreMtdRetailing.fromJson(Map<String, dynamic> json) =>
      StoreMtdRetailing(
        retailing: json["retailing"],
        retailingPer: json["retailing_per"],
        channel: json["Channel"] == null
            ? []
            : List<List<String>>.from(json["Channel"]!
                .map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "retailing": retailing,
        "retailing_per": retailingPer,
        "Channel": channel == null
            ? []
            : List<dynamic>.from(
                channel!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
