/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_stateless_widget.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_context_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_theme_helper.dart';
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

    return controller.displayMode == EHTreeDisplayMode.treeMode
        ? Obx(() => SingleChildScrollView(
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
                      ),
                  ],
                ),
              ),
            ))
        : Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.stackParentNodes.length > 0)
                      TextButton(
                          onPressed: () =>
                              controller.stackParentNodes.removeLast(),
                          child: Icon(
                            Icons.reply,
                            size: 40,
                            color: EHThemeHelper.getTextColor(),
                          )),
                    SizedBox(height: 5),
                    SingleChildScrollView(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: (controller.stackParentNodes.length == 0
                                    ? controller.treeNodeDataList
                                    : controller
                                            .stackParentNodes.last.children ??
                                        [])
                                .map<Widget>((treeNode) => ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 100, height: 80),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              //check if treenode is directory
                                              if (treeNode.children != null &&
                                                  treeNode.children!.length >
                                                      0) {
                                                controller.stackParentNodes
                                                    .add(treeNode);
                                              } else {
                                                if (treeNode.children != null &&
                                                    treeNode.children!.length >
                                                        0) {}

                                                if (treeNode.onTap != null)
                                                  treeNode.onTap!();

                                                if (controller.onTreeNodeTap !=
                                                    null)
                                                  controller
                                                      .onTreeNodeTap!(treeNode);
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  treeNode.icon == null
                                                      ? Icons.launch
                                                      : treeNode.icon,
                                                  size: 40,
                                                  color: EHThemeHelper
                                                      .getTextColor(),
                                                ),
                                                Text(
                                                  treeNode.displayNameMsgKey.tr,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: EHThemeHelper
                                                          .getTextColor(),
                                                      fontSize: 13,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList())),
                  ],
                )),
          );
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
