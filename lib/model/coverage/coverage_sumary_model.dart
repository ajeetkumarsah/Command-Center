class CoverageSummary {
  Chennai? chennai;
  Chennai? dLNCR;
  Chennai? nE;

  CoverageSummary({this.chennai, this.dLNCR, this.nE});

  CoverageSummary.fromJson(Map<String, dynamic> json) {
    chennai =
    json['Chennai'] != null ? Chennai.fromJson(json['Chennai']) : null;
    dLNCR =
    json['DL.NCR'] != null ? Chennai.fromJson(json['DL.NCR']) : null;
    nE = json['N-E'] != null ? Chennai.fromJson(json['N-E']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chennai != null) {
      data['Chennai'] = chennai!.toJson();
    }
    if (dLNCR != null) {
      data['DL.NCR'] = dLNCR!.toJson();
    }
    if (nE != null) {
      data['N-E'] = nE!.toJson();
    }
    return data;
  }
}

class Chennai {
  int? billing;
  int? coverage;
  int? productiveCalls;

  Chennai({this.billing, this.coverage, this.productiveCalls});

  Chennai.fromJson(Map<String, dynamic> json) {
    billing = json['Billing'];
    coverage = json['Coverage'];
    productiveCalls = json['Productive Calls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Billing'] = billing;
    data['Coverage'] = coverage;
    data['Productive Calls'] = productiveCalls;
    return data;
  }
}
