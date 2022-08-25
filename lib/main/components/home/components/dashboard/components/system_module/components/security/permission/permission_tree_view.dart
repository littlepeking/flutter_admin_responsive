import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_tree_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';

import 'permission_model.dart';

class PermissionTreeView extends EHPanel<PermissionTreeController> {
  PermissionTreeView({Key? key, controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return
        // StatefulWrapper(
        //   onInit: () {
        //     // if (controller.orgTreeController.treeNodeDataList.length == 0) {
        //     //   controller.reloadOrgTreeData();
        //     // }
        //   },
        //   child:
        Column(children: [
      buildToolbar(context),
      SizedBox(
        height: 5,
      ),
      PageStorage(
        bucket: controller.pageStorageBucket,
        child: Expanded(
          child: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))),
              child: Obx(() {
                SplitViewMode splitViewMode = Responsive.isMobile(Get.context!)
                    ? SplitViewMode.Vertical
                    : SplitViewMode.Horizontal;
                return EHMasterDetailSplitView(
                  controller: EHMasterDetailSplitterController(
                      splitterWeights: 0.3,
                      maxWeight: 0.8,
                      viewMode: splitViewMode,
                      masterPanel: PermTreeComponent(
                        controller: controller.permTreeCompController,
                      ),
                      detailPanel: Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: EHTabsView(
                            expandMode: EHTabsViewExpandMode.Scrollable,
                            controller: controller.detailTabsViewController),
                      ),
                      showDetail: controller.permissionModel.value != null),
                );
              })),
        ),
      )
    ]);
    // );
  }

  buildToolbar(BuildContext context) {
    isTreeNodeEditable() {
      return controller.permissionModel.value != null &&
          controller.permissionModel.value!.id != "0";
    }

    return Obx(() => EHToolBar(
          children: [
            EHButton(
                controller: EHButtonController(
              onPressed: () async {
                this.controller.permissionModel.value = PermissionModel(
                    parentId: this
                        .controller
                        .permTreeCompController
                        .permTreeController
                        .selectedTreeNode
                        .value!
                        .id!);
                if (this
                        .controller
                        .permissionDetailViewController
                        .detailViewFormController !=
                    null)
                  this
                      .controller
                      .permissionDetailViewController
                      .detailViewFormController!
                      .reset();
                controller.refreshPermDetailData();
              },
              child: Text('Add'.tr),
            )),
            EHButton(
                controller: EHButtonController(
                    enabled: isTreeNodeEditable(),
                    child: Text('Save'.tr),
                    onPressed: () async =>
                        await this.controller.savePermDetailView())),
            EHButton(
                controller: EHButtonController(
              enabled: isTreeNodeEditable(),
              child: Text('Delete'.tr),
              onPressed: () async {
                await controller.deleteSelectedPerm();
              },
            )),
          ],
        ));
  }
}
