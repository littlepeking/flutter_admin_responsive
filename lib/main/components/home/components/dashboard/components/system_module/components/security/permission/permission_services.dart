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

  static Future<void> deleteByIds(List<String> ids) async {
    await EHRestService().deleteByServiceName(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: '',
        data: ids);
  }

  static Future<List> buildTreeByOrgId(String orgId) async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: '/buildTreeByOrgId',
        params: {'orgId': orgId});

    return response.data!;
  }

  static Future<List> buildTree() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: '/buildTree',
        params: {});

    return response.data!;
  }

  static Future<List> updateOrgPermissions(
      String orgId, List<String> permissionIds) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: 'updateOrgPermissions',
        body: {'orgId': orgId, 'permissionIds': permissionIds});

    return response.data;
  }

  static Future<List> updatePermissionOrgs(
      String permissionId, List<String> orgIds) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: SecurityServiceNames.PermissionService,
        actionName: 'updatePermissionOrgs',
        body: {'permissionId': permissionId, 'orgIds': orgIds});

    return response.data;
  }
}
