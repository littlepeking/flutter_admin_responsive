import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHImageButtonColumnType extends EHColumnType<Map> {
  IconData? icon;
  String? labelMsgKey;
  final ValueChanged<Map>? onPressed;

  EHImageButtonColumnType(
      {this.icon = Icons.exit_to_app,
      this.labelMsgKey,
      Alignment alignment: Alignment.center,
      bool hasFilter = false,
      this.onPressed})
      : super(alignment: alignment, hasFilter: hasFilter);

  @override
  getWidget(Map value, int rowIndex, String columnName, List<Map> dataList) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: Container(
          //IntrinsicWidth make row width fit children and no expand.
          child: IntrinsicWidth(
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => onPressed == null
                    ? () => {}
                    : onPressed!(dataList[rowIndex]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) Icon(icon, size: 20),
                    if (this.labelMsgKey != null)
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Text(this.labelMsgKey!.tr),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(Get.context!).primaryColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(defaultPadding),
                            ),
                          ))
                  ],
                ))),
      )),
    );
  }
}
