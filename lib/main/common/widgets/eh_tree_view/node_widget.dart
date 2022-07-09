import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/tree_node_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tree_controller.dart';

/// Widget that displays one [EHTreeNodeData] and its children.
class NodeWidget extends StatefulWidget {
  final EHTreeNodeData treeNode;
  final TreeController controller;

  const NodeWidget({
    Key? key,
    required this.treeNode,
    required this.controller,
  }) : super(key: key);

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
  bool get _isLeaf {
    return widget.treeNode.children == null ||
        widget.treeNode.children!.isEmpty;
  }

  bool get _isExpanded {
    return widget.controller.isNodeExpanded(widget.treeNode);
  }

  @override
  Widget build(BuildContext context) {
    var icon = _isLeaf
        ? null
        : _isExpanded
            ? Icons.expand_more
            : Icons.chevron_right;

    var onIconPressed = _isLeaf
        ? null
        : () => setState(
            () => widget.controller.toggleNodeExpanded(widget.treeNode));

    List<NodeWidget> children = [];

    if (widget.treeNode.children != null) {
      for (var node in widget.treeNode.children!) {
        children.add(NodeWidget(
          treeNode: node,
          controller: widget.controller,
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: widget.controller.nodeMaxSize,
              child: IconButton(
                padding: EdgeInsets.all(widget.controller.paddingSize),
                iconSize: widget.controller.iconSize,
                icon: Icon(icon),
                onPressed: onIconPressed,
              ),
            ),
            Row(
              children: [
                if (widget.controller.showCheckBox)
                  Checkbox(
                      tristate: true,
                      value: widget.treeNode.isChecked,
                      onChanged: (val) {
                        setState(() {
                          widget.treeNode.isChecked = getNextCheckStatus(val);
                        });
                      }),
                SizedBox(width: 2),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Text(widget.treeNode.displayName.tr),
                    onTap: widget.treeNode.onTap,
                  ),
                ),
              ],
            )
          ],
        ),
        if (_isExpanded && !_isLeaf)
          Padding(
            padding: EdgeInsets.only(left: widget.controller.indent),
            child: Column(children: children),
          )
      ],
    );
  }

  bool getNextCheckStatus(bool? val) {
    if (val == null)
      return false;
    else
      return val;
  }
}
