import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import '../../services/eh_rest_service.dart';
import 'eh_datagrid_source.dart';

class EHCommonDataGridSource extends EHDataGridSource {
  String serviceName;

  EHCommonDataGridSource(
      {required this.serviceName,
      String actionName = 'query',
      required List<EHColumnConf> columnsConfig,
      List<EHFilterInfo> columnFilters = const [],
      bool? isMobile,
      int? pageIndex,
      bool? loadDataAtInit})
      : super(
            isMobile: isMobile = false,
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
              return await EHRestService.query(
                  serviceName: serviceName,
                  actionName: actionName,
                  filters: filters,
                  orderBy: orderBy,
                  pageIndex: pageIndex,
                  pageSize: pageSize);
            });
}
