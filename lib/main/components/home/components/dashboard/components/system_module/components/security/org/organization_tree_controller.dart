import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/components/org_tree_component_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
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
      EHTab('Detail Info', self.organizationDetailViewController,
          (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: OrganizationDetailView(
              controller: c,
            ));
      }),

      EHTab(
        'Permissions',
        self.permTreeComponentController,
        (controller) => PermTreeComponent(
          controller: self.permTreeComponentController,
        ),
      ),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
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

      detailTabsViewController.getTab('Permissions').isHide = false;
    } else {
      detailTabsViewController.selectedTab =
          detailTabsViewController.getTab('Detail Info');
      detailTabsViewController.getTab('Permissions').isHide = true;
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

    EHToastMessageHelper.showInfoMessage('Saved successfully.');
  }

  Future<void> deleteSelectedOrg() async {
    await OrganizationService().deleteOrgById(
        orgTreeCompController.orgTreeController.selectedTreeNode.value!.id);
    await refreshOrgTreeData(overrideSelectedTreeNodeId: '');

    orgModel.value = null;

    await organizationDetailViewController.initData();
    EHToastMessageHelper.showInfoMessage('Deleted successfully.');
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
