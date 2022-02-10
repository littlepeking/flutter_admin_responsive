import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'components/receipt/receipt_edit.dart';
import 'components/receipt/receipt_edit_controller.dart';

class WmsPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  TreeController sideMenuTreeController =
      new TreeController(allNodesExpanded: false);

  List<EHTreeNode> get menu => [
        EHTreeNode(
          menuName: "Inbound",
          children: [
            EHTreeNode(
                menuName: "Asn",
                icon: Icons.note_alt,
                onTap: () {
                  tabViewController.addTab(EHTab<ReceiptEditController>(
                      'Asn', ReceiptEditController(),
                      (EHController controller) {
                    return ReceiptEdit(controller: controller);
                  }, closable: true));
                }),
            EHTreeNode(
                menuName: "Asn Details",
                icon: Icons.summarize,
                onTap: () {
                  tabViewController.addTab(
                      EHTab<TestController>('Asn Details', TestController(),
                          (EHController controller) {
                    return Test2(controller: controller);
                  }, closable: true));
                }),
          ],
        ),
        EHTreeNode(
          menuName: "Outbound",
          children: [
            EHTreeNode(icon: Icons.note_alt, menuName: "Orders"),
            EHTreeNode(icon: Icons.summarize, menuName: "Order Details"),
            EHTreeNode(
                icon: Icons.format_list_bulleted, menuName: "Pick Details"),
          ],
        ),
      ];

  reset() {
    tabViewController.reset();
  }
}
