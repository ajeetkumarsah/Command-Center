class FiltersModel {
  final List<String> site;
  final List<String> division;
  final List<String> district;
  final List<String> branch;
  final List<String> category;
  final List<String> brand;
  final List<String> brandForm;
  final List<String> subBrandForm;
  final List<String> subBrandGroup;
  final List<String> attr1;
  final List<String> attr2;
  final List<String> attr3;
  final List<String> attr4;
  final List<String> attr5;
  final List<String> subChannel;
  final List<String> indAttr1;
  final List<String> indAttr2;
  final List<String> indAttr3;
  final List<String> indAttr4;
  final List<String> indAttr5;
  final OtherAttrs? otherAttrs;

  FiltersModel({
    required this.site,
    required this.division,
    required this.district,
    required this.branch,
    required this.category,
    required this.brand,
    required this.brandForm,
    required this.subBrandForm,
    required this.subBrandGroup,
    required this.attr1,
    required this.attr2,
    required this.attr3,
    required this.attr4,
    required this.attr5,
    required this.subChannel,
    required this.indAttr1,
    required this.indAttr2,
    required this.indAttr3,
    required this.indAttr4,
    required this.indAttr5,
    this.otherAttrs,
  });

  factory FiltersModel.fromJson(Map<String, dynamic> json) => FiltersModel(
        site: json["site"] != null
            ? List<String>.from(json["site"].map((x) => x))
            : [],
        division: json["division"] != null
            ? List<String>.from(json["division"].map((x) => x))
            : [],
        district: json["district"] != null
            ? List<String>.from(json["district"].map((x) => x))
            : [],
        branch: json["branch"] != null
            ? List<String>.from(json["branch"].map((x) => x))
            : [],
        category: json["category"] != null
            ? List<String>.from(json["category"].map((x) => x))
            : [],
        brand: json["brand"] != null
            ? List<String>.from(json["brand"].map((x) => x))
            : [],
        brandForm: json["brandForm"] != null
            ? List<String>.from(json["brandForm"].map((x) => x ?? ''))
            : [],
        subBrandForm: json["subBrandForm"] != null
            ? List<String>.from(json["subBrandForm"].map((x) => x))
            : [],
        subBrandGroup: json["subBrandGroup"] != null
            ? List<String>.from(json["subBrandGroup"].map((x) => x))
            : [],
        attr1: json["attr1"] != null
            ? List<String>.from(json["attr1"].map((x) => x))
            : [],
        attr2: json["attr2"] != null
            ? List<String>.from(json["attr2"].map((x) => x))
            : [],
        attr3: json["attr3"] != null
            ? List<String>.from(json["attr3"].map((x) => x))
            : [],
        attr4: json["attr4"] != null
            ? List<String>.from(json["attr4"].map((x) => x))
            : [],
        attr5: json["attr5"] != null
            ? List<String>.from(json["attr5"].map((x) => x))
            : [],
        subChannel: json["subChannel"] != null
            ? List<String>.from(json["subChannel"].map((x) => x))
            : [],
        indAttr1: json["ind_attr1"] != null
            ? List<String>.from(json["ind_attr1"].map((x) => x))
            : [],
        indAttr2: json["ind_attr2"] != null
            ? List<String>.from(json["ind_attr2"].map((x) => x))
            : [],
        indAttr3: json["ind_attr3"] != null
            ? List<String>.from(json["ind_attr3"].map((x) => x))
            : [],
        indAttr4: json["ind_attr4"] != null
            ? List<String>.from(json["ind_attr4"].map((x) => x))
            : [],
        indAttr5: json["ind_attr5"] != null
            ? List<String>.from(json["ind_attr5"].map((x) => x))
            : [],
        otherAttrs: json["OtherAttrs"] == null
            ? null
            : OtherAttrs.fromJson(json["OtherAttrs"]),
      );

  Map<String, dynamic> toJson() => {
        "site": List<dynamic>.from(site.map((x) => x)),
        "division": List<dynamic>.from(division.map((x) => x)),
        "district": List<dynamic>.from(district.map((x) => x)),
        "branch": List<dynamic>.from(branch.map((x) => x)),
        "category": List<dynamic>.from(category.map((x) => x)),
        "brand": List<dynamic>.from(brand.map((x) => x)),
        "brandForm": List<dynamic>.from(brandForm.map((x) => x)),
        "subBrandForm": List<dynamic>.from(subBrandForm.map((x) => x)),
        "subBrandGroup": List<dynamic>.from(subBrandGroup.map((x) => x)),
        "attr1": List<dynamic>.from(attr1.map((x) => x)),
        "attr2": List<dynamic>.from(attr2.map((x) => x)),
        "attr3": List<dynamic>.from(attr3.map((x) => x)),
        "attr4": List<dynamic>.from(attr4.map((x) => x)),
        "attr5": List<dynamic>.from(attr5.map((x) => x)),
        "subChannel": List<dynamic>.from(subChannel.map((x) => x)),
      };
}

class OtherAttrs {
  final List<String> attr1;
  final List<String> attr2;
  final List<String> attr3;
  final List<String> attr4;
  final List<String> attr5;

  OtherAttrs({
    required this.attr1,
    required this.attr2,
    required this.attr3,
    required this.attr4,
    required this.attr5,
  });

  factory OtherAttrs.fromJson(Map<String, dynamic> json) => OtherAttrs(
        attr1: json["attr1"] == null
            ? []
            : List<String>.from(json["attr1"]!.map((x) => x)),
        attr2: json["attr2"] == null
            ? []
            : List<String>.from(json["attr2"]!.map((x) => x)),
        attr3: json["attr3"] == null
            ? []
            : List<String>.from(json["attr3"]!.map((x) => x)),
        attr4: json["attr4"] == null
            ? []
            : List<String>.from(json["attr4"]!.map((x) => x)),
        attr5: json["attr5"] == null
            ? []
            : List<String>.from(json["attr5"]!.map((x) => x)),
      );
}
