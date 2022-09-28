/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_common_service_names.dart';

import '../../widgets/eh_datagrid/eh_datagrid_filter_data.dart';
import 'eh_rest_service.dart';

class EHCommonService {
  static Future<Map<String, dynamic>> queryByPage({
    required String serviceName,
    String actionName = 'queryByPage',
    Map<String, Object?>? params = const {},
    List<EHDataGridFilterData> filters = const [],
    Map<String, String> orderBy = const {},
    int pageIndex = -1,
    int pageSize = 25,
  }) async {
    Response<Map<String, dynamic>> response = await EHRestService()
        .postByServiceName<Map<String, dynamic>>(
            serviceName: serviceName,
            actionName: actionName,
            body: {
          'filters': filters,
          'orderBy': orderBy,
          'pageIndex': pageIndex,
          'pageSize': pageSize,
          'params': params,
        });

    return response.data!;
  }

  static Future<List<Map<String, dynamic>>> queryByListName({
    String serviceName = EHCommonServiceNames.EHCommonService,
    String actionName = 'queryByListName',
    required String listName,
    Map<String, Object?>? params = const {},
  }) async {
    Response<List<Map<String, dynamic>>> response = await EHRestService()
        .postByServiceName<List<Map<String, dynamic>>>(
            serviceName: serviceName,
            actionName: actionName,
            body: {
          'listName': listName,
          'params': params,
        });

    return response.data ?? [];
  }
}
