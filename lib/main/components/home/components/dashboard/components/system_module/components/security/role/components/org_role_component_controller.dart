import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/components/org_tree_component_controller.dart';
import 'package:flutter/material.dart';

class OrgRoleComponentController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late OrgTreeComponentController orgTreeComponentController;

  late EHTabsViewController detailTabsViewController;

  late EHDataGridController orgRoleDataGridController;

  OrgRoleComponentController._create(EHPanelController parent) : super(parent);

  static Future<OrgRoleComponentController> create(EHPanelController parent,
      {List<EHColumnConf> extraColumns = const []}) async {
    OrgRoleComponentController self =
        OrgRoleComponentController._create(parent);

    self.orgTreeComponentController = await OrgTreeComponentController.create(
        self, onTap: (selectedOrgModel) {
      if (selectedOrgModel != null) {
        self.orgRoleDataGridController.dataGridSource
            .setParam('orgId', selectedOrgModel.id);
        self.orgRoleDataGridController.dataGridSource.handleRefresh();
      }
    });

    getOrgRolesDataGridSource() {
      EHServiceDataGridSource dataGridSource = EHServiceDataGridSource(
          serviceName: '/security/role',
          actionName: 'queryUserRoleByPage',
          // loadDataAtInit: false,
          columnFilters: [],
          columnsConfig: [
            EHColumnConf('name', EHStringColumnType(),
                fullQuanifiedName: 'org.name',
                columnHeaderName: 'Organization'),
            EHColumnConf('roleName', EHStringColumnType(),
                fullQuanifiedName: 'r.roleName', columnHeaderName: 'Role Name'),
            EHColumnConf('displayName', EHStringColumnType(),
                fullQuanifiedName: 'r.displayName',
                columnHeaderName: 'Description'),
            ...extraColumns
          ],
          params: {
            'userId': '1515880093879160833'
          });
      return dataGridSource;
    }

    self.orgRoleDataGridController = EHDataGridController(
        wrapWithExpanded: false,
        showCheckbox: false,
        // onRowSelected: (data) =>
        //     EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: getOrgRolesDataGridSource());

    self.detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Roles List', self.orgRoleDataGridController, (EHController c) {
        return EHDataGrid(controller: c);
      }),
    ]);

    return self;
  }
}
