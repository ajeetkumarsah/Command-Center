class CoverageModel {
  Coverage? coverage;

  CoverageModel({this.coverage});

  CoverageModel.fromJson(Map<String, dynamic> json) {
    coverage = json['coverage'] != null
        ? new Coverage.fromJson(json['coverage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coverage != null) {
      data['coverage'] = this.coverage!.toJson();
    }
    return data;
  }
}

class Coverage {
  int? billingPer;
  int? coverage;
  String? filter;
  String? month;

  Coverage({this.billingPer, this.coverage, this.filter, this.month});

  Coverage.fromJson(Map<String, dynamic> json) {
    billingPer = json['Billing_Per'];
    coverage = json['Coverage'];
    filter = json['filter'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Billing_Per'] = this.billingPer;
    data['Coverage'] = this.coverage;
    data['filter'] = this.filter;
    data['month'] = this.month;
    return data;
  }
}
