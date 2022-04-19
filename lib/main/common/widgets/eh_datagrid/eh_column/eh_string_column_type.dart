import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
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
          text: value == null || value=='' ? '' : items![value]!,
        ),
      );
    } else
      return Container(
        padding: EdgeInsets.all(this.padding),
        alignment: alignment,
        child: EHText(
          text: value ?? '',
        ),
      );
  }
}
