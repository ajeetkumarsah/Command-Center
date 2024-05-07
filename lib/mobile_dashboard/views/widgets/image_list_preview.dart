import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';

class ImagePreviewList extends StatelessWidget {
  const ImagePreviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<File> files = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 18,
          ),
        ),
        title: Text(
          'Preview',
          style: GoogleFonts.ptSansCaption(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          File image = files[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: GestureDetector(
              onTap: () =>
                  Get.toNamed(AppPages.IMAGE_PREVIEW_LIST, arguments: image),
              child: Image.file(image),
            ),
          );
        },
      ),
    );
  }
}
