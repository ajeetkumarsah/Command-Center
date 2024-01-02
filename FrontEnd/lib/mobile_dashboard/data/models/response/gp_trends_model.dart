class GPTrendsModel {
  final int? yMin;
  final int? yMax;
  final int? yRange;
  final int? yInterval;
  final List<GPTrendsDataModel>? data;

  GPTrendsModel({
    this.yMin,
    this.yMax,
    this.yRange,
    this.yInterval,
    this.data,
  });

  factory GPTrendsModel.fromJson(Map<String, dynamic> json) => GPTrendsModel(
        yMin: json["yMin"],
        yMax: json["yMax"],
        yRange: json["yRange"],
        yInterval: json["yInterval"],
        data: json["data"] == null
            ? []
            : List<GPTrendsDataModel>.from(
                json["data"]!.map((x) => GPTrendsDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "yMin": yMin,
        "yMax": yMax,
        "yRange": yRange,
        "yInterval": yInterval,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GPTrendsDataModel {
  final String? month;
  final String? cyGp;
  final String? pyGp;
  final String? gpIya;
  final String? cyGpRv;
  final String? pyGpRv;
  final int? index;

  GPTrendsDataModel({
    this.month,
    this.cyGp,
    this.pyGp,
    this.gpIya,
    this.cyGpRv,
    this.pyGpRv,
    this.index,
  });

  factory GPTrendsDataModel.fromJson(Map<String, dynamic> json) =>
      GPTrendsDataModel(
        month: json["month"],
        cyGp: json["CY GP"]?.toString(),
        pyGp: json["PY GP"].toString(),
        gpIya: json["GP IYA"],
        cyGpRv: json["CY GP RV"].toString(),
        pyGpRv: json["PY GP RV"].toString(),
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "CY GP": cyGp,
        "PY GP": pyGp,
        "GP IYA": gpIya,
      };
}
