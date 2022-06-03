import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
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
            columnHeaderName: 'USERID', hideType: EHGridColHideType.hide),
        EHColumnConf('username', EHStringColumnType(),
            columnHeaderName: 'USERNAME'),
        EHColumnConf('domainUsername', EHStringColumnType(),
            columnHeaderName: 'AD USERNAME'),
        EHColumnConf(
            'authType',
            EHStringColumnType(
                widgetType: EHWidgetType.DropDown,
                items: {'BASIC': 'BASIC', 'LDAP': 'LDAP'}),
            columnHeaderName: 'AUTH TYPE'),

        EHColumnConf('enabled', EHBoolColumnType(),
            columnHeaderName: 'ENABLED'),
        EHColumnConf('accountLocked', EHBoolColumnType(),
            columnHeaderName: 'IS LOCKED'),
        EHColumnConf('credentialsExpired', EHBoolColumnType(),
            columnHeaderName: 'EXPIRED'),
        EHColumnConf('addWho', EHStringColumnType(),
            columnHeaderName: 'ADD BY'),
        EHColumnConf('addDate', EHDateColumnType(),
            columnHeaderName: 'ADD DATE'),

        EHColumnConf('editWho', EHStringColumnType(),
            columnHeaderName: 'EDIT WHO'),
        EHColumnConf('editDate', EHDateColumnType(),
            columnHeaderName: 'EDIT DATE'),
        // EHColumnConf('isConfirmed', EHBoolColumnType(), columnWidth: 110),
      ],
    );
  }
}
