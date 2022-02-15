import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:flutter/material.dart';

class EHIntColumnType extends EHColumnType<int> {
  EHIntColumnType({alignment = Alignment.topRight})
      : super(alignment: alignment);

  @override
  getWidget(int? value) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: EHText(
        text: value == null ? '' : value.toString(),
      ),
    );
  }
}
