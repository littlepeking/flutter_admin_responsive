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

import 'package:json_annotation/json_annotation.dart';
import '../../utils/eh_refactor_helper.dart';

part 'eh_datagrid_filter_data.g.dart';

@JsonSerializable()
@EHMethodExecutor
class EHDataGridFilterData {
  String columnName;
  String type;
  dynamic value;
  EHDataGridFilterData(
      {required this.columnName, required this.type, this.value = ''});

  factory EHDataGridFilterData.fromJson(Map<String, dynamic> json) =>
      _$EHDataGridFilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$EHDataGridFilterDataToJson(this);

  String toJsonStr() => jsonEncode(toJson());
}
