import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';

import 'organization_model.dart';

class OrganizationServices {
  static Future<List<OrganizationModel>> getOrgList() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: SecurityServiceNames.OrganizationService,
        actionName: 'findAll');

    return response.data!.map((x) => OrganizationModel.fromJson(x)).toList();
  }

  static Future<OrganizationModel> save(OrganizationModel org) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: SecurityServiceNames.OrganizationService,
        actionName: 'createOrUpdate',
        body: org);

    return OrganizationModel.fromJson(response.data!);
  }

  static Future<void> deleteOrgById(String? id) async {
    await EHRestService().deleteByServiceName(
        serviceName:
            SecurityServiceNames.OrganizationService + '/' + id.toString(),
        actionName: '');
  }

  static Future<List> buildTree() async {
    Response response = await EHRestService().getByServiceName<List>(
      serviceName: SecurityServiceNames.OrganizationService,
      actionName: '/buildTree',
    );

    return response.data;
  }

  static Future<List> buildTreeByPermId(String permissionId) async {
    Response response = await EHRestService().getByServiceName<List>(
        serviceName: SecurityServiceNames.OrganizationService,
        actionName: '/buildTreeByPermId',
        params: {'permId': permissionId});

    return response.data;
  }
}
