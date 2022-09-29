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

import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_panel.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/modules/security/org/organization_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'organization_detail_view_controller.dart';

class OrganizationDetailView extends EHPanel<OrganizationDetailViewController> {
  OrganizationDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => EHEditForm<OrganizationModel>(
            controller: controller.getWidgetControllerFormController!())),
      ],
    );
  }
}
