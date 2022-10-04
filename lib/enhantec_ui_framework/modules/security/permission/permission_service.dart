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
import 'package:enhantec_platform_ui/enhantec_ui_framework/services/eh_base_model_service.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/services/eh_rest_service.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/services/service_names.dart';

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

  Future<List> buildTreeByRoleId(String roleId) async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: serviceName,
        actionName: '/buildTreeByRoleId',
        params: {'roleId': roleId});

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

  Future<List> updateRolePermissions(
      String roleId, List<String> permissionIds) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName,
        actionName: 'updateRolePermissions',
        body: {'roleId': roleId, 'permissionIds': permissionIds});

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
