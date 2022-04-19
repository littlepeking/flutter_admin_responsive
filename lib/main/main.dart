import 'dart:async';
import 'package:eh_flutter_framework/main/common/i18n/customSfLocalization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eh_flutter_framework/main/common/Utils/theme.dart';
import 'package:eh_flutter_framework/main/common/i18n/fallback_localization_delegate.dart';
import 'package:eh_flutter_framework/main/common/i18n/messages.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/error/PageNotFound.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:eh_flutter_framework/main/routes/page_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    //this line prints the default flutter gesture caught exception in console
    FlutterError.dumpErrorToConsole(details, forceReport: true);
    print("--------------------------------");
    print("Error From INSIDE FRAME_WORK");
    print("----------------------");
    print("++++++++++++++++++++++");
    print("----------------------");
    print("Error :  ${details.exception}");
    print("StackTrace :  ${details.stack}");
  };
  runZonedGuarded(() async {
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
      locale:
          Locale('zh', 'CN'), // translations will be displayed in that locale
      fallbackLocale: Locale('en', 'US'),
    )); // starting point of app
  }, (error, stackTrace) {
    print("--------------------------------\n");
    print("Error FROM OUT_SIDE FRAMEWORK ");
    print("--------------------------------\n");
    print("++++++++++++++++++++++++++++++++\n");
    print("--------------------------------\n");
    print("Error :  $error");
    print("StackTrace :  $stackTrace");
  });
}

class InitAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(GlobalDataController(), permanent: true);
  }
}
