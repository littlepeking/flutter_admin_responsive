import 'package:admin/controllers/test_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:admin/screens/page_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Services/theme.dart';
import 'controllers/menu_controller.dart';
import 'controllers/main_navigation_controller.dart';
import 'screens/error/PageNotFound.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: EhTheme.lightTheme,
    darkTheme: EhTheme.darkTheme,
    color: Colors.white,
    //home: Home(),
    initialRoute: rootRoute,
    unknownRoute: GetPage(
        name: '/not-found',
        page: () => PageNotFound(),
        transition: EhTheme.defaultTransition),
    getPages: pageConfig,
    initialBinding: InitAppBinding(),
  ));
}

class InitAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    Get.lazyPut<TestNavigationController>(() => TestNavigationController());
  }
}
