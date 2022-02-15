import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:flutter/material.dart';

class EHBoolColumnType extends EHColumnType<bool> {
  EHBoolColumnType({EHWidgetType widgetType = EHWidgetType.CheckBox})
      : super(widgetType: widgetType);

  @override
  getWidget(bool? value) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: Checkbox(
        value: value,
        onChanged: (bool? value) => {},
      ),
    );
  }
}
