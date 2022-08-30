import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_base_model_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';

import 'permission_model.dart';

class PermissionService extends EHBaseModelService<PermissionModel> {
  PermissionService._internal();

  static PermissionService _singleton = new PermissionService._internal();

  factory PermissionService() => _singleton;

  @override
  String get serviceName => SecurityServiceNames.PermissionService;

  Future<List<PermissionModel>> getAll() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: serviceName, actionName: 'findAll');

    return response.data!.map((x) => PermissionModel.fromJson(x)).toList();
  }

  Future<PermissionModel> save(PermissionModel org) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName, actionName: 'createOrUpdate', body: org);

    return PermissionModel.fromJson(response.data!);
  }

  Future<void> deleteByIds(List<String> ids) async {
    await EHRestService().deleteByServiceName(
        serviceName: serviceName, actionName: '', data: ids);
  }

  Future<List> buildTreeByOrgId(String orgId) async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: serviceName,
        actionName: '/buildTreeByOrgId',
        params: {'orgId': orgId});

    return response.data!;
  }

  Future<List> buildTree() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: serviceName, actionName: '/buildTree', params: {});

    return response.data!;
  }

  Future<List> updateOrgPermissions(
      String orgId, List<String> permissionIds) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName,
        actionName: 'updateOrgPermissions',
        body: {'orgId': orgId, 'permissionIds': permissionIds});

    return response.data;
  }

  Future<List> updatePermissionOrgs(
      String permissionId, List<String> orgIds) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName,
        actionName: 'updatePermissionOrgs',
        body: {'permissionId': permissionId, 'orgIds': orgIds});

    return response.data;
  }
}
