import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/receipt/receipt_edit.dart';
import 'components/receipt/receipt_edit_controller.dart';

class WmsModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
      showCheckBox: false,
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
          icon: Icons.login,
          displayName: "wms.inbound",
          children: [
            EHTreeNode(
                displayName: 'wms.asn',
                onTap: () {
                  tabViewController.addTab(EHTab<ReceiptEditController>(
                      'asn', 'wms.asn', ReceiptEditController(),
                      (EHController controller) {
                    return ReceiptEdit(controller: controller);
                  }, closable: true));
                  // FocusManager.instance.primaryFocus?.unfocus();
                }),
            EHTreeNode(
                displayName: 'wms.asnDetails',
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
                      displayName: 'wms.asnDetails',
                      onTap: () {
                        tabViewController.addTab(EHTab<TestController>(
                            'asnDetails', 'wms.asnDetails', TestController(),
                            (EHController controller) {
                          return Test2(controller: controller);
                        }, closable: true));
                      }),
                  EHTreeNode(
                      displayName: 'wms.asnDetails',
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
                            displayName: 'wms.asnDetails',
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
          displayName: 'wms.outbound',
          children: [
            EHTreeNode(displayName: 'wms.orders'),
            EHTreeNode(displayName: 'wms.orderDetails'),
            EHTreeNode(displayName: "wms.pickDetails"),
          ],
        ),
      ].obs);

  reset() {
    tabViewController.reset();
  }
}
