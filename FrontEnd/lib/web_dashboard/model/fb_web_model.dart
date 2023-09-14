class FBModel {
  FocusBrand? focusBrand;

  FBModel({this.focusBrand});

  FBModel.fromJson(Map<String, dynamic> json) {
    focusBrand = json['focusBrand'] != null
        ? new FocusBrand.fromJson(json['focusBrand'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.focusBrand != null) {
      data['focusBrand'] = this.focusBrand!.toJson();
    }
    return data;
  }
}

class FocusBrand {
  String? fbActual;
  String? fbTarget;
  String? fbIYA;
  String? filter;
  String? month;

  FocusBrand(
      {this.fbActual, this.fbTarget, this.fbIYA, this.filter, this.month});

  FocusBrand.fromJson(Map<String, dynamic> json) {
    fbActual = json['fbActual'];
    fbTarget = json['fbTarget'];
    fbIYA = json['fbIYA'];
    filter = json['filter'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fbActual'] = this.fbActual;
    data['fbTarget'] = this.fbTarget;
    data['fbIYA'] = this.fbIYA;
    data['filter'] = this.filter;
    data['month'] = this.month;
    return data;
  }
}
