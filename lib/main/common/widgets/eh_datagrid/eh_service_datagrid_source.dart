import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
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
      Map<String, Object?>? extraParams,
      bool? loadDataAtInit})
      : super(
            pageIndex: pageIndex,
            columnFilters: columnFilters,
            columnsConfig: columnsConfig,
            loadDataAtInit: loadDataAtInit = true,
            getData: (
              Map<String, Object?> filters,
              Map<String, String> orderBy,
              int pageIndex,
              int pageSize,
            ) async {
              return await EHCommonService.queryByPage(
                  serviceName: serviceName,
                  actionName: actionName,
                  filters: filters,
                  orderBy: orderBy,
                  pageIndex: pageIndex,
                  pageSize: pageSize,
                  extraParams: extraParams);
            });
}
