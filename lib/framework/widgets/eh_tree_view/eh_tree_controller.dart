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

import 'package:enhantec_platform_ui/framework/base/eh_controller.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// A controller for a tree state.
///
/// Allows to modify the state of the tree.
///
typedef bool IsNodeMatch(EHTreeNode node);

enum EHTreeDisplayMode { treeMode, stackMode }

class EHTreeController extends EHController {
  /// Horizontal indent between levels.
  final double indent;

  /// Size of the expand/collapse icon.
  final double? iconSize;

  final double? nodeMaxSize;

  final double paddingSize;

  final bool showCheckBox;

  final EHTreeDisplayMode displayMode;

  final bool allowCascadeCheck;

  final bool isNodeSelectable;

  final ValueChanged<EHTreeNode>? onTreeNodeTap;

  /// Tree controller to manage the tree state.
  bool _allNodesExpanded;
  RxList<EHTreeNode> treeNodeDataList;

  Rx<EHTreeNode?> selectedTreeNode = Rxn();

  RxList<EHTreeNode> stackParentNodes = RxList<EHTreeNode>();

  EHTreeController(
      {this.indent = 10,
      this.iconSize = 20,
      this.nodeMaxSize,
      this.paddingSize = 6,
      this.showCheckBox = false,
      this.displayMode = EHTreeDisplayMode.treeMode,
      this.allowCascadeCheck = true,
      required this.treeNodeDataList,
      this.isNodeSelectable = false,
      allNodesExpanded = true,
      this.onTreeNodeTap})
      : _allNodesExpanded = allNodesExpanded;

  bool get allNodesExpanded => _allNodesExpanded;

  bool isNodeExpanded(EHTreeNode treeNode) {
    return treeNode.isExpanded ?? _allNodesExpanded;
  }

  void toggleNodeExpanded(EHTreeNode treeNode) {
    treeNode.isExpanded = !isNodeExpanded(treeNode);
    treeNodeDataList.refresh();
  }

  // void expandAll() {
  //   _allNodesExpanded = true;
  //   _expanded.clear();
  // }

  // void collapseAll() {
  //   _allNodesExpanded = false;
  //   _expanded.clear();
  // }

  void expandNode(EHTreeNode treeNode) {
    treeNode.isExpanded = true;
    treeNodeDataList.refresh();
  }

  void collapseNode(EHTreeNode treeNode) {
    treeNode.isExpanded = false;
    treeNodeDataList.refresh();
  }

  void checkNode(EHTreeNode treeNode, bool? val) {
    treeNode.isChecked = getNextCheckStatus(val);

    if (allowCascadeCheck) {
      if (treeNode.children != null && treeNode.children!.length > 0) {
        treeNode.children!.forEach((e) {
          checkNode(e, treeNode.isChecked);
        });
      }
    }
    treeNodeDataList.refresh();
  }

  void reCalculateAllCheckStatus() {
    if (allowCascadeCheck) {
      if (treeNodeDataList.length > 0)
        treeNodeDataList.forEach((node) {
          recursivelyCalculateCheckStatus(node);
        });
      treeNodeDataList.refresh();
    }
  }

  bool? recursivelyCalculateCheckStatus(EHTreeNode node) {
    if (node.children == null || node.children!.length == 0) {
      return node.isChecked;
    } else {
      bool needInitedStatus = true;
      bool? checkStatus;
      node.children!.forEach((c) {
        recursivelyCalculateCheckStatus(c);
        if (needInitedStatus) {
          checkStatus = c.isChecked;
          needInitedStatus = false;
        }
        checkStatus = mergeStatuses(checkStatus, c.isChecked);
      });

      return node.isChecked = checkStatus;
    }
  }

  bool? mergeStatuses(bool? status1, bool? status2) {
    bool dirContainsSemiSelected = status1 == null || status2 == null;

    bool dirContainsSelected = status1 == true || status2 == true;

    bool dirContainsUnSelected = status1 == false || status2 == false;

    if (dirContainsSemiSelected) {
      return null;
    } else if (dirContainsUnSelected) {
      if (dirContainsSelected) {
        return null;
      } else {
        return false;
      }
    } else {
      //!dirContainsUnSelected
      return true;
    }
  }

  bool getNextCheckStatus(bool? val) {
    if (val == null)
      return false;
    else
      return val;
  }

  List<EHTreeNode> getAllFilteredNodes(IsNodeMatch filter) {
    List<EHTreeNode> res = [];
    treeNodeDataList.forEach((node) {
      res.addAll(_filterNode(node, filter));
    });

    return res;
  }

  List<EHTreeNode> _filterNode(EHTreeNode node, IsNodeMatch isNodeMatch) {
    List<EHTreeNode> res = [];
    if (node.children != null && node.children!.length > 0) {
      node.children!.forEach((e) => res.addAll(_filterNode(e, isNodeMatch)));
    }
    if (isNodeMatch(node)) res.add(node);
    return res;
  }
}
