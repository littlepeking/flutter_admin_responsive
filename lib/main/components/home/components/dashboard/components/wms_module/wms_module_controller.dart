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
import 'package:enhantec_platform_ui/enhantec_ui_framework/example/receipt/receipt_edit.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/example/receipt/receipt_edit_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:enhantec_platform_ui/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:enhantec_platform_ui/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WmsModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
      showCheckBox: false,
      allNodesExpanded: true,
      displayMode: Responsive.isMobile(Get.context!)
          ? EHTreeDisplayMode.stackMode
          : EHTreeDisplayMode.treeMode,
      treeNodeDataList: [
        EHTreeNode(
          icon: Icons.login,
          displayNameMsgKey: "wms.inbound",
          children: [
            EHTreeNode(
                displayNameMsgKey: 'wms.asn',
                onTap: () {
                  tabViewController.addTab(EHTab<ReceiptEditController>(
                      'asn', 'wms.asn', ReceiptEditController(),
                      (EHController controller) {
                    return ReceiptEdit(controller: controller);
                  }, closable: true));
                  // FocusManager.instance.primaryFocus?.unfocus();
                }),
            EHTreeNode(
                displayNameMsgKey: 'wms.asnDetails',
                icon: Icons.folder,
                onTap: () {
                  tabViewController.addTab(EHTab<TestController>(
                      'asnDetails', 'wms.asnDetails', TestController(),
                      (EHController controller) {
                    return Test2(controller: controller);
                  }, closable: true));
                },
                children: [
                  EHTreeNode(
                      displayNameMsgKey: 'wms.asnDetails',
                      onTap: () {
                        tabViewController.addTab(EHTab<TestController>(
                            'asnDetails', 'wms.asnDetails', TestController(),
                            (EHController controller) {
                          return Test2(controller: controller);
                        }, closable: true));
                      }),
                  EHTreeNode(
                      displayNameMsgKey: 'wms.asnDetails',
                      icon: Icons.folder,
                      onTap: () {
                        tabViewController.addTab(EHTab<TestController>(
                            'asnDetails', 'wms.asnDetails', TestController(),
                            (EHController controller) {
                          return Test2(controller: controller);
                        }, closable: true));
                      },
                      children: [
                        EHTreeNode(
                            displayNameMsgKey: 'wms.asnDetails',
                            onTap: () {
                              tabViewController.addTab(EHTab<TestController>(
                                  'asnDetails',
                                  'wms.asnDetails',
                                  TestController(), (EHController controller) {
                                return Test2(controller: controller);
                              }, closable: true));
                            })
                      ])
                ]),
          ],
        ),
        EHTreeNode(
          icon: Icons.logout,
          displayNameMsgKey: 'wms.outbound',
          children: [
            EHTreeNode(displayNameMsgKey: 'wms.orders'),
            EHTreeNode(displayNameMsgKey: 'wms.orderDetails'),
            EHTreeNode(displayNameMsgKey: "wms.pickDetails"),
          ],
        ),
      ].obs);

  reset() {
    tabViewController.reset();
  }
}
