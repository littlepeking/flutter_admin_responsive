import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../organization_model.dart';
import '../organization_services.dart';

typedef OrgTreeNodeOnTap = void Function(OrganizationModel? model);

class OrgTreeComponentController extends EHPanelController {
  late EHTreeController orgTreeController;

  late OrgTreeNodeOnTap onTap;

  OrgTreeComponentController._create(EHPanelController parent) : super(parent);

  Future<OrganizationModel?> reloadOrgTreeData(List data,
      {String? overrideSelectedTreeNodeId}) async {
    // EHTreeNode rootNode = EHTreeNode(
    //     id: '0',
    //     displayName: 'All Organizations',
    //     children: [],
    //     icon: Icons.lan,
    //     data: null,
    //     hideCheckBox: true,
    //     onTap: () => onTap(null));

    return EHTreeUtilHelper.loadTreeNodesFromMap<OrganizationModel>(
        data, orgTreeController, OrganizationModel.fromJson,
        overrideSelectedTreeNodeId: overrideSelectedTreeNodeId,
        onNodeClick: (orgModel) => onTap(orgModel),
        rootNode: null,
        displayNameField: 'name');
  }

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrgTreeComponentController> create(EHPanelController parent,
      {OrgTreeNodeOnTap? onTap, showCheckBox = false}) async {
    OrgTreeComponentController self =
        OrgTreeComponentController._create(parent);

    self.onTap = onTap ?? ((model) => {});

    self.orgTreeController = EHTreeController(
        showCheckBox: showCheckBox,
        allowCascadeCheck: false,
        isNodeSelectable: true,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    // List treeMapData = await OrganizationServices.buildTree();
    // await self.reloadOrgTreeData(treeMapData);

    return self;
  }
}
