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

import 'package:enhantec_platform_ui/framework/base/eh_stateless_widget.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:flutter/material.dart';

import 'org_tree_component_controller.dart';

class OrgTreeComponent extends EHStatelessWidget<OrgTreeComponentController> {
  OrgTreeComponent({Key? key, required OrgTreeComponentController controller})
      : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    // return StatefulWrapper(
    //   onInit: () async {
    //     //Here use StatefulWrapper to make sure tree node is only loaded in first time and will no need to load in the widget next rebuild as stateless widget might rebuild at any time, which is out of our control.
    //     //if need refresh the tree then we can add a 'refresh' button.
    //     // if (controller.orgTreeController.treeNodeDataList.length == 0) {
    //     //   await controller.reloadOrgTreeData();
    //     // }

    //     await controller.reloadOrgTreeData();
    //   },
    //   child: EHTreeView(
    //     controller: controller.orgTreeController,
    //   ),
    // );

    return EHTreeView(
      controller: controller.orgTreeController,
    );
  }
}
