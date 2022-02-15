import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:flutter/material.dart';

class EHImageButtonColumnType extends EHColumnType<Map> {
  IconData icon;
  final ValueChanged<Map>? onPressed;

  EHImageButtonColumnType(
      {this.icon = Icons.exit_to_app,
      alignment: Alignment.topRight,
      this.onPressed})
      : super(alignment: alignment);

  @override
  getWidget(Map value, int rowIndex, String columnName, List<Map> dataList) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () =>
                onPressed == null ? () => {} : onPressed!(dataList[rowIndex]),
            child: Container(
                child: Row(
              children: [Icon(icon, size: 20)],
            )),
          )),
    );
  }
}
