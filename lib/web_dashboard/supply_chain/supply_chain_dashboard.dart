import 'dart:convert';

import 'package:command_centre/web_dashboard/supply_chain/supply_chain_provider/transportation_provider.dart';
import 'package:command_centre/web_dashboard/supply_chain/utils/division_supply_chain.dart';
import 'package:command_centre/web_dashboard/supply_chain/utils/drawer_alerts.dart';
import 'package:command_centre/web_dashboard/supply_chain/utils/drawer_widget_supply_chain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../helper/app_urls.dart';
import '../../provider/sheet_provider.dart';
import '../../utils/colors/colors.dart';
import '../../utils/style/text_style.dart';
import '../utils/comman_utils/drawer_widget.dart';
import '../utils/summary_utils/drawer_container/drawer_utils/title_widget.dart';
import 'custom_widget/button_widget.dart';
import 'helper/data.dart';

class SupplyChainDashBoard extends StatefulWidget {
  const SupplyChainDashBoard({Key? key}) : super(key: key);

  @override
  State<SupplyChainDashBoard> createState() => _SupplyChainDashBoardState();
}

class _SupplyChainDashBoardState extends State<SupplyChainDashBoard> {
  bool graphVisible = false;
  String? selectedValue;
  int typeIndex = 2;

  int compareTypeIndex = 0;
  int compareYear1Index = 0;
  int compareYear2Index = 0;
  int compareMonth1Index = 0;
  int compareMonth2Index = 0;

  String compareMonth1 = '';
  String compareMonth2 = '';
  String compareYear1 = '';
  String compareYear2 = '';

  int statusTypeIndex = 0;
  int selectedYearIndex = 0;
  int selectedMonthIndex = 0;
  String statusMonth = month.first;
  int statusYear = year.first;

  List<String> selectedIndices = [];

  final OverlayPortalController _tooltipController = OverlayPortalController();
  final OverlayPortalController _tooltipController2 = OverlayPortalController();
  final OverlayPortalController _tooltipController3 = OverlayPortalController();
  final OverlayPortalController _tooltipController4 = OverlayPortalController();
  final OverlayPortalController _tooltipController5 = OverlayPortalController();

  final _link = LayerLink();
  final _link2 = LayerLink();
  final _link3 = LayerLink();
  final _link4 = LayerLink();
  final _link5 = LayerLink();

  /// width of the button after the widget rendered
  double? _buttonWidth;
  List<dynamic> matrixCardDataList = [];
  List<dynamic> filterDestinationDataList = [];
  List<dynamic> filterCategoryDataList = [];
  List<dynamic> filterVehicleDataList = [];
  List<dynamic> filterSbfDataList = [];
  List<dynamic> filterSourceList = [];

