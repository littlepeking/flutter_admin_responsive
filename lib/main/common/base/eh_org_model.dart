import 'dart:convert';

import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/eh_refactor_helper.dart';
import 'eh_model_converters.dart';

part 'eh_org_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
class EHOrgModel extends EHModel {
  String? code;
  String? parentId;
  String? name;
  String? address1;
  String? address2;

  String? contact1;
  String? contact2;

  // EHModel(this.addDate, this.addWho, this.editDate, this.editWho);

  factory EHOrgModel.fromJson(Map<String, dynamic> json) =>
      _$EHOrgModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EHOrgModelToJson(this);

  String toJsonStr() => jsonEncode(toJson());

  EHOrgModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      this.parentId,
      this.name,
      this.address1,
      this.address2,
      this.contact1,
      this.contact2,
      this.code})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho);
}
