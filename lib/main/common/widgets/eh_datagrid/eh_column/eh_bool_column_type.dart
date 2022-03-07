import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:flutter/material.dart';

class EHBoolColumnType extends EHColumnType<bool> {
  EHBoolColumnType({EHWidgetType widgetType = EHWidgetType.CheckBox})
      : super(widgetType: widgetType);

  @override
  getWidget(bool value, int rowIndex, columnName, List<Map> dataList) {
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
                  items: {'true': 'Yes', 'false': 'No'}),
            ),
          );
  }
}
