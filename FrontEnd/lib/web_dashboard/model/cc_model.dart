class CCModel {
  CallCompliance? callCompliance;

  CCModel({this.callCompliance});

  CCModel.fromJson(Map<String, dynamic> json) {
    callCompliance = json['callCompliance'] != null
        ? new CallCompliance.fromJson(json['callCompliance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.callCompliance != null) {
      data['callCompliance'] = this.callCompliance!.toJson();
    }
    return data;
  }
}

class CallCompliance {
  double? ccCurrentMonth;
  String? ccCurrentMonthTarget;
  double? ccPreviousMonth;
  String? ccPreviousMonthTarget;
  String? filter;
  String? month;

  CallCompliance(
      {this.ccCurrentMonth,
        this.ccCurrentMonthTarget,
        this.ccPreviousMonth,
        this.ccPreviousMonthTarget,
        this.filter,
        this.month});

  CallCompliance.fromJson(Map<String, dynamic> json) {
    ccCurrentMonth = json['ccCurrentMonth'];
    ccCurrentMonthTarget = json['ccCurrentMonthTarget'];
    ccPreviousMonth = json['ccPreviousMonth'];
    ccPreviousMonthTarget = json['ccPreviousMonthTarget'];
    filter = json['filter'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ccCurrentMonth'] = this.ccCurrentMonth;
    data['ccCurrentMonthTarget'] = this.ccCurrentMonthTarget;
    data['ccPreviousMonth'] = this.ccPreviousMonth;
    data['ccPreviousMonthTarget'] = this.ccPreviousMonthTarget;
    data['filter'] = this.filter;
    data['month'] = this.month;
    return data;
  }
}
