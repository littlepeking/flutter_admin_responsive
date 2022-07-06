import 'dart:convert';
import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../../../common/base/eh_model.dart';
import '../../../../../../../../../common/utils/eh_refactor_helper.dart';

part 'user_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
class UserModel extends EHModel {
  String? username;
  String? authType;
  String? domainUsername;
  bool enabled;
  bool accountLocked;
  bool credentialsExpired;

  UserModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      this.username,
      this.authType,
      this.enabled = true,
      this.accountLocked = false,
      this.credentialsExpired = false})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
