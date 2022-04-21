import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import '../../utils/eh_refactor_helper.dart';

part 'eh_rest_error.g.dart';

@JsonSerializable()
@methodExecutor
class RestError extends EHModel {
  String title;
  int status;
  String detail;
  RestError({
    required this.title,
    required this.status,
    required this.detail,
  });

  factory RestError.fromJson(Map<String, dynamic> json) =>
      _$RestErrorFromJson(json);

  factory RestError.fromJsonStr(jsonString) =>
      _$RestErrorFromJson(json.decode(jsonString));

  @override
  Map<String, dynamic> toJson() => _$RestErrorToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
