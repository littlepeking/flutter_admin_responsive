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
import 'package:eh_flutter_framework/enhantec_ui_framework/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_button.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/modules/security/role/role_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'role_edit_controller.dart';

class RoleEditView extends EHPanel<RoleEditController> {
  RoleEditView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildToolbar(context),
        Expanded(
          child: EHTabsView(controller: controller.headerTabsViewController),
        ),
      ],
    );
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            if (await controller.roleGeneralInfoController.editFormController!
                .validate()) {
              //bool isCreateNewRole = controller.model.value.id == null;
              await RoleService()
                  .createOrUpdateRxModel(model: controller.model);
              await controller.updateRolePermissions(
                  roleId: controller.model.value.id!);
              controller.reloadData();
              EHToastMessageHelper.showInfoMessage('common.security.roleSaved'
                  .trParams(
                      {'displayName': controller.model.value.displayName!}));
            }
          },
          child: Text('common.general.save'.tr),
        )),
        Container(
          // width: 90,
          child: EHDropdown(
              controller: EHDropDownController(
            key: GlobalKey(),
            focusNode: FocusNode(),
            isMenu: true,
            dropDownWidth: 150,
            labelMsgKey: 'common.general.actions',
            items: {'print': 'Print'},
            onChanged: (value) {},
          )),
        )
      ],
    );
  }
}
