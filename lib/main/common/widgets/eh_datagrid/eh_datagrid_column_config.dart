import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_Image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:get/get.dart';

class EHDataGridColumnConfig {
  String columnName;

  String? sortColumnName; //排序时使用的列，默认为columnName
  //列头显示名称
  String? columnHeaderName;
  //控件类型：用于排序比较和选择控件展示
  EHColumnType columnType;

  RxDouble width; // Double.nan.obs;

  bool hideInMobile;

  EHDataGridColumnConfig(
      {required this.columnName,
      required this.columnType,
      double? columnWidth,
      this.columnHeaderName,
      this.sortColumnName,
      this.hideInMobile = false})
      : width = (columnType is EHImageButtonColumnType)
            ? 36.0.obs
            : columnWidth == null
                ? 150.0.obs
                : columnWidth.obs;
}
