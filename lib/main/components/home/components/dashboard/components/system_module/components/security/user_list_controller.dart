import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/constants/common_constant.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:flutter/material.dart';

class UserListController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHDataGridController userDataGridController;

  UserListController() : super(null) {
    userDataGridController = EHDataGridController(
        showCheckbox: true,
        expandInMobile: true,
        onRowSelected: (data) =>
            EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: getServiceDataGridSource());
  }

  getServiceDataGridSource() {
    return EHServiceDataGridSource(
      serviceName: '/security/user',
      // loadDataAtInit: false,
      columnFilters: [
        EHFilterInfo(columnName: 'editDate', sort: EHDataGridColumnSortType.Asc)
      ],
      columnsConfig: [
        EHColumnConf('id', EHStringColumnType(),
            columnHeaderName: 'Id', hideType: EHGridColHideType.hide),
        EHColumnConf('username', EHStringColumnType(),
            columnHeaderName: 'Username'),
        EHColumnConf('domainUsername', EHStringColumnType(),
            columnHeaderName: 'Domain Username'),
        EHColumnConf(
            'authType',
            EHStringColumnType(
                widgetType: EHWidgetType.DropDown,
                items: {'BASIC': 'BASIC', 'LDAP': 'LDAP'}),
            columnHeaderName: 'Auth Type'),

        EHColumnConf('enabled', EHBoolColumnType(),
            columnHeaderName: 'Enabled'),
        EHColumnConf('accountLocked', EHBoolColumnType(),
            columnHeaderName: 'Account Locked'),
        EHColumnConf('credentialsExpired', EHBoolColumnType(),
            columnHeaderName: 'Credentials Expired'),
        EHColumnConf('addWho', EHStringColumnType(),
            columnHeaderName: 'Add Who'),
        EHColumnConf('addDate',
            EHDateColumnType(dateFormat: CommonConstant.defaultDateTimeFormat),
            columnHeaderName: 'Add Date'),

        EHColumnConf('editWho', EHStringColumnType(),
            columnHeaderName: 'Edit Who'),
        EHColumnConf('editDate',
            EHDateColumnType(dateFormat: CommonConstant.defaultDateTimeFormat),
            columnHeaderName: 'Edit Date'),
        // EHColumnConf('isConfirmed', EHBoolColumnType(), columnWidth: 110),
      ],
    );
  }
}
