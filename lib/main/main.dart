import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/Utils/theme.dart';
import '../common/i18n/messages.dart';
import 'components/home/components/error/PageNotFound.dart';
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
  void dependencies() {}
}
