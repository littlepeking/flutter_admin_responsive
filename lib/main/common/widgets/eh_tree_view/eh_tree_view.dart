import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_node_widget.dart';
import 'eh_tree_controller.dart';

/// Tree view with collapsible and expandable nodes.
class EHTreeView extends EHStatelessWidget<EHTreeController> {
  EHTreeView({Key? key, required EHTreeController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    controller.reCalculateAllCheckStatus();
    return buildNodes();
  }

  Widget buildNodes() {
    if (controller.treeNodeDataList == null)
      return SizedBox();
    else
      return Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var node in controller.treeNodeDataList!)
                EHNodeWidget(
                  treeNode: node,
                  controller: controller,
                )
            ],
          ));
  }
}
