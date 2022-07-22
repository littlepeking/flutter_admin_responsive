import 'dart:convert';
import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:eh_flutter_framework/main/common/base/eh_version_model.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../../../../../../common/utils/eh_refactor_helper.dart';

part 'organization_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
class OrganizationModel extends EHVersionModel {
  String? name;
  String? code;
  String? parentId;
  String? address1;
  String? address2;
  String? contact1;
  String? contact2;

  OrganizationModel({
    String? id,
    this.code,
    this.name,
    this.parentId,
    this.address1,
    this.address2,
    this.contact1,
    this.contact2,
    DateTime? addDate,
    DateTime? editDate,
    String? addWho,
    String? editWho,
    int? version,
  }) : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho,
            version: version);

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
