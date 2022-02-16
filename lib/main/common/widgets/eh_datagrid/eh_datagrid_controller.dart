import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:get/get.dart';
import 'eh_datagrid_source.dart';

class EHDataGridController extends EHController {
  // Default pager height
  double rowHeight = 35;
  double dataPagerHeight = 55.0;
  double headerRowHeight = 75.0;
  double? fixedHeight;

  /// DataGridSource required for SfDataGrid to obtain the row data.
  EHDataGridSource dataGridSource = EHDataGridSource();

  EHDataGridController({double? fixedHeight}) {
    this.fixedHeight = fixedHeight == null
        ? Responsive.isMobile(Get.context!)
            ? 500
            : double.infinity
        : fixedHeight;
  }
}
