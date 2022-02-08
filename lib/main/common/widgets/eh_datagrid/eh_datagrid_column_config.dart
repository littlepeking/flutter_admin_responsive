import 'package:get/get.dart';

import 'eh_datagrid_constants.dart';

class EHDataGridColumnConfig {
  String columnName;

  String? sortColumnName; //排序时使用的列，默认为columnName
  //列头显示名称
  String? columnHeaderName;
  //控件类型：用于排序比较和选择控件展示
  EHDataGridColumnType columnType;

  RxDouble? width = 150.0.obs; // Double.nan.obs;

  bool hideInMobile;

  EHDataGridColumnConfig(this.columnName, this.columnType,
      {this.columnHeaderName, this.sortColumnName, this.hideInMobile = false});
}
