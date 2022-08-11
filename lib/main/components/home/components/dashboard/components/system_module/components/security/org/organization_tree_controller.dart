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
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'organization_model.dart';
import 'organization_services.dart';

class OrganizationTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgTreeComponentController orgTreeCompController;

  Rx<OrganizationModel?> model = Rxn<OrganizationModel>();

  late EHTabsViewController detailTabsViewController;

  late OrganizationDetailViewController organizationDetailViewController;

  OrganizationTreeController._create(EHPanelController? parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrganizationTreeController> create() async {
    OrganizationTreeController self = OrganizationTreeController._create(null);

    self.organizationDetailViewController =
        await OrganizationDetailViewController.create(self);

    self.orgTreeCompController = await OrgTreeComponentController.create(self,
        onTap: (selectedOrgModel) {
      if (self.model.value != null &&
          self.organizationDetailViewController.orgDetailViewFormController !=
              null)
        self.organizationDetailViewController.orgDetailViewFormController!
            .reset();

      self.model.value = selectedOrgModel;
      self.model.refresh();
    });

    self.detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Detail Info', self.organizationDetailViewController,
          (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: OrganizationDetailView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    return self;
  }

  Future<void> saveOrgDetailView() async {
    if (await organizationDetailViewController.orgDetailViewFormController!
        .validate()) {
      model.value = await OrganizationServices.save(model.value!);
      model.refresh();

      EHToastMessageHelper.showInfoMessage('Saved successfully.');
      await orgTreeCompController.reloadOrgTreeData(
          overrideSelectedTreeNodeId: model.value!.id!);

      await organizationDetailViewController.initData();
    }
  }

  Future<void> deleteSelectedOrg() async {
    await OrganizationServices.deleteOrgById(
        orgTreeCompController.orgTreeController.selectedTreeNode.value!.id);
    await orgTreeCompController.reloadOrgTreeData(
        overrideSelectedTreeNodeId: '');

    model.value = null;

    await organizationDetailViewController.initData();
    EHToastMessageHelper.showInfoMessage('Delete successfully.');
  }
}
