import 'package:command_centre/mobile_dashboard/data/models/response/trends_model.dart';

class RetailingTrendsModel {
  final TrendsModel? ind;
  final TrendsModel? indDir;

  RetailingTrendsModel({
    this.ind,
    this.indDir,
  });

  factory RetailingTrendsModel.fromJson(Map<String, dynamic> json) =>
      RetailingTrendsModel(
        ind: json["ind"] == null ? null : TrendsModel.fromJson(json["ind"]),
        indDir: json["ind_dir"] == null || json["ind_dir"] is List
            ? null
            : TrendsModel.fromJson(json["ind_dir"]),
      );
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
  final String? progressBarCcCurrentMonth;

  Coverage({
    this.cmCoverage,
    this.billing,
    this.progressBarBillingIya,
    this.ccCurrentMonth,
    this.progressBarCcCurrentMonth,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        cmCoverage: json["cmCoverage"],
        billing: json["billing"],
        progressBarBillingIya: json["progressBarBillingIYA"],
        ccCurrentMonth: json["ccCurrentMonth"],
        progressBarCcCurrentMonth: json["progressBarCcCurrentMonth"],
      );

  Map<String, dynamic> toJson() => {
        "cmCoverage": cmCoverage,
        "billing": billing,
        "progressBarBillingIYA": progressBarBillingIya,
        "ccCurrentMonth": ccCurrentMonth,
        "progressBarCcCurrentMonth": progressBarCcCurrentMonth,
      };
}

class DgpCompliance {
  final String? gpAchievememt;
  final String? gpAbs;
  final String? gpP3MCy;
  final String? gpP3MPy;
  final String? gpIya;
  final String? progressBarGpIya;
  final String? progressBarGpAchieved;
  final String? gpP3Miya;
  final String? progressBarGpP3Miya;

  DgpCompliance({
    this.gpAchievememt,
    this.gpAbs,
    this.gpP3MCy,
    this.gpP3MPy,
    this.gpIya,
    this.progressBarGpIya,
    this.progressBarGpAchieved,
    this.gpP3Miya,
    this.progressBarGpP3Miya,
  });

  factory DgpCompliance.fromJson(Map<String, dynamic> json) => DgpCompliance(
        gpAchievememt: json["gpAchievememt"],
        gpAbs: json["gpAbs"],
        gpP3MCy: json["gp_P3M_CY"],
        gpP3MPy: json["gp_P3M_PY"],
        gpIya: json["gpIYA"],
        progressBarGpIya: json["progressBarGpIYA"],
        progressBarGpAchieved: json["progressBarGpAchieved"],
        gpP3Miya: json["gpP3MIYA"],
        progressBarGpP3Miya: json["progressBarGpP3MIYA"],
      );

  Map<String, dynamic> toJson() => {
        "gpAchievememt": gpAchievememt,
        "gpAbs": gpAbs,
        "gp_P3M_CY": gpP3MCy,
        "gp_P3M_PY": gpP3MPy,
        "gpIYA": gpIya,
        "progressBarGpIYA": progressBarGpIya,
        "progressBarGpAchieved": progressBarGpAchieved,
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
        fbActual: json["fbActual"],
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
  final Ind? ind;
  final Ind? indDir;

  MtdRetailing({
    this.ind,
    this.indDir,
  });

  factory MtdRetailing.fromJson(Map<String, dynamic> json) => MtdRetailing(
        ind: json["ind"] == null ? null : Ind.fromJson(json["ind"]),
        indDir: json["ind_dir"] == null ? null : Ind.fromJson(json["ind_dir"]),
      );

  Map<String, dynamic> toJson() => {
        "ind": ind?.toJson(),
        "ind_dir": indDir?.toJson(),
      };
}

class Ind {
  final String? cmIya;
  final String? progressBarCmIya;
  final String? fyIya;
  final String? progressBarFyIya;
  final String? cmSaliance;
  final String? cmSellout;
  final List<List<String>>? channel;
  final int? yMin;
  final double? yMax;
  final double? yInterval;
  final List<YAxisDatum>? yAxisData;
  final List<Trend>? trends;

  Ind({
    this.cmIya,
    this.progressBarCmIya,
    this.fyIya,
    this.progressBarFyIya,
    this.cmSaliance,
    this.cmSellout,
    this.channel,
    this.yMin,
    this.yMax,
    this.yInterval,
    this.yAxisData,
    this.trends,
  });

  factory Ind.fromJson(Map<String, dynamic> json) => Ind(
        cmIya: json["cmIya"],
        progressBarCmIya: json["progressBarCmIya"],
        fyIya: json["fyIya"],
        progressBarFyIya: json["progressBarFyIya"],
        cmSaliance: json["cmSaliance"],
        cmSellout: json["cmSellout"],
        channel: json["Channel"] == null
            ? []
            : List<List<String>>.from(json["Channel"]!
                .map((x) => List<String>.from(x.map((x) => x)))),
        yMin: json["yMin"],
        yMax: json["yMax"]?.toDouble(),
        yInterval: json["yInterval"]?.toDouble(),
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisDatum>.from(
                json["y_axis_data"]!.map((x) => YAxisDatum.fromJson(x))),
        trends: json["Trends"] == null
            ? []
            : List<Trend>.from(json["Trends"]!.map((x) => Trend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cmIya": cmIya,
        "progressBarCmIya": progressBarCmIya,
        "fyIya": fyIya,
        "progressBarFyIya": progressBarFyIya,
        "cmSaliance": cmSaliance,
        "cmSellout": cmSellout,
        "Channel": channel == null
            ? []
            : List<dynamic>.from(
                channel!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "yMin": yMin,
        "yMax": yMax,
        "yInterval": yInterval,
        "y_axis_data": yAxisData == null
            ? []
            : List<dynamic>.from(yAxisData!.map((x) => x.toJson())),
        "Trends": trends == null
            ? []
            : List<dynamic>.from(trends!.map((x) => x.toJson())),
      };
}

class Trend {
  final String? month;
  final double? cyRt;
  final int? pyRt;
  final String? iya;
  final String? cyRtRv;
  final String? pyRtRv;
  final int? index;

  Trend({
    this.month,
    this.cyRt,
    this.pyRt,
    this.iya,
    this.cyRtRv,
    this.pyRtRv,
    this.index,
  });

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
        month: json["month"],
        cyRt: json["cy_rt"]?.toDouble(),
        pyRt: json["py_rt"],
        iya: json["IYA"],
        cyRtRv: json["cy_rt_rv"],
        pyRtRv: json["py_rt_rv"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "cy_rt": cyRt,
        "py_rt": pyRt,
        "IYA": iya,
        "cy_rt_rv": cyRtRv,
        "py_rt_rv": pyRtRv,
        "index": index,
      };
}

class YAxisDatum {
  final double? yAbs;
  final String? yRv;

  YAxisDatum({
    this.yAbs,
    this.yRv,
  });

  factory YAxisDatum.fromJson(Map<String, dynamic> json) => YAxisDatum(
        yAbs: json["y_abs"]?.toDouble(),
        yRv: json["y_rv"],
      );

  Map<String, dynamic> toJson() => {
        "y_abs": yAbs,
        "y_rv": yRv,
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
