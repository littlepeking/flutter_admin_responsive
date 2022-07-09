import 'package:flutter/material.dart';

import 'node_widget.dart';
import 'tree_controller.dart';

/// Tree view with collapsible and expandable nodes.
class EHTreeView extends StatefulWidget {
  final TreeController treeController;

  EHTreeView({Key? key, required this.treeController}) : super(key: key);

  @override
  _EHTreeViewState createState() => _EHTreeViewState();
}

class _EHTreeViewState extends State<EHTreeView> {
  late TreeController _controller;

  @override
  void initState() {
    _controller = widget.treeController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildNodes();
  }

  Widget buildNodes() {
    if (_controller.treeNodeDataList == null)
      return SizedBox();
    else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var node in _controller.treeNodeDataList!)
            NodeWidget(
              treeNode: node,
              controller: _controller,
            )
        ],
      );
  }
}
