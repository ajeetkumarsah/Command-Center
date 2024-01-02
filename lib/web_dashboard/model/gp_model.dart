class GPModel {
  DgpCompliance? dgpCompliance;

  GPModel({this.dgpCompliance});

  GPModel.fromJson(Map<String, dynamic> json) {
    dgpCompliance = json['dgpCompliance'] != null
        ? DgpCompliance.fromJson(json['dgpCompliance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dgpCompliance != null) {
      data['dgpCompliance'] = dgpCompliance!.toJson();
    }
    return data;
  }
}

class DgpCompliance {
  String? gpAchievememt;
  String? gpAbs;
  String? gpIYA;
  String? gpAchievememtAllIndia;
  String? gpAbsAllIndia;
  String? gpIYAAllIndia;

  DgpCompliance(
      {this.gpAchievememt,
        this.gpAbs,
        this.gpIYA,
        this.gpAchievememtAllIndia,
        this.gpAbsAllIndia,
        this.gpIYAAllIndia});

  DgpCompliance.fromJson(Map<String, dynamic> json) {
    gpAchievememt = json['gpAchievememt'];
    gpAbs = json['gpAbs'];
    gpIYA = json['gpIYA'];
    gpAchievememtAllIndia = json['gpAchievememtAllIndia'];
    gpAbsAllIndia = json['gpAbsAllIndia'];
    gpIYAAllIndia = json['gpIYAAllIndia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gpAchievememt'] = gpAchievememt;
    data['gpAbs'] = gpAbs;
    data['gpIYA'] = gpIYA;
    data['gpAchievememtAllIndia'] = gpAchievememtAllIndia;
    data['gpAbsAllIndia'] = gpAbsAllIndia;
    data['gpIYAAllIndia'] = gpIYAAllIndia;
    return data;
  }
}
