import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';

import 'organization_model.dart';

class OrganizationServices {
  static Future<List<OrganizationModel>> getOrgList() async {
    Response<List> response = await EHRestService().getByServiceName<List>(
        serviceName: '/security/org', actionName: 'findAll');

    return response.data!.map((x) => OrganizationModel.fromJson(x)).toList();
  }

  static Future<OrganizationModel> save(OrganizationModel org) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: '/security/org', actionName: 'createOrUpdate', body: org);

    return OrganizationModel.fromJson(response.data!);
  }

  static Future<void> deleteOrgById(String? id) async {
    await EHRestService().deleteByServiceName(
        serviceName: '/security/org/' + id.toString(), actionName: '');
  }
}
