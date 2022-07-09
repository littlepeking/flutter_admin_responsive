// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';

import 'builder.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Widget that displays one [TreeNode] and its children.
class NodeWidget extends StatefulWidget {
  final TreeNode treeNode;
  final TreeController state;

  const NodeWidget({
    Key? key,
    required this.treeNode,
    required this.state,
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
    return widget.state.isNodeExpanded(widget.treeNode.key!);
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
            () => widget.state.toggleNodeExpanded(widget.treeNode.key!));

    List<NodeWidget> children = [];

    if (widget.treeNode.children != null) {
      for (var node in widget.treeNode.children!) {
        children.add(NodeWidget(
          treeNode: node,
          state: widget.state,
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: widget.state.nodeMaxSize,
              child: IconButton(
                padding: EdgeInsets.all(widget.state.paddingSize),
                iconSize: widget.state.iconSize,
                icon: Icon(icon),
                onPressed: onIconPressed,
              ),
            ),
            widget.treeNode.content,
          ],
        ),
        if (_isExpanded && !_isLeaf)
          Padding(
            padding: EdgeInsets.only(left: widget.state.indent),
            child: Column(children: children),
          )
      ],
    );
  }
}
