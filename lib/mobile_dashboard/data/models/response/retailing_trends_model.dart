import 'package:command_centre/mobile_dashboard/data/models/response/trends_model.dart';

class RetailingTrendsModel {
  final TrendsModel? ind;
  final TrendsModel? indDir;

  RetailingTrendsModel({
    this.ind,
    this.indDir,
  });

  factory RetailingTrendsModel.fromJson(Map<String, dynamic> json) =>
      RetailingTrendsModel(
        ind: json["ind"] == null ? null : TrendsModel.fromJson(json["ind"]),
        indDir: json["ind_dir"] == null
            ? null
            : TrendsModel.fromJson(json["ind_dir"]),
      );
}
