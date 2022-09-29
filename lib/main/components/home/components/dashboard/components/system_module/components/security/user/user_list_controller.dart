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

import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/constants/common_constant.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_edit_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_edit_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHDataGridController userDataGridController;

  UserListController() : super(null) {
    userDataGridController = EHDataGridController(
        showCheckbox: true,
        disableFixedHeight: true,
        onRowSelected: (data) async => Get.find<SystemModuleController>()
            .tabViewController
            .addTab(EHTab<UserEditController>('edit', 'common.general.edit',
                await UserEditController.create(params: {'id': data['id']}),
                (EHController controller) {
              return UserEditView(controller: controller);
            }, closable: true, expandMode: EHTabsViewExpandMode.Expand)),
        dataGridSource: getUserListDataGridSource());
  }

  getUserListDataGridSource() {
    return EHServiceDataGridSource(
      serviceName: '/security/user',
      loadDataAtInit: false,
      columnFilters: [
        EHFilterInfo(
            columnName: 'editDate', sort: EHDataGridColumnSortType.Desc)
      ],
      columnsConfig: [
        EHColumnConf('id', EHStringColumnType(),
            columnHeaderMsgKey: 'common.general.id',
            hideType: EHGridColHideType.hide),
        EHColumnConf('username', EHStringColumnType(),
            columnHeaderMsgKey: 'common.security.username'),
        EHColumnConf('domainUsername', EHStringColumnType(),
            columnHeaderMsgKey: 'common.security.domainUsername'),
        EHColumnConf(
            'authType',
            EHStringColumnType(
                widgetType: EHWidgetType.DropDown,
                items: {'BASIC': 'BASIC', 'LDAP': 'LDAP'}),
            columnHeaderMsgKey: 'common.security.authType'),

        EHColumnConf('enabled', EHBoolColumnType(),
            columnHeaderMsgKey: 'common.general.isEnabled'),
        EHColumnConf('accountLocked', EHBoolColumnType(),
            columnHeaderMsgKey: 'common.security.accountLocked'),
        EHColumnConf('credentialsExpired', EHBoolColumnType(),
            columnHeaderMsgKey: 'common.security.credentialsExpired'),
        EHColumnConf('addWho', EHStringColumnType(),
            columnHeaderMsgKey: 'common.general.addWho'),
        EHColumnConf('addDate',
            EHDateColumnType(dateFormat: CommonConstant.defaultDateTimeFormat),
            columnHeaderMsgKey: 'common.general.addDate'),

        EHColumnConf('editWho', EHStringColumnType(),
            columnHeaderMsgKey: 'common.general.editWho'),
        EHColumnConf('editDate',
            EHDateColumnType(dateFormat: CommonConstant.defaultDateTimeFormat),
            columnHeaderMsgKey: 'common.general.editDate'),
        // EHColumnConf('isConfirmed', EHBoolColumnType(), columnWidth: 110),
      ],
    );
  }
}
