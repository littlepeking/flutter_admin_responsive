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

import 'package:eh_flutter_framework/enhantec_ui_framework/utils/eh_refactor_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'eh_rest_error.g.dart';

@JsonSerializable()
@EHMethodExecutor
class RestError {
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

  Map<String, dynamic> toJson() => _$RestErrorToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
