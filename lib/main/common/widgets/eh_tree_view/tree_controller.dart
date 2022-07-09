import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/tree_node_data.dart';

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
  List<EHTreeNodeData>? treeNodeDataList;

  TreeController(
      {this.indent = 10,
      this.iconSize = 20,
      this.nodeMaxSize,
      this.paddingSize = 6,
      this.showCheckBox = false,
      this.treeNodeDataList,
      allNodesExpanded = true})
      : _allNodesExpanded = allNodesExpanded;

  bool get allNodesExpanded => _allNodesExpanded;

  bool isNodeExpanded(EHTreeNodeData treeNode) {
    return treeNode.isExpanded;
  }

  void toggleNodeExpanded(EHTreeNodeData treeNode) {
    treeNode.isExpanded = !isNodeExpanded(treeNode);
  }

  // void expandAll() {
  //   _allNodesExpanded = true;
  //   _expanded.clear();
  // }

  // void collapseAll() {
  //   _allNodesExpanded = false;
  //   _expanded.clear();
  // }

  void expandNode(EHTreeNodeData treeNode) {
    treeNode.isExpanded = true;
  }

  void collapseNode(EHTreeNodeData treeNode) {
    treeNode.isExpanded = false;
  }
}
