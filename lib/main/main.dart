import 'dart:async';
import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_exception.dart';
import 'dart:convert';
import 'package:eh_flutter_framework/main/common/i18n/customSfLocalization.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eh_flutter_framework/main/common/Utils/theme.dart';
import 'package:eh_flutter_framework/main/common/i18n/fallback_localization_delegate.dart';
import 'package:eh_flutter_framework/main/common/i18n/messages.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_theme_helper.dart';
import 'package:eh_flutter_framework/main/components/home/components/error/PageNotFound.dart';
import 'package:eh_flutter_framework/main/routes/page_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/utils/theme_custom_attributes.dart';

main() {
  //SOME GetxControllers CANNOT BE PUT HERE (NEED FIGURE IT OUT), OTHERWISE EXCEPTION WILL NOT BE CAUGHT PROPERLY!
  //E.G. Get.put(EHTabsViewController(), permanent: true);
  //////////////////////////////////////////////////////////////
  // disable WidgetsFlutterBinding.ensureInitialized() as it will prevent runZonedGuarded.onerror be triggered.
  // WidgetsFlutterBinding.ensureInitialized();
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
        const Locale('en', 'US'),
        const Locale('zh', 'CN'),
        // ... other locales the app supports
      ],
      debugShowCheckedModeBanner: false,
      theme: EhTheme.lightTheme.copyWith(
          extensions: <ThemeExtension<dynamic>>[ThemeCustomAttributes.light]),
      darkTheme: EhTheme.darkTheme.copyWith(
          extensions: <ThemeExtension<dynamic>>[ThemeCustomAttributes.dark]),
      // AS WidgetsFlutterBinding.ensureInitialized() is disabled, commment following code as it will not work.
      themeMode:
          EHThemeHelper.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      color: Colors.white,
      //home: Home(),
      initialRoute: '/login',
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
    print('Hi, Asynchrounous error encoutered, like dioError');
    if (error is DioError) {
      DioError dioError = error;
      if (dioError.response != null && dioError.response!.data != null) {
        Map data = dioError.response!.data is Map
            ? dioError.response!.data
            : json.decode(dioError.response!.data!);
        // ignore: todo
        //TODO: FORM VALIDATION ERROR
        if (data['status'] != null && data['status'] == 500) {
          EHToastMessageHelper.showInfoMessage(
              'common.error.internalServerError',
              type: EHToastMsgType.Error);
        } else if (data['type'] != null &&
            data['type']
                .toString()
                .startsWith('https://zalando.github.io/problem/')) {
          EHToastMessageHelper.showInfoMessage(data['details'],
              titleMsgKey: data['title'], type: EHToastMsgType.Error);
        } else {
          EHToastMessageHelper.showInfoMessage(data['error'],
              type: EHToastMsgType.Error);
        }
      }
    } else if (error is EHException) {
      EHToastMessageHelper.showInfoMessage(error.message,
          type: EHToastMsgType.Error);
    }
    print("--------------------------------\n");
    print("Error FROM OUT_SIDE FRAMEWORK ");
    print("--------------------------------\n");
    print("++++++++++++++++++++++++++++++++\n");
    print("--------------------------------\n");
    print("Error :  $error");
    print("StackTrace :  $stackTrace");
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    print('Triggers synchronous error');
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
}

class InitAppBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put(GlobalDataController(), permanent: true);
  }
}
