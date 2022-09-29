/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_navigator.dart';
import 'package:enhantec_frontend_project/main/common/constants/constants.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/system_module/system_module.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/wms_module/wms_module.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/workbench_module/workbench_module.dart';
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
