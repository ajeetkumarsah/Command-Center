import 'package:flutter/material.dart';

class TextPopup extends StatelessWidget {
  final TextEditingController textController;

  const TextPopup({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter New Text'),
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: 'Enter new text...'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Update'),
        ),
      ],
    );
  }
}
