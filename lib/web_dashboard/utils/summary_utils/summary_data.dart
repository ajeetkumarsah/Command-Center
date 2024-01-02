import 'package:flutter/material.dart';

import '../../../utils/style/text_style.dart';

class Retailing extends StatefulWidget {
  final String site;
  final String division;
  final String selectedSite;
  final String selectdmonth;
  final String sellout;
  final String allIndia;
  final String tgtSite;
  final String tgtDivision;
  final String tgtAllIndia;
  final String isSelect;
  final String perTitle;
  final String cmSaliance;
  final String dgpCom;
  final int iya;

  const Retailing(
      {Key? key,
      required this.isSelect,
      required this.perTitle,
      required this.dgpCom,
      required this.site,
      required this.division,
      required this.allIndia,
      required this.tgtSite,
      required this.tgtDivision,
      required this.tgtAllIndia,
      required this.iya,
      required this.cmSaliance,
      required this.selectedSite,
      required this.selectdmonth,
      required this.sellout})
      : super(key: key);

  @override
  State<Retailing> createState() => _RetailingState();
}

class _RetailingState extends State<Retailing> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.dgpCom.replaceAll("%", "");
    final intResult = int.parse(result) / 100;
    double doubleVar = intResult.toDouble();
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        widget.iya == 0
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 205,
                  child: Center(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Sellout",
                                    style: ThemeText.coverageText,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '',
                                    style: ThemeText.subTitleText,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Target",
                                    style: ThemeText.showMoreText,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.site,
                                    style: ThemeText.showMoreText,
                                  ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Text(
                                  //   widget.selectdmonth,
                                  //   style: ThemeText.showMoreText,
                                  // ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Text(
                                  //   widget.selectedSite,
                                  //   style: ThemeText.showMoreText,
                                  // )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 205,
                  child: Center(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Sellout",
                                    style: ThemeText.coverageText,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.site,
                                    style: ThemeText.subTitleText,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Target",
                                    style: ThemeText.showMoreText,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.site,
                                    style: ThemeText.showMoreText,
                                  ),
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  // const Text(
                                  //   "Month",
                                  //   style: ThemeText.showMoreText,
                                  // ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Text(
                                  //   'Site',
                                  //   style: ThemeText.showMoreText,
                                  // )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
