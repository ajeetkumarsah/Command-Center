import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:command_centre/mobile_dashboard/bindings/home_binding.dart';
import 'package:command_centre/mobile_dashboard/utils/routes/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeBinding().dependencies();
  runApp(
    GetMaterialApp(
      title: "Command Center",
      initialRoute: AppPages.SPLASH_SCREEN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
