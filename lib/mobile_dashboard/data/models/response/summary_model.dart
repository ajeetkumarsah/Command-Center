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
  final bool? dataFound;

  Billing({
    this.billingActual,
    this.billingIya,
    this.progressBarBillingIya,
    this.dataFound,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        billingActual: json["billingActual"],
        billingIya: json["billingIYA"],
        progressBarBillingIya: json["progressBarBillingIYA"],
        dataFound: json["dataFound"],
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
  final bool? dataFound;

  CallCompliance({
    this.ccCurrentMonth,
    this.progressBarCcCurrentMonth,
    this.ccPreviousMonth,
    this.progressBarCcPreviousMonth,
    this.dataFound,
  });

  factory CallCompliance.fromJson(Map<String, dynamic> json) => CallCompliance(
        ccCurrentMonth: json["ccCurrentMonth"],
        progressBarCcCurrentMonth: json["progressBarCcCurrentMonth"],
        ccPreviousMonth: json["ccPreviousMonth"],
        progressBarCcPreviousMonth: json["progressBarCcPreviousMonth"],
        dataFound: json["dataFound"],
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
  final bool? dataFound;

  final String? progressBarCcCurrentMonth;

  Coverage({
    this.cmCoverage,
    this.billing,
    this.progressBarBillingIya,
    this.ccCurrentMonth,
    this.dataFound,
    this.progressBarCcCurrentMonth,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        cmCoverage: json["cmCoverage"],
        billing: json["billing"],
        ccCurrentMonth: json["ccCurrentMonth"],
        progressBarCcCurrentMonth: json["progressBarCcCurrentMonth"],
        progressBarBillingIya: json["progressBarBillingIYA"],
        dataFound: json["dataFound"],
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
  final bool? dataFound;

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
    this.dataFound,
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
        dataFound: json["dataFound"],
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
  final bool? dataFound;

  FocusBrand({
    this.fbActual,
    this.fbOpportunity,
    this.fbAchievement,
    this.progressBarFbAchievement,
    this.dataFound,
  });

  factory FocusBrand.fromJson(Map<String, dynamic> json) => FocusBrand(
        fbActual: json["fbActual"].toString(),
        fbOpportunity: json["fbOpportunity"],
        fbAchievement: json["fbAchievement"],
        progressBarFbAchievement: json["progressBarFbAchievement"],
        dataFound: json["dataFound"],
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
  final bool? dataFound;

  Inventory({
    this.inventoryActual,
    this.inventoryIya,
    this.dataFound,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        inventoryActual: json["inventoryActual"],
        inventoryIya: json["inventoryIYA"],
        dataFound: json["dataFound"],
      );

  Map<String, dynamic> toJson() => {
        "inventoryActual": inventoryActual,
        "inventoryIYA": inventoryIya,
      };
}

// class MtdRetailing {
//   final String? cmIya;
//   final String? progressBarCmIya;
//   final String? fyIya;
//   final String? progressBarFyIya;
//   final String? cmSaliance;
//   final String? cmSellout;

//   MtdRetailing({
//     this.cmIya,
//     this.progressBarCmIya,
//     this.fyIya,
//     this.progressBarFyIya,
//     this.cmSaliance,
//     this.cmSellout,
//   });

//   factory MtdRetailing.fromJson(Map<String, dynamic> json) => MtdRetailing(
//         cmIya: json["cmIya"].toString(),
//         progressBarCmIya: json["progressBarCmIya"].toString(),
//         fyIya: json["fyIya"].toString(),
//         progressBarFyIya: json["progressBarFyIya"].toString(),
//         cmSaliance: json["cmSaliance"].toString(),
//         cmSellout: json["cmSellout"].toString(),
//       );

//   Map<String, dynamic> toJson() => {
//         "cmIya": cmIya,
//         "progressBarCmIya": progressBarCmIya,
//         "fyIya": fyIya,
//         "progressBarFyIya": progressBarFyIya,
//         "cmSaliance": cmSaliance,
//         "cmSellout": cmSellout,
//       };
// }

class Productivity {
  final String? productivityCurrentMonth;
  final String? progressBarProductivityCurrentMonth;
  final String? productivityPreviousMonth;
  final String? progressBarProductivityPreviousMonth;
  final bool? dataFound;

  Productivity({
    this.productivityCurrentMonth,
    this.progressBarProductivityCurrentMonth,
    this.productivityPreviousMonth,
    this.progressBarProductivityPreviousMonth,
    this.dataFound,
  });

  factory Productivity.fromJson(Map<String, dynamic> json) => Productivity(
        productivityCurrentMonth: json["productivityCurrentMonth"],
        progressBarProductivityCurrentMonth:
            json["progressBarProductivityCurrentMonth"],
        productivityPreviousMonth: json["productivityPreviousMonth"],
        progressBarProductivityPreviousMonth:
            json["progressBarProductivityPreviousMonth"],
        dataFound: json["dataFound"],
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
  final bool? dataFound;

  Shipment({
    this.shipmentActual,
    this.shipmentIya,
    this.dataFound,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        shipmentActual: json["shipmentActual"],
        shipmentIya: json["shipmentIYA"],
        dataFound: json["dataFound"],
      );

  Map<String, dynamic> toJson() => {
        "shipmentActual": shipmentActual,
        "shipmentIYA": shipmentIya,
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
  final List<Trend>? trends;

  final double? yMin;
  final double? yMax;
  final double? yInterval;
  final List<YAxisData>? yAxisData;
  final List<YAxisData>? yAxisDataPer;
  final bool? dataFound;
  final double? yPerMin;
  final double? yPerMax;
  final double? yPerInterval;

  final String? cyP3MIya;

  final String? progressBarP3MIya;

  final String? cmPySellout;

  Ind({
    this.cmIya,
    this.progressBarCmIya,
    this.fyIya,
    this.progressBarFyIya,
    this.cmSaliance,
    this.cmSellout,
    this.channel,
    this.trends,
    this.yMin,
    this.yMax,
    this.yInterval,
    this.yAxisData,
    this.dataFound,
    this.yAxisDataPer,
    this.yPerInterval,
    this.yPerMax,
    this.yPerMin,
    this.cmPySellout,
    this.cyP3MIya,
    this.progressBarP3MIya,
  });

  factory Ind.fromJson(Map<String, dynamic> json) => Ind(
        dataFound: json["dataFound"],
        cyP3MIya: json["cyP3MIya"] != null ? json["cyP3MIya"].toString() : '',
        progressBarP3MIya: json["progressBarP3MIya"],
        cmPySellout:
            json["cmPySellout"] != null ? json["cmPySellout"].toString() : '',
        cmIya: json["cmIya"] != null ? json["cmIya"].toString() : '',
        progressBarCmIya: json["progressBarCmIya"],
        fyIya: json["fyIya"] != null ? json["fyIya"].toString() : '',
        progressBarFyIya: json["progressBarFyIya"] != null
            ? json["progressBarFyIya"].toString()
            : '',
        cmSaliance:
            json["cmSaliance"] != null ? json["cmSaliance"].toString() : '',
        cmSellout: json["cmSellout"].toString(),
        channel: json["Channel"] == null
            ? []
            : List<List<String>>.from(json["Channel"]!
                .map((x) => List<String>.from(x.map((x) => x)))),
        trends: json["Trends"] == null
            ? []
            : List<Trend>.from(json["Trends"]!.map((x) => Trend.fromJson(x))),
        yMin: json["yMin"]?.toDouble() ?? 0.0,
        yMax: json["yMax"]?.toDouble() ?? 1,
        yInterval: json["yInterval"]?.toDouble() ?? 1,
        yPerMin: json["yPerMin"]?.toDouble() ?? 0,
        yPerMax: json["yPerMax"]?.toDouble() ?? 1,
        yPerInterval: json["yPerInterval"]?.toDouble() ?? 1,
        yAxisData: json["y_axis_data"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data"]!.map((x) => YAxisData.fromJson(x))),
        yAxisDataPer: json["y_axis_data_per"] == null
            ? []
            : List<YAxisData>.from(
                json["y_axis_data_per"]!.map((x) => YAxisData.fromJson(x))),
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
      };
}

class YAxisData {
  final double? yAbs;
  final String? yRv;

  YAxisData({
    this.yAbs,
    this.yRv,
  });

  factory YAxisData.fromJson(Map<String, dynamic> json) => YAxisData(
        yAbs: json["y_abs"]?.toDouble(),
        yRv: json["y_rv"],
      );

  Map<String, dynamic> toJson() => {
        "y_abs": yAbs,
        "y_rv": yRv,
      };
}

class Trend {
  final String? month;
  final String? cyRt;
  final String? cmIya;
  final String? pyRt;
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
    this.cmIya,
  });

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
        month: json["month"].toString(),
        cyRt: json["cy_rt"].toString(),
        pyRt: json["py_rt"].toString(),
        cmIya: json["cmIya"].toString(),
        iya: json["IYA"].toString(),
        cyRtRv: json["cy_rt_rv"].toString(),
        pyRtRv: json["py_rt_rv"].toString(),
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
