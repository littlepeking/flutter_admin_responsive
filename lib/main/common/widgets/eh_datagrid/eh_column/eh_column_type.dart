import 'package:eh_flutter_framework/main/common/base/EHException.dart';
import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:flutter/material.dart';

abstract class EHColumnType<T> {
  EHWidgetType widgetType;
  Map<String, String>? selectItems;
  Alignment alignment;
  double padding;
  EHColumnType(
      {this.widgetType = EHWidgetType.Text,
      this.selectItems,
      this.padding = defaultPadding,
      this.alignment = Alignment.topLeft}) {
    if (widgetType == EHWidgetType.DropDown && selectItems == null) {
      throw EHException(
          'selectItems must be provide when EHWidgetType is DropDown');
    }
  }

  getWidget(T value, int rowIndex, String columnName, List<Map> dataList);
}
