import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/components/org_tree_component.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';

import 'org_role_component_controller.dart';

class OrgRoleComponent extends EHPanel<OrgRoleComponentController> {
  OrgRoleComponent({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      PageStorage(
        bucket: controller.pageStorageBucket,
        child: Expanded(
          child: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))),
              child: Obx(() => EHMasterDetailSplitView(
                  controller: EHMasterDetailSplitterController(
                      viewMode: Responsive.isMobile(Get.context!)
                          ? SplitViewMode.Vertical
                          : SplitViewMode.Horizontal,
                      splitterWeights: 0.3,
                      masterPanel: OrgTreeComponent(
                          controller: controller.orgTreeComponentController),
                      detailPanel: EHTabsView(
                          expandMode: EHTabsViewExpandMode.Expand,
                          controller: controller.detailTabsViewController),
                      showDetail: !EHUtilHelper.isEmpty(controller
                          .orgTreeComponentController
                          .orgTreeController
                          .selectedTreeNode
                          .value),
                      placeHolderWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.tips_and_updates),
                          Text('Please select an organization'.tr)
                        ],
                      ))))),
        ),
      )
    ]);
  }
}
