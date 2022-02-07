import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'eh_datagrid_source.dart';

class EHDataGridController<T extends EHDataGridSource> extends EHController {
  // Default pager height
  double dataPagerHeight = 85.0;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  T dataGridSource;

  EHDataGridController(this.dataGridSource);
}
