import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final File imageFile = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: Image.file(imageFile)),
    );
  }
}
