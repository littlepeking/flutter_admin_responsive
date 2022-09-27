import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:flutter/material.dart';

class EHDoubleColumnType extends EHColumnType<double> {
  int precision;

  EHDoubleColumnType({alignment = Alignment.topRight, this.precision = 2})
      : super(alignment: alignment);

  @override
  getWidget(double? value, int rowIndex, columnName, List<Map> dataList) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: EHText(
        textMsgKey: value == null ? '' : value.toStringAsFixed(precision),
      ),
    );
  }
}
