import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_context_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_node_widget.dart';
import 'eh_tree_controller.dart';
import 'eh_tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class EHTreeView extends EHStatelessWidget<EHTreeController> {
  EHTreeView({Key? key, required EHTreeController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    controller.reCalculateAllCheckStatus();
    return buildNodes();
  }

  Widget buildNodes() {
    controller.treeNodeDataList.value =
        treeShakeByPermission(controller.treeNodeDataList);

    return Obx(() => SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var node in controller.treeNodeDataList)
                  EHNodeWidget(
                    treeNode: node,
                    controller: controller,
                  )
              ],
            ),
          ),
        ));
  }

  List<EHTreeNode> treeShakeByPermission(List<EHTreeNode> treeNodeDataList) {
    List<EHTreeNode> accessableTreeNodes = [];
    treeNodeDataList.forEach((node) => accessableTreeNodes.addIf(
        _treeNodeShakeByPermission(node) != null, node));

    return accessableTreeNodes;
  }

  EHTreeNode? _treeNodeShakeByPermission(EHTreeNode treeNode) {
    if (treeNode.children != null && treeNode.children!.length > 0) {
      List<EHTreeNode> accessableChildren = [];
      treeNode.children!.forEach((cNode) {
        EHTreeNode? childTreeNode = _treeNodeShakeByPermission(cNode);
        if (childTreeNode != null) accessableChildren.add(childTreeNode);
      });

      if (accessableChildren.length > 0) {
        treeNode.children = accessableChildren;
        return treeNode;
      } else
        return null;
    } else {
      return EHContextHelper.hasAnyPermission(treeNode.permissionCodes)
          ? treeNode
          : null;
    }
  }
}
