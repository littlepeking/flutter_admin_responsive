import 'dart:convert';

import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EHContextHelper {
  static Future<UserModel> getUserInfo() async {
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

  static setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}
