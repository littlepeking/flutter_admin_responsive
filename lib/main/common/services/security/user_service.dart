import 'package:eh_flutter_framework/main/common/services/common/eh_base_model_service.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_model.dart';

import '../common/service_name.dart';

class UserService extends EHBaseModelService<UserModel> {
  UserService._internal();

  static UserService _singleton = new UserService._internal();

  factory UserService() => _singleton;

  @override
  String get serviceName => SecurityServiceNames.UserService;
}
