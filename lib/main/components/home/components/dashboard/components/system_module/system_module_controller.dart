/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/org/organization_tree_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/org/organization_tree_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/permission/permission_tree_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/permission/permission_tree_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/role/org_role_list_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/role/org_role_list_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/user/user_list_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/user/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  EHTreeController get sideMenuTreeController => EHTreeController(
      showCheckBox: false,
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
            displayNameMsgKey: 'common.md.masterData',
            icon: Icons.museum,
            children: []),
        EHTreeNode(
            displayNameMsgKey: 'common.security.security',
            icon: Icons.admin_panel_settings,
            children: [
              EHTreeNode(
                  permissionCodes: {'SECURITY_ORG'},
                  displayNameMsgKey: 'common.security.organization',
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
                  displayNameMsgKey: 'common.security.user',
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
                  displayNameMsgKey: 'common.security.role',
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
                  displayNameMsgKey: 'common.security.permission',
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
