import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TmsPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  List<EHTreeNode> get menu => [
        EHTreeNode(
          menuName: "Transport Management",
          children: [
            EHTreeNode(
                menuName: "Shipment Orders",
                icon: Icons.access_alarm,
                onTap: () {
                  tabViewController.addTab("Shipment Orders", Test2(param: '1'),
                      closeable: true);
                })
          ],
        ),
        EHTreeNode(
          menuName: "Routes",
          children: [],
        ),
      ];

  reset() {
    tabViewController.reset();
  }
}
