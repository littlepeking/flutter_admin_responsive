import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/common_constant.dart';

class EHDateColumnType extends EHColumnType<DateTime> {
  String dateFormat;
  EHDateColumnType({this.dateFormat = CommonConstant.defaultDateFormat});

  @override
  getWidget(DateTime? value, int rowIndex, columnName, List<Map> dataList) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: EHText(
        textMsgKey: value == null ? '' : DateFormat(dateFormat).format(value),
      ),
    );
  }
}
