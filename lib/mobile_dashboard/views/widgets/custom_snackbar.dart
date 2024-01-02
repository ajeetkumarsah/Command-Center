import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/utils/dimensions.dart';

void showCustomSnackBar(String message,
    {bool isError = true, bool isBlack = false}) {
  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: isBlack
          ? Colors.black
          : isError
              ? Colors.red
              : Colors.green,
      message: message,
      maxWidth: Dimensions.WEB_MAX_WIDTH,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      borderRadius: Dimensions.RADIUS_SMALL,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}
