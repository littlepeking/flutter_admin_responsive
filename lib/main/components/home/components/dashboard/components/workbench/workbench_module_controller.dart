import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_tree_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_tree_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_tree_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/org_role_list_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/org_role_list_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_list_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class WorkbenchModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
      showCheckBox: false,
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
            displayName: "Master Data", icon: Icons.museum, children: []),
        EHTreeNode(
            displayName: "Security",
            icon: Icons.admin_panel_settings,
            children: [
              EHTreeNode(
                  permissionCodes: {'SECURITY_PERMISSION'},
                  displayName: "Organization",
                  isChecked: true,
                  onTap: () async {
                    // FocusManager.instance.primaryFocus?.unfocus();
                  }),
              EHTreeNode(
                  // permissionCodes: {'SECURITY_USER'},
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
                  permissionCodes: {'SECURITY_ROLE'},
                  displayName: "Role",
                  onTap: () async {
                    tabViewController.addTab(EHTab<OrgRoleListController>(
                        'Role', await OrgRoleListController.create(),
                        (EHController controller) {
                      return OrgRoleListView(controller: controller);
                    }, closable: true, expandMode: EHTabsViewExpandMode.None));
                  },
                  children: []),
              EHTreeNode(
                  permissionCodes: {'SECURITY_PERMISSION'},
                  displayName: "Permission",
                  onTap: () async {
                    tabViewController.addTab(EHTab<PermissionTreeController>(
                        'Permission', await PermissionTreeController.create(),
                        (EHController controller) {
                      return PermissionTreeView(controller: controller);
                    },
                        closable: true,
                        expandMode: EHTabsViewExpandMode.Expand));
                  },
                  children: [])
            ]),
      ].obs);

  reset() {
    tabViewController.reset();
  }
}
