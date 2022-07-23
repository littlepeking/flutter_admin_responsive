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

  RxDouble splitterWeights = 0.2.obs;

  Rx<OrganizationModel?> model = Rxn<OrganizationModel>();

  late EHTabsViewController detailTabsViewController;

  late OrganizationDetailViewController organizationDetailViewController;

  Future<void> reloadOrgTreeData({String? overrideTreeNodeId}) async {
    orgTreeController.treeNodeDataList.clear();

    EHTreeNode rootNode = EHTreeNode(
        id: '',
        displayName: 'All Organizations',
        children: [],
        icon: Icons.lan,
        data: null,
        onTap: () {
          model.value = null;
          model.refresh();
        });

    orgTreeController.treeNodeDataList.add(rootNode);

    String selectTreeNodeId = '';

    //calculate selectedTreeNodeId: override node id take precedence and then selected Tree node id and then root node.
    if (overrideTreeNodeId != null) {
      selectTreeNodeId = overrideTreeNodeId;
      orgTreeController.selectedTreeNode.value = null;
    } else {
      if (orgTreeController.selectedTreeNode.value != null) {
        selectTreeNodeId = orgTreeController.selectedTreeNode.value!.id!;
        orgTreeController.selectedTreeNode.value = null;
      }
    }

    Response<List> response = await EHRestService().getByServiceName<List>(
      serviceName: '/security/org',
      actionName: '/buildTree',
    );

    if (response.data != null) {
      response.data!.forEach((map) {
        EHTreeNode node = convertMap2TreeData(map, selectTreeNodeId);
        rootNode.children!.add(node);
        node.parentTreeNode = rootNode;
      });

      orgTreeController.treeNodeDataList.refresh();
    }

    if (orgTreeController.selectedTreeNode.value == null) {
      orgTreeController.selectedTreeNode.value = rootNode;
    }
    //need set model data to the selected org, so need reset orgDetailViewFormController to make sure displayValue and error are all cleared.
    if (organizationDetailViewController.orgDetailViewFormController != null)
      organizationDetailViewController.orgDetailViewFormController!.reset();
    model.value = orgTreeController.selectedTreeNode.value!.data;
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

    if (node.children != null) {
      print(node.children.toString());
      node.children!.forEach((c) => c.parentTreeNode = node);
    }

    if (node.isSelected) orgTreeController.selectedTreeNode.value = node;

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
      reloadOrgTreeData(overrideTreeNodeId: model.value!.id!);

      organizationDetailViewController.initData();
    }
  }

  void deleteSelectedOrg() async {
    await OrganizationServices.deleteOrgById(
        orgTreeController.selectedTreeNode.value!.id);
    EHToastMessageHelper.showInfoMessage('Delete successfully.');
    reloadOrgTreeData(
        overrideTreeNodeId:
            orgTreeController.selectedTreeNode.value!.parentTreeNode!.id);

    organizationDetailViewController.initData();
  }
}
