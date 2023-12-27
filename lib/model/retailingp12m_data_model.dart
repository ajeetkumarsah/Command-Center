// To parse this JSON data, do
//
//     final retailingP12MModel = retailingP12MModelFromJson(jsonString);

import 'dart:convert';

RetailingP12MModel retailingP12MModelFromJson(String str) => RetailingP12MModel.fromJson(json.decode(str));

String retailingP12MModelToJson(RetailingP12MModel data) => json.encode(data.toJson());

class RetailingP12MModel {
  String monthYear;
  String distCode;
  String primaryBranchCode;
  String region;
  String stateName;
  String siteName;
  String channelName;
  String owningBrand;
  String brandName;
  String brandformName;
  String sbfName;
  String pcode;
  double retailing;

  RetailingP12MModel({
    required this.monthYear,
    required this.distCode,
    required this.primaryBranchCode,
    required this.region,
    required this.stateName,
    required this.siteName,
    required this.channelName,
    required this.owningBrand,
    required this.brandName,
    required this.brandformName,
    required this.sbfName,
    required this.pcode,
    required this.retailing,
  });

  factory RetailingP12MModel.fromJson(Map<String, dynamic> json) => RetailingP12MModel(
    monthYear: json["MonthYear"],
    distCode: json["DistCode"],
    primaryBranchCode: json["PrimaryBranchCode"],
    region: json["Region"],
    stateName: json["StateName"]?? '',
    siteName: json["SiteName"],
    channelName: json["channel_name"],
    owningBrand: json["owningBrand"],
    brandName: json["brand_name"],
    brandformName: json["brandform_name"],
    sbfName: json["sbf_name"],
    pcode: json["pcode"],
    retailing: json["Retailing"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "MonthYear": monthYear,
    "DistCode": distCode,
    "PrimaryBranchCode": primaryBranchCode,
    "Region": region,
    "StateName": stateName,
    "SiteName": siteName,
    "channel_name": channelName,
    "owningBrand": owningBrand,
    "brand_name": brandName,
    "brandform_name": brandformName,
    "sbf_name": sbfName,
    "pcode": pcode,
    "Retailing": retailing,
  };
}
