import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node_data.dart';
import 'package:get/get_connect/http/src/http/io/file_decoder_io.dart';

/// A controller for a tree state.
///
/// Allows to modify the state of the tree.
class EHTreeController {
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

  EHTreeController(
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

  void checkNode(EHTreeNodeData treeNode, bool? val) {
    treeNode.isChecked = getNextCheckStatus(val);

    if (treeNode.children != null && treeNode.children!.length > 0) {
      treeNode.children!.forEach((e) {
        checkNode(e, treeNode.isChecked);
      });
    }
  }

  void reCalculateAllCheckStatus() {
    if (treeNodeDataList != null && treeNodeDataList!.length > 0)
      treeNodeDataList!.forEach((node) {
        recursivelyCalculateCheckStatus(node);
      });
  }

  bool? recursivelyCalculateCheckStatus(EHTreeNodeData node) {
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
}
