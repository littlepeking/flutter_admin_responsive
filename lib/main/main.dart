import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/Utils/theme.dart';
import '../common/i18n/messages.dart';
import 'components/home/components/error/PageNotFound.dart';
import 'components/home/components/dashboard/controllers/main_panel_navigation_controller.dart';
import 'controllers/menu_controller.dart';
import 'components/home/components/dashboard/components/mainPanel/controllers/test_navigation_controller.dart';
import 'routes/page_config.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: EhTheme.lightTheme,
    darkTheme: EhTheme.darkTheme,
    color: Colors.white,
    //home: Home(),
    initialRoute: '/',
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
    Get.lazyPut<MainPanelNavigationController>(
        () => MainPanelNavigationController());
    Get.lazyPut<TestNavigationController>(() => TestNavigationController());
  }
}
