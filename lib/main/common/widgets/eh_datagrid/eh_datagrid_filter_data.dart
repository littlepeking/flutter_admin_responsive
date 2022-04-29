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
