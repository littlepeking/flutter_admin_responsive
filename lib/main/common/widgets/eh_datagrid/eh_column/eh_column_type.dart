import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:flutter/material.dart';

abstract class EHColumnType<T> {
  EHWidgetType widgetType;
  Alignment alignment;
  double padding;
  EHColumnType(
      {this.widgetType = EHWidgetType.Text,
      this.padding = defaultPadding,
      this.alignment = Alignment.topLeft});

  getWidget(T value);
}
