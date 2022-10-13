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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_panel.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_edit_form.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/role/role_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'role_detail_general_controller.dart';

class RoleDetailGeneralView extends EHPanel<RoleDetailGeneralController> {
  RoleDetailGeneralView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => EHEditForm<RoleModel>(
            controller: controller.getEditFormController!())),
      ],
    );
  }
}
