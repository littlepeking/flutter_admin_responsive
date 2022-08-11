import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../organization_model.dart';
import '../organization_services.dart';

typedef OrgTreeNodeOnTap = void Function(OrganizationModel? model);

class OrgTreeComponentController extends EHPanelController {
  late EHTreeController orgTreeController;

  late OrgTreeNodeOnTap onTap;

  Future<OrganizationModel?> reloadOrgTreeData(
      {String? overrideSelectedTreeNodeId}) async {
    orgTreeController.treeNodeDataList.clear();

    EHTreeNode rootNode = EHTreeNode(
        id: '',
        displayName: 'All Organizations',
        children: [],
        icon: Icons.lan,
        data: null,
        onTap: () => onTap(null));

    orgTreeController.treeNodeDataList.add(rootNode);

    String selectTreeNodeId = '';

    //calculate selectedTreeNodeId: override node id take precedence and then selected Tree node id and then root node.
    if (overrideSelectedTreeNodeId != null) {
      selectTreeNodeId = overrideSelectedTreeNodeId;
      orgTreeController.selectedTreeNode.value = null;
    } else {
      if (orgTreeController.selectedTreeNode.value != null) {
        selectTreeNodeId = orgTreeController.selectedTreeNode.value!.id!;
        // orgTreeController.selectedTreeNode.value = null;
      }
    }

    Response<List> response = await OrganizationServices.buildTree();

    if (response.data != null) {
      response.data!.forEach((map) {
        EHTreeNode node = _convertMap2TreeData(map, selectTreeNodeId);
        rootNode.children!.add(node);
        node.parentTreeNode = rootNode;
      });

      orgTreeController.treeNodeDataList.refresh();
    }

    if (orgTreeController.selectedTreeNode.value == null ||
        orgTreeController.selectedTreeNode.value!.id == '') {
      orgTreeController.selectedTreeNode.value = rootNode;
    }
    return orgTreeController.selectedTreeNode.value!.data;
  }

  EHTreeNode _convertMap2TreeData(
      Map<String, dynamic> data, String selectedNodeId) {
    List<EHTreeNode>? children;

    if (data['children'] != null) {
      children = data['children']
          .map<EHTreeNode>((c) => _convertMap2TreeData(c, selectedNodeId))
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
          onTap(orgModel);
        });

    if (node.children != null) {
      print(node.children.toString());
      node.children!.forEach((c) => c.parentTreeNode = node);
    }

    if (node.isSelected) orgTreeController.selectedTreeNode.value = node;

    return node;
  }

  OrgTreeComponentController._create(EHPanelController parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrgTreeComponentController> create(EHPanelController parent,
      {OrgTreeNodeOnTap? onTap}) async {
    OrgTreeComponentController self =
        OrgTreeComponentController._create(parent);

    self.onTap = onTap ?? ((model) => {});

    self.orgTreeController = EHTreeController(
        displaySelectedItems: true,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    await self.reloadOrgTreeData();

    return self;
  }
}
