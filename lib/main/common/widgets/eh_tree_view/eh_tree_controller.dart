import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

/// A controller for a tree state.
///
/// Allows to modify the state of the tree.
class EHTreeController extends EHController {
  /// Horizontal indent between levels.
  final double indent;

  /// Size of the expand/collapse icon.
  final double? iconSize;

  final double? nodeMaxSize;

  final double paddingSize;

  final bool showCheckBox;

  final bool isNodeSelectable;

  /// Tree controller to manage the tree state.
  bool _allNodesExpanded;
  RxList<EHTreeNode> treeNodeDataList;

  Rx<EHTreeNode?> selectedTreeNode = Rxn();

  EHTreeController(
      {this.indent = 10,
      this.iconSize = 20,
      this.nodeMaxSize,
      this.paddingSize = 6,
      this.showCheckBox = false,
      required this.treeNodeDataList,
      this.isNodeSelectable = false,
      allNodesExpanded = true})
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

    if (treeNode.children != null && treeNode.children!.length > 0) {
      treeNode.children!.forEach((e) {
        checkNode(e, treeNode.isChecked);
      });
    }
  }

  void reCalculateAllCheckStatus() {
    if (treeNodeDataList != null && treeNodeDataList.length > 0)
      treeNodeDataList.forEach((node) {
        recursivelyCalculateCheckStatus(node);
      });
    treeNodeDataList.refresh();
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
}
