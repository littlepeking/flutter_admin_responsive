import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:flutter/material.dart';

abstract class EHColumnType<T> {
  EHWidgetType widgetType;
  Map<String, String>? items;
  Alignment alignment;
  double padding;
  bool hasFilter;
  EHColumnType(
      {this.widgetType = EHWidgetType.Text,
      this.items = const {'': ''},
      this.padding = defaultPadding,
      this.alignment = Alignment.topLeft,
      this.hasFilter = true});

  getWidget(T value, int rowIndex, String columnName, List<Map> dataList);
}
