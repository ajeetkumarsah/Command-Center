class CBPModel {
  CBPData? cBPData;

  CBPModel({this.cBPData});

  CBPModel.fromJson(Map<String, dynamic> json) {
    cBPData = json['CBP_Data'] != null
        ? CBPData.fromJson(json['CBP_Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cBPData != null) {
      data['CBP_Data'] = cBPData!.toJson();
    }
    return data;
  }
}

class CBPData {
  int? billing;
  int? coverage;
  int? productiveCalls;
  int? billingAllIndia;
  int? coverageAllIndia;
  int? productiveCallsAllIndia;

  CBPData(
      {this.billing,
        this.coverage,
        this.productiveCalls,
        this.billingAllIndia,
        this.coverageAllIndia,
        this.productiveCallsAllIndia});

  CBPData.fromJson(Map<String, dynamic> json) {
    billing = json['Billing'];
    coverage = json['Coverage'];
    productiveCalls = json['Productive Calls'];
    billingAllIndia = json['BillingAllIndia'];
    coverageAllIndia = json['CoverageAllIndia'];
    productiveCallsAllIndia = json['ProductiveCallsAllIndia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Billing'] = billing;
    data['Coverage'] = coverage;
    data['Productive Calls'] = productiveCalls;
    data['BillingAllIndia'] = billingAllIndia;
    data['CoverageAllIndia'] = coverageAllIndia;
    data['ProductiveCallsAllIndia'] = productiveCallsAllIndia;
    return data;
  }
}
