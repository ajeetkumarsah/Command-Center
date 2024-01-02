class FiltersModel {
  final List<String> site;
  final List<String> division;
  final List<String> cluster;
  // final List<String> branch;
  final List<String> category;
  final List<String> brand;
  final List<String> brandForm;
  final List<String> subBrandForm;
  final List<String> channel;
  final List<dynamic> subChannel;

  FiltersModel({
    required this.site,
    required this.division,
    required this.cluster,
    // required this.branch,
    required this.category,
    required this.brand,
    required this.brandForm,
    required this.subBrandForm,
    required this.channel,
    required this.subChannel,
  });

  factory FiltersModel.fromJson(Map<String, dynamic> json) => FiltersModel(
        site: json["site"] == null
            ? []
            : List<String>.from(json["site"]!.map((x) => x)),
        division: json["division"] == null
            ? []
            : List<String>.from(json["division"]!.map((x) => x)),
        cluster: json["cluster"] == null
            ? []
            : List<String>.from(json["cluster"]!.map((x) => x)),
        // branch: json["branch"] == null
        //     ? []
        //     : List<String>.from(json["branch"]!.map((x) => x)),
        category: json["category"] == null
            ? []
            : List<String>.from(json["category"]!.map((x) => x)),
        brand: json["brand"] == null
            ? []
            : List<String>.from(json["brand"]!.map((x) => x)),
        brandForm: json["brandForm"] == null
            ? []
            : List<String>.from(json["brandForm"]!.map((x) => x)),
        subBrandForm: json["subBrandForm"] == null
            ? []
            : List<String>.from(json["subBrandForm"]!.map((x) => x)),
        channel: json["channel"] == null
            ? []
            : List<String>.from(json["channel"]!.map((x) => x)),
        subChannel: json["subChannel"] == null
            ? []
            : List<dynamic>.from(json["subChannel"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "site": List<dynamic>.from(site.map((x) => x)),
        "division": List<dynamic>.from(division.map((x) => x)),
        "cluster": List<dynamic>.from(cluster.map((x) => x)),
        // "branch": List<dynamic>.from(branch.map((x) => x)),
        "category": List<dynamic>.from(category.map((x) => x)),
        "brand": List<dynamic>.from(brand.map((x) => x)),
        "brandForm": List<dynamic>.from(brandForm.map((x) => x)),
        "subBrandForm": List<dynamic>.from(subBrandForm.map((x) => x)),
        "channel": List<dynamic>.from(channel.map((x) => x)),
        "subChannel": List<dynamic>.from(subChannel.map((x) => x)),
      };
}
