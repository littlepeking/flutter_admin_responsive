import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/components/org_tree_component_controller.dart';
import 'package:flutter/material.dart';

import '../../org/organization_service.dart';

class OrgRoleComponentController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgTreeComponentController orgTreeComponentController;

  late EHTabsViewController detailTabsViewController;

  late EHDataGridController orgRoleDataGridController;

  OrgRoleComponentController._create(EHPanelController parent) : super(parent);

  static Future<OrgRoleComponentController> create(EHPanelController parent,
      {ValueChanged<Map>? onRowSelected,
      List<EHColumnConf> extraColumns = const []}) async {
    OrgRoleComponentController self =
        OrgRoleComponentController._create(parent);

    self.orgTreeComponentController = await OrgTreeComponentController.create(
        self, onTap: (selectedOrgModel) {
      String orgId = selectedOrgModel != null ? selectedOrgModel.id! : "0";
      self.orgRoleDataGridController.dataGridSource.setParam('orgId', orgId);
      self.orgRoleDataGridController.dataGridSource.handleRefresh();
    });

    List treeMapData = await OrganizationService().buildTree();
    await self.orgTreeComponentController.reloadOrgTreeData(treeMapData);

    getOrgRolesDataGridSource() {
      EHServiceDataGridSource dataGridSource = EHServiceDataGridSource(
          serviceName: SecurityServiceNames.RoleService,
          // loadDataAtInit: false,
          columnFilters: [],
          columnsConfig: [
            EHColumnConf('orgId', EHStringColumnType(),
                fullQuanifiedName: 'orgId',
                columnHeaderName: 'common.security.organization',
                hideType: EHGridColHideType.hide),
            EHColumnConf('roleName', EHStringColumnType(),
                fullQuanifiedName: 'roleName',
                columnHeaderName: 'common.security.roleName'),
            EHColumnConf('displayName', EHStringColumnType(),
                fullQuanifiedName: 'displayName',
                columnHeaderName: 'common.general.description'),
            ...extraColumns
          ],
          params: {
            'orgId': '0'
          });
      return dataGridSource;
    }

    self.orgRoleDataGridController = EHDataGridController(
        wrapWithExpanded: false,
        onRowSelected: onRowSelected,
        disableFixedHeight: true,
        // onRowSelected: (data) =>
        //     EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: getOrgRolesDataGridSource());

    self.detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('common.security.roleList', self.orgRoleDataGridController,
          (EHController c) {
        return EHDataGrid(controller: c);
      }, expandMode: EHTabsViewExpandMode.Expand),
    ]);

    return self;
  }
}