  Future<http.Response> postRequest(context, List<dynamic> date, List<dynamic> category, List<dynamic> subBrand, List<dynamic> destination,
      List<dynamic> source, String movement, List<dynamic> vehicleType) async {
    final provider = Provider.of<TransportationProvider>(context, listen: false);


    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/webData/transportation';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "date": date,
      "category": category,
      "subBrandForm": subBrand,
      "destinationCity": destination,
      "sourceCity": source,
      "movement": movement,
      "vehicleType": vehicleType,
      "physicalYear": ""
    });

    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        matrixCardDataList = jsonDecode(response.body);
        provider.setMasterData(matrixCardDataList);

      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  Future<http.Response> categoryDropdownList(context) async {
    final filterData = Provider.of<TransportationProvider>(context, listen: false);
    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/appData/supply/categoryFilter';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "destination": filterData.destinationFilter,
      "category": [],
      "subBrandForm": filterData.sbfFilter,
      "sourceCity": filterData.sourceFilter,
      "vehicleType": filterData.vehicleFilter,
      "movement": ''
    });

    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        filterCategoryDataList = jsonDecode(response.body);

      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  Future<http.Response> destinationDropdownList(context) async {
    final filterData = Provider.of<TransportationProvider>(context, listen: false);
    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/appData/supply/destinationFilter';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "destination": [],
      "category": filterData.catFilter,
      "subBrandForm": filterData.sbfFilter,
      "sourceCity": filterData.sourceFilter,
      "vehicleType": filterData.vehicleFilter,
      "movement": ''
    });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        filterDestinationDataList = jsonDecode(response.body);

      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  Future<http.Response> sourceDropdownList(context) async {
    final filterData = Provider.of<TransportationProvider>(context, listen: false);

    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/appData/supply/sourceCityFilter';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "destination": filterData.destinationFilter,
      "category": filterData.catFilter,
      "subBrandForm": filterData.sbfFilter,
      "sourceCity": [],
      "vehicleType": filterData.vehicleFilter,
      "movement": ''
    });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        filterSourceList = jsonDecode(response.body);

      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  Future<http.Response> sbfDropdownList(context) async {
    final filterData = Provider.of<TransportationProvider>(context, listen: false);

    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/appData/supply/sbfFilter';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "destination": filterData.destinationFilter,
      "category": filterData.catFilter,
      "subBrandForm": [],
      "sourceCity": filterData.sourceFilter,
      "vehicleType": filterData.vehicleFilter,
      "movement": ''
    });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        filterSbfDataList = jsonDecode(response.body);

      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  Future<http.Response> vehicleDropdownList(context) async {
    final filterData = Provider.of<TransportationProvider>(context, listen: false);

    // var url = '$BASE_URL/api/webDeepDive/rt/monthlyData';
    var url = '$BASE_URL/api/appData/supply/vehicleTypeFilter';
    // var url = 'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654';

    var body = json.encode({
      "destination": filterData.destinationFilter,
      "category": filterData.catFilter,
      "subBrandForm": filterData.sbfFilter,
      "sourceCity": filterData.sourceFilter,
      "vehicleType": [],
      "movement": ''
    });    var response = await http.post(Uri.parse(url), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      setState(() {
        filterVehicleDataList = jsonDecode(response.body);

      });
    } else {
      var snackBar = SnackBar(content: Text(response.body));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    postRequest(context, [], [], [], [], [], '', []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<TransportationProvider>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _tooltipController.hide();
          _tooltipController2.hide();
          _tooltipController3.hide();
          _tooltipController4.hide();
          _tooltipController5.hide();
        },
        child: Stack(
          children: [
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawerWidgetSupplyChain(
                  indexNew: 0,
                  onClick: () {
                    setState(() {
                      graphVisible = true;
                    });
                  },
                  menuData: provider.masterdata,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 31),
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 574),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supply Chain',
                            style: TextStyle(color: Color(0xff99A5B1), fontSize: 14, fontFamily: fontFamily, fontWeight: FontWeight.w400),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  'Transportation',
                                  style: TextStyle(
                                      color: MyColors.toggleColorWhite,
                                      fontSize: 30,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 312,
                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async{
                                          String? movement;
                                          setState(() {
                                            provider.setLoad(true);
                                            typeIndex = index;
                                            movement = data[typeIndex];
                                            provider.setMovementFilter(movement);
                                          });
                                          if (movement == "Both") {
                                            await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                provider.sourceFilter!, '', provider.vehicleFilter!);
                                          } else {
                                            await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                provider.sourceFilter!, provider.movementFilter! , provider.vehicleFilter!);
                                          }
                                          provider.setLoad(false);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            width: 100,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: typeIndex == index ? MyColors.iconColorBlue : Colors.white,
                                                borderRadius: const BorderRadius.all(Radius.circular(20))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(
                                                data[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: typeIndex == index ? Colors.white : Colors.black,
                                                    fontWeight: typeIndex == index ? FontWeight.bold : FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CompositedTransformTarget(
                                  link: _link,
                                  child: OverlayPortal(
                                    controller: _tooltipController,
                                    overlayChildBuilder: (BuildContext context) {
                                      return CompositedTransformFollower(
                                        link: _link,
                                        targetAnchor: Alignment.bottomLeft,
                                        child: Align(
                                          alignment: AlignmentDirectional.topStart,
                                          child: MenuWidget(
                                            SelectedDropdownindex: 1,
                                            width: _buttonWidth,
                                            list: filterCategoryDataList,
                                            onFilterClick: () async {
                                              provider.setLoad(true);
                                              _tooltipController.hide();

                                              await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                  provider.sourceFilter!, provider.movementFilter! , provider.vehicleFilter!);
                                              provider.setLoad(false);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: ButtonWidget(
                                      onTap: onTap,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                provider.catFilter!.isEmpty ? 'Category' : provider.catFilter!.length > 1 ? '${provider.catFilter?.first}+':'${provider.catFilter?.first}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: MyColors.dropdownTextGrey,
                                                    fontFamily: fontFamily,
                                                    fontStyle: FontStyle.italic),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            const Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CompositedTransformTarget(
                                    link: _link2,
                                    child: OverlayPortal(
                                      controller: _tooltipController2,
                                      overlayChildBuilder: (BuildContext context) {
                                        return CompositedTransformFollower(
                                          link: _link2,
                                          targetAnchor: Alignment.bottomLeft,
                                          child: Align(
                                            alignment: AlignmentDirectional.topStart,
                                            child: MenuWidget(
                                              SelectedDropdownindex: 2,
                                              width: _buttonWidth,
                                              list: filterSourceList,
                                              onFilterClick: () async {
                                                provider.setLoad(true);
                                                _tooltipController2.hide();

                                                await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                    provider.sourceFilter!, provider.movementFilter! , provider.vehicleFilter!);
                                                provider.setLoad(false);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: ButtonWidget(
                                        onTap: onTap2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  provider.sourceFilter!.isEmpty ? 'Source' : provider.sourceFilter!.length > 1 ? '${provider.sourceFilter?.first}+' : '${provider.sourceFilter?.first}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: MyColors.dropdownTextGrey,
                                                      fontFamily: fontFamily,
                                                      fontStyle: FontStyle.italic),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CompositedTransformTarget(
                                    link: _link3,
                                    child: OverlayPortal(
                                      controller: _tooltipController3,
                                      overlayChildBuilder: (BuildContext context) {
                                        return CompositedTransformFollower(
                                          link: _link3,
                                          targetAnchor: Alignment.bottomLeft,
                                          child: Align(
                                            alignment: AlignmentDirectional.topStart,
                                            child: MenuWidget(
                                              SelectedDropdownindex: 3,
                                              width: _buttonWidth,
                                              list: filterDestinationDataList,
                                              onFilterClick: () async {
                                                provider.setLoad(true);
                                                _tooltipController3.hide();

                                                await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                    provider.sourceFilter!, provider.movementFilter! , provider.vehicleFilter!);
                                                provider.setLoad(false);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: ButtonWidget(
                                        onTap: onTap3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  provider.destinationFilter!.isEmpty ? 'Destination' : provider.destinationFilter!.length > 1 ?'${provider.destinationFilter?.first}+' : '${provider.destinationFilter?.first}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: MyColors.dropdownTextGrey,
                                                      fontFamily: fontFamily,
                                                      fontStyle: FontStyle.italic),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CompositedTransformTarget(
                                    link: _link4,
                                    child: OverlayPortal(
                                      controller: _tooltipController4,
                                      overlayChildBuilder: (BuildContext context) {
                                        return CompositedTransformFollower(
                                          link: _link4,
                                          targetAnchor: Alignment.bottomLeft,
                                          child: Align(
                                            alignment: AlignmentDirectional.topStart,
                                            child: MenuWidget(
                                              SelectedDropdownindex: 4,
                                              width: _buttonWidth,
                                              list: filterVehicleDataList,
                                              onFilterClick: () async {
                                                provider.setLoad(true);
                                                _tooltipController4.hide();

                                                await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                    provider.sourceFilter!, provider.movementFilter! , provider.vehicleFilter!);
                                                provider.setLoad(false);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: ButtonWidget(
                                        onTap: onTap4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  provider.vehicleFilter!.isEmpty ? 'Truck Type' : provider.vehicleFilter!.length > 1 ? '${provider.vehicleFilter?.first}+' : '${provider.vehicleFilter?.first}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: MyColors.dropdownTextGrey,
                                                      fontFamily: fontFamily,
                                                      fontStyle: FontStyle.italic),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CompositedTransformTarget(
                                    link: _link5,
                                    child: OverlayPortal(
                                      controller: _tooltipController5,
                                      overlayChildBuilder: (BuildContext context) {
                                        return CompositedTransformFollower(
                                          link: _link5,
                                          targetAnchor: Alignment.bottomLeft,
                                          child: Align(
                                            alignment: AlignmentDirectional.topStart,
                                            child: MenuWidget(
                                              SelectedDropdownindex: 5,
                                              width: _buttonWidth,
                                              list: filterSbfDataList,
                                              onFilterClick: () async {
                                                provider.setLoad(true);
                                                _tooltipController5.hide();

                                                await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                    provider.sourceFilter!, provider.movementFilter!, provider.vehicleFilter!);
                                                provider.setLoad(false);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: ButtonWidget(
                                        onTap: onTap5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  provider.sbfFilter!.isEmpty ? 'SBF' : provider.sbfFilter!.length > 1 ? '${provider.sbfFilter?.first}+' : '${provider.sbfFilter?.first}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: MyColors.dropdownTextGrey,
                                                      fontFamily: fontFamily,
                                                      fontStyle: FontStyle.italic),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder: (context, setState) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              scrollable: true,
                                              content: Form(
                                                child: SizedBox(
                                                  width: 600,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 600,
                                                            height: 60,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                itemCount: filter.length,
                                                                itemBuilder: (context, index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.all(12.0),
                                                                    child: InkWell(
                                                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                      onTap: () {
                                                                        setState(() {
                                                                          compareTypeIndex = index;

                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        width: 170,
                                                                        height: 60,
                                                                        decoration: BoxDecoration(
                                                                            color: compareTypeIndex == index ? const Color(0xffF0F0F0) : Colors.white,
                                                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                            boxShadow: const [BoxShadow(color: MyColors.grey, blurRadius: 1)]),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8, bottom: 8),
                                                                          child: Text(
                                                                            filter[index],
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(
                                                                              color: compareTypeIndex == index ? MyColors.iconColorBlue : MyColors.grey,
                                                                              fontWeight:
                                                                                  compareTypeIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 600,
                                                        child: ListView.builder(
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: year.length,
                                                            itemBuilder: (context, index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    compareYear1Index = index;
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                                                                  child: Text(
                                                                    '${year[index]}',
                                                                    style: TextStyle(
                                                                      color: compareYear1Index == index ? MyColors.iconColorBlue : MyColors.grey,
                                                                      fontWeight: compareYear1Index == index ? FontWeight.bold : FontWeight.normal,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                      compareTypeIndex != 2
                                                          ? Column(
                                                              children: [
                                                                Container(
                                                                  height: 0.5,
                                                                  width: 600,
                                                                  color: MyColors.grey.withOpacity(0.5),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(top: 12, left: compareTypeIndex == 0 ? 0 : 100),
                                                                  child: Center(
                                                                    child: Container(
                                                                      height: compareTypeIndex == 0 ? 100 : 50,
                                                                      width: 600,
                                                                      alignment: Alignment.center,
                                                                      child: Center(
                                                                        child: GridView.builder(
                                                                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                                maxCrossAxisExtent: 80,
                                                                                childAspectRatio: 2 / 1,
                                                                                crossAxisSpacing: 20,
                                                                                mainAxisSpacing: 15),
                                                                            itemCount: compareTypeIndex == 0 ? month.length : quarter.length,
                                                                            itemBuilder: (BuildContext ctx, index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    compareMonth1Index = index;
                                                                                  });
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 12),
                                                                                  child: Text(
                                                                                    compareTypeIndex == 0 ? month[index] : quarter[index],
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: compareMonth1Index == index
                                                                                          ? MyColors.iconColorBlue
                                                                                          : MyColors.grey,
                                                                                      fontWeight: compareMonth1Index == index
                                                                                          ? FontWeight.bold
                                                                                          : FontWeight.normal,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox(),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text(
                                                          'vs',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 40,
                                                        width: 600,
                                                        child: ListView.builder(
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: year.length,
                                                            itemBuilder: (context, index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    compareYear2Index = index;
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                                                                  child: Text(
                                                                    '${year[index]}',
                                                                    style: TextStyle(
                                                                      color: compareYear2Index == index ? MyColors.iconColorBlue : MyColors.grey,
                                                                      fontWeight: compareYear2Index == index ? FontWeight.bold : FontWeight.normal,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                      compareTypeIndex != 2
                                                          ? Column(
                                                              children: [
                                                                Container(
                                                                  height: 0.5,
                                                                  width: 600,
                                                                  color: MyColors.grey.withOpacity(0.5),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(top: 12, left: compareTypeIndex == 0 ? 0 : 100),
                                                                  child: Container(
                                                                    height: compareTypeIndex == 0 ? 100 : 50,
                                                                    width: 600,
                                                                    alignment: Alignment.center,
                                                                    child: GridView.builder(
                                                                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                            maxCrossAxisExtent: 80,
                                                                            childAspectRatio: 2 / 1,
                                                                            crossAxisSpacing: 20,
                                                                            mainAxisSpacing: 15),
                                                                        itemCount: compareTypeIndex == 0 ? month.length : quarter.length,
                                                                        itemBuilder: (BuildContext ctx, index) {
                                                                          return InkWell(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                compareMonth2Index = index;
                                                                              });
                                                                            },
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(top: 12),
                                                                              child: Text(
                                                                                compareTypeIndex == 0 ? month[index] : quarter[index],
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: compareMonth2Index == index
                                                                                      ? MyColors.iconColorBlue
                                                                                      : MyColors.grey,
                                                                                  fontWeight:
                                                                                      compareMonth2Index == index ? FontWeight.bold : FontWeight.normal,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                Center(
                                                  child: ElevatedButton(
                                                    child: const Text("Apply"),
                                                    onPressed: () {

                                                      // your code
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                        height: 34,
                                        width: 120,
                                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Compare',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: fontFamily
                                                ),
                                              ),
                                              Icon(
                                                Icons.compare_arrows,
                                                color: MyColors.iconColorBlue,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder: (context, setState) {
                                            return AlertDialog(
                                              scrollable: true,
                                              content: Stack(
                                                children: [
                                                  Form(
                                                    child: SizedBox(
                                                      width: 600,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 600,
                                                                height: 60,
                                                                child: ListView.builder(
                                                                    scrollDirection: Axis.horizontal,
                                                                    itemCount: filter.length,
                                                                    itemBuilder: (context, index) {
                                                                      return Padding(
                                                                        padding: const EdgeInsets.all(12.0),
                                                                        child: InkWell(
                                                                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                          onTap: () {
                                                                            setState(() {
                                                                              statusTypeIndex = index;

                                                                            });
                                                                          },
                                                                          child: Container(
                                                                            width: 170,
                                                                            height: 60,
                                                                            decoration: BoxDecoration(
                                                                                color:
                                                                                    statusTypeIndex == index ? const Color(0xffF0F0F0) : Colors.white,
                                                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                boxShadow: const [BoxShadow(color: MyColors.grey, blurRadius: 1)]),
                                                                            child: Padding(
                                                                              padding:
                                                                                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 8, bottom: 8),
                                                                              child: Text(
                                                                                filter[index],
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontFamily: fontFamily,
                                                                                  fontWeight:
                                                                                      statusTypeIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                                  color:
                                                                                      statusTypeIndex == index ? MyColors.iconColorBlue : MyColors.grey,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            width: 600,
                                                            child: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                itemCount: year.length,
                                                                itemBuilder: (context, index) {
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        selectedYearIndex = index;
                                                                        statusYear = year[index];
                                                                      });
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                                                                      child: Text(
                                                                        '${year[index]}',
                                                                        style: TextStyle(
                                                                          fontFamily: fontFamily,
                                                                          fontWeight: selectedYearIndex == index ? FontWeight.bold : FontWeight.normal,
                                                                          color: selectedYearIndex == index ? MyColors.iconColorBlue : MyColors.grey,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                          statusTypeIndex != 2
                                                              ? Column(
                                                                  children: [
                                                                    Container(
                                                                      height: 0.5,
                                                                      width: 600,
                                                                      color: MyColors.grey.withOpacity(0.5),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                        top: 12,
                                                                        left: statusTypeIndex == 0 ? 0 : 100,
                                                                      ),
                                                                      child: Container(
                                                                        height: statusTypeIndex == 0 ? 100 : 50,
                                                                        width: 600,
                                                                        alignment: Alignment.center,
                                                                        child: GridView.builder(
                                                                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                                maxCrossAxisExtent: 80,
                                                                                childAspectRatio: 3 / 1,
                                                                                crossAxisSpacing: 20,
                                                                                mainAxisSpacing: 15),
                                                                            itemCount: statusTypeIndex == 0 ? month.length : quarter.length,
                                                                            itemBuilder: (BuildContext ctx, index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    selectedMonthIndex = index;
                                                                                    statusMonth = month[index];
                                                                                  });
                                                                                },
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    statusTypeIndex == 0 ? month[index] : quarter[index],
                                                                                    style: TextStyle(
                                                                                        fontFamily: fontFamily,
                                                                                        fontWeight: selectedMonthIndex == index
                                                                                            ? FontWeight.bold
                                                                                            : FontWeight.normal,
                                                                                        color: selectedMonthIndex == index
                                                                                            ? MyColors.iconColorBlue
                                                                                            : MyColors.dropdownTextGrey),
                                                                                    textAlign: TextAlign.center,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      right: 0,
                                                      child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              Navigator.of(context).pop();
                                                            });
                                                          },
                                                          child: const Icon(Icons.close))),
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  child: const Text("Apply"),
                                                  onPressed: () async {
                                                    provider.setLoad(true);
                                                    String date = "$statusYear-$statusMonth";
                                                    // provider.filterDate.clear();
                                                    provider.setFilterDate(date);
                                                    Navigator.of(context).pop();
                                                    await postRequest(context, provider.filterDate!, provider.catFilter!, provider.sbfFilter!, provider.destinationFilter!,
                                                        provider.sourceFilter!, provider.movementFilter! , provider.vehicleFilter!);
                                                    provider.setLoad(false);
                                                    // your code
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                        height: 34,
                                        width: 100,
                                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                provider.filterDate.isEmpty ? 'YTD': '${provider.filterDate.first}',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: MyColors.iconColorBlue,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () async{
                                      provider.setLoad(true);
                                      setState(() {
                                        graphVisible = false;
                                        selectedValue;
                                        typeIndex = 2;
                                        compareTypeIndex = 0;
                                        compareYear1Index = 0;
                                        compareYear2Index = 0;
                                        compareMonth1Index = 0;
                                        compareMonth2Index = 0;
                                        compareMonth1 = '';
                                        compareMonth2 = '';
                                        compareYear1 = '';
                                        compareYear2 = '';
                                        statusTypeIndex = 0;
                                        selectedYearIndex = 0;
                                        selectedMonthIndex = 0;
                                        statusMonth = month.first;
                                        statusYear = year.first;

                                        _tooltipController.hide();
                                        _tooltipController2.hide();
                                        _tooltipController3.hide();
                                        _tooltipController4.hide();
                                        _tooltipController5.hide();

                                        selectedIndices = [];
                                        provider.setDefault();
                                      });
                                      await postRequest(context, [], [], [], [], [], '', []);
                                      provider.setLoad(false);

                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.refresh,
                                          color: MyColors.iconColorBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.ios_share,
                                        color: MyColors.iconColorBlue,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: matrixCardDataList.isEmpty
                                  ? const Center(child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()))
                                  : SupplyChainDiv(
                                      matrixCardDataList: matrixCardDataList[0]['cardData'],
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const DrawerAlerts(indexNew: 0)
              ],
            )
          ],
        ),
      ),
    );
  }

  void onTap() {
    categoryDropdownList(context);
    _buttonWidth = context.size?.width;
    _tooltipController.toggle();
    _tooltipController2.hide();
    _tooltipController3.hide();
    _tooltipController4.hide();
    _tooltipController5.hide();
  }

  void onTap2() {
    sourceDropdownList(context);
    _buttonWidth = context.size?.width;
    _tooltipController.hide();
    _tooltipController2.toggle();
    _tooltipController3.hide();
    _tooltipController4.hide();
    _tooltipController5.hide();
  }

  void onTap3() {
    destinationDropdownList(context);
    _buttonWidth = context.size?.width;
    _tooltipController3.toggle();
    _tooltipController4.hide();
    _tooltipController2.hide();
    _tooltipController.hide();
    _tooltipController5.hide();
  }

  void onTap4() {
    vehicleDropdownList(context);
    _buttonWidth = context.size?.width;
    _tooltipController4.toggle();
    _tooltipController2.hide();
    _tooltipController.hide();
    _tooltipController3.hide();
    // _tooltipController4.hide();
    _tooltipController5.hide();
  }

  void onTap5() {
    sbfDropdownList(context);
    _buttonWidth = context.size?.width;
    _tooltipController5.toggle();
    _tooltipController2.hide();
    _tooltipController.hide();
    _tooltipController3.hide();
    _tooltipController4.hide();
    // _tooltipController5.hide();
  }
}
