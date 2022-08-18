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

import 'organization_model.dart';
import 'organization_services.dart';

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

  refreshOrgDetailData() async {
    orgModel.refresh();
    if (orgModel.value != null && orgModel.value!.id != null) {
      await permTreeComponentController.reloadPermTreeData(
          orgId: orgModel.value!.id!);
      await organizationDetailViewController.initData();
      organizationDetailViewController.orgDetailViewFormController!.reset();

      if (detailTabsViewController.tabsConfig[1].isHide)
        detailTabsViewController.tabsConfig[1].isHide = false;
    } else {
      detailTabsViewController.selectedIndex.value = 0;
      if (!detailTabsViewController.tabsConfig[1].isHide)
        detailTabsViewController.tabsConfig[1].isHide = true;
    }
    detailTabsViewController.tabsConfig.refresh();
  }

  Future<void> saveOrgDetailView() async {
    if (detailTabsViewController.selectedTab.tabName == 'Detail Info') {
      if (await organizationDetailViewController.orgDetailViewFormController!
          .validate()) {
        orgModel.value = await OrganizationServices.save(orgModel.value!);

        await orgTreeCompController.reloadOrgTreeData(
            overrideSelectedTreeNodeId: orgModel.value!.id!);
        await refreshOrgDetailData();
      }
    } else if (detailTabsViewController.selectedTab.tabName == 'Permissions') {
      await permTreeComponentController.updateOrgPermissions(
          orgId: orgModel.value!.id!);
    }

    EHToastMessageHelper.showInfoMessage('Saved successfully.');
  }

  Future<void> deleteSelectedOrg() async {
    await OrganizationServices.deleteOrgById(
        orgTreeCompController.orgTreeController.selectedTreeNode.value!.id);
    await orgTreeCompController.reloadOrgTreeData(
        overrideSelectedTreeNodeId: '');

    orgModel.value = null;

    await organizationDetailViewController.initData();
    EHToastMessageHelper.showInfoMessage('Delete successfully.');
  }
}
