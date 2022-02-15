import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:flutter/material.dart';

import '../../eh_text.dart';

class EHStringColumnType extends EHColumnType<String> {
  TextOverflow overflow;
  EHStringColumnType(
      {this.overflow = TextOverflow.ellipsis, alignment = Alignment.topLeft})
      : super(alignment: alignment);

  @override
  getWidget(String value) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: EHText(
        text: value,
      ),
    );
  }
}
