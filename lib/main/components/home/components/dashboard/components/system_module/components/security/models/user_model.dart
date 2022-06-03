import 'dart:convert';
import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:eh_flutter_framework/main/common/base/eh_org_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../../../common/utils/eh_refactor_helper.dart';

part 'user_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
class UserModel extends EHOrgModel {
  String? username;
  String? authType;
  String? domainUsername;
  bool enabled;
  bool accountNonLocked;
  bool credentialsNonExpired;
  UserModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      String? orgId,
      this.username,
      this.authType,
      this.enabled = true,
      this.accountNonLocked = true,
      this.credentialsNonExpired = true})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho,
            orgId: orgId);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
