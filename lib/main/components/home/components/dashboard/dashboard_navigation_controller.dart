import 'package:eh_flutter_framework/main/common/Utils/eh_navigator.dart';
import 'package:eh_flutter_framework/main/common/constants/map_constant.dart';
import 'package:eh_flutter_framework/main/common/constants/navigation_keys.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wms_module/wms_module.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/workbench_module/workbench_module.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/tms_module/tms_module.dart';

class DashBoardNavigationController extends GetxController {
  static DashBoardNavigationController instance =
      Get.find<DashBoardNavigationController>();

  final GlobalKey<NavigatorState>? navigatorKey =
      Get.nestedKey(NavigationKeys.dashBoardNavKey);

  Route? generateRoute(RouteSettings settings) {
    if (settings.name == MapConstant.systemModuleRoute[SystemModule.wms])
      return EHNavigator.getPageRoute(settings, WmsModuleWidget());
    else if (settings.name == MapConstant.systemModuleRoute[SystemModule.tms])
      return EHNavigator.getPageRoute(settings, TmsModuleWidget());
    else if (settings.name ==
        MapConstant.systemModuleRoute[SystemModule.system])
      return EHNavigator.getPageRoute(settings, SystemModuleWidget());
    else if (settings.name ==
        MapConstant.systemModuleRoute[SystemModule.workbench])
      return EHNavigator.getPageRoute(settings, WorkbenchModuleWidget());
    else
      return null;
    //  return _getPageRoute(settings, WmsModuleWidget()); 不能写DEFAULT,因为多级导航时，父路径'/'也会在此进行遍历。可能是FLUTTER BUG，导致重复创建路由，报错：Multiple widgets used the same GlobalKey。
  }
}
