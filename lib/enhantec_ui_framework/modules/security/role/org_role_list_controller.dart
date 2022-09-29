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

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_panel_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_toast_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_image_button_column_type.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/role/components/org_role_component_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/role/role_service.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'role_edit_controller.dart';
import 'role_edit_view.dart';

class OrgRoleListController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgRoleComponentController orgRoleComponentController;

  OrgRoleListController._create() : super(null);

  static Future<OrgRoleListController> create() async {
    OrgRoleListController self = OrgRoleListController._create();

    self.orgRoleComponentController =
        await OrgRoleComponentController.create(self,
            onRowSelected: (dataRow) async => {
                  Get.find<SystemModuleController>().tabViewController.addTab(
                          EHTab<RoleEditController>(
                              'edit',
                              'common.general.edit',
                              await RoleEditController.create(
                                  params: {'id': dataRow['id']}),
                              (EHController controller) {
                        return RoleEditView(controller: controller);
                      },
                              closable: true,
                              expandMode: EHTabsViewExpandMode.Expand))
                },
            extraColumns: [
          EHColumnConf(
              'delete',
              EHImageButtonColumnType(
                  icon: null,
                  labelMsgKey: 'common.general.delete',
                  onPressed: (dataRow) async {
                    await RoleService().deleteById(dataRow['id']);

                    self.orgRoleComponentController.orgRoleDataGridController
                        .dataGridSource
                        .handleRefresh();

                    EHToastMessageHelper.showInfoMessage(
                        'Role @displayName delete successfully'.trParams({
                      'displayName': dataRow['displayName'],
                    }));
                  }),
              columnHeaderMsgKey: 'common.security.deleteRole')
        ]);

    return self;
  }
}
