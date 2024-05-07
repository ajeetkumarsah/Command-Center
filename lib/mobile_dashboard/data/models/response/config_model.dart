class ConfigModel {
  final int? index;
  final String? apkVersion;
  final String? ipaVersion;
  final String? apkLink;
  final String? ipaLink;
  final bool? onMaintenance;
  final String? updatedOn;

  ConfigModel({
    this.index,
    this.apkVersion,
    this.ipaVersion,
    this.apkLink,
    this.ipaLink,
    this.onMaintenance,
    this.updatedOn,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        index: json["index"],
        apkVersion: json["apkVersion"],
        ipaVersion: json["ipaVersion"],
        apkLink: json["apkLink"],
        ipaLink: json["ipaLink"],
        onMaintenance: json["onMaintenance"],
        updatedOn: json["updatedOn"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "apkVersion": apkVersion,
        "ipaVersion": ipaVersion,
        "apkLink": apkLink,
        "ipaLink": ipaLink,
        "onMaintenance": onMaintenance,
        "updatedOn": updatedOn,
      };
}
