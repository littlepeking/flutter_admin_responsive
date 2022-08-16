import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:flutter/material.dart';
import 'eh_tree_controller.dart';
import 'eh_tree_node.dart';

class EHTreeHelper {
  static Future<T?> loadTreeNodesFromMap<T extends EHModel>(
      List<Map<String, dynamic>>? treeNodeList,
      EHTreeController treeController,
      T fromJson2Model(e),
      {ValueChanged<T?>? onNodeClick,
      String? overrideSelectedTreeNodeId,
      EHTreeNode? rootNode}) {
    treeController.treeNodeDataList.clear();

    onNodeClick = onNodeClick ?? (T? t) => {};

    if (rootNode != null) treeController.treeNodeDataList.add(rootNode);

    String selectTreeNodeId = '';

    //calculate selectedTreeNodeId: override node id take precedence and then selected Tree node id and then root node.
    if (overrideSelectedTreeNodeId != null) {
      selectTreeNodeId = overrideSelectedTreeNodeId;
      treeController.selectedTreeNode.value = null;
    } else {
      if (treeController.selectedTreeNode.value != null) {
        selectTreeNodeId = treeController.selectedTreeNode.value!.id!;
        // treeController.selectedTreeNode.value = null;
      }
    }

    if (treeNodeList != null) {
      treeNodeList.forEach((map) {
        EHTreeNode node = _convertMap2TreeData(treeController, map,
            fromJson2Model, selectTreeNodeId, onNodeClick!);
        if (rootNode != null) {
          rootNode.children!.add(node);
          node.parentTreeNode = rootNode;
        } else {
          treeController.treeNodeDataList.add(node);
          node.parentTreeNode = null;
        }
      });

      treeController.treeNodeDataList.refresh();
    }

    if (treeController.selectedTreeNode.value == null ||
        treeController.selectedTreeNode.value!.id == '') {
      treeController.selectedTreeNode.value = rootNode;
    }
    return treeController.selectedTreeNode.value!.data;
  }

  static EHTreeNode _convertMap2TreeData<T extends EHModel>(
      EHTreeController treeController,
      Map<String, dynamic> data,
      T fromJson(dynamic e),
      String selectedNodeId,
      ValueChanged<T?> onNodeClick) {
    List<EHTreeNode>? children;

    if (data['children'] != null) {
      children = data['children']
          .map<EHTreeNode>((c) => _convertMap2TreeData(
              treeController, c, fromJson, selectedNodeId, onNodeClick))
          .toList();
    }

    T model = fromJson(data);

    EHTreeNode node = EHTreeNode(
        id: data['id'],
        displayName: data['name'],
        data: model,
        children: children,
        isSelected: data['id'] == selectedNodeId,
        onTap: () {
          onNodeClick(model);
        });

    if (node.children != null) {
      print(node.children.toString());
      node.children!.forEach((c) => c.parentTreeNode = node);
    }

    if (node.isSelected) treeController.selectedTreeNode.value = node;

    return node;
  }
}
