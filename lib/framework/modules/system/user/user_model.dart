/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'dart:convert';
import 'dart:core';

import 'package:enhantec_platform_ui/framework/base/eh_model_converters.dart';
import 'package:enhantec_platform_ui/framework/base/eh_version_model.dart';
import 'package:enhantec_platform_ui/framework/modules/system/role/role_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../../../../framework/utils/eh_refactor_helper.dart';

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
