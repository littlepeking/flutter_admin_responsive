import 'package:eh_flutter_framework/main/common/base/StatefulWrapper.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:flutter/material.dart';

import 'org_tree_comp_controller.dart';

class OrgTreeCompView extends EHStatelessWidget<OrgTreeCompController> {
  OrgTreeCompView({Key? key, required OrgTreeCompController controller})
      : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () async {
        //Here use StatefulWrapper to make sure tree node is only loaded in first time and will no need to load in the widget next rebuild as stateless widget might rebuild at any time, which is out of our control.
        //if need refresh the tree then we can add a 'refresh' button.
        // if (controller.orgTreeController.treeNodeDataList.length == 0) {
        //   await controller.reloadOrgTreeData();
        // }

        await controller.reloadOrgTreeData();
      },
      child: EHTreeView(
        controller: controller.orgTreeController,
      ),
    );
  }
}
