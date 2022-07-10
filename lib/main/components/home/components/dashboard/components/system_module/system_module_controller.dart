import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node_data.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_list_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_list_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
          showCheckBox: true,
          allNodesExpanded: false,
          treeNodeDataList: [
            EHTreeNodeData(
                displayName: "Security",
                icon: Icons.login,
                children: [
                  EHTreeNodeData(
                      displayName: "User",
                      icon: Icons.summarize,
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
                  EHTreeNodeData(
                      displayName: "Role",
                      icon: Icons.summarize,
                      onTap: () {
                        tabViewController.addTab(
                            EHTab<TestController>('Role', TestController(),
                                (EHController controller) {
                          return Test2(controller: controller);
                        }, closable: true));
                      },
                      children: [])
                ]),
          ]);

  reset() {
    tabViewController.reset();
  }
}
