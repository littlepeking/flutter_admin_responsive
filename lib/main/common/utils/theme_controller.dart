import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_custom_attributes.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find<ThemeController>();

  static getThemeColor(Color darkColor, Color lightColor) {
    return instance.isDarkMode.value ? darkColor : lightColor;
  }

  RxBool isDarkMode = false.obs;

  static ThemeCustomAttributes getThemeCustomAttributes() {
    return Theme.of(Get.context!).extension<ThemeCustomAttributes>()!;
  }

  static Color getTextColor() {
    //using getThemeColor temporarily as getThemeCustomAttributes().textColor cannot get latest color after testing, we need figure it out in future.
    return getThemeColor(Colors.white, Colors.black);

    //return getThemeCustomAttributes().textColor!;
  }

  static Color getBackgroundColor() {
    //using getThemeColor temporarily as getThemeCustomAttributes().textColor cannot get latest color after testing, we need figure it out in future.
    return getThemeColor(Colors.transparent, Colors.transparent);

    //return getThemeCustomAttributes().textColor!;
  }

  static Color getDisableTextColor() {
    return Colors.grey;

    //eturn getThemeCustomAttributes().disableColor!;
  }
}
