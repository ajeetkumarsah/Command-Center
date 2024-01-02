import 'package:flutter/material.dart';

import '../../helper/http_call.dart';
import '../model/fb_web_model.dart';
import '../model/retailing_model.dart';
import '../utils/summary_utils/summary_data.dart';

class DistributionWebContainer extends StatefulWidget {
  final String elName;

  const DistributionWebContainer({
    super.key,
    required this.elName,
  });

  @override
  State<DistributionWebContainer> createState() =>
      _DistributionWebContainerState();
}

class _DistributionWebContainerState extends State<DistributionWebContainer> {
  @override
  Widget build(BuildContext context) {
    return Retailing(
      site: "110",
      tgtSite: "111",
      tgtDivision: "112",
      division: "113",
      allIndia: "114",
      tgtAllIndia: "115",
      isSelect: widget.elName,
      perTitle: '',
      dgpCom: '40%',
      iya: 0,
      cmSaliance: '116',
      selectedSite: '',
      selectdmonth: '',
      sellout: '',
    );
    //   FutureBuilder<RetailingModel>(
    //   future: fetchFBWeb(context),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Padding(
    //         padding: EdgeInsets.only(top: 100.0),
    //         child: Center(child: CircularProgressIndicator()),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     } else {
    //       final appData = snapshot.data;
    //       print("FB : $appData");
    //       return Retailing(
    //         site: "110",
    //         tgtSite: "111",
    //         tgtDivision: "112",
    //         division: "113",
    //         allIndia: "114",
    //         tgtAllIndia: "115",
    //         isSelect: widget.elName,
    //         perTitle: '',
    //         dgpCom: '40%',
    //         iya: 0,
    //         cmSaliance: '116',
    //         selectedSite: '',
    //         selectdmonth: '',
    //         sellout: '',
    //       );
    //       //   Retailing(
    //       //   site: appData!.mtdRetailing!.cmSellout! ?? '0',
    //       //   division: appData.mtdRetailing!.cmIyaDivision! ?? '0',
    //       //   allIndia: appData.mtdRetailing!.cmIyaAllIndia! ?? '0',
    //       //   tgtSite: '',
    //       //   tgtDivision: '',
    //       //   tgtAllIndia: '',
    //       //   isSelect: '',
    //       //   perTitle: '',
    //       //   dgpCom: '40%', iya: widget.iya, cmSaliance: appData.mtdRetailing!.cmSaliance! ?? '0',
    //       // );
    //     }
    //   },
    // );
  }
}
