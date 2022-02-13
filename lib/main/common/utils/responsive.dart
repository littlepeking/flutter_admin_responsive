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
}
