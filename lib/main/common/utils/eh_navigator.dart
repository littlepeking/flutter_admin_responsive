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

import 'package:eh_flutter_framework/main/common/utils/theme.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/workbench_module/workbench_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wms_module/wms_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHNavigator {
  static navigateTo(String routeName, {int? navigatorKey}) {
    Get.offAndToNamed(routeName, id: navigatorKey);

    //   Future<dynamic>? navigateTo(String routeName) {
    //     return Get.toNamed(routeName, id: 2);
    //     //Get.toNamed(routeName, id: GlobalKey().hashCode);  //do not use GET since it can only accept id instead of globalkey
    //   }
    /*
        Navigator.push(
        context,
        MaterialPageRoute(
        opaque: false, builder: (BuildContext context) => NextScreen()));
    */

    // if (Responsive.isMobile(Get.context!) ||
    //     Responsive.isTablet(Get.context!)) {
    //   Get.back();
    // }
    //return Get.toNamed(routeName, id: 1);
    //Get.toNamed(routeName,        id: navigatorKey.hashCode); //do not use GET since it can only accept id instead of globalkey
  }

  static goBack(int navigatKey) =>
      Get.nestedKey(navigatKey)!.currentState!.pop();

  static PageRoute getPageRoute(settings, Widget child) {
    return GetPageRoute(
        settings: settings,
        page: () => child,
        transition: EhTheme.defaultTransition,
        opaque: false);
  }

  static void resetAllModuleTabs() {
    if (Get.isRegistered<SystemModuleController>())
      resetTab(Get.find<SystemModuleController>().tabViewController);
    if (Get.isRegistered<WmsModuleController>())
      resetTab(Get.find<WmsModuleController>().tabViewController);
    if (Get.isRegistered<TmsModuleController>())
      resetTab(Get.find<TmsModuleController>().tabViewController);
    if (Get.isRegistered<WorkbenchModuleController>())
      resetTab(Get.find<WorkbenchModuleController>().tabViewController);
  }

  static void resetTab(EHTabsViewController? c) {
    if (c != null) c.reset();
  }
}
