import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/components/org_role_component_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class OrgRoleListController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgRoleComponentController orgRoleComponentController;

  OrgRoleListController._create() : super(null);

  static Future<OrgRoleListController> create() async {
    OrgRoleListController self = OrgRoleListController._create();

    self.orgRoleComponentController =
        await OrgRoleComponentController.create(self, extraColumns: [
      EHColumnConf(
          'delete',
          EHImageButtonColumnType(
              icon: null,
              label: 'Delete',
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
          columnHeaderName: 'Delete Role')
    ]);

    return self;
  }
}
