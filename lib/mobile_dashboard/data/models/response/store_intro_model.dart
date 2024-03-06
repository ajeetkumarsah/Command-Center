class StoreIntroModel {
  final String? storeName;
  final String? Lat;
  final String? Long;

  StoreIntroModel({
    this.storeName,
    this.Lat,
    this.Long,
  });

  factory StoreIntroModel.fromJson(Map<String, dynamic> json) =>
      StoreIntroModel(
        storeName: json["storeName"],
        Lat: json["Lat"],
        Long: json["Long"],
      );

  Map<String, dynamic> toJson() => {
        "storeName": storeName,
        "Lat": Lat,
        "Long": Long,
      };
}
