class RetailingModel {
  MtdRetailing? mtdRetailing;

  RetailingModel({this.mtdRetailing});

  RetailingModel.fromJson(Map<String, dynamic> json) {
    mtdRetailing = json['mtdRetailing'] != null
        ? MtdRetailing.fromJson(json['mtdRetailing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mtdRetailing != null) {
      data['mtdRetailing'] = mtdRetailing!.toJson();
    }
    return data;
  }
}

class MtdRetailing {
  String? cmIya;
  String? cmSellout;
  String? filter;
  String? month;

  MtdRetailing({this.cmIya, this.cmSellout, this.filter, this.month});

  MtdRetailing.fromJson(Map<String, dynamic> json) {
    cmIya = json['cmIya'];
    cmSellout = json['cmSellout'];
    filter = json['filter'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmIya'] = cmIya;
    data['cmSellout'] = cmSellout;
    data['filter'] = filter;
    data['month'] = month;
    return data;
  }
}
