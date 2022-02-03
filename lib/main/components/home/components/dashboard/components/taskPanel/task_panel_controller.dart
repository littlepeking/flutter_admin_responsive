import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TaskPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  TreeController sideMenuTreeController =
      new TreeController(allNodesExpanded: false);

  List<EHTreeNode> get menu => [
        EHTreeNode(menuName: "Tasks", icon: Icons.access_alarm, onTap: () {}),
        EHTreeNode(
            menuName: "Notifications", icon: Icons.access_alarm, onTap: () {}),
      ];

  reset() {
    tabViewController.reset();
  }
}
