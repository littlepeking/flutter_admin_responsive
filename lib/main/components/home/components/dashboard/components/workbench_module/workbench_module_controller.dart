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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkbenchModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  late EHTreeController sideMenuTreeController;

  WorkbenchModuleController() {
    sideMenuTreeController = EHTreeController(
        showCheckBox: false,
        allNodesExpanded: true,
        displayMode: !Responsive.isDesktop(Get.context!)
            ? EHTreeDisplayMode.stackMode
            : EHTreeDisplayMode.treeMode,
        treeNodeDataList: [
          EHTreeNode(
              displayNameMsgKey: 'common.general.notification',
              icon: Icons.notifications,
              children: []),
          EHTreeNode(
              displayNameMsgKey: 'common.general.alert',
              icon: Icons.alarm,
              children: [
                // EHTreeNode(
                //     permissionCodes: {'SECURITY_PERMISSION'},
                //     displayName: "Permission",
                //     onTap: () async {
                //       tabViewController.addTab(EHTab<PermissionTreeController>(
                //           'Permission', await PermissionTreeController.create(),
                //           (EHController controller) {
                //         return PermissionTreeView(controller: controller);
                //       }, closable: true, expandMode: EHTabsViewExpandMode.Expand));
                //     },
                //     children: [])
              ]),
        ].obs);
  }
  reset() {
    tabViewController.reset();
  }
}
