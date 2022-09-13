import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_custom_attributes.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find<ThemeController>();

  static getThemeColor(Color darkColor, Color lightColor) {
    return instance.isDarkMode.value ? darkColor : lightColor;
  }

  static const defaultIsDarkMode = false;

  var isDarkMode = defaultIsDarkMode.obs;

  static ThemeCustomAttributes getThemeCustomAttributes() {
    return Theme.of(Get.context!).extension<ThemeCustomAttributes>()!;
  }
}
