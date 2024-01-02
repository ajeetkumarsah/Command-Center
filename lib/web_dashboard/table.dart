import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  // Dummy data for the list
  final List<String> items = List.generate(3, (index) => 'Item $index');
  final List<String> items1 = List.generate(30, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.builder Example'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width+100,
          height: 1200,// Adjust width as needed
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: ListView.builder(
                  itemCount: items1.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int inde) {
                    return ListTile(
                      title: Text(items1[inde]),
                      // You can customize the list item here
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width, // Adjust width as needed
                child: ListView.builder(
                  itemCount: items.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 100,
                      child: ListView.builder(
                        itemCount: items1.length,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int inde) {
                          return ListTile(
                            title: Text(items1[inde]),
                            // You can customize the list item here
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
