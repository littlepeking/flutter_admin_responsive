import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';

class EHDataGridFilterInfo {
  String columnName;
  EHDataGridColumnSortType sort;
  String text;
  EHDataGridFilterInfo(
      {required this.columnName,
      this.sort = EHDataGridColumnSortType.None,
      this.text = ''});
}
