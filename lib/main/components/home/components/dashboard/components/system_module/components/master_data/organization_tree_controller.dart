import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizationTreeController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTreeController orgTreeController;

  OrganizationTreeController() : super(null) {
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
  }
}
