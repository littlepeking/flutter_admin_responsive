import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/tree_node_data.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_list_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_list_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  TreeController getsideMenuTreeController = new TreeController(
      showCheckBox: true,
      allNodesExpanded: false,
      treeNodeDataList: [
        EHTreeNodeData(displayName: "Inbound", icon: Icons.login, children: [
          EHTreeNodeData(displayName: "User", icon: Icons.summarize, children: [
            EHTreeNodeData(
                displayName: "Role", icon: Icons.summarize, children: [])
          ])
        ]),
        EHTreeNodeData(displayName: "Outbound", icon: Icons.logout, children: [
          EHTreeNodeData(displayName: "User", icon: Icons.summarize, children: [
            EHTreeNodeData(
                displayName: "Role", icon: Icons.summarize, children: [])
          ])
        ])
      ]);

  List<EHTreeNode> get menuOrigin => [
        EHTreeNode(
          displayName: "Security",
          children: [
            EHTreeNode(
                displayName: "User",
                icon: Icons.note_alt,
                onTap: () {
                  tabViewController.addTab(EHTab<UserListController>(
                      'User List', UserListController(),
                      (EHController controller) {
                    return UserList(controller: controller);
                  },
                      closable: true,
                      expandMode: EHTabsViewExpandMode.Growable));
                  // FocusManager.instance.primaryFocus?.unfocus();
                }),
            EHTreeNode(
                displayName: "Role",
                icon: Icons.summarize,
                onTap: () {
                  tabViewController.addTab(EHTab<TestController>(
                      'Role', TestController(), (EHController controller) {
                    return Test2(controller: controller);
                  }, closable: true));
                }),
          ],
        ),
      ];

  reset() {
    tabViewController.reset();
  }
}
