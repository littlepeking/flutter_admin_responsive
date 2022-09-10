import 'package:eh_flutter_framework/main/common/utils/theme.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/task_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tmsPanel/tms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHNavigator {
  static void logout() {
    preLogout();
    EHNavigator.navigateTo("/login");
  }

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

  static void preLogout() {
    if (Get.isRegistered<SystemModuleController>())
      resetTab(Get.find<SystemModuleController>().tabViewController);
    if (Get.isRegistered<WmsPanelController>())
      resetTab(Get.find<WmsPanelController>().tabViewController);
    if (Get.isRegistered<TmsPanelController>())
      resetTab(Get.find<TmsPanelController>().tabViewController);
    if (Get.isRegistered<TaskPanelController>())
      resetTab(Get.find<TaskPanelController>().tabViewController);

    Get.find<SideMenuController>().reset();
  }

  static void resetTab(EHTabsViewController? c) {
    if (c != null) c.reset();
  }
}
