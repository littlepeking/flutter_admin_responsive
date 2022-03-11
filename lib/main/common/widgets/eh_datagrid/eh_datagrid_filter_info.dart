import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';

class EHFilterInfo {
  String columnName;
  EHDataGridColumnSortType sort;
  String text;
  EHFilterInfo(
      {required this.columnName,
      this.sort = EHDataGridColumnSortType.None,
      this.text = ''});
}
