import 'package:command_centre/utils/comman/focusbrand/focusbrand_table.dart';
import 'package:flutter/material.dart';

import '../model/data_table_model.dart';
import '../utils/colors/colors.dart';
import '../utils/comman/app_bar.dart';
import '../utils/comman/focusbrand/focusbrand_category.dart';
import '../utils/comman/focusbrand/focusbrand_channel.dart';
import '../utils/comman/focusbrand/focusbrand_trends.dart';
import '../utils/const/header_text.dart';

class FocusBrandScreen extends StatefulWidget {
  const FocusBrandScreen({Key? key}) : super(key: key);

  @override
  State<FocusBrandScreen> createState() => _FocusBrandScreenState();
}

class _FocusBrandScreenState extends State<FocusBrandScreen> {
  late List<DataTableModel> rowData;
  late bool sort = true;
  var isExpanded = false;

  @override
  void initState() {
    rowData = DataTableModel.getRowsDataFB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: CustumAppBar(title: 'Focus Brand'),
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
                  const HeaderText(title: "Focus Brand Summary | CM"),
                  FocusBrandTable(onTap: () {}, rowData: rowData, sort: sort),
                  const FocusBrandCategory(),
                  const FocusBrandChannel(),
                  FocusBrandTrends(
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
