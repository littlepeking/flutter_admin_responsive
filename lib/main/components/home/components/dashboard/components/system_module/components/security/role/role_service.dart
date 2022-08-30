import 'package:eh_flutter_framework/main/common/services/common/eh_base_model_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';

import 'role_model.dart';

class RoleService extends EHBaseModelService<RoleModel> {
  RoleService._internal();

  static RoleService _singleton = new RoleService._internal();

  factory RoleService() => _singleton;

  @override
  String get serviceName => SecurityServiceNames.RoleService;

  Future<void> deleteById(String id) async {
    await EHRestService().deleteByServiceName(
        serviceName: serviceName, actionName: '', params: {'roleId': id});
  }
}
