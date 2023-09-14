import 'package:command_centre/web_dashboard/utils/comman_utils/coverage_division.dart';
import 'package:flutter/material.dart';

class GeoPositionTable extends StatelessWidget {
  final bool addGeoBool;
  final Function() onCoverageTap;
  final Function() onApplyTap;
  final List<dynamic> divisionList;
  final List<dynamic> siteList;
  final List<dynamic> branchList;
  final List<dynamic> clusterList;
  final int selectedGeo;

  const GeoPositionTable(
      {super.key,
      required this.addGeoBool,
      required this.onCoverageTap,
      required this.divisionList,
      required this.siteList,
      required this.branchList,
      required this.selectedGeo,
      required this.clusterList,
      required this.onApplyTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 30,
      child: Visibility(
        visible: addGeoBool,
        child: Container(
            height: 210,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                ),
              ],
              color: Colors.white,
            ),
            child: CoverageWebSheet(
              onTap: onCoverageTap,
              divisionList: divisionList,
              siteList: siteList,
              branchList: branchList,
              selectedGeo: selectedGeo,
              clusterList: clusterList,
              onApplyPressed: onApplyTap,
              elName: "includedData[el].name",
            )),
      ),
    );
  }
}
