import 'dart:convert';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:eh_flutter_framework/main/common/base/eh_version_model.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_refactor_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
@EHList2StringConverter
class PermissionModel extends EHVersionModel {
  String? type;
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
