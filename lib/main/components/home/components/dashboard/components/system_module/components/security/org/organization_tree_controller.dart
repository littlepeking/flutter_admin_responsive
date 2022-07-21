import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_detail_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

import 'organization_model.dart';

class OrganizationTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTreeController orgTreeController;

  RxBool isOrgDetailOpened = false.obs;

  RxDouble splitterWeights = 0.2.obs;

  Rx<OrganizationModel?> model = Rxn<OrganizationModel>();

  late EHTabsViewController detailTabsViewController;

  late OrganizationDetailViewController organizationDetailViewController;

  Future<void> loadOrgTreeData() async {
    Response<Map<String, dynamic>> response =
        await EHRestService().getByServiceName<Map<String, dynamic>>(
      serviceName: '/security/org',
      actionName: '/buildTree',
    );

    if (response.data != null) {
      EHTreeNode node = convertMap2TreeData(response.data!);
      orgTreeController.treeNodeDataList![0].children!.add(node);
      orgTreeController.treeNodeDataList!.refresh();
    }
  }

  EHTreeNode convertMap2TreeData(Map<String, dynamic> data) {
    List<EHTreeNode>? children;

    if (data['children'] != null) {
      children = data['children']
          .map<EHTreeNode>((c) => convertMap2TreeData(c))
          .toList();
    }

    OrganizationModel orgModel = OrganizationModel.fromJson(data);

    return EHTreeNode(
        id: data['id'],
        displayName: data['name'],
        data: orgModel,
        children: children,
        onTap: () {
          model.value = orgModel;
          model.refresh();
        });
  }

  OrganizationTreeController() : super(null) {
    organizationDetailViewController = OrganizationDetailViewController(this);

    orgTreeController = EHTreeController(
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

    detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Detail Info', organizationDetailViewController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: OrganizationDetailView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);
  }
}
