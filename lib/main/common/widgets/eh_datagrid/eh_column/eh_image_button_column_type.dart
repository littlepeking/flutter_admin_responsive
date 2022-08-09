import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:flutter/material.dart';

class EHImageButtonColumnType extends EHColumnType<Map> {
  IconData icon;
  String? label;
  final ValueChanged<Map>? onPressed;

  EHImageButtonColumnType(
      {this.icon = Icons.exit_to_app,
      this.label,
      Alignment alignment: Alignment.topRight,
      bool hasFilter = false,
      this.onPressed})
      : super(alignment: alignment, hasFilter: hasFilter);

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20),
                if (this.label != null) Text(this.label!)
              ],
            )),
          )),
    );
  }
}
