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
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_module_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:enhantec_platform_ui/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:enhantec_platform_ui/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmsModuleController extends EHModuleController {
  TmsModuleController() {
    moduleTabViewController = EHTabsViewController();

    moduleSideMenuTreeController = EHTreeController(
        allNodesExpanded: true,
        displayMode: !Responsive.isDesktop(Get.context!)
            ? EHTreeDisplayMode.stackMode
            : EHTreeDisplayMode.treeMode,
        treeNodeDataList: [
          EHTreeNode(
            displayNameMsgKey: 'wms.transportManagement',
            icon: Icons.local_shipping,
            children: [
              EHTreeNode(
                  icon: Icons.assignment,
                  displayNameMsgKey: 'wms.shipmentOrders',
                  onTap: () {
                    moduleTabViewController.getOrAddTab((EHTab<TestController>(
                        'shipmentOrders',
                        'wms.shipmentOrders',
                        TestController(), (EHController controller) {
                      return Test2(controller: controller);
                    }, closable: true)));
                  }),
              EHTreeNode(
                icon: Icons.alt_route,
                displayNameMsgKey: 'wms.routes',
                children: [],
              ),
            ],
          ),
        ].obs);
  }
  reset() {
    moduleTabViewController.reset();
  }
}
