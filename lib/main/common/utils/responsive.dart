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

class Responsive {
  static RxBool _isKeyboardShown = false.obs;

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static bool isExtraSmall(BuildContext context) {
    return MediaQuery.of(context).size.height < 500;
  }

  static bool isKeyboardShown(BuildContext context) {
    return _isKeyboardShown.value;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double dialogWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (isMobile(context)) return screenWidth;

    return screenWidth > 1500 ? 1500 * 2 / 3 : screenWidth * 2 / 3;
  }

  static double dialogHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    if (isMobile(context)) return screenHeight;

    return screenHeight > 800 ? 800 * 2 / 3 : screenHeight * 2 / 3;
  }
}
