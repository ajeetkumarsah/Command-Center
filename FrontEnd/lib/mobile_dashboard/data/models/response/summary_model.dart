import 'dart:convert';

List<SummaryModel> summaryModelFromJson(String str) => List<SummaryModel>.from(
    json.decode(str).map((x) => SummaryModel.fromJson(x)));

String summaryModelToJson(List<SummaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SummaryModel {
  final MtdRetailing? mtdRetailing;
  final Coverage? coverage;
  final CallCompliance? callCompliance;
  final Productivity? productivity;
  final Billing? billing;
  final Shipment? shipment;
  final Inventory? inventory;
  final DgpCompliance? dgpCompliance;
  final FocusBrand? focusBrand;

  SummaryModel({
    this.mtdRetailing,
    this.coverage,
    this.callCompliance,
    this.productivity,
    this.billing,
    this.shipment,
    this.inventory,
    this.dgpCompliance,
    this.focusBrand,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
        mtdRetailing: json["mtdRetailing"] == null
            ? null
            : MtdRetailing.fromJson(json["mtdRetailing"]),
        coverage: json["coverage"] == null
            ? null
            : Coverage.fromJson(json["coverage"]),
        callCompliance: json["callCompliance"] == null
            ? null
            : CallCompliance.fromJson(json["callCompliance"]),
        productivity: json["productivity"] == null
            ? null
            : Productivity.fromJson(json["productivity"]),
        billing:
            json["billing"] == null ? null : Billing.fromJson(json["billing"]),
        shipment: json["shipment"] == null
            ? null
            : Shipment.fromJson(json["shipment"]),
        inventory: json["inventory"] == null
            ? null
            : Inventory.fromJson(json["inventory"]),
        dgpCompliance: json["dgpCompliance"] == null
            ? null
            : DgpCompliance.fromJson(json["dgpCompliance"]),
        focusBrand: json["focusBrand"] == null
            ? null
            : FocusBrand.fromJson(json["focusBrand"]),
      );

  Map<String, dynamic> toJson() => {
        "mtdRetailing": mtdRetailing?.toJson(),
        "coverage": coverage?.toJson(),
        "callCompliance": callCompliance?.toJson(),
        "productivity": productivity?.toJson(),
        "billing": billing?.toJson(),
        "shipment": shipment?.toJson(),
        "inventory": inventory?.toJson(),
        "dgpCompliance": dgpCompliance?.toJson(),
        "focusBrand": focusBrand?.toJson(),
      };
}

class Billing {
  final String? billingActual;
  final String? billingIya;
  final String? progressBarBillingIya;

  Billing({
    this.billingActual,
    this.billingIya,
    this.progressBarBillingIya,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        billingActual: json["billingActual"],
        billingIya: json["billingIYA"],
        progressBarBillingIya: json["progressBarBillingIYA"],
      );

  Map<String, dynamic> toJson() => {
        "billingActual": billingActual,
        "billingIYA": billingIya,
        "progressBarBillingIYA": progressBarBillingIya,
      };
}

class CallCompliance {
  final String? ccCurrentMonth;
  final String? progressBarCcCurrentMonth;
  final String? ccPreviousMonth;
  final String? progressBarCcPreviousMonth;

  CallCompliance({
    this.ccCurrentMonth,
    this.progressBarCcCurrentMonth,
    this.ccPreviousMonth,
    this.progressBarCcPreviousMonth,
  });

  factory CallCompliance.fromJson(Map<String, dynamic> json) => CallCompliance(
        ccCurrentMonth: json["ccCurrentMonth"],
        progressBarCcCurrentMonth: json["progressBarCcCurrentMonth"],
        ccPreviousMonth: json["ccPreviousMonth"],
        progressBarCcPreviousMonth: json["progressBarCcPreviousMonth"],
      );

  Map<String, dynamic> toJson() => {
        "ccCurrentMonth": ccCurrentMonth,
        "progressBarCcCurrentMonth": progressBarCcCurrentMonth,
        "ccPreviousMonth": ccPreviousMonth,
        "progressBarCcPreviousMonth": progressBarCcPreviousMonth,
      };
}

class Coverage {
  final String? cmCoverage;
  final String? billing;
  final String? progressBarBillingIya;
  final String? ccCurrentMonth;

  Coverage({
    this.cmCoverage,
    this.billing,
    this.progressBarBillingIya,
    this.ccCurrentMonth,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        cmCoverage: json["cmCoverage"],
        billing: json["billing"],
        ccCurrentMonth: json["ccCurrentMonth"],
        progressBarBillingIya: json["progressBarBillingIYA"],
      );

  Map<String, dynamic> toJson() => {
        "cmCoverage": cmCoverage,
        "billing": billing,
        "progressBarBillingIYA": progressBarBillingIya,
      };
}

class DgpCompliance {
  final String? gpAchievememt;
  final String? gpAbs;
  final String? gpP3MCy;
  final String? gpP3MPy;
  final String? gpIya;
  final String? progressBarGpIya;
  final String? gpP3Miya;
  final String? progressBarGpP3Miya;
  final String? progressBarGpAchieved;

  DgpCompliance({
    this.gpAchievememt,
    this.gpAbs,
    this.gpP3MCy,
    this.gpP3MPy,
    this.gpIya,
    this.progressBarGpIya,
    this.gpP3Miya,
    this.progressBarGpP3Miya,
    this.progressBarGpAchieved,
  });

  factory DgpCompliance.fromJson(Map<String, dynamic> json) => DgpCompliance(
        gpAchievememt: json["gpAchievememt"],
        gpAbs: json["gpAbs"],
        gpP3MCy: json["gp_P3M_CY"],
        gpP3MPy: json["gp_P3M_PY"],
        gpIya: json["gpIYA"],
        progressBarGpIya: json["progressBarGpIYA"],
        gpP3Miya: json["gpP3MIYA"],
        progressBarGpP3Miya: json["progressBarGpP3MIYA"],
        progressBarGpAchieved: json["progressBarGpAchieved"],
      );

  Map<String, dynamic> toJson() => {
        "gpAchievememt": gpAchievememt,
        "gpAbs": gpAbs,
        "gp_P3M_CY": gpP3MCy,
        "gp_P3M_PY": gpP3MPy,
        "gpIYA": gpIya,
        "progressBarGpIYA": progressBarGpIya,
        "gpP3MIYA": gpP3Miya,
        "progressBarGpP3MIYA": progressBarGpP3Miya,
      };
}

class FocusBrand {
  final String? fbActual;
  final int? fbOpportunity;
  final String? fbAchievement;
  final String? progressBarFbAchievement;

  FocusBrand({
    this.fbActual,
    this.fbOpportunity,
    this.fbAchievement,
    this.progressBarFbAchievement,
  });

  factory FocusBrand.fromJson(Map<String, dynamic> json) => FocusBrand(
        fbActual: json["fbActual"].toString(),
        fbOpportunity: json["fbOpportunity"],
        fbAchievement: json["fbAchievement"],
        progressBarFbAchievement: json["progressBarFbAchievement"],
      );

  Map<String, dynamic> toJson() => {
        "fbActual": fbActual,
        "fbOpportunity": fbOpportunity,
        "fbAchievement": fbAchievement,
        "progressBarFbAchievement": progressBarFbAchievement,
      };
}

class Inventory {
  final int? inventoryActual;
  final int? inventoryIya;

  Inventory({
    this.inventoryActual,
    this.inventoryIya,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        inventoryActual: json["inventoryActual"],
        inventoryIya: json["inventoryIYA"],
      );

  Map<String, dynamic> toJson() => {
        "inventoryActual": inventoryActual,
        "inventoryIYA": inventoryIya,
      };
}

class MtdRetailing {
  final String? cmIya;
  final String? progressBarCmIya;
  final String? fyIya;
  final String? progressBarFyIya;
  final String? cmSaliance;
  final String? cmSellout;

  MtdRetailing({
    this.cmIya,
    this.progressBarCmIya,
    this.fyIya,
    this.progressBarFyIya,
    this.cmSaliance,
    this.cmSellout,
  });

  factory MtdRetailing.fromJson(Map<String, dynamic> json) => MtdRetailing(
        cmIya: json["cmIya"].toString(),
        progressBarCmIya: json["progressBarCmIya"].toString(),
        fyIya: json["fyIya"].toString(),
        progressBarFyIya: json["progressBarFyIya"].toString(),
        cmSaliance: json["cmSaliance"].toString(),
        cmSellout: json["cmSellout"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "cmIya": cmIya,
        "progressBarCmIya": progressBarCmIya,
        "fyIya": fyIya,
        "progressBarFyIya": progressBarFyIya,
        "cmSaliance": cmSaliance,
        "cmSellout": cmSellout,
      };
}

class Productivity {
  final String? productivityCurrentMonth;
  final String? progressBarProductivityCurrentMonth;
  final String? productivityPreviousMonth;
  final String? progressBarProductivityPreviousMonth;

  Productivity({
    this.productivityCurrentMonth,
    this.progressBarProductivityCurrentMonth,
    this.productivityPreviousMonth,
    this.progressBarProductivityPreviousMonth,
  });

  factory Productivity.fromJson(Map<String, dynamic> json) => Productivity(
        productivityCurrentMonth: json["productivityCurrentMonth"],
        progressBarProductivityCurrentMonth:
            json["progressBarProductivityCurrentMonth"],
        productivityPreviousMonth: json["productivityPreviousMonth"],
        progressBarProductivityPreviousMonth:
            json["progressBarProductivityPreviousMonth"],
      );

  Map<String, dynamic> toJson() => {
        "productivityCurrentMonth": productivityCurrentMonth,
        "progressBarProductivityCurrentMonth":
            progressBarProductivityCurrentMonth,
        "productivityPreviousMonth": productivityPreviousMonth,
        "progressBarProductivityPreviousMonth":
            progressBarProductivityPreviousMonth,
      };
}

class Shipment {
  final int? shipmentActual;
  final int? shipmentIya;

  Shipment({
    this.shipmentActual,
    this.shipmentIya,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        shipmentActual: json["shipmentActual"],
        shipmentIya: json["shipmentIYA"],
      );

  Map<String, dynamic> toJson() => {
        "shipmentActual": shipmentActual,
        "shipmentIYA": shipmentIya,
      };
}
