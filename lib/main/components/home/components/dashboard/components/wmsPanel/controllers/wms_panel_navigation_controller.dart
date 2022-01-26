import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/Utils/theme.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/TestComponent/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WmsPanelNavigationController extends GetxController {
  static WmsPanelNavigationController instance =
      Get.find<WmsPanelNavigationController>();

  var count = 0.obs;

  var isDarkMode = true.obs;

  var pageIndex = 0.obs;

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>(debugLabel: 'test');
  //final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(1);

  Future<dynamic>? navigateTo(String routeName) {
    navigatorKey.currentState!.popAndPushNamed(routeName);
    if (Responsive.isMobile(Get.context!) || Responsive.isTablet(Get.context!))
      Get.back();
    //return Get.toNamed(routeName, id: 1);
    //Get.toNamed(routeName,        id: navigatorKey.hashCode); //do not use GET since it can only accept id instead of globalkey
  }

  goBack() => navigatorKey.currentState!.pop();

  @override
  onClose() {
    print("close wms panel controller...");
  }
}

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/myTest':
      return _getPageRoute(settings, Test());
    // case "/myTest2":
    //   return _getPageRoute(settings, Test2());
    default:
  }
}

PageRoute _getPageRoute(settings, Widget child) {
  return GetPageRoute(
    settings: settings,
    page: () => child,
    transition: EhTheme.defaultTransition,
  );
}
