import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_common_service_names.dart';

import 'eh_rest_service.dart';

class EHCommonService {
  static Future<List<Map<String, dynamic>>> queryByPage({
    String serviceName = EHCommonServiceNames.EHCommonService,
    String actionName = 'query',
    Map<String, Object?>? extraParams = const {},
    Map<String, Object?> filters = const {},
    Map<String, String> orderBy = const {},
    int pageIndex = -1,
    int pageSize = 25,
  }) async {
    Response<List<Map<String, dynamic>>> response = await EHRestService()
        .postByServiceName<List<Map<String, dynamic>>>(
            serviceName: serviceName,
            actionName: actionName,
            body: {
          'filters': filters,
          'orderBy': orderBy,
          'pageIndex': pageIndex,
          'pageSize': pageSize,
          'extraParams': extraParams,
        });

    return response.data ?? [];
  }

  static Future<List<Map<String, dynamic>>> queryByListName({
    String serviceName = EHCommonServiceNames.EHCommonService,
    String actionName = 'queryByListName',
    required String listName,
    Map<String, Object?>? extraParams = const {},
  }) async {
    Response<List<Map<String, dynamic>>> response = await EHRestService()
        .postByServiceName<List<Map<String, dynamic>>>(
            serviceName: serviceName,
            actionName: actionName,
            body: {
          'listName': listName,
          'extraParams': extraParams,
        });

    return response.data ?? [];
  }
}
