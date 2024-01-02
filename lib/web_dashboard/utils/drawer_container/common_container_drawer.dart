import 'package:flutter/material.dart';

import '../comman_utils/drawer_widget.dart';

class CommonContainerDrawer extends StatefulWidget {
  const CommonContainerDrawer({super.key});

  @override
  State<CommonContainerDrawer> createState() => _CommonContainerDrawerState();
}

class _CommonContainerDrawerState extends State<CommonContainerDrawer> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/svg/image65.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerWidget(indexNew: 6,),
              Text("FB"),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              // selectedIndex == 0
              //     ? SummaryContainer(
              //   widgetList: allMetrics,
              //   onTapContainer: () {
              //     setState(() {
              //       if (sheetProvider.selectedCard == "Retailing") {
              //         selectedIndex = 1;
              //       } else if (sheetProvider.selectedCard ==
              //           "Coverage") {
              //         selectedIndex = 2;
              //       }
              //       if (sheetProvider.selectedCard == "Golden Points") {
              //         selectedIndex = 3;
              //       } else if (sheetProvider.selectedCard ==
              //           "Focus Brand") {
              //         selectedIndex = 4;
              //       }
              //       if (sheetProvider.selectedCard == "Distribution") {
              //         selectedIndex = 2;
              //       } else if (sheetProvider.selectedCard ==
              //           "Productivity") {
              //         selectedIndex = 6;
              //       }
              //       if (sheetProvider.selectedCard ==
              //           "Call Compliance") {
              //         selectedIndex = 5;
              //       } else if (sheetProvider.selectedCard ==
              //           "Shipment") {
              //         selectedIndex = 8;
              //       } else if (sheetProvider.selectedCard ==
              //           "Inventory") {
              //         selectedIndex = 7;
              //       } else {}
              //     });
              //   },
              //   includedData: includedData,
              //   metricData: metricData,
              //   allMetrics: allMetrics,
              //   list: [],
              //   divisionList: divisionCount,
              //   siteList: siteCount,
              //   branchList: [],
              //   selectedGeo: 0,
              //   clusterList: clusterCount,
              //   onApplyPressed: () {},
              //   menuBool: menuBool,
              //   divisionBool: divisionBool,
              //   removeBool: removeBool,
              //   firstIsHovering: firstIsHovering,
              //   onGestureTap: () {
              //     setState(() {
              //       showHide = false;
              //       menuBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //       divisionBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //       removeBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //       addDateBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //     });
              //   },
              //   addDateBool: addDateBool,
              //   dataList: dataList,
              //   coverageDataList: coverageDataList,
              //   gpDataList: gpDataList,
              //   fbDataList: fbDataList,
              //   prodDataList: prodDataList,
              //   ccDataList: ccDataList,
              //   onApplyPressedMonth: () async {
              //     setState(() {
              //       menuBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //       divisionBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //       addDateBool = [
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false,
              //         false
              //       ];
              //       setIndex = 1;
              //       SharedPreferencesUtils.setInt('int', setIndex);
              //       initial = false;
              //     });
              //     if (sheetProvider.selectedIcon == "Retailing") {
              //       initial = false;
              //       await fetchRetailingWeb(context, '');
              //       addData();
              //     } else if (sheetProvider.selectedIcon == "Coverage") {
              //       initial = false;
              //       await fetchCoverageWeb(context);
              //       addDataCoverage();
              //     } else if (sheetProvider.selectedIcon ==
              //         "Golden Points") {
              //       initial = false;
              //       await fetchGPWeb(context);
              //       addDataGP();
              //     } else if (sheetProvider.selectedIcon ==
              //         "Focus Brand") {
              //       initial = false;
              //       await fetchFocusBWeb(context);
              //       addDataFB();
              //     } else if (sheetProvider.selectedIcon ==
              //         "Productivity") {
              //       initial = false;
              //       await fetchProductivityWeb(context);
              //       addDataProd();
              //     } else if (sheetProvider.selectedIcon ==
              //         "Call Compliance") {
              //       initial = false;
              //       await fetchCCWeb(context);
              //       addDataCC();
              //     } else {}
              //   },
              //   updateDefault: showHide,
              //   onPressed: () {
              //     setState(() {
              //       showHide = !showHide;
              //     });
              //   },
              //   onPressedGeo: () {},
              //   onRemoveGeoPressed: () {
              //     if (sheetProvider.selectedIcon == "Retailing") {
              //       removeData(sheetProvider.removeIndex);
              //     } else if (sheetProvider.selectedIcon == "Coverage") {
              //       removeDataCoverage(sheetProvider.removeIndex);
              //     } else if (sheetProvider.selectedIcon ==
              //         "Golden Points") {
              //       removeDataGP(sheetProvider.removeIndex);
              //     } else if (sheetProvider.selectedIcon ==
              //         "Focus Brand") {
              //       removeDataFB(sheetProvider.removeIndex);
              //     } else if (sheetProvider.selectedIcon ==
              //         "Productivity") {
              //       removeDataProd(sheetProvider.removeIndex);
              //     } else if (sheetProvider.selectedIcon ==
              //         "Call Compliance") {
              //       removeDataCC(sheetProvider.removeIndex);
              //     } else {}
              //
              //     removeBool = [
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //     ];
              //     menuBool = [
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //       false,
              //     ];
              //     setState(() {
              //       // showHide = !showHide;
              //     });
              //   },
              //   onNewMonth: () {
              //     sheetProvider.isDefaultMonth = !sheetProvider.isDefaultMonth;
              //   },
              //   updateMonth: sheetProvider.isDefaultMonth, onApplyPressedMonthDefault: () async{
              //   dataList.forEach((item) {
              //     String filter = item[0]['mtdRetailing']['filter'];
              //     filtersList.add(filter);
              //   });
              //   var setRetailing;
              //   for (String filter in filtersList){
              //     setRetailing = findDatasetName(filter);
              //     await callAPIWithFilters(setRetailing, filter, 'retailingData');
              //     filtersList = [];
              //   }
              //   coverageDataList.forEach((item) {
              //     String filter = item[0]['coverage']['filter'];
              //     filtersListCoverage.add(filter);
              //   });
              //   var setCoverage;
              //   for (String filter in filtersListCoverage){
              //     setCoverage = findDatasetName(filter);
              //     await callAPIWithFilters(setCoverage, filter, 'CBPData');
              //     filtersListCoverage = [];
              //   }
              //
              //   gpDataList.forEach((item) {
              //     String filter = item[0]['dgpCompliance']['filter'];
              //     filtersListGP.add(filter);
              //   });
              //   var setGP;
              //   for (String filter in filtersListGP){
              //     setGP = findDatasetName(filter);
              //     await callAPIWithFilters(setGP, filter, 'GPData');
              //     filtersListGP = [];
              //   }
              //
              //   fbDataList.forEach((item) {
              //     String filter = item[0]['focusBrand']['filter'];
              //     filtersListFB.add(filter);
              //   });
              //   var setFB;
              //   for (String filter in filtersListFB){
              //     setFB = findDatasetName(filter);
              //     await callAPIWithFilters(setFB, filter, 'FBData');
              //     filtersListFB = [];
              //   }
              //
              //   prodDataList.forEach((item) {
              //     String filter = item[0]['productivity']['filter'];
              //     filtersListProd.add(filter);
              //   });
              //   var setProd;
              //   for (String filter in filtersListProd){
              //     setProd = findDatasetName(filter);
              //     await callAPIWithFilters(setProd, filter, 'ProductivityData');
              //     filtersListProd = [];
              //   }
              //
              //   ccDataList.forEach((item) {
              //     String filter = item[0]['callCompliance']['filter'];
              //     filtersListCC.add(filter);
              //   });
              //   var setCC;
              //   for (String filter in filtersListCC){
              //     setCC = findDatasetName(filter);
              //     await callAPIWithFilters(setCC, filter, 'ccData');
              //     filtersListCC = [];
              //   }
              //
              //   // dataList = [];
              //   // coverageDataList = [];
              //   // gpDataList = [];
              //   // fbDataList = [];
              //   // prodDataList = [];
              //   // ccDataList = [];
              //   addData();
              //   addDataCoverage();
              //   addDataGP();
              //   addDataFB();
              //   addDataProd();
              //   addDataCC();
              //   sheetProvider.isDefaultMonth = !sheetProvider.isDefaultMonth;
              // },
              // )
              //     : selectedIndex == 1
              //     ? const RetailingContainer()
              //     : selectedIndex == 2
              //     ? DistributionContainer(
              //   title: 'Coverage & Distribution',
              //   onApplyPressedMonth: () async {
              //     sheetProvider.isLoaderActive = true;
              //     setState(() {
              //       sheetProvider.selectMonth = false;
              //         var division = SharedPreferencesUtils.getString('webCoverageSheetDivision');
              //         var site = SharedPreferencesUtils.getString('webCoverageSheetSite');
              //         var year = SharedPreferencesUtils.getString('webCoverageYear');
              //         var month = SharedPreferencesUtils.getString('webCoverageMonth');
              //       dataListCoverage1.add({
              //           "$division": "$site",
              //           "date": "$month-$year",
              //           "channel": ""
              //         });
              //     });
              //     await postRequest(context, channelNew, monthNew);
              //     addDataCoverageAll();
              //     sheetProvider.isLoaderActive = false;
              //   },
              //   addMonthBool: addMonthBool,
              //   divisionList: divisionCount,
              //   siteList: siteCount,
              //   branchList: [],
              //   selectedGeo: 0,
              //   clusterList: clusterCount,
              //   dataList: dataListCoverage, coverageAPIList: coverageDataListAPI, onChangedFilter: (value) async {
              //   selectedItemValueChannel[0] = value!;
              //   channelNew = selectedItemValueChannel[0];
              //   sheetProvider.isLoaderActive = true;
              //   if(sheetProvider.isCurrentTab == 0){
              //     dataListCoverage1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": sheetProvider.selectedChannelMonth,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     // await postRequest(context, channelNew, monthNew);
              //     addDataCoverageSheet();
              //     sheetProvider.isLoaderActive = false;
              //   }else if (sheetProvider.isCurrentTab == 1){
              //     dataListCoverageCCTabs1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": sheetProvider.selectedChannelMonth,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequestCCTabs(context, channelNew, monthNew);
              //     addDataCoverageSheetCCTabs();
              //     sheetProvider.isLoaderActive = false;
              //
              //   }else if (sheetProvider.isCurrentTab == 2){
              //     dataListCoverageTabs1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": sheetProvider.selectedChannelMonth,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequestProdTabs(context, channelNew, monthNew);
              //     addDataCoverageSheetTabs();
              //     sheetProvider.isLoaderActive = false;
              //
              //   }else{
              //     dataListCoverageBillingTabs1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": sheetProvider.selectedChannelMonth,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequestBillingTabs(context, channelNew, monthNew);
              //     addDataCoverageSheetBillingTabs();
              //     sheetProvider.isLoaderActive = false;
              //   }
              // },
              //   selectedItemValueChannel: selectedItemValueChannel, onChangedFilterMonth: (value) async {
              //   selectedItemValueChannelMonth[0] = value!;
              //   monthNew = "${selectedItemValueChannelMonth[0]}-2023";
              //   if(sheetProvider.isCurrentTab == 0){
              //     sheetProvider.isLoaderActive = true;
              //     dataListCoverage1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": monthNew,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequest(context, channelNew, monthNew);
              //     sheetProvider.isLoaderActive = false;
              //   }else if (sheetProvider.isCurrentTab == 1){
              //     sheetProvider.isLoaderActive = true;
              //     dataListCoverageCCTabs1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": monthNew,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequestCCTabs(context, channelNew, monthNew);
              //     addDataCoverageSheetCCTabs();
              //     sheetProvider.isLoaderActive = false;
              //
              //   }else if (sheetProvider.isCurrentTab == 2){
              //     sheetProvider.isLoaderActive = true;
              //     dataListCoverageTabs1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": monthNew,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequestProdTabs(context, channelNew, monthNew);
              //     addDataCoverageSheetTabs();
              //     sheetProvider.isLoaderActive = false;
              //   }else{
              //     sheetProvider.isLoaderActive = true;
              //     dataListCoverageBillingTabs1[sheetProvider.selectedChannelIndex] = {
              //       sheetProvider.selectedChannelDivision: sheetProvider.selectedChannelSite,
              //       "date": monthNew,
              //       "channel": channelNew
              //     };
              //     setState(() {});
              //     await postRequestBillingTabs(context, channelNew, monthNew);
              //     addDataCoverageSheetBillingTabs();
              //     sheetProvider.isLoaderActive = false;
              //   }
              //
              // },
              //   selectedItemValueChannelMonth: selectedItemValueChannelMonth,
              //   onApplyPressedMonthCHRTab: () async {
              //     if (sheetProvider.isCurrentTab == 1){
              //       sheetProvider.isLoaderActive = true;
              //       setState(() {
              //         sheetProvider.selectMonth = false;
              //         var division = SharedPreferencesUtils.getString('webCoverageSheetDivision');
              //         var site = SharedPreferencesUtils.getString('webCoverageSheetSite');
              //         var year = SharedPreferencesUtils.getString('webCoverageYear');
              //         var month = SharedPreferencesUtils.getString('webCoverageMonth');
              //         dataListCoverageCCTabs1.add({
              //           "$division": "$site",
              //           "date": "$month-$year",
              //           "channel": ""
              //         });
              //       });
              //       await postRequestCCTabs(context, channelNew, monthNew);
              //       sheetProvider.isLoaderActive = false;
              //
              //     }else if (sheetProvider.isCurrentTab == 2){
              //       sheetProvider.isLoaderActive = true;
              //       setState(() {
              //         sheetProvider.selectMonth = false;
              //         var division = SharedPreferencesUtils.getString('webCoverageSheetDivision');
              //         var site = SharedPreferencesUtils.getString('webCoverageSheetSite');
              //         var year = SharedPreferencesUtils.getString('webCoverageYear');
              //         var month = SharedPreferencesUtils.getString('webCoverageMonth');
              //         dataListCoverageTabs1.add({
              //           "$division": "$site",
              //           "date": "$month-$year",
              //           "channel": ""
              //         });
              //       });
              //       await postRequestProdTabs(context, channelNew, monthNew);
              //       sheetProvider.isLoaderActive = false;
              //     }else if (sheetProvider.isCurrentTab == 3){
              //       sheetProvider.isLoaderActive = true;
              //       setState(() {
              //         sheetProvider.selectMonth = false;
              //         var division = SharedPreferencesUtils.getString('webCoverageSheetDivision');
              //         var site = SharedPreferencesUtils.getString('webCoverageSheetSite');
              //         var year = SharedPreferencesUtils.getString('webCoverageYear');
              //         var month = SharedPreferencesUtils.getString('webCoverageMonth');
              //         dataListCoverageBillingTabs1.add({
              //           "$division": "$site",
              //           "date": "$month-$year",
              //           "channel": ""
              //         });
              //       });
              //       await postRequestBillingTabs(context, channelNew, monthNew);
              //       sheetProvider.isLoaderActive = false;
              //     }
              //
              // }, dataListTabs: dataListCoverageTabs, dataListBillingTabs: dataListCoverageBillingTabs, dataListCCTabs: dataListCoverageCCTabs,
              // )
              //     : selectedIndex == 3
              //     ? const GPContainer(
              //   title: 'Golden Points',
              // )
              //     : selectedIndex == 4
              //     ? const GPContainer(
              //   title: 'Focus Brand222',
              // )
              //     : selectedIndex == 5
              //     ? const GPContainer(
              //   title: 'Call Compliance',
              // )
              //     : selectedIndex == 6
              //     ? const GPContainer(
              //   title: 'Productivity',
              // )
              //     : selectedIndex == 7
              //     ? const GPContainer(
              //   title: 'Inventory',
              // )
              //     : selectedIndex == 8
              //     ? const GPContainer(
              //   title: 'Shipment',
              // )
              //     : selectedIndex == 9
              //     ? const GPContainer(
              //   title: 'Trends',
              // )
              //     : selectedIndex == 10
              //     ? const GPContainer(
              //   title:
              //   'Templates',
              // )
              //     : selectedIndex ==
              //     11
              //     ? const GPContainer(
              //   title:
              //   'View Abbreviations',
              // )
              //     : selectedIndex ==
              //     12
              //     ? const GPContainer(
              //   title:
              //   'View Definitions',
              // )
              //     : Container()
            ],
          ),
        )
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
