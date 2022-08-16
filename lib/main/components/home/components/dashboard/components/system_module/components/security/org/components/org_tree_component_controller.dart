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

  Future<OrganizationModel?> reloadOrgTreeData(
      {String? overrideSelectedTreeNodeId}) async {
    EHTreeNode rootNode = EHTreeNode(
        id: '',
        displayName: 'All Organizations',
        children: [],
        icon: Icons.lan,
        data: null,
        onTap: () => onTap(null));

    Response<List> response = await OrganizationServices.buildTree();

    return EHTreeUtilHelper.loadTreeNodesFromMap<OrganizationModel>(
        response.data, orgTreeController, OrganizationModel.fromJson,
        overrideSelectedTreeNodeId: overrideSelectedTreeNodeId,
        onNodeClick: (orgModel) => onTap(orgModel),
        rootNode: rootNode);
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
        isNodeSelectable: true,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    await self.reloadOrgTreeData();

    return self;
  }
}
