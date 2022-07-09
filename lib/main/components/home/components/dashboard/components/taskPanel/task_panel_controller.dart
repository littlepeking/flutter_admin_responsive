import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/tree_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TaskPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  TreeController sideMenuTreeController =
      new TreeController(allNodesExpanded: false);

  List<EHTreeNode> get menu => [
        EHTreeNode(
            displayName: "Tasks", icon: Icons.access_alarm, onTap: () {}),
        EHTreeNode(
            displayName: "Notifications",
            icon: Icons.access_alarm,
            onTap: () {}),
      ];

  reset() {
    tabViewController.reset();
  }
}
