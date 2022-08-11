import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_data.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import '../../services/common/eh_common_service.dart';
import '../../services/common/eh_common_service_names.dart';
import 'eh_datagrid_source.dart';

class EHServiceDataGridSource extends EHDataGridSource {
  EHServiceDataGridSource(
      {String serviceName = EHCommonServiceNames.EHCommonService,
      String actionName = 'queryByPage',
      required List<EHColumnConf> columnsConfig,
      List<EHFilterInfo> columnFilters = const [],
      int? pageIndex,
      Map<String, Object?> params = const {},
      bool? loadDataAtInit})
      : super(
            pageIndex: pageIndex,
            columnFilters: columnFilters,
            params: params,
            columnsConfig: columnsConfig,
            loadDataAtInit: loadDataAtInit = true,
            getData: (
              Map<String, Object?> params,
              List<EHDataGridFilterData> filters,
              Map<String, String> orderBy,
              int pageIndex,
              int pageSize,
            ) async {
              filters.forEach((e) {
                EHColumnConf columnConfig = columnsConfig
                    .where((config) => config.columnName == e.columnName)
                    .first;
                e.columnName = columnConfig.fullQuanifiedName ?? e.columnName;
              });

              orderBy.forEach((key, value) {
                EHColumnConf columnConfig = columnsConfig
                    .where((config) => config.columnName == key)
                    .first;
                if (columnConfig.fullQuanifiedName != null) {
                  orderBy[columnConfig.fullQuanifiedName!] = value;
                  orderBy.remove(key);
                }
              });

              return await EHCommonService.queryByPage(
                  serviceName: serviceName,
                  actionName: actionName,
                  filters: filters,
                  orderBy: orderBy,
                  pageIndex: pageIndex,
                  pageSize: pageSize,
                  params: params);
            });
}
