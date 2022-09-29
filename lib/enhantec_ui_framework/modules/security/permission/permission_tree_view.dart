/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_panel.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_toast_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_button.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_master_detail_splitter.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_toolbar.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/permission/components/perm_tree_component.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/permission/permission_tree_controller.dart';
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
                            expandMode: EHTabsViewExpandMode.Scroll,
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
                if (this
                            .controller
                            .permTreeCompController
                            .permTreeController
                            .selectedTreeNode
                            .value !=
                        null &&
                    (this
                                .controller
                                .permTreeCompController
                                .permTreeController
                                .selectedTreeNode
                                .value!
                                .data as PermissionModel)
                            .type ==
                        'D') {
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
                } else {
                  EHToastMessageHelper.showInfoMessage(
                      'common.security.selectOrgBeforeCreatePerm');
                }
              },
              child: Text('common.general.add'.tr),
            )),
            EHButton(
                controller: EHButtonController(
                    enabled: isTreeNodeEditable(),
                    child: Text('common.general.save'.tr),
                    onPressed: () async =>
                        await this.controller.savePermDetailView())),
            EHButton(
                controller: EHButtonController(
              enabled: isTreeNodeEditable(),
              child: Text('common.general.delete'.tr),
              onPressed: () async {
                await controller.deleteSelectedPerm();
              },
            )),
          ],
        ));
  }
}
