import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/master_data/models/organization_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/receipt_detail_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/receipt_detail_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizationTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTreeController orgTreeController;

  Rx<OrganizationModel?> model = Rxn<OrganizationModel>();

  RxBool isOrgDetailOpened = false.obs;

  RxDouble splitterWeights = 0.2.obs;

  late EHTabsViewController receiptDetailTabsViewController;

  late ReceiptDetailViewController receiptDetailInfoController;

  OrganizationTreeController() : super(null) {
    receiptDetailInfoController = ReceiptDetailViewController(this);

    orgTreeController = EHTreeController(
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[
          EHTreeNode(displayName: 'Headquanter', children: [
            EHTreeNode(displayName: 'subBranch01', children: [
              EHTreeNode(displayName: 'Headquanter', children: [
                EHTreeNode(displayName: 'subBranch01', children: []),
                EHTreeNode(displayName: 'subBranch01', children: [])
              ])
            ]),
            EHTreeNode(displayName: 'subBranch01', children: [
              EHTreeNode(displayName: 'Headquanter', children: [
                EHTreeNode(displayName: 'subBranch01', children: [
                  EHTreeNode(displayName: 'Headquanter', children: [
                    EHTreeNode(displayName: 'subBranch01', children: []),
                    EHTreeNode(displayName: 'subBranch01', children: [])
                  ])
                ]),
                EHTreeNode(displayName: 'subBranch01', children: [
                  EHTreeNode(displayName: 'Headquanter', children: [
                    EHTreeNode(displayName: 'subBranch01', children: []),
                    EHTreeNode(displayName: 'subBranch01', children: [
                      EHTreeNode(displayName: 'Headquanter', children: [
                        EHTreeNode(displayName: 'subBranch01', children: []),
                        EHTreeNode(displayName: 'subBranch01', children: [
                          EHTreeNode(displayName: 'Headquanter', children: [
                            EHTreeNode(
                                displayName: 'subBranch01', children: []),
                            EHTreeNode(displayName: 'subBranch01', children: [])
                          ])
                        ])
                      ])
                    ])
                  ])
                ])
              ])
            ])
          ]),
        ].obs);

    receiptDetailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Detail Info', receiptDetailInfoController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: ReceiptDetailView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);
  }
}
