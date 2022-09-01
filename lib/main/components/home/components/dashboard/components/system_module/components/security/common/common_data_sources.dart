import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_service.dart';

class CommonDataSources {
  static Future<Map<String, String>> getOrgDDLDataSource() async {
    List<OrganizationModel> list = await OrganizationService().getOrgList();
    return Map<String, String>.fromIterable(list,
        key: (e) => (e as OrganizationModel).id!,
        value: (e) => (e as OrganizationModel).name!);
  }
}
