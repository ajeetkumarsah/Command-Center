class MapDataModel {
  final String? storeName;
  final String? lat;
  final String? long;

  MapDataModel({
    this.storeName,
    this.lat,
    this.long,
  });

  factory MapDataModel.fromJson(Map<String, dynamic> json) =>
      MapDataModel(
        storeName: json["storeName"],
        lat: json["Lat"],
        long: json["Long"],
      );

  Map<String, dynamic> toJson() => {
    "storeName": storeName,
    "Lat": lat,
    "Long": long,
  };
}
