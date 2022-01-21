import 'package:eh_flutter_framework/common/Utils/theme.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/mainPanel/main_panel.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPanelNavigationController extends GetxController {
  static MainPanelNavigationController instance =
      Get.find<MainPanelNavigationController>();

  // final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(2);

//   Future<dynamic>? navigateTo(String routeName) {
//     return Get.toNamed(routeName, id: 2);
//     //Get.toNamed(routeName, id: GlobalKey().hashCode);  //do not use GET since it can only accept id instead of globalkey
//   }

//   goBack() => navigatorKey!.currentState!.pop();
// }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>(debugLabel: 'main');
  //final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(1);

  Future<dynamic>? navigateTo(String routeName) {
    navigatorKey.currentState!.popAndPushNamed(routeName);
    Get.back();
    //return Get.toNamed(routeName, id: 1);
    //Get.toNamed(routeName,        id: navigatorKey.hashCode); //do not use GET since it can only accept id instead of globalkey
  }
}

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/mainPanel":
      return _getPageRoute(settings, MainPanelWidget());
    case "/myTasks":
      return _getPageRoute(settings, MyTasks());
    default:
    //  return _getPageRoute(settings, MainPanelWidget()); 不能写DEFAULT,因为多级导航时，父路径'/'也会在此进行遍历。可能是FLUTTER BUG，导致重复创建路由，报错：Multiple widgets used the same GlobalKey。
  }
}

PageRoute _getPageRoute(settings, Widget child) {
  return GetPageRoute(
    settings: settings,
    page: () => child,
    transition: EhTheme.defaultTransition,
  );
}
