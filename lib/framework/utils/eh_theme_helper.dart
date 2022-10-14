/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

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

  static Color getLightBackgroundColor() {
    //using getThemeColor temporarily as getThemeCustomAttributes().textColor cannot get latest color after testing, we need figure it out in future.
    return getThemeColor(
        Color.fromARGB(255, 62, 62, 62), Color.fromARGB(255, 227, 227, 227));

    //return getThemeCustomAttributes().textColor!;
  }

  static Color getExtraLightBackgroundColor() {
    //using getThemeColor temporarily as getThemeCustomAttributes().textColor cannot get latest color after testing, we need figure it out in future.
    return getThemeColor(Colors.transparent, Color.fromARGB(255, 92, 91, 91));

    //return getThemeCustomAttributes().textColor!;
  }

  static Color getDisableTextColor() {
    return getThemeColor(
        Color.fromARGB(255, 34, 34, 34), Color.fromARGB(255, 216, 216, 216));

    //eturn getThemeCustomAttributes().disableColor!;
  }
}
