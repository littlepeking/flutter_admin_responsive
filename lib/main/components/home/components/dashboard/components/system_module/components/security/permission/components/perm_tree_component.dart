import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:flutter/material.dart';

import 'perm_tree_component_controller.dart';

class PermTreeComponent extends EHStatelessWidget<PermTreeComponentController> {
  PermTreeComponent({Key? key, required controller})
      : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return EHTreeView(
      controller: controller.permTreeController,
    );
  }
}
