import 'package:eh_flutter_framework/main/common/Utils/EHNavigator.dart';
import 'package:eh_flutter_framework/main/common/constants/NavigationKeys.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/tmsPanel/tms_panel.dart';

class DashBoardNavigationController extends GetxController {
  static DashBoardNavigationController instance =
      Get.find<DashBoardNavigationController>();

  final GlobalKey<NavigatorState>? navigatorKey =
      Get.nestedKey(NavigationKeys.dashBoardNavKey);

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/wmsPanel":
        return EHNavigator.getPageRoute(settings, WmsPanelWidget());
      case "/tmsPanel":
        return EHNavigator.getPageRoute(settings, TmsPanelWidget());
      case "/myTasks":
        return EHNavigator.getPageRoute(settings, MyTasks());
      default:
      //  return _getPageRoute(settings, WmsPanelWidget()); 不能写DEFAULT,因为多级导航时，父路径'/'也会在此进行遍历。可能是FLUTTER BUG，导致重复创建路由，报错：Multiple widgets used the same GlobalKey。
    }
  }
}
