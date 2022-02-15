import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EHDateColumnType extends EHColumnType<DateTime> {
  String dateFormat;
  EHDateColumnType({this.dateFormat = 'yyyy/MM/dd'});

  @override
  getWidget(DateTime? value) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: EHText(
        text: value == null ? '' : DateFormat(dateFormat).format(value),
      ),
    );
  }
}
