class RetailingGeoModel {
  final List<List<String>>? ind;
  final List<List<String>>? indDir;

  RetailingGeoModel({
    this.ind,
    this.indDir,
  });

  factory RetailingGeoModel.fromJson(Map<String, dynamic> json) =>
      RetailingGeoModel(
        ind: json["ind"] == null
            ? []
            : List<List<String>>.from(
                json["ind"]!.map((x) => List<String>.from(x.map((x) => x)))),
        indDir: json["ind_dir"] == null
            ? []
            : List<List<String>>.from(json["ind_dir"]!
                .map((x) => List<String>.from(x.map((x) => x.toString())))),
      );

  Map<String, dynamic> toJson() => {
        "ind": ind == null
            ? []
            : List<dynamic>.from(
                ind!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "ind_dir": indDir == null
            ? []
            : List<dynamic>.from(
                indDir!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
