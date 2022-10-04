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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_model_converters.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_version_model.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_refactor_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
@EHList2StringConverter
class PermissionModel extends EHVersionModel {
  String? type;
  String? moduleId;
  String parentId;
  String? authority;
  String? displayName;
  bool? checkStatus;
  List<PermissionModel>? children;

  PermissionModel({
    String? id,
    DateTime? addDate,
    DateTime? editDate,
    String? addWho,
    String? editWho,
    int? version,
    this.type,
    this.moduleId,
    required this.parentId,
    this.authority,
    this.displayName,
    this.checkStatus,
    this.children,
  }) : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho,
            version: version);
  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PermissionModelToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return PermissionModel.fromJson(json);
  }

  String toJsonStr() => jsonEncode(toJson());
}
