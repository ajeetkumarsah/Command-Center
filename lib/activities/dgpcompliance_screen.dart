import 'package:flutter/material.dart';

import '../model/data_table_model.dart';
import '../utils/colors/colors.dart';

import '../utils/comman/app_bar.dart';
import '../utils/comman/dgp_compliance/dgp_category.dart';
import '../utils/comman/dgp_compliance/dgp_channel.dart';
import '../utils/comman/dgp_compliance/dgp_table.dart';
import '../utils/comman/dgp_compliance/dgp_trends.dart';
import '../utils/const/header_text.dart';

class DGPComplianceScreen extends StatefulWidget {
  const DGPComplianceScreen({Key? key}) : super(key: key);

  @override
  State<DGPComplianceScreen> createState() => _DGPComplianceScreenState();
}

class _DGPComplianceScreenState extends State<DGPComplianceScreen> {
  late List<DataTableModel> rowData;
  var isExpanded = false;

  @override
  void initState() {
    rowData = DataTableModel.getRowsDataGP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: CustumAppBar(title: 'DGP Compliance'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/app_bar/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(title: "Golden Points Summary | P3M"),
                  DGPTable(rowData: rowData),
                  const DGPCategory(),
                  const DGPChannel(),
                  DGPTrends(
                    isExpanded: isExpanded,
                    onExpansionChanged: (bool expanded) {
                      setState(() => isExpanded = expanded);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
