import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    _updateTheme();
  }

  void toggleTheme() async {
    isDarkMode.toggle();
    _updateTheme();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }

  void _updateTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
