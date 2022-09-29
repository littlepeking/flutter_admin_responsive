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

import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/components/org_tree_component_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../permission/permission_model.dart';
import '../permission/permission_service.dart';
import 'organization_model.dart';
import 'organization_service.dart';

class OrganizationTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgTreeComponentController orgTreeCompController;

  Rx<OrganizationModel?> orgModel = Rxn<OrganizationModel>();

  late EHTabsViewController detailTabsViewController;

  late OrganizationDetailViewController organizationDetailViewController;

  late PermTreeComponentController permTreeComponentController;

  OrganizationTreeController._create(EHPanelController? parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrganizationTreeController> create() async {
    OrganizationTreeController self = OrganizationTreeController._create(null);

    self.organizationDetailViewController =
        await OrganizationDetailViewController.create(self);

    self.orgTreeCompController = await OrgTreeComponentController.create(self,
        onTap: (selectedOrgModel) {
      if (self.orgModel.value != null &&
          self.organizationDetailViewController.orgDetailViewFormController !=
              null)
        self.organizationDetailViewController.orgDetailViewFormController!
            .reset();

      self.orgModel.value = selectedOrgModel;
      self.refreshOrgDetailData();
    });

    await self.refreshOrgTreeData();

    self.permTreeComponentController =
        await PermTreeComponentController.create(self, showCheckBox: true);

    self.detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('detailInfo', 'common.general.detailInfo',
          self.organizationDetailViewController, (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: OrganizationDetailView(
              controller: c,
            ));
      }),
      EHTab(
        'funcPerms',
        'common.security.funcPerms',
        self.permTreeComponentController,
        (controller) => PermTreeComponent(
          controller: self.permTreeComponentController,
        ),
      ),
    ]);

    return self;
  }

  refreshOrgTreeData({String? overrideSelectedTreeNodeId}) async {
    List treeMapData = await OrganizationService().buildTree();

    await orgTreeCompController.reloadOrgTreeData(treeMapData,
        overrideSelectedTreeNodeId: overrideSelectedTreeNodeId);
  }

  refreshPermissionTreeData(String orgId) async {
    List treeMapData = await PermissionService().buildTreeByOrgId(orgId);
    await permTreeComponentController.reloadPermTreeData(treeMapData);
  }

  refreshOrgDetailData() async {
    orgModel.refresh();
    if (orgModel.value != null && orgModel.value!.id != null) {
      await refreshPermissionTreeData(orgModel.value!.id!);
      await organizationDetailViewController.initData();

      detailTabsViewController.getTab('funcPerms').isHide = false;
    } else {
      detailTabsViewController.selectedTab =
          detailTabsViewController.getTab('detailInfo');
      detailTabsViewController.getTab('funcPerms').isHide = true;
    }
    organizationDetailViewController.orgDetailViewFormController?.reset();
    detailTabsViewController.tabsConfig.refresh();
  }

  Future<void> saveOrgDetailView() async {
    if (await organizationDetailViewController.orgDetailViewFormController!
        .validate()) {
      bool isNew = orgModel.value!.id == null;
      orgModel.value = await OrganizationService().save(orgModel.value!);

      if (!isNew) {
        await updateOrgPermissions(orgId: orgModel.value!.id!);
      }

      await refreshOrgTreeData(overrideSelectedTreeNodeId: orgModel.value!.id!);
      await refreshOrgDetailData();
    }

    EHToastMessageHelper.showInfoMessage('common.general.saved');
  }

  Future<void> deleteSelectedOrg() async {
    await OrganizationService().deleteOrgById(
        orgTreeCompController.orgTreeController.selectedTreeNode.value!.id);
    await refreshOrgTreeData(overrideSelectedTreeNodeId: '');

    orgModel.value = null;

    await organizationDetailViewController.initData();
    EHToastMessageHelper.showInfoMessage('common.general.deleted');
  }

  Future<List> updateOrgPermissions({required String orgId}) async {
    List<EHTreeNode> treeNodeList = permTreeComponentController
        .permTreeController
        .getAllFilteredNodes((node) =>
            (node.data as PermissionModel).type == 'P' &&
            node.isChecked == true);

    List<String> permissionIds = treeNodeList.map((e) => e.id!).toList();

    List treeMapData =
        await PermissionService().updateOrgPermissions(orgId, permissionIds);

    return treeMapData;
  }
}
