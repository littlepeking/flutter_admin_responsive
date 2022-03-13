import 'package:dio/dio.dart';

import 'eh_rest_service.dart';

class EHCommonService {
  static Future<List<Map<String, dynamic>>> queryByPage({
    required String serviceName,
    required String actionName,
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
    required String listName,
    Map<String, Object?>? extraParams = const {},
  }) async {
    String serviceName = 'EHCommonService';
    String actionName = 'queryByListName';
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
