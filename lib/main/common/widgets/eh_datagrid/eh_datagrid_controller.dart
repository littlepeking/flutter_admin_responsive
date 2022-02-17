import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:get/get.dart';
import 'eh_datagrid_column_config.dart';
import 'eh_datagrid_source.dart';

class EHDataGridController extends EHController {
  // Default pager height
  double rowHeight = 35;
  double dataPagerHeight = 54.0;
  double headerRowHeight = 57.0;
  double? fixedHeight;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  late EHDataGridSource dataGridSource;

  EHDataGridController(
      {double? fixedHeight, required EHDataGridSource dataGridSource}) {
    this.fixedHeight = fixedHeight == null
        ? Responsive.isMobile(Get.context!)
            ? 300
            : double.infinity
        : fixedHeight;

    this.dataGridSource = dataGridSource;
  }
}
