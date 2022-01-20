import 'package:admin/common/Utils/theme.dart';
import 'package:admin/common/routing/routes.dart';
import 'package:admin/screens/dashboard/components/main_panel.dart';
import 'package:admin/screens/dashboard/components/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  static MainNavigationController instance =
      Get.find<MainNavigationController>();

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
    case mainNavigationMainPanelPageRoute:
      return _getPageRoute(settings, MainPanelWidget());
    case mainNavigationMyTasksPageRoute:
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
