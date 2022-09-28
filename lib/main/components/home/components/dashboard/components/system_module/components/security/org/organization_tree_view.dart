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

import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/components/org_tree_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_tree_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';

import 'organization_model.dart';

class OrganizationTreeView extends EHPanel<OrganizationTreeController> {
  OrganizationTreeView({Key? key, controller})
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
                      masterPanel: OrgTreeComponent(
                        controller: controller.orgTreeCompController,
                      ),
                      detailPanel: Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: EHTabsView(
                            expandMode: EHTabsViewExpandMode.Scroll,
                            controller: controller.detailTabsViewController),
                      ),
                      showDetail: controller.orgModel.value != null),
                );
              })),
        ),
      )
    ]);
    // );
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            this.controller.orgModel.value = OrganizationModel(
                parentId: this
                    .controller
                    .orgTreeCompController
                    .orgTreeController
                    .selectedTreeNode
                    .value!
                    .id);
            if (this
                    .controller
                    .organizationDetailViewController
                    .orgDetailViewFormController !=
                null)
              this
                  .controller
                  .organizationDetailViewController
                  .orgDetailViewFormController!
                  .reset();
            controller.refreshOrgDetailData();
          },
          child: Text('common.general.add'.tr),
        )),
        EHButton(
            controller: EHButtonController(
                child: Text('common.general.save'.tr),
                onPressed: () async =>
                    await this.controller.saveOrgDetailView())),
        EHButton(
            controller: EHButtonController(
          child: Text('common.general.delete'.tr),
          onPressed: () async {
            await controller.deleteSelectedOrg();
          },
        )),
      ],
    );
  }
}
