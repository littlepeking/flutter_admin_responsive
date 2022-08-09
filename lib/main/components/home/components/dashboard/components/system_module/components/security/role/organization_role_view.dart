import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';

import 'organization_role_view_controller.dart';

class OrganizationRoleView extends EHPanel<OrganizationRoleViewController> {
  OrganizationRoleView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      // PageStorage(
      //   bucket: controller.pageStorageBucket,
      //   child: Expanded(
      //     child: Container(
      //         decoration: BoxDecoration(
      //             border: Border(top: BorderSide(color: Colors.grey))),
      //         child: Obx(() => EHMasterDetailSplitView(
      //             controller: EHMasterDetailSplitterController(
      //                 viewMode: SplitViewMode.Horizontal,
      //                 splitterWeights: 0.4,
      //                 masterPanel:
      //                     EHTabsView(controller: controller.orgTreeController),
      //                 detailPanel: EHTabsView(
      //                     expandMode: EHTabsViewExpandMode.Flexible,
      //                     controller: controller.detailTabsViewController),
      //                 showDetail: controller.model.value != null)))),
      //   ),
      // )
    ]);
  }
}
