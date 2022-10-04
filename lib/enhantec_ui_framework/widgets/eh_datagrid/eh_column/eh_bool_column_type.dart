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

import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_dropdown.dart';
import 'package:flutter/material.dart';

class EHBoolColumnType extends EHColumnType<bool> {
  EHBoolColumnType({EHWidgetType widgetType = EHWidgetType.CheckBox})
      : super(widgetType: widgetType, items: {
          'true': 'common.general.yes',
          'false': 'common.general.no'
        });

  @override
  getWidget(bool? value, int rowIndex, columnName, List<Map> dataList) {
    if (value == null) value = false;

    return widgetType == EHWidgetType.CheckBox
        ? Container(
            padding: EdgeInsets.all(this.padding),
            alignment: alignment,
            child: Checkbox(
              tristate: true,
              value: value,
              onChanged: (bool? value) => {},
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: 5),
            child: EHDropdown(
              controller: EHDropDownController(
                  key: GlobalKey(),
                  width: 60,
                  showErrorInfo: false,
                  showLabel: false,
                  enabled: false,
                  focusNode: FocusNode(),
                  bindingValue: value.toString(),
                  items: items!),
            ),
          );
  }
}
