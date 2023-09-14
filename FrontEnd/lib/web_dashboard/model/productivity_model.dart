class ProductivityModel {
  Productivity? productivity;

  ProductivityModel({this.productivity});

  ProductivityModel.fromJson(Map<String, dynamic> json) {
    productivity = json['productivity'] != null
        ? new Productivity.fromJson(json['productivity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productivity != null) {
      data['productivity'] = this.productivity!.toJson();
    }
    return data;
  }
}

class Productivity {
  int? productivePer;
  int? productiveTarget;
  String? filter;
  String? month;

  Productivity(
      {this.productivePer, this.productiveTarget, this.filter, this.month});

  Productivity.fromJson(Map<String, dynamic> json) {
    productivePer = json['Productive_Per'];
    productiveTarget = json['Productive_Target'];
    filter = json['filter'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Productive_Per'] = this.productivePer;
    data['Productive_Target'] = this.productiveTarget;
    data['filter'] = this.filter;
    data['month'] = this.month;
    return data;
  }
}
