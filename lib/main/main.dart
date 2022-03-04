import 'package:eh_flutter_framework/main/common/i18n/customSfLocalization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/Utils/theme.dart';
import 'common/i18n/fallback_localization_delegate.dart';
import 'common/i18n/messages.dart';
import 'common/utils/ThemeController.dart';
import 'components/home/components/error/PageNotFound.dart';
import 'controllers/global_data_controller.dart';
import 'routes/page_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(GetMaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      // ... app-specific localization delegate[s] here
      //SfGlobalLocalizations.delegate,
      CustomSfLocalizationDelegate(),
      FallbackLocalizationDelegate()
    ],
    supportedLocales: [
      const Locale('en'),
      const Locale('zh'),
      // ... other locales the app supports
    ],
    debugShowCheckedModeBanner: false,
    theme: EhTheme.lightTheme,
    darkTheme: EhTheme.darkTheme,
    themeMode: ThemeMode.dark,
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
    Get.put(ThemeController(), permanent: true);
    Get.put(GlobalDataController(), permanent: true);
  }
}
