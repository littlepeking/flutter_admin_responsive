import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'components/TestComponent/test2.dart';

class WmsPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  List<EHTreeNode> get menu => [
        EHTreeNode(
          menuName: "Inbound",
          children: [
            EHTreeNode(
                menuName: "Asn",
                icon: Icons.access_alarm,
                onTap: () {
                  tabViewController.addTab("Asn", Test2(param: '1'),
                      closeable: true);
                }),
            EHTreeNode(
                menuName: "Asn Details",
                icon: Icons.access_alarm,
                onTap: () {
                  tabViewController.addTab("Asn Details", Test2(param: '1'),
                      closeable: true);
                }),
          ],
        ),
        EHTreeNode(
          menuName: "Outbound",
          children: [
            EHTreeNode(menuName: "Orders"),
            EHTreeNode(menuName: "Order Details"),
            EHTreeNode(menuName: "Pick Details"),
          ],
        ),
      ];

  reset() {
    tabViewController.reset();
  }
}
