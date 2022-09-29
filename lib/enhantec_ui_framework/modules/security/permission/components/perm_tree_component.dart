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

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_stateless_widget.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_view.dart';
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
