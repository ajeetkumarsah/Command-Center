import 'package:flutter/material.dart';

class SelectBranchDropdown extends StatefulWidget {
  const SelectBranchDropdown({super.key});

  @override
  State<SelectBranchDropdown> createState() => _SelectMapDropdownState();
}

class _SelectMapDropdownState extends State<SelectBranchDropdown> {
  String? typeofwork;
  final List<String> listtypes = [
    'Full Time, WFH',
    'Part Time, WFH',
    'Full Time, Office',
    'Part Time, Office'
  ];
  String selectedItem = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: DropdownButtonFormField(
        isExpanded: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        value: typeofwork,
        items: listtypes.map((option) {
          return DropdownMenuItem(
            value: option,
            child: const Text("Branch Location"),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            typeofwork = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "please Select subject";
          } else {
            return null;
          }
        },
        // decoration: InputDecoration(
        //   contentPadding:
        //       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        //   filled: true,
        //   fillColor: Colors.white,
        //   border: OutlineInputBorder(
        //     borderSide: const BorderSide(width: 1, color: Colors.black),
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(5),
        //     borderSide: const BorderSide(width: 1, color: Colors.black),
        //   ),
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(5),
        //     borderSide: const BorderSide(width: 1, color: Colors.white),
        //   ),
        //   errorBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(width: 1, color: Colors.white),
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        // ),
      ),
    );
  }
}
