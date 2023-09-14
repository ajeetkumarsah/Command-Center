import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/8b8bbcdc-8167-4393-ad2b-d39648667654'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        jsonData = jsonResponse;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData.isEmpty) {
      return Center(child: const CircularProgressIndicator()); // Show a loading indicator
    }

    final List<String> months = jsonData.map<String>((data) {
      return data[0]['month'];
    }).toList();

    final List<List<dynamic>> retailingValues =
        jsonData.map<List<dynamic>>((data) {
      return data[0]['data'].map<dynamic>((item) => item['retailing']).toList();
    }).toList();

    final List<String> months1 = jsonData.map<String>((data) {
      return data[1]['month'];
    }).toList();

    final List<List<dynamic>> retailingValues1 =
        jsonData.map<List<dynamic>>((data) {
      return data[1]['data'].map<dynamic>((item) => item['retailing']).toList();
    }).toList();

    final List<String> months2 = jsonData.map<String>((data) {
      return data[2]['month'];
    }).toList();

    final List<List<dynamic>> retailingValues2 =
        jsonData.map<List<dynamic>>((data) {
      return data[2]['data'].map<dynamic>((item) => item['retailing']).toList();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter DataTable'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            const DataColumn(label: Text('Date')),
            ...months.map((month) => DataColumn(label: Text(month))),
            ...months1.map((month) => DataColumn(label: Text(month))),
            ...months2.map((month) => DataColumn(label: Text(month))),
          ],
          rows: List.generate(31, (index) {
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                ...retailingValues.map((values) {
                  if (index < values.length) {
                    return DataCell(Text(values[index].toString()));
                  } else {
                    return const DataCell(Text(''));
                  }
                }).toList(),
                ...retailingValues1.map((values) {
                  if (index < values.length) {
                    return DataCell(Text(values[index].toString()));
                  } else {
                    return const DataCell(Text(''));
                  }
                }).toList(),
                ...retailingValues2.map((values) {
                  if (index < values.length) {
                    return DataCell(Text(values[index].toString()));
                  } else {
                    return const DataCell(Text(''));
                  }
                }).toList(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
