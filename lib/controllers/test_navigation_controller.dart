import 'package:admin/routing/routes.dart';
import 'package:admin/screens/dashboard/components/test.dart';
import 'package:admin/screens/dashboard/components/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestNavigationController extends GetxController {
  static TestNavigationController instance =
      Get.find<TestNavigationController>();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>(debugLabel: 'test');
  //final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(1);

  Future<dynamic>? navigateTo(String routeName) {
    return navigatorKey.currentState!.popAndPushNamed(routeName);
    //return Get.toNamed(routeName, id: 1);
    //Get.toNamed(routeName,        id: navigatorKey.hashCode); //do not use GET since it can only accept id instead of globalkey
  }

  goBack() => navigatorKey.currentState!.pop();
}

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case mainNavigationMyTestPageRoute:
      return _getPageRoute(settings, Test());
    case mainNavigationMyTestPageRoute2:
      return _getPageRoute(settings, Test2());
    default:
      ;
  }
}

PageRoute _getPageRoute(settings, Widget child) {
  return GetPageRoute(
    settings: settings,
    page: () => child,
    transition: Transition.noTransition,
  );
}
