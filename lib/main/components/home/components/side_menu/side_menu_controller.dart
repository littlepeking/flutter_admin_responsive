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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_panel_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:enhantec_platform_ui/main/common/constants/constants.dart';
import 'package:enhantec_platform_ui/main/common/utils/context_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/system_module_controller.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/workbench_module/workbench_module_controller.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/wms_module/wms_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuController extends EHPanelController {
  static SideMenuController instance = Get.find<SideMenuController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SideMenuController(EHPanelController? parentController)
      : super(parentController);

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void toggleDrawer() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  EHTreeController getSideMenuController(SystemModule system) {
    switch (system) {
      case SystemModule.wms:
        return Get.find<WmsModuleController>().sideMenuTreeController;
      case SystemModule.tms:
        return Get.find<TmsModuleController>().sideMenuTreeController;
      case SystemModule.system:
        return Get.find<SystemModuleController>().sideMenuTreeController;
      case SystemModule.workbench:
        return Get.find<WorkbenchModuleController>().sideMenuTreeController;
      default:
        throw Exception('Side menu not found for module: ' + system.toString());
    }
  }

  EHTreeView getSideBarTreeView() {
    EHTreeController controller =
        getSideMenuController(ContextHelper.currentModule.value);

    return EHTreeView(
        key: GlobalKey(debugLabel: ContextHelper.currentModule.value.name),
        controller: controller);
  }
}
