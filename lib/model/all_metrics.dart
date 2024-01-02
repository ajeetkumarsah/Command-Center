import 'dart:convert';

List<AllMetrics> allMetricsFromJson(String str) => List<AllMetrics>.from(json.decode(str).map((x) => AllMetrics.fromJson(x)));

String allMetricsToJson(List<AllMetrics> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllMetrics {
  String name;
  String subtitle;
  bool isEnabled;
  AllMetrics( {
    required this.name,
    required this.subtitle,
    this.isEnabled = false,
  });

  factory AllMetrics.fromJson(Map<String, dynamic> json) => AllMetrics(
    name: json['name']??"",
    subtitle: json['subtitle']??"",
    isEnabled: json['isEnabled']?? false,
  );

  Map<String, dynamic> toJson()=>{
    "name": name,
    "subtitle": subtitle,
    "isEnabled": isEnabled
  };
}
