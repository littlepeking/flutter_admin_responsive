import 'dart:convert';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:eh_flutter_framework/main/common/base/eh_version_model.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_refactor_helper.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
@EHList2StringConverter
class RoleModel extends EHVersionModel {
  String orgId;
  String roleName;
  String displayName;

  List<PermissionModel> permissions;

  RoleModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      int? version,
      required this.orgId,
      required this.roleName,
      required this.displayName,
      this.permissions = const []})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho,
            version: version);
  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return RoleModel.fromJson(json);
  }

  String toJsonStr() => jsonEncode(toJson());
}
