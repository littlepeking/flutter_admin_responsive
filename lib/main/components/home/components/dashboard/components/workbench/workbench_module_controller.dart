import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
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
            displayName: "Notifications",
            icon: Icons.notifications,
            children: []),
        EHTreeNode(displayName: "Alerts", icon: Icons.alarm, children: [
          // EHTreeNode(
          //     permissionCodes: {'SECURITY_PERMISSION'},
          //     displayName: "Permission",
          //     onTap: () async {
          //       tabViewController.addTab(EHTab<PermissionTreeController>(
          //           'Permission', await PermissionTreeController.create(),
          //           (EHController controller) {
          //         return PermissionTreeView(controller: controller);
          //       }, closable: true, expandMode: EHTabsViewExpandMode.Expand));
          //     },
          //     children: [])
        ]),
      ].obs);

  reset() {
    tabViewController.reset();
  }
}
