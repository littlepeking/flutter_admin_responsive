import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_list.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_list_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  TreeController sideMenuTreeController =
      new TreeController(allNodesExpanded: false);

  List<EHTreeNode> get menu => [
        EHTreeNode(
          menuName: "Security",
          children: [
            EHTreeNode(
                menuName: "User",
                icon: Icons.note_alt,
                onTap: () {
                  tabViewController.addTab(EHTab<UserListController>(
                      'User', UserListController(), (EHController controller) {
                    return UserList(controller: controller);
                  },
                      closable: true,
                      expandMode: EHTabsViewExpandMode.Growable));
                  // FocusManager.instance.primaryFocus?.unfocus();
                }),
            EHTreeNode(
                menuName: "Role",
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
