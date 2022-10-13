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
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_panel_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_toast_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/components/org_tree_component.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/components/org_tree_component_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/permission/components/perm_tree_component_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../org/organization_service.dart';
import 'permission_detail_view.dart';
import 'permission_detail_view_controller.dart';
import 'permission_model.dart';
import 'permission_service.dart';

class PermissionTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late PermTreeComponentController permTreeCompController;

  Rx<PermissionModel?> permissionModel = Rxn<PermissionModel>();

  late EHTabsViewController detailTabsViewController;

  late PermissionDetailViewController permissionDetailViewController;

  late OrgTreeComponentController orgTreeComponentController;

  PermissionTreeController._create(EHPanelController? parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<PermissionTreeController> create() async {
    PermissionTreeController self = PermissionTreeController._create(null);

    self.permissionDetailViewController =
        await PermissionDetailViewController.create(self);

    self.permTreeCompController = await PermTreeComponentController.create(self,
        isNodeSelectable: true, onTapNode: (selectedPermModel) async {
      if (self.permissionModel.value != null &&
          self.permissionDetailViewController.detailViewFormController != null)
        self.permissionDetailViewController.detailViewFormController!.reset();

      self.permissionModel.value = selectedPermModel;
      await self.refreshPermDetailData();
    });

    self.orgTreeComponentController =
        await OrgTreeComponentController.create(self, showCheckBox: true);

    await self.refreshPermTreeData();

    self.detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('detailInfo', 'common.general.detailInfo',
          self.permissionDetailViewController, (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: PermissionDetailView(
              controller: c,
            ));
      }),

      EHTab(
        'organizations',
        'common.security.organizations',
        self.orgTreeComponentController,
        (controller) => OrgTreeComponent(
          controller: self.orgTreeComponentController,
        ),
      ),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    return self;
  }

  refreshPermTreeData({String? overrideSelectedTreeNodeId}) async {
    List treeMapData = await PermissionService().buildTree();

    await permTreeCompController.reloadPermTreeData(treeMapData,
        overrideSelectedTreeNodeId: overrideSelectedTreeNodeId);
  }

  refreshOrgTreeData(String permissionId) async {
    List treeMapData =
        await OrganizationService().buildTreeByPermId(permissionId);
    await orgTreeComponentController.reloadOrgTreeData(treeMapData);
  }

  refreshPermDetailData() async {
    permissionModel.refresh();
    if (permissionModel.value != null && permissionModel.value!.id != null) {
      await refreshOrgTreeData(permissionModel.value!.id!);

      if (permissionModel.value!.type == 'D') {
        detailTabsViewController.getTab('organizations').isHide = true;
        detailTabsViewController.selectedTab =
            detailTabsViewController.getTab('detailInfo');
      } else {
        detailTabsViewController.getTab('organizations').isHide = false;
      }
    } else {
      detailTabsViewController.selectedTab =
          detailTabsViewController.getTab('detailInfo');
      detailTabsViewController.getTab('organizations').isHide = true;
    }

    permissionDetailViewController.detailViewFormController?.reset();
    detailTabsViewController.tabsConfig.refresh();
  }

  Future<void> savePermDetailView() async {
    if (await permissionDetailViewController.detailViewFormController!
        .validate()) {
      permissionModel.value =
          await PermissionService().save(permissionModel.value!);

      await updatePermissionOrgIds(permissionId: permissionModel.value!.id!);

      await refreshPermTreeData(
          overrideSelectedTreeNodeId: permissionModel.value!.id!);
      await refreshPermDetailData();
    }

    EHToastMessageHelper.showInfoMessage('common.general.saved');
  }

  Future<void> deleteSelectedPerm() async {
    await PermissionService().deleteByIds([
      permTreeCompController.permTreeController.selectedTreeNode.value!.id!
    ]);
    await refreshPermTreeData(overrideSelectedTreeNodeId: '0');

    permissionModel.value = null;

    EHToastMessageHelper.showInfoMessage('common.general.deleted');
  }

  Future<List> updatePermissionOrgIds({required String permissionId}) async {
    List<EHTreeNode> treeNodeList = orgTreeComponentController.orgTreeController
        .getAllFilteredNodes((node) => node.isChecked == true);

    List<String> orgIds = treeNodeList.map((e) => e.id!).toList();

    List treeMapData =
        await PermissionService().updatePermissionOrgs(permissionId, orgIds);

    return treeMapData;
  }
}
