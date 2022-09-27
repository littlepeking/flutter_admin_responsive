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

import 'components/security/org/organization_tree_controller.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
      showCheckBox: false,
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
            displayName: 'common.md.masterData',
            icon: Icons.museum,
            children: []),
        EHTreeNode(
            displayName: 'common.security.security',
            icon: Icons.admin_panel_settings,
            children: [
              EHTreeNode(
                  permissionCodes: {'SECURITY_ORG'},
                  displayName: 'common.security.organization',
                  isChecked: true,
                  onTap: () async {
                    tabViewController.addTab(EHTab<OrganizationTreeController>(
                        'organization',
                        'common.security.organization',
                        await OrganizationTreeController.create(),
                        (EHController controller) {
                      return OrganizationTreeView(controller: controller);
                    },
                        closable: true,
                        expandMode: EHTabsViewExpandMode.Expand));
                    // FocusManager.instance.primaryFocus?.unfocus();
                  }),
              EHTreeNode(
                  permissionCodes: {'SECURITY_USER'},
                  displayName: 'common.security.user',
                  isChecked: true,
                  onTap: () {
                    tabViewController.addTab(EHTab<UserListController>(
                        'userList',
                        'common.security.userList',
                        UserListController(), (EHController controller) {
                      return UserList(controller: controller);
                    }, closable: true, expandMode: EHTabsViewExpandMode.None));
                    // FocusManager.instance.primaryFocus?.unfocus();
                  }),
              EHTreeNode(
                  permissionCodes: {'SECURITY_ROLE'},
                  displayName: 'common.security.role',
                  onTap: () async {
                    tabViewController.addTab(EHTab<OrgRoleListController>(
                        'Role',
                        'common.security.role',
                        await OrgRoleListController.create(),
                        (EHController controller) {
                      return OrgRoleListView(controller: controller);
                    }, closable: true, expandMode: EHTabsViewExpandMode.None));
                  },
                  children: []),
              EHTreeNode(
                  permissionCodes: {'SECURITY_PERMISSION'},
                  displayName: 'common.security.permission',
                  onTap: () async {
                    tabViewController.addTab(EHTab<PermissionTreeController>(
                        'Permission',
                        'common.security.permission',
                        await PermissionTreeController.create(),
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
