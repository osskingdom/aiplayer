import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/more/controllers/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check and request storage permissions
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    SystemNavigator.pop(); // Exit the app if permission is denied
    return;
  }

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
