import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/more/controllers/theme_controller.dart';

void main() {
  final ThemeController themeController = Get.put(ThemeController());
  
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}
