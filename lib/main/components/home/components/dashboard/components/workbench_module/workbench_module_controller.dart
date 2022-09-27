import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
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
            displayNameMsgKey: 'common.general.notification',
            icon: Icons.notifications,
            children: []),
        EHTreeNode(
            displayNameMsgKey: 'common.general.alert',
            icon: Icons.alarm,
            children: [
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
