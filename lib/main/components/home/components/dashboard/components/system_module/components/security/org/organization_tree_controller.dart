import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

import 'organization_model.dart';
import 'organization_services.dart';

class OrganizationTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTreeController orgTreeController;

  RxBool isOrgDetailOpened = false.obs;

  RxDouble splitterWeights = 0.2.obs;

  Rx<OrganizationModel?> model = Rxn<OrganizationModel>();

  late EHTabsViewController detailTabsViewController;

  late OrganizationDetailViewController organizationDetailViewController;

  Future<void> reloadOrgTreeData() async {
    orgTreeController.treeNodeDataList.clear();

    EHTreeNode rootNode = EHTreeNode(
        id: '',
        displayName: 'All Organizations',
        children: [],
        icon: Icons.lan,
        onTap: () {
          model.value = null;
          model.refresh();
        });

    orgTreeController.treeNodeDataList.add(rootNode);

    String selectTreeNodeId = '';
    if (orgTreeController.selectedTreeNode != null) {
      selectTreeNodeId = orgTreeController.selectedTreeNode!.id!;
      orgTreeController.selectedTreeNode = null;
    }

    Response<Map<String, dynamic>> response =
        await EHRestService().getByServiceName<Map<String, dynamic>>(
      serviceName: '/security/org',
      actionName: '/buildTree',
    );

    if (response.data != null) {
      EHTreeNode node = convertMap2TreeData(response.data!, selectTreeNodeId);
      orgTreeController.treeNodeDataList[0].children!.add(node);
      orgTreeController.treeNodeDataList.refresh();
    }

    if (orgTreeController.selectedTreeNode == null) {
      orgTreeController.selectedTreeNode = rootNode;
    }
  }

  EHTreeNode convertMap2TreeData(
      Map<String, dynamic> data, String selectedNodeId) {
    List<EHTreeNode>? children;

    if (data['children'] != null) {
      children = data['children']
          .map<EHTreeNode>((c) => convertMap2TreeData(c, selectedNodeId))
          .toList();
    }

    OrganizationModel orgModel = OrganizationModel.fromJson(data);

    EHTreeNode node = EHTreeNode(
        id: data['id'],
        displayName: data['name'],
        data: orgModel,
        children: children,
        isSelected: data['id'] == selectedNodeId,
        onTap: () {
          if (model.value != null)
            organizationDetailViewController.orgDetailViewFormController!
                .reset();
          model.value = orgModel;
          model.refresh();
        });

    if (node.isSelected) orgTreeController.selectedTreeNode = node;

    return node;
  }

  OrganizationTreeController._create(EHPanelController? parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrganizationTreeController> create() async {
    OrganizationTreeController self = OrganizationTreeController._create(null);

    self.organizationDetailViewController =
        await OrganizationDetailViewController.create(self);

    self.orgTreeController = EHTreeController(
        displaySelectedItems: true,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    // orgTreeController = EHTreeController(
    //     displaySelectedItems: true,
    //     allNodesExpanded: true,
    //     treeNodeDataList: <EHTreeNode>[
    //       EHTreeNode(displayName: 'Headquanter', children: [
    //         EHTreeNode(displayName: 'subBranch01', children: [
    //           EHTreeNode(displayName: 'Headquanter', children: [
    //             EHTreeNode(displayName: 'subBranch01', children: []),
    //             EHTreeNode(displayName: 'subBranch01', children: [])
    //           ])
    //         ]),
    //         EHTreeNode(displayName: 'subBranch01', children: [
    //           EHTreeNode(displayName: 'Headquanter', children: [
    //             EHTreeNode(displayName: 'subBranch01', children: [
    //               EHTreeNode(displayName: 'Headquanter', children: [
    //                 EHTreeNode(displayName: 'subBranch01', children: []),
    //                 EHTreeNode(displayName: 'subBranch01', children: [])
    //               ])
    //             ]),
    //             EHTreeNode(displayName: 'subBranch01', children: [
    //               EHTreeNode(displayName: 'Headquanter', children: [
    //                 EHTreeNode(displayName: 'subBranch01', children: []),
    //                 EHTreeNode(displayName: 'subBranch01', children: [
    //                   EHTreeNode(displayName: 'Headquanter', children: [
    //                     EHTreeNode(displayName: 'subBranch01', children: []),
    //                     EHTreeNode(displayName: 'subBranch01', children: [
    //                       EHTreeNode(displayName: 'Headquanter', children: [
    //                         EHTreeNode(
    //                             displayName: 'subBranch01', children: []),
    //                         EHTreeNode(displayName: 'subBranch01', children: [])
    //                       ])
    //                     ])
    //                   ])
    //                 ])
    //               ])
    //             ])
    //           ])
    //         ])
    //       ]),
    //     ].obs);

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

  void saveOrgDetailView() async {
    if (await organizationDetailViewController.orgDetailViewFormController!
        .validate()) {
      model.value = await OrganizationServices.save(model.value!);
      model.refresh();
      EHToastMessageHelper.showInfoMessage('Saved successfully.');
      reloadOrgTreeData();
    }
  }
}
