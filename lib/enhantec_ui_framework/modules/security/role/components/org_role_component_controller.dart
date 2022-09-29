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
import 'package:enhantec_frontend_project/enhantec_ui_framework/services/service_names.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/org/components/org_tree_component_controller.dart';
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
                columnHeaderMsgKey: 'common.security.organization',
                hideType: EHGridColHideType.hide),
            EHColumnConf('roleName', EHStringColumnType(),
                fullQuanifiedName: 'roleName',
                columnHeaderMsgKey: 'common.security.roleName'),
            EHColumnConf('displayName', EHStringColumnType(),
                fullQuanifiedName: 'displayName',
                columnHeaderMsgKey: 'common.general.description'),
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
      EHTab('roleList', 'common.security.roleList',
          self.orgRoleDataGridController, (EHController c) {
        return EHDataGrid(controller: c);
      }, expandMode: EHTabsViewExpandMode.Expand),
    ]);

    return self;
  }
}
