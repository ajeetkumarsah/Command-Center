// To parse this JSON data, do
//
//     final tableCoverageSummary = tableCoverageSummaryFromJson(jsonString);

import 'dart:convert';

List<TableCoverageSummary> tableCoverageSummaryFromJson(String str) => List<TableCoverageSummary>.from(json.decode(str).map((x) => TableCoverageSummary.fromJson(x)));

String tableCoverageSummaryToJson(List<TableCoverageSummary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableCoverageSummary {
  int billingPer;
  int coverage;
  String filter;
  String month;
  List<Site> sites;

  TableCoverageSummary({
    required this.billingPer,
    required this.coverage,
    required this.filter,
    required this.month,
    required this.sites,
  });

  factory TableCoverageSummary.fromJson(Map<String, dynamic> json) => TableCoverageSummary(
    billingPer: json["Billing_Per"],
    coverage: json["Coverage"],
    filter: json["filter"],
    month: json["month"],
    sites: List<Site>.from(json["sites"].map((x) => Site.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Billing_Per": billingPer,
    "Coverage": coverage,
    "filter": filter,
    "month": month,
    "sites": List<dynamic>.from(sites.map((x) => x.toJson())),
  };
}

class Site {
  String site;
  double billingPer;
  int coverage;
  List<Branch> branch;

  Site({
    required this.site,
    required this.billingPer,
    required this.coverage,
    required this.branch,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    site: json["Site"],
    billingPer: json["Billing_Per"]?.toDouble(),
    coverage: json["Coverage"],
    branch: List<Branch>.from(json["Branch"].map((x) => Branch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Site": site,
    "Billing_Per": billingPer,
    "Coverage": coverage,
    "Branch": List<dynamic>.from(branch.map((x) => x.toJson())),
  };
}

class Branch {
  String branch;
  double billingPer;
  int coverage;

  Branch({
    required this.branch,
    required this.billingPer,
    required this.coverage,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    branch: json["Branch"],
    billingPer: json["Billing_Per"]?.toDouble(),
    coverage: json["Coverage"],
  );

  Map<String, dynamic> toJson() => {
    "Branch": branch,
    "Billing_Per": billingPer,
    "Coverage": coverage,
  };
}
