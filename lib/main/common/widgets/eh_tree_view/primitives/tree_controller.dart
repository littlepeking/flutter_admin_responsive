// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/key_provider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/tree_node_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A controller for a tree state.
///
/// Allows to modify the state of the tree.
class TreeController {
  /// Horizontal indent between levels.
  final double indent;

  /// Size of the expand/collapse icon.
  final double? iconSize;

  final double? nodeMaxSize;

  final double paddingSize;

  final bool showCheckBox;

  /// Tree controller to manage the tree state.

  bool _allNodesExpanded;
  final Map<Key, bool> _expanded = <Key, bool>{};

  List<EHTreeNodeData>? treeNodeDataList;

  /// List of root level tree nodes.
  List<EHTreeNode>? nodes;

  TreeController(
      {this.indent = 10,
      this.iconSize = 20,
      this.nodeMaxSize,
      this.paddingSize = 6,
      this.nodes,
      this.showCheckBox = false,
      this.treeNodeDataList,
      allNodesExpanded = true})
      : _allNodesExpanded = allNodesExpanded;

  bool get allNodesExpanded => _allNodesExpanded;

  List<EHTreeNode>? generateNodeList() {
    if (nodes != null) {
      return nodes;
    } else if (treeNodeDataList != null) {
      nodes = treeNodeDataList!.map((e) => _generateNode(e)).toList();
      return nodes;
    } else {
      return null;
    }
  }

  EHTreeNode _generateNode(EHTreeNodeData treeNodeData) {
    List<EHTreeNode>? children;

    if (treeNodeData.children != null)
      children = treeNodeData.children!
          .map((treeNodeData) => _generateNode(treeNodeData))
          .toList();

    EHTreeNode treeNode = EHTreeNode(
        key: GlobalKey(),
        displayName: treeNodeData.displayName,
        children: children,
        icon: treeNodeData.icon,
        showCheckBox: showCheckBox,
        checked: treeNodeData.isChecked);

    return treeNode;
  }

  bool isNodeExpanded(Key key) {
    return _expanded[key] ?? _allNodesExpanded;
  }

  void toggleNodeExpanded(Key key) {
    _expanded[key] = !isNodeExpanded(key);
  }

  void expandAll() {
    _allNodesExpanded = true;
    _expanded.clear();
  }

  void collapseAll() {
    _allNodesExpanded = false;
    _expanded.clear();
  }

  void expandNode(Key key) {
    _expanded[key] = true;
  }

  void collapseNode(Key key) {
    _expanded[key] = false;
  }
}
