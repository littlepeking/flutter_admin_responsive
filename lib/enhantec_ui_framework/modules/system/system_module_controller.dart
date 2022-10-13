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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/organization_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/organization_tree_view.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/permission/permission_tree_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/permission/permission_tree_view.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/role/org_role_list_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/role/org_role_list_view.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/user/user_list_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/user/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemModuleController extends EHController {
  EHTabsViewController tabViewController =
      EHTabsViewController(showScrollArrow: true);

  late EHTreeController sideMenuTreeController;

  SystemModuleController() {
    sideMenuTreeController = EHTreeController(
        showCheckBox: false,
        allNodesExpanded: true,
        displayMode: !Responsive.isDesktop(Get.context!)
            ? EHTreeDisplayMode.stackMode
            : EHTreeDisplayMode.treeMode,
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
                      tabViewController.getOrAddTab(
                          EHTab<OrganizationTreeController>(
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
                      tabViewController.getOrAddTab(EHTab<UserListController>(
                          'userList',
                          'common.security.userList',
                          UserListController(), (EHController controller) {
                        return UserList(controller: controller);
                      },
                          closable: true,
                          expandMode: EHTabsViewExpandMode.None));
                      // FocusManager.instance.primaryFocus?.unfocus();
                    }),
                EHTreeNode(
                    permissionCodes: {'SECURITY_ROLE'},
                    displayNameMsgKey: 'common.security.role',
                    onTap: () async {
                      tabViewController.getOrAddTab(
                          EHTab<OrgRoleListController>(
                              'role',
                              'common.security.role',
                              await OrgRoleListController.create(),
                              (EHController controller) {
                        return OrgRoleListView(controller: controller);
                      },
                              closable: true,
                              expandMode: EHTabsViewExpandMode.None));
                    },
                    children: []),
                EHTreeNode(
                    permissionCodes: {'SECURITY_PERMISSION'},
                    displayNameMsgKey: 'common.security.permission',
                    onTap: () async {
                      tabViewController.getOrAddTab(
                          EHTab<PermissionTreeController>(
                              'permission',
                              'common.security.permission',
                              await PermissionTreeController.create(),
                              (EHController controller) {
                        return PermissionTreeView(controller: controller);
                      },
                              closable: true,
                              expandMode: EHTabsViewExpandMode.Expand));
                    },
                    children: []),
                // EHTreeNode(
                //     displayNameMsgKey: 'testDialog',
                //     onTap: () async {
                //       popupDialog(TextButton(
                //           onPressed: () => popupDialog(Column(
                //                 children: [
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                   Container(
                //                     width: 200,
                //                     color: Colors.red,
                //                     child: TextButton(
                //                         onPressed: () => popupDialog(TextButton(
                //                             onPressed: () => popupDialog(TextButton(
                //                                 onPressed: () => popupDialog(
                //                                     TextButton(
                //                                         onPressed: () => {},
                //                                         child: Text(
                //                                             'popup new dialog1'))),
                //                                 child:
                //                                     Text('popup new dialog2'))),
                //                             child: Text('popup new dialog3'))),
                //                         child: Text('popup new dialog4')),
                //                   ),
                //                 ],
                //               )),
                //           child: Text('popup new dialog5')));
                //     },
                //     children: [])
              ]),
        ].obs);
  }

  // popupDialog(Widget widget) {
  //   EHDialog.showPopupDialog(widget, barrierDismissible: false);
  // }

  reset() {
    tabViewController.reset();
  }
}
