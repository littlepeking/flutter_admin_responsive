import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_custom_attributes.dart';

class EHThemeHelper {
  static EHThemeHelper instance = Get.find<EHThemeHelper>();

  static changeTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    EHThemeHelper.isDarkMode.value = !Get.isDarkMode;
  }

  static getThemeColor(Color darkColor, Color lightColor) {
    return isDarkMode.value ? darkColor : lightColor;
  }

  static RxBool isDarkMode = false.obs;

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
    return getThemeColor(Colors.grey, Colors.grey);

    //eturn getThemeCustomAttributes().disableColor!;
  }
}
