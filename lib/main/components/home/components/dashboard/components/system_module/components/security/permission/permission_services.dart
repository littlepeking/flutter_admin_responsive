import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';

import 'permission_model.dart';

class PermissionServices {
  static Future<List<PermissionModel>> getAll() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: 'findAll');

    return response.data!.map((x) => PermissionModel.fromJson(x)).toList();
  }

  static Future<PermissionModel> save(PermissionModel org) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: 'createOrUpdate',
        body: org);

    return PermissionModel.fromJson(response.data!);
  }

  static Future<void> deleteById(List<String> ids) async {
    await EHRestService().deleteByServiceName(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: '',
        data: ids);
  }

  static Future<Response<List>> buildTree() async {
    return await EHRestService().getByServiceName<List>(
      serviceName: SecurityServiceNames.PermissionService,
      actionName: '/buildTree',
    );
  }
}
