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

import 'package:enhantec_platform_ui/framework/utils/eh_context_helper.dart';
import 'package:enhantec_platform_ui/framework/utils/eh_theme_helper.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_tree_controller.dart';

/// Widget that displays one [EHTreeNode] and its children.
class EHNodeWidget extends StatelessWidget {
  final EHTreeNode treeNode;
  final EHTreeController controller;
  const EHNodeWidget(
      {Key? key, required this.treeNode, required this.controller})
      : super(key: key);

  bool get _isLeaf {
    return treeNode.children == null || treeNode.children!.isEmpty;
  }

  bool get _isExpanded {
    return controller.isNodeExpanded(treeNode);
  }

  @override
  Widget build(BuildContext context) {
    var icon = _isLeaf
        ? null
        : _isExpanded
            ? Icons.expand_more
            : Icons.chevron_right;

    var onIconPressed =
        _isLeaf ? null : () => controller.toggleNodeExpanded(treeNode);

    List<EHNodeWidget> children = [];

    if (treeNode.children != null) {
      for (var node in treeNode.children!) {
        if (EHContextHelper.hasAnyPermission(node.permissionCodes))
          children.add(EHNodeWidget(
            treeNode: node,
            controller: controller,
          ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: controller.nodeMaxSize,
              child: IconButton(
                padding: EdgeInsets.all(controller.paddingSize),
                iconSize: controller.iconSize,
                icon: Icon(icon),
                onPressed: onIconPressed,
              ),
            ),
            Row(
              children: [
                if (controller.showCheckBox && !treeNode.hideCheckBox)
                  Checkbox(
                      tristate: true,
                      value: treeNode.isChecked,
                      onChanged: (val) {
                        controller.checkNode(treeNode, val);
                        controller.reCalculateAllCheckStatus();
                      }),
                if (treeNode.icon != null) Icon(treeNode.icon),
                SizedBox(width: 2),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Container(
                        decoration: controller.isNodeSelectable
                            ? BoxDecoration(
                                color: treeNode ==
                                        controller.selectedTreeNode.value
                                    ? Theme.of(Get.context!)
                                        .textSelectionTheme
                                        .selectionColor
                                    : null,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Obx(
                            () => Text(treeNode.displayNameMsgKey.tr,
                                style: TextStyle(
                                    color: treeNode.disableTap == true
                                        ? EHThemeHelper.getDisableTextColor()
                                        : EHThemeHelper.getTextColor())),
                          ),
                        )),
                    onTap: treeNode.disableTap == true
                        ? null
                        : () {
                            controller.selectedTreeNode.value = treeNode;
                            if (treeNode.onTap != null) treeNode.onTap!();

                            if (controller.onTreeNodeTap != null)
                              controller.onTreeNodeTap!(treeNode);

                            controller.treeNodeDataList.refresh();
                          },
                  ),
                ),
              ],
            )
          ],
        ),
        if (_isExpanded && !_isLeaf)
          Padding(
            padding: EdgeInsets.only(left: controller.indent),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          )
      ],
    );
  }
}
