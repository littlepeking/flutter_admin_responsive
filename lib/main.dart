import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/Utils/theme.dart';
import 'common/controllers/main_navigation_controller.dart';
import 'common/controllers/menu_controller.dart';
import 'common/controllers/test_navigation_controller.dart';
import 'common/i18n/messages.dart';
import 'common/routing/routes.dart';
import 'components/error/PageNotFound.dart';
import 'components/page_config.dart';

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
    translations: Messages(), // your translations
    locale: Locale('zh', 'CN'), // translations will be displayed in that locale
    fallbackLocale: Locale('en', 'US'),
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
