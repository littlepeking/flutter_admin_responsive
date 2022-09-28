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

import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmsModuleController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  EHTreeController get sideMenuTreeController => EHTreeController(
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
          displayNameMsgKey: 'wms.transportManagement',
          children: [
            EHTreeNode(
                icon: Icons.assignment,
                displayNameMsgKey: 'wms.shipmentOrders',
                onTap: () {
                  tabViewController.addTab((EHTab<TestController>(
                      'shipmentOrders', 'wms.shipmentOrders', TestController(),
                      (EHController controller) {
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

  reset() {
    tabViewController.reset();
  }
}
