import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:flutter/material.dart';
import 'eh_tree_controller.dart';
import 'eh_tree_node.dart';

class EHTreeUtilHelper {
  static T? loadTreeNodesFromMap<T extends EHModel>(
    List? treeNodeList,
    EHTreeController treeController,
    T fromJson2Model(Map<String, dynamic> json), {
    String? overrideSelectedTreeNodeId,
    EHTreeNode? rootNode,
    String childrenField = 'children',
    String idField = 'id',
    String displayNameField = 'displayName',
    String checkStatusField = 'checkStatus',
    ValueChanged<T?>? onNodeClick,
    ValueChanged<EHTreeNode>? treeNodePostProcessor,
  }) {
    EHTreeNode _convertMap2TreeData<T extends EHModel>(
        EHTreeController treeController,
        Map<String, dynamic> data,
        T fromJson(Map<String, dynamic> json),
        String selectedNodeId,
        ValueChanged<T?> onNodeClick,
        ValueChanged<EHTreeNode>? treeNodePostProcessor) {
      List<EHTreeNode>? children;

      if (data[childrenField] != null) {
        children = data[childrenField]
            .map<EHTreeNode>((c) => _convertMap2TreeData(treeController, c,
                fromJson, selectedNodeId, onNodeClick, treeNodePostProcessor))
            .toList();
      }

      T model = fromJson(data);

      EHTreeNode node = EHTreeNode(
          id: data[idField],
          displayNameMsgKey: data[displayNameField],
          data: model,
          children: children,
          isChecked: data[checkStatusField],
          isSelected: data[idField] == selectedNodeId,
          onTap: () {
            onNodeClick(model);
          });

      if (node.children != null) {
        print(node.children.toString());
        node.children!.forEach((c) => c.parentTreeNode = node);
      }

      if (node.isSelected) treeController.selectedTreeNode.value = node;

      if (treeNodePostProcessor != null) treeNodePostProcessor(node);

      return node;
    }

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
        EHTreeNode node = _convertMap2TreeData(
            treeController,
            map,
            fromJson2Model,
            selectTreeNodeId,
            onNodeClick!,
            treeNodePostProcessor);
        if (rootNode != null) {
          rootNode.children!.add(node);
          node.parentTreeNode = rootNode;
        } else {
          treeController.treeNodeDataList.add(node);
          node.parentTreeNode = null;
        }
      });
    }

    if (treeController.selectedTreeNode.value == null ||
        treeController.selectedTreeNode.value!.id == '') {
      treeController.selectedTreeNode.value = rootNode;
    }
    return treeController.selectedTreeNode.value == null
        ? null
        : treeController.selectedTreeNode.value!.data;
  }
}
