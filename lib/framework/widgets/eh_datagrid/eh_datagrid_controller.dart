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

import 'package:enhantec_platform_ui/framework/base/eh_controller.dart';
import 'package:enhantec_platform_ui/framework/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'eh_column/eh_image_button_column_type.dart';
import 'eh_datagrid_column_config.dart';
import 'eh_datagrid_source.dart';

class EHDataGridController extends EHController {
  // Default pager height
  double rowHeight = 35;
  double dataPagerHeight = 44.0;
  double headerRowHeight = 57.0;
  double? fixedHeight;
  bool showCheckbox;
  bool disableFixedHeight;
  bool wrapWithExpanded;

  ValueChanged<Map>? onRowSelected;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  late EHDataGridSource dataGridSource;

  EHDataGridController(
      {double? fixedHeight,
      required EHDataGridSource dataGridSource,
      this.showCheckbox = false,
      this.disableFixedHeight = false,
      this.wrapWithExpanded = false,
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
          EHColumnConf(
              '__select', EHImageButtonColumnType(onPressed: onRowSelected),
              columnHeaderMsgKey: '', columnWidth: 36));

    this.dataGridSource = dataGridSource;
  }
}
