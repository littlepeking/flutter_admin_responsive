import 'package:dio/dio.dart';
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
      {ValueChanged<PermissionModel?>? onTapNode, showCheckBox = false}) async {
    PermTreeComponentController self =
        PermTreeComponentController._create(parent);

    self.onTapNode = onTapNode ?? ((model) => {});

    self.permTreeController = EHTreeController(
        showCheckBox: showCheckBox,
        isNodeSelectable: true,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    await self.reloadPermTreeData();

    return self;
  }

  Future<PermissionModel?> reloadPermTreeData(
      {String? overrideSelectedTreeNodeId}) async {
    EHTreeNode rootNode = EHTreeNode(
        id: '',
        displayName: 'Organization Permission Tree',
        children: [],
        icon: Icons.lan,
        data: null,
        onTap: () => onTapNode(null));

    Response<List<Map<String, dynamic>>> response =
        await PermissionServices.buildTree();

    return EHTreeUtilHelper.loadTreeNodesFromMap<PermissionModel>(
        response.data, permTreeController, PermissionModel.fromJson,
        overrideSelectedTreeNodeId: overrideSelectedTreeNodeId,
        onNodeClick: (orgModel) => onTapNode(orgModel),
        rootNode: rootNode);
  }
}
