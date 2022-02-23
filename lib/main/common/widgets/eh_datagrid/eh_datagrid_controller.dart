import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'eh_column/eh_Image_button_column_type.dart';
import 'eh_datagrid_column_config.dart';
import 'eh_datagrid_source.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EHDataGridController extends EHController {
  // Default pager height
  double rowHeight = 35;
  double dataPagerHeight = 54.0;
  double headerRowHeight = 57.0;
  double? fixedHeight;
  bool showCheckbox;

  ValueChanged<Map>? onRowSelected;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  late EHDataGridSource dataGridSource;

  EHDataGridController(
      {double? fixedHeight,
      required EHDataGridSource dataGridSource,
      this.showCheckbox = false,
      ValueChanged<Map>? onRowSelected}) {
    this.fixedHeight = fixedHeight == null
        ? Responsive.isMobile(Get.context!)
            ? 300
            : double.infinity
        : fixedHeight;

    if (onRowSelected != null &&
        dataGridSource.columnsConfig
            .where((element) => element.columnName == '__select')
            .isEmpty)
      dataGridSource.columnsConfig.insert(
          0,
          EHDataGridColumnConfig(
              columnName: '__select',
              columnType: EHImageButtonColumnType(onPressed: onRowSelected)));

    this.dataGridSource = dataGridSource;
  }
}
