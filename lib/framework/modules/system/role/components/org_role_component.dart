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

import 'package:enhantec_platform_ui/framework/base/eh_panel.dart';
import 'package:enhantec_platform_ui/framework/utils/eh_util_helper.dart';
import 'package:enhantec_platform_ui/framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_master_detail_splitter.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_platform_ui/framework/modules/system/org/components/org_tree_component.dart';

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
                          Text('common.security.selectOrg'.tr)
                        ],
                      ))))),
        ),
      )
    ]);
  }
}
