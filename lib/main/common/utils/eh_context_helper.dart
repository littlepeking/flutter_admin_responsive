import 'dart:convert';

import 'package:eh_flutter_framework/main/common/Utils/eh_navigator.dart';
import 'package:eh_flutter_framework/main/common/constants/map_constant.dart';
import 'package:eh_flutter_framework/main/common/constants/navigation_keys.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EHContextHelper {
  static OrganizationModel defaultOrgModel =
      OrganizationModel(id: null, name: '<Select Org>');

  static Rx<OrganizationModel?> selectedOrgModel = Rxn();

  static Map<String, Set<PermissionModel>> _orgPermissions = {};

  static Rx<SystemModule> currentModule = SystemModule.workbench.obs;

  static Future<UserModel> getUserDetail() async {
    String? contextString = await getString("userInfo");

    Map<String, dynamic> userInfoMap = jsonDecode(contextString ?? '{}');

    UserModel user = UserModel.fromJson(userInfoMap);

    final List<dynamic> roles = jsonDecode(userInfoMap['Roles'] ?? '[]');

    roles.map((r) {
      RoleModel roleModel = RoleModel.fromJson(r);

      final List<dynamic> permissions =
          jsonDecode(userInfoMap['permissions'] ?? '[]');

      permissions.map((r) {
        PermissionModel permissionModel = PermissionModel.fromJson(r);

        roleModel.permissions.add(permissionModel);
      });

      user.roles.add(roleModel);
    });

    return user;
  }

  static Future<void> logout() async {
    await EHContextHelper.removeString('userInfo');
    await EHContextHelper.removeString("Authorization");
    selectedOrgModel.value = defaultOrgModel;
    currentModule.value = SystemModule.workbench;
    EHNavigator.resetAllModuleTabs();
    EHNavigator.navigateTo("/login");
  }

  static switchOrg(OrganizationModel organizationModel) {
    selectedOrgModel.value = organizationModel;
    currentModule.value = SystemModule.workbench;
    EHNavigator.resetAllModuleTabs();
    EHNavigator.navigateTo(
      MapConstant.systemModuleRoute[currentModule.value]!,
      navigatorKey: NavigationKeys.dashBoardNavKey,
    );
  }

  static Map<String, Set<PermissionModel>> getAllUserPermissions() {
    //if (_permissions == null) refreshPermissions();

    return _orgPermissions;
  }

  static Set<PermissionModel> getUserOrgPermissions() {
    //if (_permissions == null) refreshPermissions();
    if (selectedOrgModel.value == null)
      return {};
    else
      return _orgPermissions[selectedOrgModel.value!.id] ?? {};
  }

  static Set<String> getUserOrgModules() {
    //if (_permissions == null) refreshPermissions();
    return getUserOrgPermissions().map((e) => e.moduleId!).toSet();
  }

  static bool hasAnyPermission(Set<String> permissionCodes) {
    return permissionCodes.length == 0
        ? true
        : getUserOrgPermissions()
                .map((e) => e.authority)
                .toSet()
                .intersection(permissionCodes)
                .length >
            0;
  }

  static refreshPermissions() async {
    UserModel userModel = await getUserDetail();

    userModel.roles.forEach((r) {
      r.permissions.forEach((p) {
        _orgPermissions.putIfAbsent(r.orgId!, () => {}).add(p);
      });
    });
  }

  static setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  static removeString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}
