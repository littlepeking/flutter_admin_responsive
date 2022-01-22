import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/theme.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardNavigationController extends GetxController {
  static DashBoardNavigationController instance =
      Get.find<DashBoardNavigationController>();

  // final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(2);

//   Future<dynamic>? navigateTo(String routeName) {
//     return Get.toNamed(routeName, id: 2);
//     //Get.toNamed(routeName, id: GlobalKey().hashCode);  //do not use GET since it can only accept id instead of globalkey
//   }

//   goBack() => navigatorKey!.currentState!.pop();
// }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>(debugLabel: 'dashboard');
  //final GlobalKey<NavigatorState>? navigatorKey = Get.nestedKey(1);

  Future<dynamic>? navigateTo(String routeName) {
    navigatorKey.currentState!.popAndPushNamed(routeName);
    if (Responsive.isMobile(Get.context!) || Responsive.isTablet(Get.context!))
      Get.back();
    //return Get.toNamed(routeName, id: 1);
    //Get.toNamed(routeName,        id: navigatorKey.hashCode); //do not use GET since it can only accept id instead of globalkey
  }
}

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/wmsPanel":
      return _getPageRoute(settings, WmsPanelWidget());
    case "/myTasks":
      return _getPageRoute(settings, MyTasks());
    default:
    //  return _getPageRoute(settings, WmsPanelWidget()); 不能写DEFAULT,因为多级导航时，父路径'/'也会在此进行遍历。可能是FLUTTER BUG，导致重复创建路由，报错：Multiple widgets used the same GlobalKey。
  }
}

PageRoute _getPageRoute(settings, Widget child) {
  return GetPageRoute(
    settings: settings,
    page: () => child,
    transition: EhTheme.defaultTransition,
  );
}
