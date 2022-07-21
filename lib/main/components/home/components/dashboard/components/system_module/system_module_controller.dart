import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_tree_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_list_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_list_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

import 'components/security/org/organization_tree_controller.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
      showCheckBox: false,
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
            displayName: "Master Data",
            icon: Icons.admin_panel_settings,
            children: [
              EHTreeNode(
                  displayName: "Organization",
                  isChecked: true,
                  onTap: () {
                    tabViewController.addTab(EHTab<OrganizationTreeController>(
                        'Organization', OrganizationTreeController(),
                        (EHController controller) {
                      return OrganizationTreeView(controller: controller);
                    },
                        closable: true,
                        expandMode: EHTabsViewExpandMode.Flexible));
                    // FocusManager.instance.primaryFocus?.unfocus();
                  }),
            ]),
        EHTreeNode(
            displayName: "Security",
            icon: Icons.admin_panel_settings,
            children: [
              EHTreeNode(
                  displayName: "User",
                  isChecked: true,
                  onTap: () {
                    tabViewController.addTab(EHTab<UserListController>(
                        'User List', UserListController(),
                        (EHController controller) {
                      return UserList(controller: controller);
                    }, closable: true, expandMode: EHTabsViewExpandMode.None));
                    // FocusManager.instance.primaryFocus?.unfocus();
                  }),
              EHTreeNode(
                  displayName: "Role",
                  onTap: () {
                    tabViewController.addTab(EHTab<TestController>(
                        'Role', TestController(), (EHController controller) {
                      return Test2(controller: controller);
                    }, closable: true));
                  },
                  children: [])
            ]),
      ].obs);

  reset() {
    tabViewController.reset();
  }
}
