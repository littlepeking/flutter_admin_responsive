import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node_data.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';

import 'components/receipt/receipt_edit.dart';
import 'components/receipt/receipt_edit_controller.dart';

class WmsPanelController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController sideMenuTreeController =
      new EHTreeController(allNodesExpanded: false);

  List<EHTreeNodeData> get menu => [
        // EHTreeNode(
        //   icon: Icons.login,
        //   displayName: "Inbound",
        //   children: [
        //     EHTreeNode(
        //         displayName: "Asn",
        //         onTap: () {
        //           tabViewController.addTab(EHTab<ReceiptEditController>(
        //               'Asn', ReceiptEditController(),
        //               (EHController controller) {
        //             return ReceiptEdit(controller: controller);
        //           }, closable: true));
        //           // FocusManager.instance.primaryFocus?.unfocus();
        //         }),
        //     EHTreeNode(
        //         displayName: "Asn Details",
        //         onTap: () {
        //           tabViewController.addTab(
        //               EHTab<TestController>('Asn Details', TestController(),
        //                   (EHController controller) {
        //             return Test2(controller: controller);
        //           }, closable: true));
        //         },
        //         children: [
        //           EHTreeNode(
        //               displayName: "Asn Details",
        //               onTap: () {
        //                 tabViewController.addTab(EHTab<TestController>(
        //                     'Asn Details', TestController(),
        //                     (EHController controller) {
        //                   return Test2(controller: controller);
        //                 }, closable: true));
        //               }),
        //           EHTreeNode(
        //               displayName: "Asn Details",
        //               onTap: () {
        //                 tabViewController.addTab(EHTab<TestController>(
        //                     'Asn Details', TestController(),
        //                     (EHController controller) {
        //                   return Test2(controller: controller);
        //                 }, closable: true));
        //               },
        //               children: [
        //                 EHTreeNode(
        //                     displayName: "Asn Details",
        //                     onTap: () {
        //                       tabViewController.addTab(EHTab<TestController>(
        //                           'Asn Details', TestController(),
        //                           (EHController controller) {
        //                         return Test2(controller: controller);
        //                       }, closable: true));
        //                     })
        //               ])
        //         ]),
        //   ],
        // ),
        // EHTreeNode(
        //   icon: Icons.logout,
        //   displayName: "Outbound",
        //   children: [
        //     EHTreeNode(displayName: "Orders"),
        //     EHTreeNode(displayName: "Order Details"),
        //     EHTreeNode(displayName: "Pick Details"),
        //   ],
        // ),
      ];

  reset() {
    tabViewController.reset();
  }
}
