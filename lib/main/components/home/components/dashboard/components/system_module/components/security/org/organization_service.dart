import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_base_model_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';

import 'organization_model.dart';

class OrganizationService extends EHBaseModelService<OrganizationModel> {
  OrganizationService._internal();

  static OrganizationService _singleton = new OrganizationService._internal();

  factory OrganizationService() => _singleton;

  @override
  String get serviceName => SecurityServiceNames.OrganizationService;

  Future<List<OrganizationModel>> getOrgList() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: serviceName, actionName: 'findAll');

    return response.data!.map((x) => OrganizationModel.fromJson(x)).toList();
  }

  Future<OrganizationModel> save(OrganizationModel org) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName, actionName: 'createOrUpdate', body: org);

    return OrganizationModel.fromJson(response.data!);
  }

  Future<void> deleteOrgById(String? id) async {
    await EHRestService().deleteByServiceName(
        serviceName: serviceName + '/' + id.toString(), actionName: '');
  }

  Future<List> buildTree() async {
    Response response = await EHRestService().getByServiceName<List>(
      serviceName: serviceName,
      actionName: '/buildTree',
    );

    return response.data;
  }

  Future<List> buildTreeByPermId(String permissionId) async {
    Response response = await EHRestService().getByServiceName<List>(
        serviceName: serviceName,
        actionName: '/buildTreeByPermId',
        params: {'permId': permissionId});

    return response.data;
  }
}
