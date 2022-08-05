import 'dart:convert';
import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:eh_flutter_framework/main/common/base/eh_version_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../../../common/utils/eh_refactor_helper.dart';

part 'user_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
class UserModel extends EHVersionModel {
  String? username;
  String? firstName;
  String? lastName;
  String? authType;
  String? domainUsername;
  String? originalPassword;
  String? password;
  String? rePassword;
  bool enabled;
  bool accountLocked;
  bool credentialsExpired;

  List<RoleModel> roles;

  UserModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      int? version,
      this.username,
      this.firstName,
      this.lastName,
      this.password,
      this.rePassword,
      this.authType,
      this.enabled = true,
      this.accountLocked = false,
      this.credentialsExpired = false,
      this.roles = const []})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho,
            version: version);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
