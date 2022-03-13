import 'package:dio/dio.dart';

import 'eh_http_service.dart';

class EHRestService {
  static Future<List<Map<String, dynamic>>> query({
    required String serviceName,
    String actionName = 'query',
    Map<String, Object?> filters = const {},
    Map<String, String> orderBy = const {},
    int pageIndex = -1,
    int pageSize = 25,
  }) async {
    Response<List<Map<String, dynamic>>> response = await httpService
        .post<List<Map<String, dynamic>>>(
            path: serviceName + '/' + actionName,
            body: {
          'filters': filters,
          'orderBy': orderBy,
          'pageIndex': pageIndex,
          'pageSize': pageSize
        });

    return response.data ?? [];
  }
}
