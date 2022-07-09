// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/tree_node_data.dart';
import 'package:flutter/material.dart';

import 'builder.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatefulWidget {
  final TreeController treeController;

  TreeView({Key? key, List<TreeNode>? nodes, required this.treeController})
      : super(key: key);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  late TreeController _controller;

  @override
  void initState() {
    _controller = widget.treeController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildNodes(_controller);
  }
}
