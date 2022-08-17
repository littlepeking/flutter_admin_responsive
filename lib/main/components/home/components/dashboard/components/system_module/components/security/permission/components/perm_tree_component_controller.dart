import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../permission_services.dart';
import '../permission_model.dart';

class PermTreeComponentController extends EHPanelController {
  late EHTreeController permTreeController;

  late ValueChanged<PermissionModel?> onTapNode;

  PermTreeComponentController._create(EHPanelController parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<PermTreeComponentController> create(EHPanelController parent,
      {ValueChanged<PermissionModel?>? onTapNode,
      showCheckBox = false,
      isNodeSelectable = false}) async {
    PermTreeComponentController self =
        PermTreeComponentController._create(parent);

    self.onTapNode = onTapNode ?? ((model) => {});

    self.permTreeController = EHTreeController(
        showCheckBox: showCheckBox,
        isNodeSelectable: isNodeSelectable,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    return self;
  }

  Future<PermissionModel?> reloadPermTreeData(
      {required String orgId, String? overrideSelectedTreeNodeId}) async {
    List treeMapData = await PermissionServices.buildTreeByOrgId(orgId);

    return EHTreeUtilHelper.loadTreeNodesFromMap<PermissionModel>(
      treeMapData,
      permTreeController,
      PermissionModel.fromJson,
      overrideSelectedTreeNodeId: overrideSelectedTreeNodeId,
      onNodeClick: (orgModel) => onTapNode(orgModel),
    );
  }

  Future<List> updateOrgPermissions({required String orgId}) async {
    List<EHTreeNode> treeNodeList = permTreeController.getAllFilteredNodes(
        (node) =>
            (node.data as PermissionModel).type == 'P' &&
            node.isChecked == true);

    List<String> permissionIds = treeNodeList.map((e) => e.id!).toList();

    List treeMapData =
        await PermissionServices.updateOrgPermissions(orgId, permissionIds);

    return treeMapData;
  }
}
