import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find<ThemeController>();

  static getThemeColor(Color darkColor, Color lightColor) {
    return instance.isDarkMode.value ? darkColor : lightColor;
  }

  var isDarkMode = false.obs;
}
