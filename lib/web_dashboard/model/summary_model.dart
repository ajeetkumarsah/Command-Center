class SummaryModel {
  final String filterKey;
  final List<DataItem> data;

  SummaryModel({
    required this.filterKey,
    required this.data,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];
    final dataItems = dataList.map((item) => DataItem.fromJson(item)).toList();

    return SummaryModel(
      filterKey: json['filter_key'],
      data: dataItems,
    );
  }
}

class DataItem {
  final String? cmIya;
  final String? cmSellout;
  final String? filter;
  final String? month;
  final String? gpAbs;
  final String? gpIYA;
  final String? fbActual;
  final String? fbTarget;
  final String? fbIYA;
  final double? ccCurrentMonth;
  final String? ccCurrentMonthTarget;
  final double? ccPreviousMonth;
  final String? ccPreviousMonthTarget;
  final int? Billing_Per;
  final int? Coverage;
  final int? Productive_Per;
  final int? Productive_Target;

  DataItem({
    this.cmIya,
    this.cmSellout,
    this.filter,
    this.month,
    this.gpAbs,
    this.gpIYA,
    this.fbActual,
    this.fbTarget,
    this.fbIYA,
    this.ccCurrentMonth,
    this.ccCurrentMonthTarget,
    this.ccPreviousMonth,
    this.ccPreviousMonthTarget,
    this.Billing_Per,
    this.Coverage,
    this.Productive_Per,
    this.Productive_Target,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      cmIya: json['cmIya'],
      cmSellout: json['cmSellout'],
      filter: json['filter'],
      month: json['month'],
      gpAbs: json['gpAbs'],
      gpIYA: json['gpIYA'],
      fbActual: json['fbActual'],
      fbTarget: json['fbTarget'],
      fbIYA: json['fbIYA'],
      ccCurrentMonth: json['ccCurrentMonth']?.toDouble(),
      ccCurrentMonthTarget: json['ccCurrentMonthTarget'],
      ccPreviousMonth: json['ccPreviousMonth']?.toDouble(),
      ccPreviousMonthTarget: json['ccPreviousMonthTarget'],
      Billing_Per: json['Billing_Per'],
      Coverage: json['Coverage'],
      Productive_Per: json['Productive_Per'],
      Productive_Target: json['Productive_Target'],
    );
  }
}
