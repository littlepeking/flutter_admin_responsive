import 'package:eh_flutter_framework/main/common/Utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHNavigator {
  static navigateTo(int navigatorKey, String routeName) {
    Get.offAndToNamed(routeName, id: navigatorKey);

    //   Future<dynamic>? navigateTo(String routeName) {
    //     return Get.toNamed(routeName, id: 2);
    //     //Get.toNamed(routeName, id: GlobalKey().hashCode);  //do not use GET since it can only accept id instead of globalkey
    //   }
    /*
        Navigator.push(
        context,
        MaterialPageRoute(
        opaque: false, builder: (BuildContext context) => NextScreen()));
    */

    if (Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
    //return Get.toNamed(routeName, id: 1);
    //Get.toNamed(routeName,        id: navigatorKey.hashCode); //do not use GET since it can only accept id instead of globalkey
  }

  goBack(int navigatKey) => Get.nestedKey(navigatKey)!.currentState!.pop();

  static PageRoute getPageRoute(settings, Widget child) {
    return GetPageRoute(
        settings: settings,
        page: () => child,
        transition: EhTheme.defaultTransition,
        opaque: false);
  }
}
