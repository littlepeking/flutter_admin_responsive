import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/constants/common_constant.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/components/org_role_component_controller.dart';
import 'package:flutter/material.dart';

class OrgRoleListController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgRoleComponentController orgRoleComponentController;

  OrgRoleListController._create() : super(null);

  static Future<OrgRoleListController> create() async {
    OrgRoleListController self = OrgRoleListController._create();

    self.orgRoleComponentController =
        await OrgRoleComponentController.create(self);

    return self;
  }
}
