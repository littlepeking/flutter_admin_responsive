import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'eh_service_datagrid_source.dart';

class EHCommonDataGridSource extends EHServiceDataGridSource {
  String dataSourceCode;

  EHCommonDataGridSource(
      {required this.dataSourceCode,
      required List<EHColumnConf> columnsConfig,
      List<EHFilterInfo> columnFilters = const [],
      int? pageIndex,
      bool loadDataAtInit = true})
      : super(
            pageIndex: pageIndex,
            columnFilters: columnFilters,
            columnsConfig: columnsConfig,
            loadDataAtInit: loadDataAtInit,
            params: {'dataSourceCode': dataSourceCode});
}
