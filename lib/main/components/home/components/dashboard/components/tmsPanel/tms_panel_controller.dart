import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TmsPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  TreeController sideMenuTreeController =
      new TreeController(allNodesExpanded: false);

  List<EHTreeNode> get menu => [
        EHTreeNode(
          menuName: "Transport Management",
          children: [
            EHTreeNode(
                menuName: "Shipment Orders",
                icon: Icons.access_alarm,
                onTap: () {
                  tabViewController.addTab(
                      (EHTab('Shipment Orders', TestController(),
                          (TestController controller) {
                    return Test2(controller: controller);
                  }, closable: true)));
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
