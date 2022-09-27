import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:get/get.dart';

class EHColumnConf {
  String columnName;

  String?
      fullQuanifiedName; //For matching exact DB column name to avoid multi tab;e columns name conflict. e.g.: a.receiptKey

  String? sortColumnName; //排序时使用的列，默认为columnName
  //列头显示名称
  String? columnHeaderMsgKey;
  //控件类型：用于排序比较和选择控件展示
  EHColumnType columnType;

  RxDouble width; // Double.nan.obs;

  EHGridColHideType hideType;

  EHColumnConf(
    this.columnName,
    this.columnType, {
    this.fullQuanifiedName,
    double? columnWidth,
    this.columnHeaderMsgKey,
    this.sortColumnName,
    this.hideType = EHGridColHideType.None,
  }) : width = columnWidth == null ? 150.0.obs : columnWidth.obs;
}
