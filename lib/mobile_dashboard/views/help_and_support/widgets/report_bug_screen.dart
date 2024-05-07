import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:command_centre/mobile_dashboard/utils/app_colors.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/photo_gride.dart';
import 'package:command_centre/mobile_dashboard/controllers/home_controller.dart';
import 'package:command_centre/mobile_dashboard/views/widgets/custom_snackbar.dart';


class ReportBugScreen extends StatefulWidget {
  const ReportBugScreen({super.key});

  @override
  State<ReportBugScreen> createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends State<ReportBugScreen> {
  List<File> files = [];
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  void pickMultiImages() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> _files = result.paths.map((path) => File(path!)).toList();
      files = _files;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeRepo: Get.find()),
      builder: (ctlr) {
        return Scaffold(
          backgroundColor: AppColors.white,
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
              'Report a bug',
              style: GoogleFonts.ptSansCaption(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                  child: TextFormField(
                    controller: titleController,
                    // maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      labelText: 'Title',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: commentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Comments',
                      // labelText: 'Comments',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: .5, color: AppColors.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                if (files.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: PhotoGrid(
                      imageUrls: files,
                      onLongPress: () => pickMultiImages(),
                      onImageClicked: (i) => Get.toNamed(
                        AppPages.IMAGE_PREVIEW_WIDGET,
                        arguments: files[i],
                      ),
                      onExpandClicked: () =>
                          Get.toNamed(AppPages.IMAGE_PREVIEW_LIST, arguments: files),
                      maxImages: 4,
                    ),
                  ),
                if (files.isEmpty)
                  GestureDetector(
                    onTap: pickMultiImages,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: .5,
                          color: AppColors.primary,
                        ),
                        color: AppColors.white,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              'Attach file  ',
                              style: GoogleFonts.ptSans(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.attach_file_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () async{
                    if(titleController.text.isNotEmpty && files != [] && commentController.text.isNotEmpty){
                      isLoading = true;
                      await ctlr.postBugReport(title: titleController.text, comment: commentController.text, file: PickedFile(files.first.path));
                      isLoading = false;
                      Get.back();
                    }else{
                      isLoading = true;
                      showCustomSnackBar("Something went wrong",
                          isError: false, isBlack: true);
                      
                      isLoading = false;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: isLoading ?
                    const Center(child: CircularProgressIndicator(color: Colors.white,))
                        :  Center(
                      child: Text(
                        'Submit',
                        style: GoogleFonts.ptSansCaption(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
