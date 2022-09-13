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
      bool? loadDataAtInit = true})
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

              String? key2Remove;
              String? key2Add;
              orderBy.forEach((key, value) {
                EHColumnConf columnConfig = columnsConfig
                    .where((config) => config.columnName == key)
                    .first;
                if (columnConfig.fullQuanifiedName != null &&
                    columnConfig.fullQuanifiedName != columnConfig.columnName) {
                  key2Add = columnConfig.fullQuanifiedName!;
                  key2Remove = key;
                }
              });

              if (key2Remove != null) {
                orderBy[key2Add!] = orderBy[key2Remove!]!;
                orderBy.remove(key2Remove);
              }

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
