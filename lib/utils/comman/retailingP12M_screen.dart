import 'dart:convert';

import 'package:flutter/material.dart';

import '../../helper/http_call.dart';
import '../../model/retailingp12m_data_model.dart';

class RetailingP12MScreen extends StatefulWidget {
  const RetailingP12MScreen({Key? key}) : super(key: key);

  @override
  State<RetailingP12MScreen> createState() => _RetailingP12MScreenState();
}

class _RetailingP12MScreenState extends State<RetailingP12MScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: fetchRetailingP12M(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            else{
              final appData = snapshot.data!;
              return ListView.builder(
                itemCount: appData.length,
                  itemBuilder: (context, index){
                  var retailingP12MModel = retailingP12MModelToJson(appData[index]);
                  var decodedJson = RetailingP12MModel.fromJson(jsonDecode(retailingP12MModel));
                  List<Widget> rowWidgets = [
                    Row(
                      children: [
                        Text('Month Year: '),
                        Text(decodedJson.monthYear),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Dist Code: '),
                        Text(decodedJson.distCode),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Primary Branch Code: '),
                        Text(decodedJson.primaryBranchCode),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Region: '),
                        Text(decodedJson.region),
                      ],
                    ),
                    Row(
                      children: [
                        Text('State Name: '),
                        Text(decodedJson.stateName),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Site Name: '),
                        Text(decodedJson.siteName),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Channel Name: '),
                        Text(decodedJson.channelName),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Owning Brand: '),
                        Text(decodedJson.owningBrand),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Brand Name: '),
                        Text(decodedJson.brandName),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Brand Form Name: '),
                        Text(decodedJson.brandformName),
                      ],
                    ),
                    Row(
                      children: [
                        Text('SBF Name: '),
                        Text(decodedJson.sbfName),
                      ],
                    ),
                    Row(
                      children: [
                        Text('P-Code: '),
                        Text(decodedJson.pcode),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Retailing: '),
                        Text(decodedJson.retailing.toString()),
                      ],
                    ),
                  ];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: rowWidgets,
                        ),
                      ),
                    );
              });
            }
          },
        ),
      ),
    );
  }
}
