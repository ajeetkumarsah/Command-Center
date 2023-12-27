class TrendsModel {
  final int? yMin;
  final int? yMax;
  final int? yRange;
  final int? yInterval;
  final List<TrendsDataModel>? data;

  TrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.data,
  });

  factory TrendsModel.fromJson(Map<String, dynamic> json) => TrendsModel(
        yMin: json["yMin"],
        yMax: json["yMax"],
        yRange: json["yRange"],
        yInterval: json["yInterval"],
        data: json["data"] == null
            ? []
            : List<TrendsDataModel>.from(
                json["data"]!.map((x) => TrendsDataModel.fromJson(x))),
      );
}

class TrendsDataModel {
  final String? month;
  final String? cyRt;
  final String? pyRt;
  final String? iya;
  final String? productivityPer;
  final String? billingPer;
  final String? ccPer;
  final String? cyRtRv;
  final String? pyRtRv;
  final int? index;

  TrendsDataModel({
    this.month,
    this.cyRt,
    this.pyRt,
    this.iya,
    this.productivityPer,
    this.billingPer,
    this.ccPer,
    this.cyRtRv,
    this.pyRtRv,
    this.index,
  });

  factory TrendsDataModel.fromJson(Map<String, dynamic> json) =>
      TrendsDataModel(
        month: json["month"]?.toString(),
        cyRt: json["cy_rt"]?.toString(),
        pyRt: json["py_rt"]?.toString(),
        iya: json["IYA"]?.toString(),
        productivityPer: json["productivity_per"]?.toString(),
        billingPer: json["billing_per"]?.toString(),
        ccPer: json["cc_per"]?.toString(),
        cyRtRv: json["cy_rt_rv"]?.toString(),
        pyRtRv: json["py_rt_rv"]?.toString(),
        index: json["index"],
      );
}
