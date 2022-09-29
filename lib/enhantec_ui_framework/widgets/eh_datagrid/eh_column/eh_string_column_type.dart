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

import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_selectable_text.dart';
import 'package:flutter/material.dart';

import '../../eh_text.dart';

class EHStringColumnType extends EHColumnType<String> {
  TextOverflow overflow;
  EHStringColumnType(
      {EHWidgetType widgetType = EHWidgetType.Text,
      Map<String, String>? items,
      this.overflow = TextOverflow.ellipsis,
      alignment = Alignment.topLeft})
      : super(alignment: alignment, widgetType: widgetType, items: items);

  @override
  getWidget(String? value, int rowIndex, columnName, List<Map> dataList) {
    if (widgetType == EHWidgetType.DropDown) {
      // throw EHException(
      //     'selectItems must be provide when EHWidgetType is DropDown');

      return Container(
        padding: EdgeInsets.all(this.padding),
        alignment: alignment,
        child: EHText(
          text: value == null || value == '' || !items!.containsKey(value)
              ? ''
              : items![value]!,
        ),
      );
    } else
      return Container(
        padding: EdgeInsets.all(this.padding),
        alignment: alignment,
        child: EHSelectableText(
          text: value ?? '',
        ),
      );
  }
}
