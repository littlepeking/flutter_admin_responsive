import 'package:flutter/material.dart';

import 'node_widget.dart';
import 'primitives/tree_controller.dart';

Widget buildNodes(TreeController controller) {
  controller.generateNodeList();

  if (controller.nodes == null)
    return SizedBox();
  else
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var node in controller.nodes!)
          NodeWidget(
            treeNode: node,
            state: controller,
          )
      ],
    );
}
