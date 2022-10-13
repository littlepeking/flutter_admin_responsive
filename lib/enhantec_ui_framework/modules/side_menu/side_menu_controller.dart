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
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/eh_module_manager.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_context_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_view.dart';
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

  EHTreeController getSideMenuController(String module) {
    return EHModuleManager
        .systemModuleMap[module]!.controller.moduleSideMenuTreeController;

    // switch (system) {

    //   case SystemModule.wms:
    //     return Get.find<WmsModuleController>().moduleSideMenuTreeController;
    //   case SystemModule.tms:
    //     return Get.find<TmsModuleController>().moduleSideMenuTreeController;
    //   case SystemModule.system:
    //     return Get.find<SystemModuleController>().moduleSideMenuTreeController;
    //   case SystemModule.workbench:
    //     return Get.find<WorkbenchModuleController>()
    //         .moduleSideMenuTreeController;
    //   default:
    //     throw Exception('Side menu not found for module: ' + system.toString());
    // }
  }

  EHTreeView getSideBarTreeView() {
    EHTreeController controller =
        getSideMenuController(EHContextHelper.currentModuleId.value);

    return EHTreeView(
        key: GlobalKey(debugLabel: EHContextHelper.currentModuleId.value),
        controller: controller);
  }
}
